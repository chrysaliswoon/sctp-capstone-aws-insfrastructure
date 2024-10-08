import json
import pandas as pd
import boto3
import io
import numpy as np
from collections import OrderedDict

class BuildIndicators():
    
    def __init__(self):
        self.df_merged = None
        self.df_baseline = None
        self.df_movement = None
        self.df_ddr = None
        self.df_disch_odr = None
        self.df_referral = None
        self.df_ed_diag = None
        self.df_refer_to_ane = None
        self.div = None
        self.df_news = None
        self.df_tosp = None
        self.df_elect_res = None
        
        
    def select_folder_read(self, div):
        
        def get_s3_object(bucket_name, filename_prefix):
            obj = s3.get_object(Bucket=bucket_name, Key=filename_prefix)
            data = obj['Body'].read()
            
            return pd.read_excel(io.BytesIO(data))
        
        
        s3 = boto3.client('s3')
        self.div = div

        bucket_name = 'ce6-capstone-group3-dev-sssw'

        self.df_baseline = get_s3_object(bucket_name, 'SSSW/S1. Baseline_.xlsx')
        self.df_movement = get_s3_object(bucket_name, 'SSSW/S1a. Baseline - Movement Level_.xlsx')
        self.df_referral = get_s3_object(bucket_name, 'SSSW/S2. Cases with OT_PT_ST Consult_.xlsx')
        self.df_disch_odr = get_s3_object(bucket_name, 'SSSW/S3. Patient Discharge Order_.xlsx')
        self.df_tosp = get_s3_object(bucket_name, 'SSSW/S4. TOSP Code_.xlsx')
        
        
    def process_discharge_order(self):
        
        disch_odr_columns = ['CSN', 'TAT From Order to Actual Discharge (Hrs)']        
        
        self.df_disch_odr.rename(columns={'Proc Order Parent Order DateTime' : 'Disch Order DateTime'}, inplace=True)
        self.df_merged = self.df_merged.merge(self.df_disch_odr[disch_odr_columns], on='CSN', how='left',validate="1:1")
        self.df_merged['TAT From Order to Actual Discharge (Hrs)'] = self.df_merged['TAT From Order to Actual Discharge (Hrs)'].astype(float)
           
        return self.df_merged
    
    
    def process_referral(self): 
        
        self.df_referral.loc[self.df_referral['Modality (Therapy)'].str.contains('IP Consult to Dietetics and Nutrition'), 'Modality (Therapy)'] = 'Dietitian'
    
        target_referral = pd.pivot_table(self.df_referral, values='Proc Order Name', index=['CSN'], columns=['Modality (Therapy)'], aggfunc='nunique')
        
        try:        
            self.df_merged = self.df_merged.merge(target_referral, on='CSN', how='left',validate="1:1")
            
        except AttributeError:
            self.df_merged = self.df_baseline.merge(target_referral, on='CSN', how='left',validate="1:1")
            
        
        referral_list = ['OT', 'PT', 'ST', 'MSW', 'Podiatry']
        result = list(filter(lambda x : x not in self.df_merged.columns, referral_list))
        self.df_merged[result] = 0
        
        return self.df_merged          
        
        
    def put_xlsx_as_object(self):
        s3 = boto3.client('s3')
        
        bucket_name = 'ce6-group3-sssw' 
        file_key = 'output/sssw dashboard.csv'  
        
        with io.BytesIO() as output:
            # Save the DataFrame to the in-memory buffer
            self.df_merged.to_csv(output, index=False) 
    
            # Reset the buffer's position to the beginning
            output.seek(0)
    
            # Upload the buffer's content to S3
            s3.put_object(Bucket=bucket_name, Key=file_key, Body=output) 
        
    
    def surgical_pipeline(self):
        
        self.select_folder_read('SSSW')
        self.process_referral()
        self.process_discharge_order()
        self.put_xlsx_as_object()
        #self.calculate_sssw_los()
        #self.find_transfer_out_icu('KWB055')
        #self.export_file()
        #self.get_admission_yyyy_mm()
        #self.process_tosp()
            
        return self.df_merged      
            
def lambda_handler(event, context):
    # TODO implement
    run = BuildIndicators()
    run.surgical_pipeline()
    
    return {
        
        'statusCode':200,
        'body': json.dumps('Hi')
    }

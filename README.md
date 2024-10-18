# CLOUDSCALE: AUTOMATED REPORT GENERATION USING AWS CLOUD SERVICES

## Project Overview

This capstone project is designed to demonstrate the use of AWS infrastructure for managing scalable cloud environments, a serverless application, and Apache Superset for data visualization. 

The goal is to provide a solution that integrates these components to offer efficient, scalable, and user-friendly data management and visualization.

For a quick overview of this project which contains links to the other 2 relevant repositories for the Application side clicke [here](https://chrysalis-1.gitbook.io/sctp-capstone-project) to access the Gitbook Documentation.

## Problem Statement

The current process of data analysis involves several manual tasks, including data extraction, computing indicators, creating charts and tables, and managing various file types. 

These steps are time-consuming, error-prone, and inefficient, leading to delays in decision-making and potential inconsistencies in the final output. Automating these processes could significantly enhance productivity, reduce human errors, and streamline the workflow for faster and more accurate data-driven insights.

## Proposed Solution:

To automate and optimize the data analysis workflow, we propose the following solution:

1. **S3 & Lambda for Storage and File Management**: 
   AWS S3 will serve as the centralized storage for all data files, supporting various file types. Lambda functions will automate file uploads, format conversions, and manage triggers for further processing, reducing manual file handling.

2. **AWS Glue Crawler for Data Extraction**: 
   Glue Crawler will automate the extraction of structured and unstructured data from S3. It will catalog the data, enabling easy querying and analysis without manual intervention, making the data extraction process seamless and efficient.

3. **Amazon ECS for Apache Superset**: 
   The containerized Apache Superset application will run on Amazon ECS. This will enable users to visualize data and analyze key metrics in a scalable and efficient environment, reducing the need for manual chart creation.

This solution will streamline the entire workflow, from data ingestion to visualization, enhancing efficiency, accuracy, and scalability.

## Table of Contents
- [Project Overview](#project-overview)
- [Project Structure](#project-structure)
- [Dependencies](#dependencies)
- [Setting Up the Development Environment](#setting-up-the-development-environment)
- [Testing and Debugging](#testing-and-debugging)
- [Deployment Guide](#deployment-guide)
- [Troubleshooting](#troubleshooting)
- [Contribution Guidelines](#contribution-guidelines)
- [Licensing and Credits](#licensing-and-credits)
- [Additional Resources](#additional-resources)

## Project Structure
[Explain the structure of the project here. Use a code block or tree format to illustrate the directories.]

```bash
.
├── .github/workflows               # CI/CD workflows for automated testing and deployment
├── deployment/                     # Deployment of scripts and infrastructure configuration
├── vpc/                            # Deployment of VPC (Virtual Private Cloud) configuration 
├── .gitignore                      # Specifies files to ignore in version control
├── .terraform.lock.hcl             # Terraform lock file to maintain provider versions
└── README.md                       # Project documentation, including setup instructions

```

## Dependencies

Here are the primary dependencies used in this project:

### **1. Terraform**
**Installation:**
- Download Terraform from the official site: [Terraform Downloads](https://www.terraform.io/downloads).
- Unzip the package and add it to your system's PATH.

**Verify Installation:**
```bash
terraform -v
```

### **2. AWS CLI**
**Installation:**
- Install the AWS CLI: [AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).

**Configure CLI:**
```bash
aws configure
```

### **3. Docker**
**Installation:**
- Install Docker from [Docker’s website](https://www.docker.com/products/docker-desktop).
- Follow platform-specific installation instructions.

**Verify Installation:**
```bash
docker --version
```

### **4. Python (for Lambda)**
**Installation:**
- Download and install Python from [Python.org](https://www.python.org/downloads/).

**Verify Installation:**
```bash
python --version
```

### **5. AWS Glue**
- Glue setup and configuration happen within the AWS Console. Ensure you have the correct permissions to create and manage Glue crawlers.

Make sure you’ve installed all dependencies to ensure smooth functioning of the project.

A full list of dependencies can be found in the `package.json` file.

## Setting Up the Development Environment

To set up the development environment for managing AWS infrastructure using Terraform, follow these steps. Environment variables such as AWS credentials will be handled via GitHub Actions secrets, so no need to configure them manually.

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/chrysaliswoon/sctp-capstone-aws-insfrastructure.git
   cd sctp-capstone-aws-insfrastructure
   ```

2. **Install Terraform:**
   Install Terraform as mentioned in the [primary dependencies](https://www.terraform.io/downloads).

3. **Install AWS CLI:**
   Follow the AWS CLI setup instructions from the [official documentation](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).

4. **Set Up Docker:**
   Install Docker and verify the installation by running:
   ```bash
   docker --version
   ```

5. **Set Up Python (Optional for Lambda Functions):**
   If you're using Python for Lambda:
   ```bash
   python --version
   pip install -r requirements.txt  # if there's a requirements file
   ```

6. **Terraform Initialization:**
   Run Terraform commands to initialize your project:
   ```bash
   terraform init
   terraform apply
   ```

7. **Test Deployment:**
   Ensure the deployment works by checking AWS resources (S3, ECS, Glue) and reviewing logs.

Your environment should now be set up for development and deployment.

This repository uses GitHub Actions for automating deployments to AWS. The AWS credentials and environment variables are securely stored in GitHub Secrets and are used during the CI/CD pipeline.

To trigger a deployment, simply push your changes to a branch and submit a pull request with a detailed explanation, and the GitHub Actions workflow will automatically apply the Terraform changes. You can monitor the pipeline in the Actions tab of the GitHub repository.


## Testing and Debugging

#### 1. **Unit Testing (Terraform)**
   - Use `terraform plan` to preview changes and verify infrastructure configuration.
   - Validate Terraform scripts with:
     ```bash
     terraform validate
     ```
   - Use tools like [Terratest](https://terratest.gruntwork.io/) for automated tests.

#### 2. **Testing AWS Lambda**
   - Test Lambda functions locally with [AWS SAM CLI](https://aws.amazon.com/serverless/sam/):
     ```bash
     sam local invoke "FunctionName"
     ```
   - Debug errors using CloudWatch logs.

#### 3. **Docker Testing (ECS)**
   - Test Docker containers locally before deploying to ECS:
     ```bash
     docker build -t app .
     docker run -p 8088:8088 app
     ```

#### 4. **AWS Glue Testing**
   - Run Glue crawlers in development mode and check results in the AWS Glue Console.

#### 5. **Debugging**
   - **Terraform Debugging**: Use `TF_LOG=DEBUG` to enable detailed logs.
   - **AWS CLI**: Check logs in CloudWatch for Lambda, ECS, and Glue errors.
   - Use AWS X-Ray for tracing and troubleshooting performance issues.

#### 6. **General Tips**
   - Validate AWS IAM permissions to ensure roles have correct access.
   - Use `aws cli` commands to inspect resources and troubleshoot any misconfigurations.

## Deployment Guide

For this project, we have set-up github actions workflow to automate the deployment side of things, and here was how we did it:

#### **1. Branching Strategy**

*This section outlines the branching strategy used for patching Superset image and Lambda application code.*
<br>The branching strategy is the same for both resources.

Environments
 <br>We deploy to two environments:

* **dev:**  Used for testing and development.
* **main:**  The live production environment.

Branches
* **`dev` branch:**
    * All development work for the dev environment is done on this branch.
    * Manual trigger is requred for GitHub Actions workflow to deploy the changes to the AWS Dev environment.

* **`main` branch:**
    * Represents the production-ready code.
    * To deploy to the Prod environment, changes must be merged into the `main` from `dev`.
    * A pull request to `main` requires a code review and approval before it can be merged.
    * Merging to `main` automatically triggers a GitHub Actions workflow that requires manual approval to deploy the changes to the AWS Prod environment.
<br>
<br>

*This section outlines the branching strategy for managing our Terraform code and tfvars files for deploying infrastructure to development and production environments on AWS.*

- We will use a separate branch for each environment: *dev* and *prod*. This provides clear separation and reduces the risk of accidental deployments to the wrong environment.

- *dev* branch:  
   * Contains the dev.tfvars file with settings for the development environment.
   * Example settings: smaller cpu and memory size.
   * All development and feature work starts in feature branches branched off of *dev*
   * Merging to *prod* automatically triggers a GitHub Actions workflow that deploy the changes to the AWS *dev* environment.

- *prod* branch:  
   * Contains the dev.tfvars file with settings for the production environment.
   * Example settings: higher cpu and memory size.
   * New prod features starts in feature branches branched off from *prod*
   * A pull request to *prod* from its feature branch requires a code review before it can be merged.
   * Merging to *prod* automatically triggers a GitHub Actions workflow that deploy the changes to the AWS *prod* environment.
   
    


---

#### **2. Store AWS Credentials in GitHub Secrets**

- In the repository, under **Settings** > **Secrets and Variables** > **Actions**.
- Added the following secrets:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`

---

#### **3. Testing**

- GitHub Actions runs tests and Terraform validation automatically on every push.
- Review deployment logs in the Actions tab on GitHub to ensure the deployment is successful.

---

This approach automates the deployment, ensuring consistency and reducing manual intervention.

### Detailed Troubleshooting for GitHub Actions & AWS Deployment

---

#### **1. GitHub Actions Fails to Trigger**
- **Ensure the workflow file is in the `.github/workflows/` directory**.
- Verify correct syntax and branch triggers in the `.yml` file.
- Use `push` events on the correct branch (e.g., `main`).

#### **2. Terraform Errors in GitHub Actions**
- **Issue: `terraform init` fails**:
  - Ensure correct versions of Terraform in `setup-terraform`.
  - Check AWS permissions.
  
- **Issue: `terraform apply` fails**:
  - Check for incorrect resource configuration.
  - Use `terraform plan` to debug.

#### **3. AWS Credentials Issues**
- **Problem: Failed AWS Authentication**:
  - Ensure `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` are stored correctly in GitHub Secrets.
  - Check IAM roles for adequate permissions (e.g., S3, ECS, Lambda).

#### **4. Docker Build Fails**
- **Issue: Docker image build fails**:
  - Review Dockerfile for syntax errors.
  - Make sure required environment variables are passed during the build process.

- **Issue: Docker push to ECR fails**:
  - Ensure `aws_account_id`, `region`, and repository names are correctly set.
  - Check that your ECR repository exists and permissions are configured correctly.

#### **5. Lambda Function Issues**
- **Problem: Lambda function deployment fails**:
  - Verify that the Lambda package (zip file) includes all dependencies.
  - Review logs in CloudWatch to identify function errors.

- **Issue: Missing Permissions**:
  - Ensure the IAM role associated with Lambda has permissions to access resources (e.g., S3, ECS).

---

#### **6. ECS Tasks Not Starting**
- **Problem: ECS Task Stuck in `PENDING` State**:
  - Check that your Docker image was successfully pushed to ECR.
  - Review ECS Task definitions for correct image URI and CPU/memory settings.

- **Debugging ECS**:
  - Use the ECS Console to view task details and logs.
  - Ensure the container is not running out of memory or CPU.

---

#### **7. Terraform State Locking Errors**
- **Problem: `terraform apply` shows a state lock error**:
  - Use `terraform force-unlock <lock-id>` to manually unlock if another process has locked it.

#### **8. Common GitHub Actions Debugging Techniques**
- Use `actions/checkout@v2` to ensure code is correctly pulled.
- Add `set -e` to fail the workflow on the first error in bash scripts.
- Use `echo` statements in workflows for debugging output.

---

By following these detailed troubleshooting steps, you should be able to resolve common issues encountered during deployment with GitHub Actions and AWS infrastructure.

## Contribution Guidelines

We welcome contributions! Please follow these steps:

1. **Fork the Repository**: Create your own fork of the repository.
2. **Create a Feature Branch**: Create a branch for your feature or bugfix.
    ```bash
    git checkout -b feature-branch
    ```
3. **Make Your Changes**: Develop and test your changes.
4. **Submit a Pull Request**: Once your changes are tested, submit a pull request with a detailed explanation.

## Licensing and Credits

**Author/Team:** 
- Kok Hui
- Kristine
- Jeff
- Chrysalis


## Additional Resources
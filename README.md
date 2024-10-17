# CLOUDSCALE: AUTOMATED REPORT GENERATION USING AWS CLOUD SERVICES

## Project Overview

This capstone project is designed to demonstrate the use of AWS infrastructure for managing scalable cloud environments, a serverless Lambda-based application, and Apache Superset for data visualization. 

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
   The containerized Apache Superset application will run on Amazon ECS, automating the generation of charts, tables, and computed indicators from the processed data. This will enable users to visualize data and analyze key metrics in a scalable and efficient environment, reducing the need for manual chart creation.

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
├── src/               # Source code files
├── tests/             # Automated tests
├── docs/              # Project documentation
├── docker/            # Docker files
└── README.md          # Project documentation

```

## Dependencies

Here are the primary dependencies used in this project:

- **Node.js**: Version `v14.x.x` or higher is required.
- **Docker**: Used for containerization and deployment.

A full list of dependencies can be found in the `package.json` file.

## Setting Up the Development Environment

To set up the development environment for managing AWS infrastructure using Terraform, follow these steps. Environment variables such as AWS credentials will be handled via GitHub Actions secrets, so no need to configure them manually.

1. **Clone the Repository:**
   ```bash
   git clone git@github.com:chrysaliswoon/sctp-capstone-aws-insfrastructure.git
   cd sctp-capstone-aws-insfrastructure
   ```

2. **Install Terraform:**
You need to install Terraform to manage your AWS infrastructure. You can download it from Terraform's official website or use a package manager:

    - **For macOS:**

   ```bash
    brew install terraform
   ```

   - **For Windows**: Download the binary from the website and add it to your system's PATH.

    Check the installation:

    ```bash
    terraform --version
    ```


3. Set Up AWS CLI

To interact with AWS services, you'll need to install and configure the AWS Command Line Interface (CLI). You can download it from AWS CLI official documentation.

    - **For macOS:**

   ```bash
    brew install awscli
   ```

   - **For Windows**: Download the installer and follow the installation guide on AWS's website.

This repository uses GitHub Actions for automating deployments to AWS. The AWS credentials and environment variables are securely stored in GitHub Secrets and are used during the CI/CD pipeline.

To trigger a deployment, simply push your changes to the main branch, and the GitHub Actions workflow will automatically apply the Terraform changes. You can monitor the pipeline in the Actions tab of the GitHub repository.


## Testing and Debugging


## Deployment Guide


## Troubleshooting


## Contribution Guidelines

We welcome contributions! Please follow these steps:

1. **Fork the Repository**: Create your own fork of the repository.
2. **Create a Feature Branch**: Create a branch for your feature or bugfix.
    ```bash
    git checkout -b feature-branch
    ```
3. **Make Your Changes**: Develop and test your changes.
4. **Submit a Pull Request**: Once your changes are tested, submit a pull request with a detailed explanation.

Please refer to our [CONTRIBUTING.md](CONTRIBUTING.md) for more details on contributing.

## Licensing and Credits

**Author/Team:** List the main contributors or team members.
**Third-Party Tools:** Mention any external libraries or tools used in the project.


## Additional Resources
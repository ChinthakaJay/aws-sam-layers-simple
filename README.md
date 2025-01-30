# Project Build and Deployment Guide

This project uses two scripts to automate the build and deployment process:

1. **`build.sh`**: Builds all functions and layers in the project.
2. **`deploy.sh`**: Deploys the application using AWS SAM.

Below are the steps to build and deploy the project.

---

## Prerequisites

Before running the scripts, ensure the following are installed and configured:

- **Node.js**: Required for building functions and layers.
- **AWS SAM CLI**: Required for building and deploying the application.
- **AWS CLI**: Required for authentication and deployment.

---

## Scripts

### 1. `build.sh`

This script builds all functions and layers in the project by running `npm install` and `npm run build` in each directory.

#### What It Does:
- Looks for subdirectories in the `functions` and `layers` directories.
- Checks for a `package.json` file in each directory.
- Runs `npm install` to install dependencies.
- Runs `npm run build` to build the project (if a `build` script is defined in `package.json`).
- Tracks successful and failed builds and provides a summary.

#### How to Run:
From the root directory:

```bash
./scripts/build.sh
```

#### Example Output:
```bash
🔍 Looking for function directories in: /project-root/functions
🔍 Looking for layer directories in: /project-root/layers
📦 Processing directory: function1
   Directory: /project-root/functions/function1
   📥 Installing dependencies...
   ✅ Dependencies installed successfully
   🛠️  Running build...
   ✅ Build successful
   ✨ Finished processing function1
-------------------------------------------
🎉 Build process complete!
✅ Successful builds: 4
❌ Failed builds: 0
```

---

### 2. `deploy.sh`

This script deploys the application using AWS SAM. It runs `sam build` and `sam deploy` from the project root directory.

#### What It Does:
- Navigates to the project root directory.
- Runs `sam build` to build the application.
- Runs `sam deploy` to deploy the application to AWS.

#### How to Run:
From the root directory:

```bash
./scripts/deploy.sh
```

#### Example Output:
```bash
🚀 Running SAM build and deploy from: /project-root
🛠️  Running SAM build...
Building codeuri: /project-root/functions/function1 runtime: nodejs14.x
Building codeuri: /project-root/functions/function2 runtime: nodejs14.x
✅ SAM build completed successfully
🚀 Running SAM deploy...
Deploying SAM application...
✅ SAM deploy completed successfully
🎉 SAM build and deploy process complete!
```

---

## Workflow

1. **Build the Project**:
   - Run the `build.sh` script to build all functions and layers.
   - Ensure all builds are successful before proceeding to deployment.

2. **Deploy the Project**:
   - Run the `deploy.sh` script to deploy the application using AWS SAM.

---

## Notes

- Ensure the `template.yaml` file is correctly configured in the project root directory.
- If any builds fail during the `build.sh` process, fix the issues before running `deploy.sh`.
- Customize the `deploy.sh` script to include additional `sam deploy` parameters (e.g., `--stack-name`, `--capabilities`) if needed.

---

## Troubleshooting

- **Build Failures**:
  - Check the output of the `build.sh` script for errors.
  - Ensure all `package.json` files are correctly configured.

- **Deployment Failures**:
  - Check the output of the `deploy.sh` script for errors.
  - Ensure the AWS CLI is configured with valid credentials.

---

For further assistance, refer to the [AWS SAM CLI documentation](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html).
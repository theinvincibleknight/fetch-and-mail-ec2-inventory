# EC2 Inventory Management Automation
This repository contains a set of Bash scripts designed to automate the process of fetching EC2 instance details from AWS and sending them via email. The scripts are organized into separate folders for clarity and ease of use.

## Folder Structure

```
.
├── fetch
│   ├── fetch_ec2_instances.sh
│   └── fetch_ec2_count.sh
├── mail
│   └── sendmail.sh
└── profile
    ├── output
    └── switch_profile.sh
```

## Overview

The scripts work together to perform the following tasks:

1. **Fetch EC2 Instance Details**: The `fetch/fetch_ec2_instances.sh` script retrieves details of EC2 instances from various AWS profiles and saves the output in CSV format.

2. **Count EC2 Instances**: The `fetch/fetch_ec2_count.sh` script counts the total, running, and stopped EC2 instances for each AWS profile and saves the results in a text file.

3. **Switch AWS Profiles and Execute Scripts**: The `profile/switch_profile.sh` script orchestrates the execution of the above two scripts for multiple AWS profiles. It:
   - Clears the output directory.
   - Switches between different AWS profiles (e.g., `inv-admin`, `inv-dev`, `inv-uat`, etc.).
   - Executes the `fetch_ec2_instances.sh` script for each profile and renames the output files accordingly.
   - Zips all the CSV files into a single archive.

4. **Send Email with Results**: The `mail/sendmail.sh` script constructs an email containing the EC2 instance count details from the output.txt file and sends it to specified recipients. It attaches the zipped CSV file containing the CSV details.

## Prerequisites

- **AWS CLI**: Ensure that the AWS CLI is installed and configured with the necessary profiles.
- **Postfix**: Set up [Postfix](https://blog.virtualcenter.com/2022/03/24/smtp-using-office-365-email-account-with-postfix-relay-on-ubuntu/) on your Ubuntu server to handle email sending.
- **jq**: Install `jq` for JSON processing, as it is used in the scripts to parse AWS CLI output.

## Usage

1. **Clone the Repository**: Clone this repository to your local machine or server.

   ```bash
   git clone https://github.com/theinvincibleknight/fetch-and-mail-ec2-inventory.git
   cd fetch-and-mail-ec2-inventory
   ```

2. **Configure AWS Profiles**: Ensure that your AWS profiles are correctly configured in the AWS CLI. You may need to change the profile names in the scripts (`fetch/fetch_ec2_count.sh` and `profile/switch_profile.sh`) to match your specific AWS configuration.

3. **Change File Paths**: Update the file paths in the scripts to match your directory structure if it differs from the default provided in this repository.

4. **Set Up Cron Jobs**: To automate the execution of the scripts, set up cron jobs. The provided cron job configuration will run the scripts on the 30th of every month:

   ```bash
   # Sends monthly EC2 instance details via mail
   27 11 30 * * sh /home/ubuntu/AWS/scripts/profile/switch_profile.sh
   30 11 30 * * sh /home/ubuntu/AWS/scripts/mail/sendmail.sh
   ```

   Adjust the timing as necessary to fit your requirements.

5. **Run the Scripts Manually (Optional)**: If you want to run the scripts manually for testing or immediate execution, you can do so by executing:

   ```bash
   sh /home/ubuntu/AWS/scripts/profile/switch_profile.sh
   sh /home/ubuntu/AWS/scripts/mail/sendmail.sh
   ```

## License

This project is licensed under the MIT License.

## Conclusion

This set of scripts provides a streamlined way to manage and report on EC2 instances across multiple AWS profiles. By automating the fetching of instance details and sending them via email, you can save time and ensure that stakeholders are kept informed of the current state of your AWS resources.

## Acknowledgments
- AWS for providing the cloud infrastructure.
- The community for their contributions and support.

```
Feel free to modify any sections as needed to better fit your project!
```

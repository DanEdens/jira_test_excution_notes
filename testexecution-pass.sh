#!/bin/bash

# Set the base URL for the Jira instance
JIRA_BASE_URL=https://your-jira-instance.com

# Set the API endpoint for updating test execution
XRAY_API_ENDPOINT=/rest/raven/1.0/api/testexec

# Set the username and password for the Jira user
JIRA_USERNAME=your-username
JIRA_PASSWORD=your-password

# Initialize variables for the test ID and test execution status
TEST_ID=""
STATUS=""

# Parse the command line arguments
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    --test)
    TEST_ID="$2"
    shift # past argument
    shift # past value
    ;;
    --pass)
    STATUS="PASS"
    shift # past argument
    ;;
    --fail)
    STATUS="FAIL"
    shift # past argument
    ;;
    --executing)
    STATUS="EXECUTING"
    shift # past argument
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

# Set the test execution status
curl -X PATCH -u "$JIRA_USERNAME:$JIRA_PASSWORD" "$JIRA_BASE_URL$XRAY_API_ENDPOINT/$TEST_ID" -H "Content-Type: application/json" -d "{\"status\": \"$STATUS\"}"

echo "Test execution status updated to $STATUS for test with ID $TEST_ID"
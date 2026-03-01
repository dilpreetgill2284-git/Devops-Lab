location = "australiaeast"

# Friendly, valid names (adjust as you like)
rg_name              = "rg-dil-storage"
storage_account_name = "dilstorage123456" # must be globally unique, lowercase
container_name       = "blob-container"   # lowercase, hyphens ok, no spaces

# Blob object name in Azure + your local Windows file path
blob_name   = "TestFile"
blob_source = "C:\\Terraform\\TestFile.docx"

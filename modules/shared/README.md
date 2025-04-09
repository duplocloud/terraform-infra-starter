# Shared Module  

This is a Duplocloud Tenant that will host nodes and the DB so other tenants can share with this one. Each workspace will be a parent tenant to the tenant module workspace, ie it's an input variable. 

## Setup 

Here is the envrc file:  
```bash
source_up .envrc

export TF_WORKSPACE_DIR="../../config/shared"

```

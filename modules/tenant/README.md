# Tenant Module 

Builds the Duplocloud Tenant at the environment level. Each one of these uses the projects from the devops module to create Github Environments in each repo named the same as this tenant.  

## Setup 

Here is the envrc file:  
```bash
source_up .envrc

export TF_WORKSPACE_DIR="../../config/shared"

```

Then this to get the workspace setup. You can choose a different name then `dev01` if you want.  
```bash
tf init && tf ctx dev01
```

Now try a plan to see what happens. 
```bash 
tf plan
```

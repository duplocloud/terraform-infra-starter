# Portal Module  

One workspace here will be anything that happens once per portal. So each portal will be named the name of the workspace you are in. 

## Usage 

Before running anything make sure to include the configs if they exist for each module. 
Add this to the `.envrc` in this directory.  
```bash
source_up .envrc

export TF_WORKSPACE_DIR="../../config/portal"
```

Then you need to init to get all the dependencies.  
```bash
tf init
```

Then you can select the workspace which is the name of the portals. If you have only one portal then there is only one workspace named your org.  

```bash
tf ctx myportal
```

Then you can run the plan to see what is going to happen. 

```bash
tf plan
```

```bash
tf apply
```

## CI/CD  

This module is automagically controlled by the [`portal.yaml`](../../.github/workflows/portal.yml) workflow in Github actions.

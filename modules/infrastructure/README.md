# Infrastructure Module 

This creates a duplocloud infrastructure. The module represents the infrastructure scope where each workspace name will be the name of the infrastructure, ie new workspace means new infrastructure. 

## Uses  

- [duplocloud/component/context](https://registry.terraform.io/modules/duplocloud/components/duplocloud/latest/submodules/context)

## Setup 

First this var is needed. You can add this to a `.envrc` file to auto load it when entering this dir. 
```sh
export TF_WORKSPACE_DIR="../../config/infrastructure"
```
For direnv it would look like this. 
```sh
source_up .envrc
export TF_WORKSPACE_DIR="../../config/infrastructure"
```
then
```sh
tf init
```
Finally, choose a workspace.
```sh
tf ctx nonprod01
```

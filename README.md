# CircleCi CICD [![CircleCI](https://dl.circleci.com/status-badge/img/gh/ketangangal/deployment-using-circleci/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/ketangangal/deployment-using-circleci/tree/main)

CircleCI is a continuous integration and continuous delivery platform that can be used to implement DevOps practices. The company was founded in September 2011 and has raised $315 million in venture capital funding as of 2021, at a valuation of $1.7 billion. CircleCI is one of the world's most popular CI/CD platforms.

## Pipeline Overview 
![image](https://user-images.githubusercontent.com/40850370/202102795-cb81b520-3597-4392-b66b-143f37a89800.png)

## Steps to Replicate
### Infrastructure 
```text
1. Create an Remote machine on any Cloud. For Demo I am using google cloud's Virtual Machine.
2. Create a service account and provide Artifactry Admin Write access to service account.
3. Download the json credentials key somewhere safe in your system.
```
### Circle Ci Setup 
```text
1. Create a github repository and add License, .gitignore, .circleci/config.yml.
2. Add a sample app and Dockerfile in root. 
3. Create a account on CircleCI and connect with circle ci.
4. select recently created project.
```

### Self Hosted Runner Setup 
Docker setup

```text
1. Install docker in the virtual machine that you have launched on the gcp. for simple setup you can use ```scripts/virtual_machine_setup.sh file.```
2. After installing docker setup the self-hosted runner. 
```
Self Hosted Runner Configuration 
```text
1. Go to Main circle ci dashboard
2. Select self-hosted runners and create your resource class.
3. upon creation of resource class you can use the following API token provided by circleci
4. Keep it safe somewhere in your system.
```   
Now follow the self-hosted runner setup self-hosted.sh
```text
1. Configure the self-hosted as per self-hosted.sh 
2. Then start from virtual machine setup again and add circleci user to sudo.
3. Install gcp/cli. 

Done
```
### Workflow Syntax 

- Pipeline will start from continuous-integration on docker engine.
- upon successful exceution of the continuous-itegration continuous-delivery will start. 
- upon successful exceution of the continuous-delivery, circleci will wait for user to approve the deployment in the production env.
- continuous-deployment will depend on successful of :- 
    1. continuous-integration
    2. continuous-delivery
    3. sanity-check


```yaml
workflows:
  CICD:
    jobs:
      - continuous-integration

      - continuous-delivery:
          requires:
            - continuous-integration

      - sanity-check:
          type: approval
          requires:
          - continuous-delivery

      - continuous-deployment:
          requires:
            - sanity-check
            - continuous-integration
            - continuous-delivery
```

## Advance Options (machine Learning Usecase)
1. Can configure remote GPU Machine for model Training. But workflows has to be changed from [ on push main ] to [Cron Jobs]/ [Manual Trigger]
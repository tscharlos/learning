# The Story

## WhizU Corp

There is a startup company called *WhizU Corp* that suddenly got the idea to develop the best possible SaaS product ever. <br>
Currently there are two people at the start, Tom, the big visionaire, and Bob, the tech guy. Tom worked already at different tech places so he has a good understanding what current trends are and where one may look into.
Bob previously has been developing uncountable amount of PHP based portals, shops and other great stuff but unfortunatelly he doesn't see himself as a superhuman rockstar cloud native developer. But he always tries his best.

As time is limited and it's important to make the first steps at least, the guys decide to boot on a cloud with the initial version. With the time they plan to learn and improve.

Tom tells Bob that they need to go with the [kubernetes](https://kubernetes.io/) thingy. Very important to use the [GitOps](https://www.gitops.tech/) and [IaC](https://www.redhat.com/en/topics/automation/what-is-infrastructure-as-code-iac#:~:text=Infrastructure%20as%20Code%20(IaC)%20is,to%20edit%20and%20distribute%20configurations.) approach. Thats why Bob decides to take [terraform](https://www.terraform.io/) here.

One *dev* environment is totally sufficient at first but of course it will be more later on.

Automation is a thing but if there is some fire the guys thinks its ok to go to the cloud portal and fix it quickly. And if something else can be added fast it sounds valid. Bob can add it easily to terraform later for sure.

As soon as the first steps are made the team thinks about the backlog in a brainstorm session.

## The Backlog

Tom and Bob decide to note everything possible as it may be very relevant. And if soon additional members will join so there is something one can look back into to remember the topic and split the work items.

- Add additional environments. We may have test, staging and prod. But it could happen that we may need some kind of dynamic approach as we require to setup a short living environment for potential customers in the future for demo reasons.
  - For staging, terraform workspaces could suffice, alternative terragrunt DRY configurations. If a stricter separation of environments is needed, separate states are required (and [recommended](https://developer.hashicorp.com/terraform/cli/workspaces#when-not-to-use-multiple-workspaces))
- Get rid of writing `export TF_VAR_<something>` every time.
  - put it in `terraform.tfvars` file and don't check it into git
  - optionally encrypt it with e.g. [SOPS](https://github.com/getsops/sops) then it can be checked in
- Check how to structure the code in a better way.
  - could modularize cluster-setup
- Run the code in a pipeline. If we have some changes I would like to run it for the related environment. Something like PR based approach with approval would be a nice thing.
  - TODO: app-pipeline
- Creating the loadbalancer by using kubernetes service type `LoadBalancer` seems not to be the ideal solution for us. Or there is a way to preserve the IP if we recreate it.
- Reduce time of adjusting terraform code. Some plugin or whatever for autoformat like in PHPStorm would be nice. Need to investigate.
  - for VSCode: Terraform plugin - configure to `terraform fmt` on safe
  - generic: pre-commit git-hook (see `.git/hooks/pre-commit`)
- I <u>limited the DB connection to my IP and the nodepool VM</u>. Will need to think how we proceed here in the future.
- As we will get more and more apps up and runnig, we need to think about the deployment structure. Maybe something like [app of apps](https://argo-cd.readthedocs.io/en/stable/operator-manual/cluster-bootstrapping/#app-of-apps-pattern). <u>Maybe there is something better</u>.
  - ArgoCD App-of-Apps pattern implemented - might be superseded by ApplicationSets? TODO: take a look at ApplicationSets
- Our domain is currently managed by these devops guys. But I need to include it into terraform so I can set the IP record. Need to discuss this with them.
  - there are terraform resources for exoscale
  - a problem that might occurr: LoadBalancer IP not set before traefik(or other IngressController) is deployed. See [exoscale examples](https://github.com/exoscale-labs/event-order-system-example/blob/main/k8s/dns.tf)
- Enable SSL on ingress with valid certificate. We can go with [let's encrypt](https://letsencrypt.org/de/) here.
  - couldn't make it work
- Try to deploy app with [kustomize](https://kustomize.io/) instead of [helm](https://helm.sh/). Will need to look into some best practices. I would like to have some kind of config repo where we can set only really required configs and some kind of deployment definition repo where to which we can reference the revision. And what about if we have even more of these `values.yaml`s?
- Secret management is a topic!
  - for k8s-secrets: [ESO](https://external-secrets.io/latest/)
  - for secret files in the repo: [SOPS](https://github.com/getsops/sops) or [git-crypt](https://github.com/AGWA/git-crypt)
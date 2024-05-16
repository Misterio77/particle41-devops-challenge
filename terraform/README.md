# Terraform Infra

Some terraform code for some nifty AWS infra.

## Setup

You'll need an [AWS account](https://portal.aws.amazon.com/billing/signup), a dedicated [IAM](https://console.aws.amazon.com/iam/home#/users) user (please don't generate an
access key for root I beg you), and some [credentials](https://docs.aws.amazon.com/console/iam/self-accesskeys).

You can either provide your credentials as environment variables
(`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`), or set it up with AWS CLI
(`aws configure`). I recommend the latter, as you'll want it anyway to set up a
TF state S3. For more info, see the [AWS CLI
docs](https://docs.aws.amazon.com/streams/latest/dev/setup-awscli.html).

With that done, run `./state_init.sh` to create a S3 bucket for your TF state,
and init terraform with it. Don't worry if the bucket already exists, it will
still work as you'd expect.

If you prefer local state, comment out the `backend "s3"` block in `main.tf`,
or change to whichever
[backend](https://developer.hashicorp.com/terraform/language/settings/backends/configuration)
you'd rather use.

## Applying

```
terraform apply
```

OpenTofu also works, of course:

```
tofu apply
```

### Setting up kubectl for EKS

```
aws eks update-kubeconfig --name particle41-challenge
kubectl cluster-info
```

## Destroying

You know the drill. Simply use `terraform destroy` or `tofu destroy`.

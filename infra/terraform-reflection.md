<u>TERRAFORM REFLECTION</u>

39.1. Explain why the ‘import’ blocks were important in this lab. Explain how they work, and how the process would be different if you were starting a project from scratch.

    - Import blocks tell Terraform to actually import an existing resource. You specify which resource with the to =, and the id of the resource.
    - How would the process be different from scratch? Well, there would be nothing to import. You wouldn't add import blocks; you'd just define the resource blocks and set all the values within them. The reason we wrote those specific values out by hand is because we changed them in AWS priror to this lab.


39.2. Consider how Terraform tracks the infrastructure state, and explain why you did NOT use Terraform to manage the secrets stored in the Parameter Store service. Under what circumstances WOULD it be reasonable to use Terraform to manage these secrets?

    - Terraform files are public in a git repo. We don't want secrets on git, so it would be insecure to store them in the .tf files.
    - When would you manage secrets with tf? Possibly if the referenced secrets are in files tagged to ignore when pushing to git.
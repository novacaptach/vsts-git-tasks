# Enable Git Remote Access
Certain operations require access to the remote repository from during a build. This task updates a remote of the Git repository on the agent to allow access to the upstream repository on Visual Studio Team Services.

## Requirements
For this build task to work it is required that the `Allow Scripts to Access OAuth Token` option is set in the build definition options.

## Parameters
### Enable Git Remote Access
**Remote name:** Name of the remote which should be updated. Default is `origin`. 

## Related Tasks
[Restore Git Remote](https://github.com/iozag/vsts-git-tasks/blob/master/Tasks/RestoreGitRemote/README.md) should be called at the end of the build definition to restore the remote to its original value.

## Known issues
* Git-Lfs operations, like `git lfs fetch` still won't work with this. See [this Git-Lfs issue](https://github.com/github/git-lfs/issues/906)

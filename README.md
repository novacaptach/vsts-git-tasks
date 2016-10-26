# Git Build Tools for Team Foundation Build 2015
Build tasks for interacting with Git in [Team Foundation Build 2015](http://go.microsoft.com/fwlink/?LinkId=619385).

[![Build status](https://ci.appveyor.com/api/projects/status/p7kwwi3ss3poxna5/branch/master?svg=true)](https://ci.appveyor.com/project/IOZ/vsts-git-tasks/branch/master)

## Installation
The build tasks can be installed by installing the [Git Build Tools Extension](https://marketplace.visualstudio.com/items/ioz.vsts-git-build-tasks) from the Visual Studio Team Services Marketplace. 

## Available Tasks
* [Enable Git Remote Access](./Tasks/EnableGitRemoteAccess/README.md)

  Updates a remote of the Git repository on the agent to allow access to the upstream repository on Visual Studio Team Service.

* [Restore Git Remote](./Tasks/RestoreGitRemote/README.md)

  Restores a remote of the Git repository on the agent to the original URL as set by the Visual Studio Team Services agent.

## Usage
See the [Wiki](https://github.com/argusnetch/vsts-git-tasks/wiki) for documentation.

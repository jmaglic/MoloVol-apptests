# MoloVol Apptests
Bash scripts containing automated tests for [MoloVol](https://github.com/jmaglic/MoloVol). These scripts are used to run quick tests that ensure the app is working properly. The scripts can be used on MacOS or other Unix systems.

## How to use

Clone the repo to a folder inside the MoloVol root directory. Rename the repo folder "apptests". Run tests by executing the scripts.

```console
$ apptests/t_protein.bash bin/MoloVol
```

## Naming
Prefixes such as `t_` and `ex_` are used to group scripts together so that they can be executed by higher ordered scripts. For instance, running `all.bash` will run all tests that begin with `t_`.

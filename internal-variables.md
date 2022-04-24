# BASH Internal Variables


| Variable | Details |
|:---:|:---| 
| `$@` | Function/ Script positional parameters. Expands to `"$1" "$2" "$3"...` |
| `$*` | Same as above except expands to `$1 $2 $3...` |
| `$#` | Number of positional parameters passed to script |
| `$!` | Process ID of the last command. Right most for pipelines. |
| `$$` | ID of the process that executed BASH |
| `$?` | Exit status of last command |
| `$n` | Positional parameters where n=1, 2, 3, ..., 9 |
| `${n}` | Same as above but can be > 9 |
| `$0` | In a BASH script it expands to the name of the script |
| `$_` | Last field of last command |
| `$IFS` | Internal Field Separator |
| `$PATH` | Path environment variable used to look up executables |
| `$OLDPWD` | Previous working directory |
| `$PWD` | Present working directory |
| `$FUNCNAME` | Array of function names in the execution call stack |
| `$BASH_SOURCE` | Array containing source paths for elements in FUNCNAME array. Can be used to get the script path. |
| `$BASH_ALIASES` | Associative array containing all currently defined aliases |
| `$BASH_REMATCH` | Array of matches from the last regex match |
| `$BASH_VERSION` | Bash version string |
| `$BASH_VERSINFO` | An array of 6 elements with Bash version information |
| `$BASH` | Absolute path to the currently executing Bash shell itself (heuristically determined by bash based on argv[0] and the value of $PATH; may be wrong in corner cases) |
| `$BASH_SUBSHELL` | Bash subshell level |
| `$UID` | Real (not effective if different) User ID of the process running bash |
| `$PS1` | Primary command line prompt |
| `$PS2` |  Secondary command line prompt (used for additional input) |
| `$PS3` | Tertiary command line prompt (used in select loop) |
| `$PS4` | Quaternary command line prompt (used to append info with verbose output) |
| `$RANDOM` | A pseudo random integer between 0 and 32767 |
| `$REPLY` | Variable used by read by default when no variable is specified. Also used by select to return the user-supplied value |
| `$PIPESTATUS` | Array variable that holds the exit status values of each command in the most recently executed foreground pipeline |

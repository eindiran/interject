# interject

Inspect and edit the contents of a pipe. Useful for preventing `curl | sh` shennanigans.

```shell
command1 | interject [-e EDITOR] [-t TEMPDIR] | command2
```

## Installation

To install `interject`, run `install.sh`. This script may require root privileges to successfully complete the installation as it uses `install` to place files into `/usr/local/sbin` and `/usr/local/man`.

### Requirements
To install `interject`, your machine will need `core-utils` and `gzip`. To run the script, you'll need either a copy of `vim` or to set the environment variable `EDITOR`.

`interject` is intended to run on `*nix` systems, but has only been run on Linux.

## Options and Environment Variables

### Options
* `-n`: Don't wait for the input command to finish before opening the editor. Useful for examining the output of commands that take a long time to run before completion. Usage: `long-command | interject -n | command2`.
* `-e <editor>`: sets the editor used to view and edit the contents of a pipe to `<editor>`. E.g. `command1 | interject -e emacs | command2` will open the results of `command1` in `emacs`.
* `-t <tempdir>`: sets the temporary directory used by `interject` to `<tempdir>`. E.g. `command1 | interject -t /home/example/ | command2` will store the temporary file containing the output `command1` in the directory `/home/example`.

### Environment Variables
`interject` uses the `EDITOR` and `TEMPDIR` environment variables to control the editor and temporary directory used if the `-e` and `-t` options aren't used.

If `EDITOR` isn't set, the system's default version of `vim` is used by default. Likewise, if `TEMPDIR` isn't set, `/tmp` is used as the default.

## Use
`interject` blocks while waiting for the input pipe to complete, a la `sponge`. Once the data from the pipe has been copied into a temporary file, `interject` opens the temporary file with an editor. Make edits to the file, then if you want to run the file, save and exit.
If you don't want to run the script now that you've examined it, instead exit with an error code. 
If your editor doesn't support exiting with an error code, simply delete all lines in the file before saving and exiting. Once the editor has exited, `interject` will forward the output to STDOUT or the outgoing pipe, then delete the temporary file.

In `vim`, to run the file, make edits then exit with `:wq`. To exit without running the script, instead use `:cq`. If using the `-n` flag, you can reload the file in `vim` using either `:e`, `:e!`, or `:checktime`. Note that `:e!` will automatically overwrite your changes to the file so far.

### Examples
* `curl www.example.com/potentially-malicious-script.sh | interject -e emacs | sh`
    * Download the script at `www.example.com` using `curl`, opening the result with `emacs`. After editing it, run the script using `sh`.
* `interject < foo.txt | bar`
    * Edit a temporary copy of `foo.txt` then send the edited copy to the command `bar`.
* `long-command | interject -n -t /home/test-user > output`
    * Immediately open the results of `long-command` with the default editor, saving the temporary file in `/home/test-user`. Once complete, save the edited version to `output`.

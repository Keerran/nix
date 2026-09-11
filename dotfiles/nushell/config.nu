plugin use polars
plugin use gstat

$env.SHELL = "nu"
$env.EDITOR = "nvim"

def --wrapped rebuild [
    --force (-f)
    ...rest
] {
    cd ~/.config/nixv2
    git add -N .
    let exit_code = git diff --quiet | complete | get exit_code
    if $exit_code == 0 and not $force {
        print "No changes detected, exiting."
        return
    }
    print "NixOS Rebuilding..."

    sudo nixos-rebuild switch --flake .#desktop ...$rest

    let current = nixos-rebuild list-generations --json
        | from json
        | where current == true
        | first

    if $exit_code != 0 {
        git commit -am $"Generation ($current.generation)" -m $"NixOS version: ($current.nixosVersion)" -m $"Kernel version: ($current.kernelVersion)"
    }
}

def --wrapped ks [template: path, ...rest] {
    let $template = "/mnt/shared/Projects/kickstart" | path join $template
    kickstart $template ...$rest
}

use ~/.config/nushell/completions

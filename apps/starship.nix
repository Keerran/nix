{lib, ...}:
{
    programs.starship = {
        enable = true;
        settings = {
            format = lib.strings.concatStrings [
                "[ ](bg:#DA627D)"
                "$os"
                "$username"
                "[](bg:#FCA17D fg:#DA627D)"
                "$directory"
                "[](fg:#FCA17D bg:#86BBD8)"
                "$git_branch"
                "$git_status"
                "[](fg:#86BBD8 bg:#33658A)"
                "$nix_shell"
                "[ ](fg:#33658A)"
            ];
            username = {
                show_always = true;
                style_user = "fg:#FFFFFF bg:#DA627D";
                style_root = "fg:#FFFFFF bg:#DA627D";
                format = "[$user ]($style)";
                disabled = false;
            };

            # An alternative to the username module which displays a symbol that
            # represents the current operating system
            os = {
                style = "fg:#FFFFFF bg:#DA627D";
                disabled = true; # Disabled by default
            };
            directory = {
                style = "fg:#FFFFFF bg:#FCA17D";
                format = "[ $path ]($style)";
                truncation_length = 0;
                substitutions = {
                    # Here is how you can shorten some long paths by text replacement
                    # similar to mapped_locations in Oh My Posh:
                    # Keep in mind that the order matters. For example:
                    # "Important Documents" = " 󰈙 "
                    # will not be replaced, because "Documents" was already substituted before.
                    # So either put "Important Documents" before "Documents" or use the substituted version:
                    # "Important 󰈙 " = " 󰈙 "
                    "Documents" = "󰈙 ";
                    "Downloads" = " ";
                    "Music" = " ";
                    "Pictures" = " ";
                };
            };

            c = {
                symbol = " ";
                style = "fg:#FFFFFF bg:#33658A";
                format = "[ $symbol ($version) ]($style)";
            };
            docker_context = {
                symbol = " ";
                style = "fg:#FFFFFF bg:#06969A";
                format = "[ $symbol $context ]($style)";
            };
            elixir = {
                symbol = " ";
                style = "fg:#FFFFFF bg:#33658A";
                format = "[ $symbol ($version) ]($style)";
            };
            elm = {
                symbol = " ";
                style = "fg:#FFFFFF bg:#33658A";
                format = "[ $symbol ($version) ]($style)";
            };
            git_branch = {
                symbol = "";
                style = "fg:#FFFFFF bg:#86BBD8";
                format = "[ $symbol $branch ]($style)";
            };
            git_status = {
                style = "fg:#FFFFFF bg:#86BBD8";
                format = "[$all_status$ahead_behind ]($style)";
            };
            golang = {
                symbol = " ";
                style = "fg:#FFFFFF bg:#33658A";
                format = "[ $symbol ($version) ]($style)";
            };
            gradle = {
                style = "fg:#FFFFFF bg:#33658A";
                format = "[ $symbol ($version) ]($style)";
            };
            haskell = {
                symbol = " ";
                style = "fg:#FFFFFF bg:#33658A";
                format = "[ $symbol ($version) ]($style)";
            };
            java = {
                symbol = " ";
                style = "fg:#FFFFFF bg:#33658A";
                format = "[ $symbol ($version) ]($style)";
            };
            julia = {
                symbol = " ";
                style = "fg:#FFFFFF bg:#33658A";
                format = "[ $symbol ($version) ]($style)";
            };
            nodejs = {
                symbol = "";
                style = "fg:#FFFFFF bg:#33658A";
                format = "[ $symbol ($version) ]($style)";
            };
            nim = {
                symbol = "󰆥 ";
                style = "fg:#FFFFFF bg:#33658A";
                format = "[ $symbol ($version) ]($style)";
            };
            rust = {
                symbol = "";
                style = "fg:#FFFFFF bg:#33658A";
                format = "[ $symbol ($version) ]($style)";
            };
            nix_shell = {
                symbol = "";
                style = "fg:#FFFFFF bg:#33658A";
                format = "[ $symbol ($name) ]($style)";
            };
            scala = {
                symbol = " ";
                style = "fg:#FFFFFF bg:#33658A";
                format = "[ $symbol ($version) ]($style)";
            };
            time = {
                disabled = true;
                time_format = "%R"; # Hour:Minute Format
                style = "fg:#FFFFFF bg:#33658A";
                format = "[ ♥ $time ]($style)";
            };
        };
    };

}

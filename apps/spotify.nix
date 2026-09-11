{inputs, pkgs, ...}:
{
    imports = [
        inputs.spicetify-nix.homeManagerModules.default
    ];

    programs.spicetify = with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}; {
        enable = true;
        theme = themes.catppuccin;
        colorScheme = "mocha";
        enabledExtensions = with extensions; [
            shuffle
            fullAlbumDate
            goToSong
            skipStats
            showQueueDuration
            lastfm
            hidePodcasts
            sectionMarker
            skipAfterTimestamp
            catJamSynced
            spicyLyrics
        ];
    };
}

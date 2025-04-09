{ pkgs, lib, inputs, ... }:

{

  home.packages = with pkgs; [
    onlyoffice-desktopeditors
    spotify
    anki-bin
  ];

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
      { id = "nngceckbapebfimnlniiiahkandclblb"; }
      { id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"; }
      { id = "hipekcciheckooncpjeljhnekcoolahp"; }
      { id = "kabafodfnabokkkddjbnkgbcbmipdlmb"; }
      { id = "jldhpllghnbhlbpcmnajkpdmadaolakh"; }
      { id = "annfbnbieaamhaimclajlajpijgkdblo"; }
    ];
    commandLineArgs = [
      "--disable-features=WebRtcAllowInputVolumeAdjustment"
      "--ozone-platform-hint=auto"
    ];
  };

}

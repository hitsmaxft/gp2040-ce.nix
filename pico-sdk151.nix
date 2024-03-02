{ pkgs ? import <nixpkgs> {} }:
pkgs.pico-sdk.overrideAttrs(oldAttrs:
rec {

# pick sdk in main nixpkg is incomplete 
  pname = "pico-sdk";
  version = "1.5.1";
  src= pkgs.fetchgit {
    url="https://github.com/raspberrypi/pico-sdk.git";
    name ="source";
    branchName = version;
    leaveDotGit = true;
#build all tinyusb module will break Nix builder .so clone submodule in non-recursive
    postFetch = ''
                        cd $out
                        cat .gitmodules
                        # reset git status
                        git reset --hard HEAD
                        git submodule update --init
                        find . -type d -name ".git"  -exec rm -rf {} +;
    '';
    sha256 = "sha256-2wTAeCc26lSlP+Pjv3tjCBqVJaiKEtfpWMeOh4SNpUE=";
    fetchSubmodules = false;
  };
  nativeBuildInputs = with pkgs;[ cmake ];

  installPhase = oldAttrs.installPhase + ''


  '';
  system = builtins.currentSystem;
})


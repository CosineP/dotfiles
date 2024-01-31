{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation rec {
  name = "drmr";
  version = "2012-07-09";
  #outputs = [ "out" "lv2" ];
  #LV2_INSTALL_DIR = "${placeholder "lv2"}";
  src = pkgs.fetchFromGitHub {
    owner = "nicklan";
    repo = "drmr";
    rev = "ba6994a37592f02b6268e9f0d729c8770e1467e6";
    sha256 = "sha256-V8xwjC7yyW5jKu17YAJWxUqc4D85cR3aNYKdjONX8kg=";
  };
  buildInputs = with pkgs; [
    libsndfile
    libsamplerate
    lv2
    expat
    gtk2.out
    gtk2.dev
    pkg-config
    cmake
  ];
  patches = [ ./drmr_hydrogen.patch ];
}

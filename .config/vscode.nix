{pkgs ? import <nixpkgs> {}}:
with pkgs;
    (vscode-with-extensions.override { # need to figure out how to restore after 23-05
      vscodeExtensions = with vscode-extensions; [
        github.copilot
        rust-lang.rust-analyzer
        vscodevim.vim
        ocamllabs.ocaml-platform
      ] ++ vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "flowistry";
          publisher = "wcrichton";
          version = "0.5.34";
          vscodeExtUniqueId = "wcrichton.flowistry";
          sha256 = "sha256-6jYjum+AkLxbtsDmZipshFZSk/IuE4nnDMDOrRq6JMU=";
          # homeless shelter prevents me from putting this in a hook, maybe
          # so i ran it myself *before* switching and running vscode
          #  rustup toolchain install nightly-2022-11-07 --profile minimal -c rust-src -c rustc-dev -c llvm-tools-preview
          #  cargo +nightly-2022-11-07 install flowistry_ide --version 0.5.34 --force
        }
      ];
    })

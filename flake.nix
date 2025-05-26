{
  description = "Protobuf Language Server";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.buildGoModule {
          pname = "protobuf-language-server";
          version = "0.1.1";

          src = pkgs.fetchFromGitHub {
            owner = "lasorda";
            repo = "protobuf-language-server";
            rev = "v0.1.1";
            sha256 = "sha256-bDsvByXa2kH3DnvQpAq79XvwFg4gfhtOP2BpqA1LCI0=";
          };

          vendorHash = "sha256-dRria1zm5Jk7ScXh0HXeU686EmZcRrz5ZgnF0ca9aUQ=";

          doCheck = false;

          meta = with pkgs.lib; {
            description = "Language server for Protocol Buffers";
            homepage = "https://github.com/lasorda/protobuf-language-server";
            license = licenses.asl20;
            maintainers = [ ];
          };
        };

        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/protobuf-language-server";
        };
      });
}

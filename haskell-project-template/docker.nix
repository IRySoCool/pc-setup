{ nixpkgs ? import ./repository.nix, tag ? "latest" }:

let 
    my-app = import ./default.nix {};

    inherit (nixpkgs) dockerTools cacert;

    fromImage = dockerTools.pullImage {
        imageName = "lnl7/nix";
        finalImageTag = "2.3.7";
        imageDigest = "sha256:a9e3b037f4a582b195c9c8830ab63769d7c6bd1b3283834970017b2dd0028d77";
        sha256 = "0iwiprr351irx0lmvngbvwnyl5njviz4cq1a8mkd7203d6v4hmjh";
    };
in
dockerTools.buildImage {
    fromImage = fromImage;
    name = "app-image";
    contents = [ my-app cacert];
    tag = tag;
    created = "now";
    config = {
        Cmd = [ "/bin/Main" ];
        WorkingDir = "/bin";
        ExposedPorts = {
            "8081/tcp" = {};
        };
        Volumes = {
            "/bin/config.yaml" = {};
        };
    };
}
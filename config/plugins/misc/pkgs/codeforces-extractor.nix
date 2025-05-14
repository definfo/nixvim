{
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
  lib,
}:
rustPlatform.buildRustPackage {
  name = "codeforces-extractor";
  src = fetchFromGitHub {
    owner = "yunusey";
    repo = "codeforces-extractor";
    rev = "ed0953636be4849bd6eb91ce6a5e28cced5017d6";
    hash = "sha256-sy8brYzfUpb5zeIdhOLWijFC6M/3IQpSjr0lufXDCRc=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-iy2E1HHsZfsyGbd8P9qITRzdPqSORfX/xeG4tXy0OlM=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
  ];

  doCheck = false;

  meta = {
    description = "Blazingly fast codeforces problem extractor";
    homepage = "https://github.com/yunusey/codeforces-extractor";
    license = lib.licenses.unlicense;
    maintainers = [ ];
  };
}

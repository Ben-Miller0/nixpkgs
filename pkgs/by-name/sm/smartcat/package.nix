{ lib
, fetchFromGitHub
, rustPlatform

, darwin
, libX11
, openssl
, pkg-config
, stdenv
}:

rustPlatform.buildRustPackage rec {
  pname = "smartcat";
  version = "1.7.1";

  src = fetchFromGitHub {
    owner = "efugier";
    repo = "smartcat";
    rev = "refs/tags/${version}";
    hash = "sha256-62yvXrhk9JO7JBfD7tNFjba2nHxdqAVyMIW3q+2Aomc=";
  };

  cargoHash = "sha256-y0EA6pDxAO4mxZE+k15LUrjxsDD4A/KxvJltZL9Lqgc=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
    libX11
  ]
  ++ lib.optionals stdenv.hostPlatform.isDarwin [
    darwin.apple_sdk.frameworks.AppKit
    darwin.apple_sdk.frameworks.Security
    darwin.apple_sdk.frameworks.SystemConfiguration
  ];

  meta = {
    description = "Integrate large language models into the command line";
    homepage = "https://github.com/efugier/smartcat";
    changelog = "https://github.com/efugier/smartcat/releases/tag/v${version}";
    license = lib.licenses.asl20;
    platforms = lib.platforms.unix;
    mainProgram = "sc";
    maintainers = with lib.maintainers; [ lpchaim ];
  };
}

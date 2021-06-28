{ stdenv, lib, fetchFromGitHub, autoreconfHook }:

stdenv.mkDerivation rec {
  name = "libsodium-1.0.18";

  src = fetchFromGitHub {
    owner = "input-output-hk";
    repo = "libsodium";
    rev = "cd7a72c815a7553890bbd48382eb610eb8e53cc8";
    sha256 = "sha256-qouG/sqDO2njHAliFniT1daBXKikDFlf82LgyogWuqg=";
  };

  nativeBuildInputs = [ autoreconfHook ];

  configureFlags = "--enable-static";

  outputs = [ "out" "dev" ];
  separateDebugInfo = stdenv.isLinux && stdenv.hostPlatform.libc != "musl";

  enableParallelBuilding = true;

  doCheck = true;

  meta = with lib; {
    description = "A modern and easy-to-use crypto library";
    homepage = "http://doc.libsodium.org/";
    license = licenses.isc;
    maintainers = [ "tdammers" "nclarke" ];
    platforms = platforms.all;
  };
}

##########################################################
###############         Shelley MA         ###############
############### Cardano Node Configuration ###############
##########################################################

{
  ##### Locations #####

  ByronGenesisFile = ./shelley_ma-byron-genesis.json;
  ByronGenesisHash = "6d42dfd18c8306faaf12a96716747290d2465eea16f68f720afd72a53b417e2d";
  ShelleyGenesisFile = ./shelley_ma-shelley-genesis.json;
  ShelleyGenesisHash = "e00e672d3d42ac4a82f99457d0cefa49bb8fc336f0feb112f4ccab0b59e894ba";

  ##### Core protocol parameters #####

  # This is the instance of the Ouroboros family that we are running.
  # The node also supports various test and mock instances.
  # "RealPBFT" is the real (ie not mock) (permissive) OBFT protocol, which
  # is what we use on mainnet in Byron era.
  Protocol = "Cardano";

  # The mainnet does not include the network magic into addresses. Testnets do.
  RequiresNetworkMagic = "RequiresMagic";

  TestShelleyHardForkAtEpoch = 2;

  MaxKnownMajorProtocolVersion = 2;

  ##### Update system parameters #####

  # This protocol version number gets used by block producing nodes as part
  # part of the system for agreeing on and synchronising protocol updates.
  LastKnownBlockVersion-Major = 3;
  LastKnownBlockVersion-Minor = 0;
  LastKnownBlockVersion-Alt = 0;

  # In the Byron era some software versions are also published on the chain.
  # We do this only for Byron compatibility now.
  ApplicationName = "cardano-sl";
  ApplicationVersion = 0;
}

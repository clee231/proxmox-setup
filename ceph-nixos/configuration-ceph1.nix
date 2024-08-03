{ modulesPath, config, lib, pkgs, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable sshd
  services.openssh.enable = true;

  # Set hostname
  networking.hostName = "ceph1";

  # Enable experimental Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set timezone
  time.timeZone = "America/Chicago";

  # Install system packages
  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
    pkgs.neovim
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    # change this to your ssh key
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLAZqg1AiPzGu4U6wIqtCP8UIwFviQZphFCXCEBDCBrWMJ+A/555ROvcVMAPKGgmTKp6M79+fRfmSMcRpfmuEsvi3q/1I67C+JWgEeZayxYxCt075GLLSmvVeGpiLmW9h0e+xOmi1zWYJGFlB6aaVJrJjzo9dzOw9IXM1Jo3euS/nXPdMo1D4fVZZePfayj1ZcR/D7ldR5WGIn4JyaJhoQgoF/QT9HUfejcq9xc7PmgoQqDmybcF4FJrYhO+HDrGOGikENI+wgdJ/Hzj4FC2eYYXQWWYEVoM41Gmc4uDS4P+kBlL4+IZjDh5UmYcZRDE1XC8DBf5k351AT/zObrKmCdkKkSOsF/JmeNN2T6LixExXXri5ullk5Mt4ZzlT/4mZ/L+RftSW7a2//6CY59drpK6GUKqeN3prMjblMaQ0ifxJ0hdi8o+JG60w+2sye5+RPXTckriSvQ97USjCA7ypW93UUuLpmdGirIyJsSEcF+uIwTBXytvZ0cFTA5lppzsM= AniBase0-Win"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEj6lQEUMwndgAtypzRFkSGStAz4Bia4K8Xh9Cm+5Jdr user@nixos-provisioner"
  ];

  # Create 'user' user
  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLAZqg1AiPzGu4U6wIqtCP8UIwFviQZphFCXCEBDCBrWMJ+A/555ROvcVMAPKGgmTKp6M79+fRfmSMcRpfmuEsvi3q/1I67C+JWgEeZayxYxCt075GLLSmvVeGpiLmW9h0e+xOmi1zWYJGFlB6aaVJrJjzo9dzOw9IXM1Jo3euS/nXPdMo1D4fVZZePfayj1ZcR/D7ldR5WGIn4JyaJhoQgoF/QT9HUfejcq9xc7PmgoQqDmybcF4FJrYhO+HDrGOGikENI+wgdJ/Hzj4FC2eYYXQWWYEVoM41Gmc4uDS4P+kBlL4+IZjDh5UmYcZRDE1XC8DBf5k351AT/zObrKmCdkKkSOsF/JmeNN2T6LixExXXri5ullk5Mt4ZzlT/4mZ/L+RftSW7a2//6CY59drpK6GUKqeN3prMjblMaQ0ifxJ0hdi8o+JG60w+2sye5+RPXTckriSvQ97USjCA7ypW93UUuLpmdGirIyJsSEcF+uIwTBXytvZ0cFTA5lppzsM= AniBase0-Win"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEj6lQEUMwndgAtypzRFkSGStAz4Bia4K8Xh9Cm+5Jdr user@nixos-provisioner"
    ];
  };

  # Create 'ceph' user
  users.users.ceph = {
    isNormalUser = true;
    extraGroups = [ "wheel" "ceph" ];
  };

  # Setup ceph
  services.ceph = {
    enable = true;
    global = {
      fsid = "4fca2926-9187-4e29-ab50-6571df488f9d";
      clusterName = "cephfs";
      publicNetwork = "192.168.1.0/24";
      monInitialMembers = "192.168.1.2, 192.168.1.3, 192.168.1.4";
      monHost = "192.168.1.2, 192.168.1.3, 192.168.1.4";
    };

    osd = {
      enable = true;
      daemons = ["ceph1"];
    };
    mon = {
      enable = true;
      daemons = ["ceph1"];
    };
    mgr = {
      enable = true;
      daemons = ["ceph1"];
    };
  };

  system.stateVersion = "24.05";
}

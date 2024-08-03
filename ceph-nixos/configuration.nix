{ modulesPath, config, lib, pkgs, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.openssh.enable = true;

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    # change this to your ssh key
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLAZqg1AiPzGu4U6wIqtCP8UIwFviQZphFCXCEBDCBrWMJ+A/555ROvcVMAPKGgmTKp6M79+fRfmSMcRpfmuEsvi3q/1I67C+JWgEeZayxYxCt075GLLSmvVeGpiLmW9h0e+xOmi1zWYJGFlB6aaVJrJjzo9dzOw9IXM1Jo3euS/nXPdMo1D4fVZZePfayj1ZcR/D7ldR5WGIn4JyaJhoQgoF/QT9HUfejcq9xc7PmgoQqDmybcF4FJrYhO+HDrGOGikENI+wgdJ/Hzj4FC2eYYXQWWYEVoM41Gmc4uDS4P+kBlL4+IZjDh5UmYcZRDE1XC8DBf5k351AT/zObrKmCdkKkSOsF/JmeNN2T6LixExXXri5ullk5Mt4ZzlT/4mZ/L+RftSW7a2//6CY59drpK6GUKqeN3prMjblMaQ0ifxJ0hdi8o+JG60w+2sye5+RPXTckriSvQ97USjCA7ypW93UUuLpmdGirIyJsSEcF+uIwTBXytvZ0cFTA5lppzsM= AniBase0-Win"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEj6lQEUMwndgAtypzRFkSGStAz4Bia4K8Xh9Cm+5Jdr user@nixos-provisioner"
  ];

  system.stateVersion = "24.05";
}

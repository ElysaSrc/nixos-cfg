{ pkgs, lib, config, ... }:

let
  gpuIDs = [
    "10de:2484" # Graphics
    "10de:228b" # Audio
  ];
in {
  boot = {
    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
      "vfio_virqfd"
    ];

    kernelParams = [
      # enable IOMMU
      "amd_iommu=on"
    ];
  };

  # Creates the SecureBoot files
  environment.etc = {
    "ovmf/edk2-x86_64-secure-code.fd" = {
      source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-x86_64-secure-code.fd";
    };

    "ovmf/edk2-i386-vars.fd" = {
      source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-i386-vars.fd";
      mode = "0644";
      user = "libvirtd";
    };
  };

  hardware.opengl.enable = true;
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        swtpm = {
          enable = true;
          package = pkgs.swtpm-tpm2;
        };
        ovmf.packages = with pkgs; [
          OVMFFull.fd
        ];
      };
    };
  };
}

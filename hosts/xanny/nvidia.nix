{config,lib , pkgs, ...}:

{
   services.xserver.videoDrivers = ["nvidia"];
   
   hardware.graphics = {enable = true;};

   hardware.nvidia = {
	open = true; #funny opensource drivers

	modesetting.enable = true;
	#Powermanagement 
	powerManagement.enable = true;
	powerManagement.finegrained = true;

	nvidiaSettings = true;
	package = config.boot.kernelPackages.nvidiaPackages.stable;
	
	#environment.systemPackages = [pkgs.nvidia-vaapi-driver];

	prime = {
	     offload = {
		enable = true;
		enableOffloadCmd = true;

	     };
	     intelBusId = "PCI:0:2:0";
	     nvidiaBusId = "PCI:1:0:0";
	};
   };

   specialisation = {
	gpu-heavy.configuration = {
	    system.nixos.tags =["GPU-heavy"];

	    hardware.nvidia = {
		prime.offload.enable = lib.mkForce false;
		prime.offload.enableOffloadCmd = lib.mkForce false;

		prime.sync.enable = lib.mkForce true;
		powerManagement.finegrained = lib.mkForce false;
	    };
	};
   };
}

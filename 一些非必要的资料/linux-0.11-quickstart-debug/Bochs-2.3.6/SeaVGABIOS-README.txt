SeaVGABIOS is a sub-project of the SeaBIOS project - it is an open
source implementation of a 16bit X86 VGA BIOS
(http://en.wikipedia.org/wiki/Video_BIOS). SeaVGABIOS is the
default VGA BIOS on QEMU (http://www.qemu.org/). SeaVGABIOS can also
run natively on some X86 VGA hardware with coreboot (http://www.coreboot.org/).

Building SeaVGABIOS
===================

To build SeaVGABIOS, obtain the code, run `make
menuconfig` and select the type of VGA BIOS to build in the "VGA ROM"
menu. Once selected, run `make` and the final VGA BIOS binary will be
located in "out/vgabios.bin".

The choice of available VGA BIOSes within "make menuconfig" is
dependent on whether CONFIG_QEMU, CONFIG_COREBOOT, or CONFIG_CSM is
selected. Also, the debug options under the "Debugging" menu apply to
SeaVGABIOS. All other options found in "make menuconfig" apply only to
SeaBIOS and will not impact the SeaVGABIOS build.

If SeaVGABIOS is needed for multiple different devices (eg, QEMU's
cirrus emulation and QEMU's "dispi" emulation), then one must compile
SeaVGABIOS multiple times with the appropriate config for each build.

SeaVGABIOS code
===============

The source code for SeaVGABIOS is located in the SeaBIOS
git repository. The main VGA BIOS code is located in the "vgasrc/"
directory. The VGA BIOS code is always compiled in 16bit mode.

The SeaVGABIOS builds to a separate binary from the main SeaBIOS
binary, and much of the VGA BIOS code is separate from the main BIOS
code. However, much of the SeaBIOS developer documentation applies to
SeaVGABIOS. To contribute, please join the SeaBIOS mailing list.

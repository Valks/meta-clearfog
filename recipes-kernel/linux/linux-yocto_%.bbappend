# Based on linux-yocto-custom.bb

inherit kernel
require recipes-kernel/linux/linux-yocto.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
COMPATIBLE_MACHINE = "^clearfog(-gtr-(s4|l8))?$"

KERNEL_IMAGETYPE = "zImage"
KCONFIG_MODE = "--alldefconfig"

KERNEL_DEVICETREE_clearfog = " \
	armada-388-clearfog-base.dtb \
	armada-388-clearfog-pro.dtb \
	armada-388-clearfog.dtb \
	"

KERNEL_DEVICETREE_clearfog-gtr-s4 = " \
	armada-385-clearfog-gtr-s4.dtb \
	"

KERNEL_DEVICETREE_clearfog-gtr-l8 = " \
	armada-385-clearfog-gtr-l8.dtb \
	"

SRC_URI += " \
	file://clearfog.cfg \
	file://0001-ARM-dts-add-support-for-Clearfog-GTR.patch \
	file://0002-HACK-ARM-dts-clearfog-gtr-enable-WiFi-LTE-modules.patch \
	"

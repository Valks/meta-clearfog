FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

S = "${WORKDIR}/git"

SRC_URI_append = " \
	file://0001-ddr-marvell-a38x-allow-board-specific-clock-out-setu.patch \
	file://0002-board-clearfog-enable-both-DDR-clocks.patch \
	"

# Add the suitable configuration depending on the boot media.
SRC_URI_append_clearfog = " \
	file://${BOOT_MEDIA}.cfg \
	"

# Clearfog GTR always has eMMC
SRC_URI_append_clearfog-gtr-l8 = " \
	file://emmc.cfg \
	"
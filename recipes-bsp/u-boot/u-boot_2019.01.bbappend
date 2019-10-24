FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

S = "${WORKDIR}/git"

SRC_URI_append = " \
	file://0001-ddr-marvell-a38x-allow-board-specific-clock-out-setu.patch \
	file://0002-board-clearfog-enable-both-DDR-clocks.patch \
	"

# Clearfog GTR always has eMMC
SRC_URI_append_clearfog-gtr-l8 = " \
	file://emmc.cfg \
	"

do_configure_prepend() {
	if [ "${MACHINE}" = "clearfog-gtr-l8" ]; then
		bbinfo "Clearfog GTR-L8 only supports MMC, forcing to MMC."
	elif [ "${BOOT_MEDIA}" = "SDHC" ]; then
		${S}/scripts/kconfig/merge_config.sh -m -O ${WORKDIR}/build ${WORKDIR}/build/.config ${WORKDIR}/u-boot/sdhc.cfg
	elif [ "${BOOT_MEDIA}" = "MMC" ]; then
		${S}/scripts/kconfig/merge_config.sh -m -O ${WORKDIR}/build ${WORKDIR}/build/.config ${WORKDIR}/u-boot/mmc.cfg
	elif [ "${BOOT_MEDIA}" = "SPI" ]
	then
		bbinfo "SPI hasn't been tested, defaulting to SDHC."
		${S}/scripts/kconfig/merge_config.sh -m -O ${WORKDIR}/build ${WORKDIR}/build/.config ${WORKDIR}/u-boot/sdhc.cfg
	elif [ "${BOOT_MEDIA}" = "UART" ]
	then
		bbinfo "SPI hasn't been tested, defaulting to SDHC."
		${S}/scripts/kconfig/merge_config.sh -m -O ${WORKDIR}/build ${WORKDIR}/build/.config ${WORKDIR}/u-boot/sdhc.cfg
	elif [ "${BOOT_MEDIA}" = "M.2" ]
	then
		bbinfo "SPI hasn't been tested, defaulting to SDHC."
		${S}/scripts/kconfig/merge_config.sh -m -O ${WORKDIR}/build ${WORKDIR}/build/.config ${WORKDIR}/u-boot/sdhc.cfg
	else
		bbinfo "Unknown boot media target: ${BOOT_MEDIA}, using default SDHC."
	fi
}
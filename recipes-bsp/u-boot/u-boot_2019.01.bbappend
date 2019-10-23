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
		# Default to emmc, ignore.
	elif [ "${BOOT_MEDIA}" = "SDHC" ]; then
		grep -q '^CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR' ${S}/configs/${UBOOT_MACHINE} && \
			sed -i '/CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR/c\CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x141' ${S}/configs/${UBOOT_MACHINE} || \
			echo 'CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x141' >> ${S}/configs/${UBOOT_MACHINE}
	elif [ "${BOOT_MEDIA}" = "MMC" ]; then
		grep -q '^CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR' ${S}/configs/${UBOOT_MACHINE} && \
		sed -i '/CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR/c\CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x140' ${S}/configs/${UBOOT_MACHINE} || \
		echo 'CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x140' >> ${S}/configs/${UBOOT_MACHINE}
	elif [ "${BOOT_MEDIA}" = "SPI" ]; then
		# Set the SDHC, need to test if this is suitable.
		grep -q '^CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR' ${S}/configs/${UBOOT_MACHINE} && \
			sed -i '/CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR/c\CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x141' ${S}/configs/${UBOOT_MACHINE} || \
			echo 'CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x141' >> ${S}/configs/${UBOOT_MACHINE}
	elif [ "${BOOT_MEDIA}" = "UART" ]; then
		# Set the SDHC, need to test if this is suitable.
		grep -q '^CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR' ${S}/configs/${UBOOT_MACHINE} && \
			sed -i '/CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR/c\CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x141' ${S}/configs/${UBOOT_MACHINE} || \
			echo 'CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x141' >> ${S}/configs/${UBOOT_MACHINE}
	elif [ "${BOOT_MEDIA}" = "M.2" ]; then
		# Set the SDHC, need to test if this is suitable.
		grep -q '^CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR' ${S}/configs/${UBOOT_MACHINE} && \
			sed -i '/CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR/c\CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x141' ${S}/configs/${UBOOT_MACHINE} || \
			echo 'CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x141' >> ${S}/configs/${UBOOT_MACHINE}
	else
		bbfatal "Unknown boot media target: ${BOOT_MEDIA}"
	fi
}
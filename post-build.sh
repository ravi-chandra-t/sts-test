#!/bin/bash

fixup_extlinux_dtb_name()
{
	local DTB_NAME="$(sed -n 's/^BR2_LINUX_KERNEL_INTREE_DTS_NAME="\(.*\)"$/\1/p' ${BR2_CONFIG})"
	local EXTLINUX_PATH="${TARGET_DIR}/boot/extlinux/extlinux.conf"
	if [ ! -e ${EXTLINUX_PATH} ]; then
		echo "Can not find extlinux ${EXTLINUX_PATH}"
		exit 1
	fi

	sed -i -e "s/%DTB_NAME%/${DTB_NAME}/" ${EXTLINUX_PATH}
}

reorder_init_scripts()
{
	if test -f ${TARGET_DIR}/etc/init.d/S01syslogd; then
  		mv ${TARGET_DIR}/etc/init.d/S01syslogd ${TARGET_DIR}/etc/init.d/_S01syslogd
	fi
	
	if test -f ${TARGET_DIR}/etc/init.d/S02klogd; then
  		mv ${TARGET_DIR}/etc/init.d/S02klogd ${TARGET_DIR}/etc/init.d/_S02klogd
	fi
	
	if test -f ${TARGET_DIR}/etc/init.d/S02sysctl; then
  		mv ${TARGET_DIR}/etc/init.d/S02sysctl ${TARGET_DIR}/etc/init.d/_S02sysctl
	fi
	
	if test -f ${TARGET_DIR}/etc/init.d/S10mdev; then
  		mv ${TARGET_DIR}/etc/init.d/S10mdev ${TARGET_DIR}/etc/init.d/_S10mdev
	fi
	
	if test -f ${TARGET_DIR}/etc/init.d/S20seedrng; then
  		mv ${TARGET_DIR}/etc/init.d/S20seedrng ${TARGET_DIR}/etc/init.d/_S20seedrng
	fi
	
	if test -f ${TARGET_DIR}/etc/init.d/S30tee-supplicant; then
  		mv ${TARGET_DIR}/etc/init.d/S30tee-supplicant ${TARGET_DIR}/etc/init.d/_S30tee-supplicant
	fi
	
	if test -f ${TARGET_DIR}/etc/init.d/S40network; then
  		mv ${TARGET_DIR}/etc/init.d/S40network ${TARGET_DIR}/etc/init.d/_S40network
	fi
	
}
fixup_extlinux_dtb_name $@
reorder_init_scripts $@

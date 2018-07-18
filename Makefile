# SPDX-License-Identifier: LGPL-2.1-or-later
# Copyright © 2008-2018 ANSSI. All Rights Reserved.
LIB_FILES := netfilter_extra ipsec_extra netconf_extra
CONF_FILES :=
ETC_FILES := ipsec.conf ike2/ipsec.conf.skel conf.d/netconf
SCRIPTS := ipsec_list_clients ipsec_crl_reloader

INST_LIB := install -D -m 0500
INST_CONF  := install -D -m 0640 -o 4000 -g 4000
INST_ETC := install -D -m 0500
INST_SCRIPTS := install -D -m 0755

LIBDIR ?= lib

all:

ifdef ETC_PROFILE
install: install_conf install_init install_etc install_scripts
else
install:
	@echo "ETC_PROFILE must be set (etc-default or etc-noccsd)" >&2
	@exit 1
endif

install_conf:
	${foreach file, ${CONF_FILES}, ${INST_CONF} conf/$(file) ${DESTDIR}/etc/admin/conf.d/$(file); }

install_init:
	${foreach file, ${LIB_FILES}, ${INST_LIB} lib/$(file) ${DESTDIR}/${LIBDIR}/rc/net/$(file); }

install_etc:
	${foreach file, ${ETC_FILES}, ${INST_ETC} ${ETC_PROFILE}/$(file) ${DESTDIR}/etc/$(file); }

install_scripts:
	${foreach file, ${SCRIPTS}, ${INST_SCRIPTS} scripts/$(file) ${DESTDIR}/sbin/$(file); }


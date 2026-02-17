################################################################################
#
# nwipe
#
################################################################################

SHREDOS_VERSION_FILE = board/shredos/fsoverlay/etc/shredos/version.txt

NWIPE_VERSION = $(call qstrip,$(BR2_PACKAGE_NWIPE_GIT_REVISION))
NWIPE_DEPENDENCIES = ncurses parted dmidecode coreutils libconfig
NWIPE_SITE_METHOD = git

ifneq ($(call qstrip,$(BR2_PACKAGE_NWIPE_SITE)),)
NWIPE_SITE = $(call qstrip,$(BR2_PACKAGE_NWIPE_SITE))
else
NWIPE_SITE = https://github.com/martijnvanbrummelen/nwipe.git
endif

define NWIPE_INITSH
	(cd $(@D) && \
	cp ../../../package/nwipe/002-nwipe-banner-patch.sh . && \
	./002-nwipe-banner-patch.sh && \
	PATH="../../host/bin:${PATH}" ./autogen.sh)
endef

# Pre-configure hook, as a post-patch hook would not get triggered on a package
# reconfigure, and possibly also taint the sources directory with the generated
# autogen files (which should not be there).
NWIPE_PRE_CONFIGURE_HOOKS += NWIPE_INITSH

$(eval $(autotools-package))


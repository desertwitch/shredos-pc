################################################################################
#
# smartdmt
#
################################################################################

SMARTDMT_VERSION = $(call qstrip,$(BR2_PACKAGE_SMARTDMT_GIT_REVISION))

SMARTDMT_SITE = https://github.com/desertwitch/smartdmt.git
SMARTDMT_SITE_METHOD = git

SMARTDMT_LICENSE = MIT
SMARTDMT_LICENSE_FILES = LICENSE

SMARTDMT_GOMOD = github.com/desertwitch/smartdmt
SMARTDMT_GO_ENV = CGO_ENABLED=0

SMARTDMT_LDFLAGS = \
	-X main.Version=$(shell echo $(SMARTDMT_VERSION) | sed 's/^v//' | cut -c1-7)

SMARTDMT_BUILD_TARGETS = ./cmd/smartdmt

$(eval $(golang-package))

# -*- Mode: Makefile; indent-tabs-mode: t; tab-width: 2 -*-
#
# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Michael Terry

.PHONY: flatpak
flatpak:
	flatpak-builder --repo=$(HOME)/repo \
	                --force-clean \
	                builddir \
	                org.gnome.DejaDup.yaml
	flatpak install --or-update --user -y org.gnome.DejaDup

.PHONY: clean
clean:
	rm -rf builddir

.PHONY: lint
lint:
	reuse lint

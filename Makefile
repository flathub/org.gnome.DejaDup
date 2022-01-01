# -*- Mode: Makefile; indent-tabs-mode: t; tab-width: 2 -*-
#
# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: Michael Terry

.PHONY: flatpak
flatpak:
	flatpak-builder --install \
	                --user \
	                --force-clean \
	                _build \
	                org.gnome.DejaDup.yaml

.PHONY: clean
clean:
	rm -rf _build

.PHONY: lint
lint:
	reuse lint

# -*- Mode: Makefile; indent-tabs-mode: t; tab-width: 2 -*-

.PHONY: flatpak
flatpak:
	flatpak-builder --repo=$(HOME)/repo \
	                --force-clean \
	                builddir \
	                org.gnome.DejaDup.yaml
	flatpak update --user -y org.gnome.DejaDup

.PHONY: clean
clean:
	rm -rf builddir


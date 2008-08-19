indexing
	description: "Enumeration for GDI+ pixel format."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_PIXEL_FORMAT

feature -- Enumeration

	Alpha: INTEGER is 0x40000
			-- Alpha

	Canonical: INTEGER is 0x200000
			-- Canonical

	DontCare: INTEGER is 0
			-- DontCare

	Extended: INTEGER is 0x100000
			-- Extended

	Format16bppArgb1555: INTEGER is 0x61007
			-- Format16bppArgb1555

	Format16bppGrayScale: INTEGER is 0x101004
			-- Format16bppGrayScale

	Format16bppRgb555: INTEGER is 0x21005
			-- Format16bppRgb555

	Format16bppRgb565: INTEGER is 0x21006
			-- Format16bppRgb565

	Format1bppIndexed: INTEGER is 0x30101
			-- Format1bppIndexed

	Format24bppRgb: INTEGER is 0x21808
			-- Format24bppRgb

	Format32bppArgb: INTEGER is 0x26200a
			-- Format32bppArgb

	Format32bppPArgb: INTEGER is 0xe200b
			-- Format32bppPArgb

	Format32bppRgb: INTEGER is 0x22009
			-- Format32bppRgb

	Format48bppRgb: INTEGER is 0x10300c
			-- Format48bppRgb

	Format4bppIndexed: INTEGER is 0x30402
			-- Format4bppIndexed

	Format64bppArgb: INTEGER is 0x34400d
			-- Format64bppArgb

	Format64bppPArgb: INTEGER is 0x1c400e
			-- Format64bppPArgb

	Format8bppIndexed: INTEGER is 0x30803
			-- Format8bppIndexed

	Gdi: INTEGER is 0x20000
			-- Gdi

	Indexed: INTEGER is 0x10000
			-- Indexed

	Max: INTEGER is 15
			-- Max

	PAlpha : INTEGER is 0x80000
			-- PAlpha

	Undefined: INTEGER is 0
			-- Undefined

feature -- Query

	is_valid (a_format: INTEGER): BOOLEAN is
			-- If `a_format' valid?
		do
			Result := a_format = Alpha
			    or a_format = Canonical
				or a_format = DontCare
				or a_format = Extended
				or a_format = Format16bppArgb1555
				or a_format = Format16bppGrayScale
				or a_format = Format16bppRgb555
				or a_format = Format16bppRgb565
				or a_format = Format1bppIndexed
				or a_format = Format24bppRgb
				or a_format = Format32bppArgb
				or a_format = Format32bppPArgb
				or a_format = Format32bppRgb
				or a_format = Format48bppRgb
				or a_format = Format4bppIndexed
				or a_format = Format64bppArgb
				or a_format = Format64bppPArgb
				or a_format = Format8bppIndexed
				or a_format = Gdi
				or a_format = Indexed
				or a_format = Max
				or a_format = PAlpha
				or a_format = Undefined
		end

	is_valid_format (a_format: INTEGER): BOOLEAN is
			-- If `a_format' valid pixel format enumeration
		do
			Result := a_format = Format16bppArgb1555
				or a_format = Format16bppGrayScale
				or a_format = Format16bppRgb555
				or a_format = Format16bppRgb565
				or a_format = Format1bppIndexed
				or a_format = Format24bppRgb
				or a_format = Format32bppArgb
				or a_format = Format32bppPArgb
				or a_format = Format32bppRgb
				or a_format = Format48bppRgb
				or a_format = Format4bppIndexed
				or a_format = Format64bppArgb
				or a_format = Format64bppPArgb
				or a_format = Format8bppIndexed
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end

indexing
	description	: "Window drawing constants (DT_xxxx, DI_xxxx, ...)"
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_DRAWING_CONSTANTS

create
	default_create

feature -- DrawText constants (DT_xxxx)

	Dt_top: INTEGER is 0
			-- Declared in Windows as DT_TOP

	Dt_left: INTEGER is 0
			-- Declared in Windows as DT_LEFT

	Dt_center: INTEGER is 1
			-- Declared in Windows as DT_CENTER

	Dt_right: INTEGER is 2
			-- Declared in Windows as DT_RIGHT

	Dt_vcenter: INTEGER is 4
			-- Declared in Windows as DT_VCENTER

	Dt_bottom: INTEGER is 8
			-- Declared in Windows as DT_BOTTOM

	Dt_wordbreak: INTEGER is 16
			-- Declared in Windows as DT_WORDBREAK

	Dt_singleline: INTEGER is 32
			-- Declared in Windows as DT_SINGLELINE

	Dt_expandtabs: INTEGER is 64
			-- Declared in Windows as DT_EXPANDTABS

	Dt_tabstop: INTEGER is 128
			-- Declared in Windows as DT_TABSTOP

	Dt_noclip: INTEGER is 256
			-- Declared in Windows as DT_NOCLIP

	Dt_externalleading: INTEGER is 512
			-- Declared in Windows as DT_EXTERNALLEADING

	Dt_calcrect: INTEGER is 1024
			-- Declared in Windows as DT_CALCRECT

	Dt_noprefix: INTEGER is 2048
			-- Declared in Windows as DT_NOPREFIX

	Dt_internal: INTEGER is 4096
			-- Declared in Windows as DT_INTERNAL

feature -- DrawImage constants (DI_xxxx)

	Di_compat: INTEGER is 4
			-- Declared in Windows as DI_COMPAT

	Di_defaultsize: INTEGER is 8
			-- Declared in Windows as DI_DEFAULTSIZE

	Di_image: INTEGER is 2
			-- Declared in Windows as DI_IMAGE

	Di_mask: INTEGER is 1
			-- Declared in Windows as DI_MASK

	Di_normal: INTEGER is 3
			-- Declared in Windows as DI_NORMAL

end -- class WEL_DRAWING_CONSTANTS

note
	description: "Choose font (CF) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CF_CONSTANTS

feature -- Access

	Cf_screenfonts: INTEGER = 1

	Cf_printerfonts: INTEGER = 2

	Cf_both: INTEGER = 3
			-- `Cf_screenfonts' | `Cf_printerfonts'.

	Cf_showhelp: INTEGER = 4

	Cf_enablehook: INTEGER = 8

	Cf_enabletemplate: INTEGER = 16

	Cf_enabletemplatehandle: INTEGER = 32

	Cf_inittologfontstruct: INTEGER = 64

	Cf_usestyle: INTEGER = 128

	Cf_effects: INTEGER = 256

	Cf_apply: INTEGER = 512

	Cf_ansionly: INTEGER = 1024

	Cf_novectorfonts: INTEGER = 2048

	Cf_nooemfonts: INTEGER = 2048
			-- Same as `Cf_novectorfonts'.

	Cf_nosimulations: INTEGER = 4096

	Cf_limitsize: INTEGER = 8192

	Cf_fixedpitchonly: INTEGER = 16384

	Cf_wysiwyg: INTEGER = 32768
			-- To be used with `Cf_both'.

	Cf_forcefontexist: INTEGER = 65536

	Cf_scalableonly: INTEGER = 131072

	Cf_ttonly: INTEGER = 262144

	Cf_nofacesel: INTEGER = 524288

	Cf_nostylesel: INTEGER = 1048576

	Cf_nosizesel: INTEGER = 2097152

	Cf_noscriptsel: INTEGER = 8388608;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_CF_CONSTANTS


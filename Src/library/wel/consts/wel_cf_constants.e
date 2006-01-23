indexing
	description: "Choose font (CF) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CF_CONSTANTS

feature -- Access

	Cf_screenfonts: INTEGER is 1

	Cf_printerfonts: INTEGER is 2

	Cf_both: INTEGER is 3
			-- `Cf_screenfonts' | `Cf_printerfonts'.

	Cf_showhelp: INTEGER is 4

	Cf_enablehook: INTEGER is 8

	Cf_enabletemplate: INTEGER is 16

	Cf_enabletemplatehandle: INTEGER is 32

	Cf_inittologfontstruct: INTEGER is 64

	Cf_usestyle: INTEGER is 128

	Cf_effects: INTEGER is 256

	Cf_apply: INTEGER is 512

	Cf_ansionly: INTEGER is 1024

	Cf_novectorfonts: INTEGER is 2048

	Cf_nooemfonts: INTEGER is 2048
			-- Same as `Cf_novectorfonts'.

	Cf_nosimulations: INTEGER is 4096

	Cf_limitsize: INTEGER is 8192

	Cf_fixedpitchonly: INTEGER is 16384

	Cf_wysiwyg: INTEGER is 32768
			-- To be used with `Cf_both'.

	Cf_forcefontexist: INTEGER is 65536

	Cf_scalableonly: INTEGER is 131072

	Cf_ttonly: INTEGER is 262144

	Cf_nofacesel: INTEGER is 524288

	Cf_nostylesel: INTEGER is 1048576

	Cf_nosizesel: INTEGER is 2097152

	Cf_noscriptsel: INTEGER is 8388608;

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




end -- class WEL_CF_CONSTANTS


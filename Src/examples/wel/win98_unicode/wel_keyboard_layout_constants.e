class
	WEL_KEYBOARD_LAYOUT_CONSTANTS

feature {NONE} --Constants


	Hkl_prev: INTEGER is 0
		--Previous locale identifier
		
	Hkl_next: INTEGER is 1
		--Next locale identifier
		
	Klf_activate: INTEGER is 1

	Klf_substitute_ok: INTEGER is 2
		
	Klf_unload_previous: INTEGER is 4
		
	Klf_reorder: INTEGER is 8
		--Reorder locale identifiers starting with current as first

	Kl_namelength: INTEGER is 9 	
		
	--Windows 2000 or later
	Klf_replace_lang: INTEGER is 16
	
	Klf_notellshell: INTEGER is 128
	
	Klf_set_for_process: INTEGER is 256
	

end -- class WEL_KEYBOARD_LAYOUT_CONSTANTS

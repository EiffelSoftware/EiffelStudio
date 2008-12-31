note
	description: "Server configuration constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	EOLE_SERVER_CONFIGURATION


feature -- Access

	clsid: STRING = "{2DB76EC0-9672-11D2-B961-00403392AC95}"
			-- String representation of CLSID of component
			-- Should be filled by user

	typelib_id: STRING = "{0B72E240-AA36-11D2-B961-00403392AC95}"
			-- String representation of UUID of component's type library
			-- Should be filled by user

	dispinterface_id: STRING = "{9A383B80-AA39-11D2-B961-00403392AC95}"
				-- String representation of UUID of dispinterface
			-- Should be filled by user

	component_name: STRING = "EiffelCOM ActivX example"
			-- Component name
			-- Should be filled by user
	
	company_name: STRING = "ISE"
			-- Company name
			-- Should be filled by user

	product_name: STRING = "Example"
			-- Product name
			-- Should be filled by user

	major_version_number: INTEGER = 1
			-- Major version namber
			-- Should be filled by user

	minor_version_number: INTEGER = 0;
			-- Minor version number
			-- Should be filled by user


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


end -- class EOLE_SERVER_CONFIGURATION

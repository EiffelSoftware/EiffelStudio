indexing
	description: "Server configuration constants"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	EOLE_SERVER_CONFIGURATION


feature -- Access

	clsid: STRING is ""
			-- String representation of CLSID of component
			-- Should be filled by user

	typelib_id: STRING is ""
			-- String representation of UUID of component's type library
			-- Should be filled by user

	dispinterface_id: STRING is ""
				-- String representation of UUID of dispinterface
			-- Should be filled by user

	component_name: STRING is ""
			-- Component name
			-- Should be filled by user
	
	company_name: STRING is ""
			-- Company name
			-- Should be filled by user

	product_name: STRING is ""
			-- Product name
			-- Should be filled by user

	major_version_number: INTEGER is 
			-- Major version namber
			-- Should be filled by user

	minor_version_number: INTEGER is 
			-- Minor version number
			-- Should be filled by user


end -- class EOLE_SERVER_CONFIGURATION

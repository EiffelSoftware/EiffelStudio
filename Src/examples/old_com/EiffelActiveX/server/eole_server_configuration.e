indexing
	description: "Server configuration constants"
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	EOLE_SERVER_CONFIGURATION


feature -- Access

	clsid: STRING is "{2DB76EC0-9672-11D2-B961-00403392AC95}"
			-- String representation of CLSID of component
			-- Should be filled by user

	typelib_id: STRING is "{0B72E240-AA36-11D2-B961-00403392AC95}"
			-- String representation of UUID of component's type library
			-- Should be filled by user

	dispinterface_id: STRING is "{9A383B80-AA39-11D2-B961-00403392AC95}"
				-- String representation of UUID of dispinterface
			-- Should be filled by user

	component_name: STRING is "EiffelCOM ActivX example"
			-- Component name
			-- Should be filled by user
	
	company_name: STRING is "ISE"
			-- Company name
			-- Should be filled by user

	product_name: STRING is "Example"
			-- Product name
			-- Should be filled by user

	major_version_number: INTEGER is 1
			-- Major version namber
			-- Should be filled by user

	minor_version_number: INTEGER is 0
			-- Minor version number
			-- Should be filled by user


end -- class EOLE_SERVER_CONFIGURATION

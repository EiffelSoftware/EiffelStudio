indexing
	description: "Light encapsulation of COM basics for Unmanaged MetaData and Debugger APIs."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_COM

feature -- High level

	initialize_com is
			-- Call `com_initialize' only once as required
			-- per Windows documentation.
		once
			com_initialize
		end

feature -- Disposal

	release (a_pointer: POINTER) is
			-- Release COM objects represented by `a_pointer'.
		external
			"C++ [IUnknown <unknwn.h>]"
		alias
			"Release"
		end
		
feature {NONE} -- Initialization

	com_initialize is
			-- Call to `CoInitialize' to initialize COM.
			-- To be done once.
		external
			"C use %"cli_writer.h%""
		end

end -- class CLI_COM

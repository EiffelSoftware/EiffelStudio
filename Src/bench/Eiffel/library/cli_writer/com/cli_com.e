indexing
	description: "Light encapsulation of COM basics for Unmanaged MetaData and Debugger APIs."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_COM

feature -- Access

	com_initialize is
			-- Call to `CoInitialize' to initialize COM.
			-- To be done once.
		external
			"C use %"pe_writer.h%""
		end

	release (a_pointer: POINTER) is
			-- Release COM objects represented by `a_pointer'.
		external
			"C++ [IUnknown <unknwn.h>]"
		alias
			"Release"
		end

end -- class CLI_COM

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
		local
			l_result: INTEGER
		once
			l_result := com_initialize
			check
				call_succeed: l_result = com_S_OK or else l_result = com_S_FALSE
			end
		end

feature -- Disposal

	release (a_pointer: POINTER) is
			-- Release COM objects represented by `a_pointer'.
		external
			"C++ IUnknown use %"unknwn.h%""
		alias
			"Release"
		end
		
feature {NONE} -- Initialization

--	com_initialize is
--			-- Call to `CoInitialize' to initialize COM.
--			-- To be done once.
--		external
--			"C use %"cli_writer.h%""
--		end

	com_initialize: INTEGER is
		external
			"C inline use %"unknwn.h%""
		alias
			"CoInitialize(NULL)"
		end

--	com_initialize_apartment_threaded: INTEGER is
--		external
--			"C++ inline use %"objbase.h%""
--		alias
--			"CoInitializeEx(NULL, COINIT_APARTMENTTHREADED)"
--		end
--
--	com_initialize_multithreaded: INTEGER is
--		external
--			"C++ inline use %"objbase.h%""
--		alias
--			"CoInitializeEx(NULL, COINIT_MULTITHREADED)"
--		end

	com_S_OK: INTEGER is
		external
			"C macro use %"objbase.h%""
		alias
			"S_OK"
		end

	com_S_FALSE: INTEGER is
		external
			"C macro use %"unknwn.h%""
		alias
			"S_FALSE"
		end

end -- class CLI_COM

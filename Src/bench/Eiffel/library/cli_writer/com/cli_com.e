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
			l_result := com_initialize_multithreaded
			check
				call_succeed: l_result = com_S_OK or else l_result = com_S_FALSE
			end
		end

feature -- Disposal

	frozen release (a_pointer: POINTER) is
			-- Release COM objects represented by `a_pointer'.
		external
			"C++ IUnknown use %"unknwn.h%""
		alias
			"Release"
		end
		
feature {NONE} -- Initialization

	frozen com_initialize: INTEGER is
		external
			"C inline use %"unknwn.h%""
		alias
			"CoInitialize(NULL)"
		end

	frozen com_initialize_multithreaded: INTEGER is
		external
			"C++ inline use %"objbase.h%""
		alias
			"CoInitializeEx(NULL, COINIT_MULTITHREADED)"
		end

	frozen com_initialize_apartmentthreaded: INTEGER is
		external
			"C++ inline use %"objbase.h%""
		alias
			"CoInitializeEx(NULL, COINIT_APARTMENTTHREADED)"
		end	

	frozen com_S_OK: INTEGER is
		external
			"C macro use %"objbase.h%""
		alias
			"S_OK"
		end

	frozen com_S_FALSE: INTEGER is
		external
			"C macro use %"unknwn.h%""
		alias
			"S_FALSE"
		end

end -- class CLI_COM

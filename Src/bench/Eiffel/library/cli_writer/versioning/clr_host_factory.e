indexing
	description: "Manage unique instance of COR_RUNTIME_HOST."
	date: "$Date$"
	revision: "$Revision$"

class
	CLR_HOST_FACTORY

inherit
	CLR_HOST_STARTUP_FLAGS
	
feature -- Access
	
	runtime_host (version: STRING; flags: INTEGER): CLR_HOST is
			-- CLR runtime version currently loaded in process.
			-- Check documentation available at:
			-- http://msdn.microsoft.com/library/default.asp?url=/library/en-us/cpgenref/html/grfuncorbindtoruntimeex.asp
		local
			l_version: UNI_STRING
			l_host: POINTER
		once
			if version = Void or else version.is_empty then
					-- Default version.
				create l_version.make ("v1.0.3705")
			else			
				create l_version.make (version)
			end
			l_host := new_cor_runtime_host (l_version.item, flags)
			if l_host /= default_pointer then
				create Result.make_by_pointer (l_host)
			end
		end

feature {NONE} -- Implementation

	new_cor_runtime_host (version: POINTER; flags: INTEGER): POINTER is
			-- Create a new instance of ICorRuntimeHost. Used to fix version of the CLR
			-- being used by compiler to generate IL code.
		external
			"C signature (LPWSTR, DWORD): EIF_POINTER use %"cli_writer.h%""
		end

end -- class CLR_HOST_FACTORY

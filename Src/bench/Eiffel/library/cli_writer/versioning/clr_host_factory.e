indexing
	description: "Manage unique instance of COR_RUNTIME_HOST."
	date: "$Date$"
	revision: "$Revision$"

class
	CLR_HOST_FACTORY

inherit
	CLR_HOST_STARTUP_FLAGS
	
feature -- Access
	
	runtime_host (version: STRING): CLR_HOST is
			-- CLR runtime version currently loaded in process.
			-- Check documentation available at:
			-- http://msdn.microsoft.com/library/default.asp?url=/library/en-us/cpgenref/html/grfuncorbindtoruntimeex.asp
		require
			has_version: version /= Void implies (create {IL_ENVIRONMENT}).installed_runtimes.has (version)
		local
			l_version: UNI_STRING
			l_host: POINTER
		once
			if version = Void then
					-- Default version.
				create l_version.make ((create {IL_ENVIRONMENT}).default_version)
			else			
				create l_version.make (version)
			end
			l_host := new_cor_runtime_host (l_version.item, 0)
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

indexing
	description: "Create COM_ISE_CACHE_MANAGER instances"
	date: "$Date$"
	revision: "$Revision$"

class
	EMITTER_FACTORY

inherit
	CLI_COM
	
	CLR_HOST_FACTORY
		export
			{NONE} all
		end

feature -- Initialization

	new_emitter (runtime_version: STRING): COM_ISE_CACHE_MANAGER is
			-- Create a new instance of COM_ISE_CACHE_MANAGER.
		local
			p: POINTER
			l_host: CLR_HOST
		do
			initialize_com
			l_host := runtime_host (runtime_version)
			check
				l_host_not_void: l_host /= Void
			end
			p := c_new_ise_cache_manager
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end

feature {NONE} -- Externals

	c_new_ise_cache_manager: POINTER is
			-- Creates new instance of ISE_Cache_COM_ISE_CACHE_MANAGER.
		external
			"C use %"cli_writer.h%""
		alias
			"new_ise_cache_manager"
		end

end -- class EMITTER_FACTORY

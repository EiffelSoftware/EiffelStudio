indexing
	description: "Create COM_ISE_CACHE_MANAGER instances"
	date: "$Date$"
	revision: "$Revision$"

class
	EMITTER_FACTORY

inherit
	CLI_COM

feature -- Initialization

	new_emitter: COM_ISE_CACHE_MANAGER is
			-- Create a new instance of FUSION_SUPPORT.
		local
			p: POINTER
		do
			initialize_com
			p := c_new_ise_cache_manager
			if p /= default_pointer then
				create Result.make_by_pointer (p)
				Result.initialize
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

indexing
	description: "Create FUSION_XX instances."
	date: "$Date$"
	revision: "$Revision$"

class
	FUSION_FACTORY

inherit
	CLI_COM

feature -- Initialization

	new_fusion_support: FUSION_SUPPORT is
			-- Create a new instance of FUSION_SUPPORT.
		local
			p: POINTER
		do
			initialize_com
			p := c_new_fusion_support
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end

feature {NONE} -- Externals

	c_new_fusion_support: POINTER is
			-- New instance of IFusionSupport
		external
			"C use %"cli_writer.h%""
		alias
			"new_fusion_support"
		end

end -- class FUSION_FACTORY

indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CREATION_FEATURE_BL

inherit
	CREATION_FEATURE_B
		rename
			parent as bad_parent
		undefine
			set_parent, has_call, is_polymorphic, generate_on,
			basic_register, analyze, register, analyze_on, free_register,
			set_register, is_feature_call, generate_access_on_type,
			generate_access, generate_special_feature, allocates_memory,
			generate_parameters_list, fill_from
		end

	FEATURE_BL
		undefine
			generate, enlarged, is_first, context_type, generate_end
		select
			parent
		end

end -- class CREATION_FEATURE_BL

indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CREATION_FEATURE_BW

inherit
	CREATION_FEATURE_BL
		undefine
			check_dt_current, generate_access_on_type, is_polymorphic,
			need_invariant, set_need_invariant, fill_from
		redefine
			parent
		end

	FEATURE_BW
		undefine
			enlarged, generate, is_first, context_type, generate_end
		redefine
			parent
		end

creation
	make

feature -- 

	parent: NESTED_BL

end -- class CREATION_FEATURE_BW

indexing
	description: "Error for a custom attribute where value is not a constant."
	date: "$Date$"
	revision: "$Revision$"

class
	VICA2
	
inherit
	VICA
		redefine
			build_explain, subcode
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: like context_class; a_feature: FEATURE_I) is
			-- Create new error because incorrect custom attribute creation
			-- of type `a_creation_type' in `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_feature_not_void: a_feature /= Void
		do
			context_class := a_class
			set_feature (a_feature)
		ensure
			context_class_set: context_class = a_class
		end

feature -- Properties

	subcode: INTEGER is 2
			-- Subcode of error.

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Display error message
		do
			st.add_string ("Value provided for custom attribute is not constant.")
			st.add_new_line
		end

end

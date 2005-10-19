indexing
	description: "Errors when an incorrect named argument is provided in custom attribute."
	date: "$Date$"
	revision: "$Revision$"

class
	VICA3

inherit
	VICA
		redefine
			build_explain, subcode
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: like context_class; a_feature: FEATURE_I; a_creation_type: like creation_type) is
			-- Create new error because incorrect custom attribute creation
			-- of type `a_creation_type' in `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_creation_type: a_creation_type /= Void
			a_feature_not_void: a_feature /= Void
		do
			context_class := a_class
			creation_type := a_creation_type
			set_feature (a_feature)
		ensure
			context_class_set: context_class = a_class
			creatiion_type_set: creation_type = a_creation_type
		end

feature -- Access

	creation_type: CL_TYPE_A
			-- Type of custom attribute.

	named_argument_feature: FEATURE_I
			-- Feature being using for named argument setting.
			
	named_argument_name: STRING
			-- Name of not found `named_argument_feature'.

feature -- Properties

	subcode: INTEGER is 3
			-- Subcode of error.

feature -- Settings

	set_named_argument_feature (a_feat: like named_argument_feature) is
			-- Set feature associated to `named_argument_feature' which is not valid for 
			-- custom attriibute creation.
		require
			a_feat_not_void: a_feat /= Void
		do
			named_argument_feature := a_feat
		ensure
			named_argument_set: named_argument_feature = a_feat
		end
		
	set_named_argument_name (a_name: like named_argument_name) is
			-- Set `named_argument_name' with `a_name'.
		require
			a_name_not_void: a_name /= Void
		do
			named_argument_name := a_name
		ensure
			named_argument_name_set: named_argument_name = a_name
		end
		
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Display error message
		do
			st.add_string ("Incorrect custom attribute specification in ")
			st.add_class (context_class.lace_class)
			st.add_string (".")
			st.add_new_line
			st.add_string ("Type of custom attribute being created ")
			st.add_class (creation_type.associated_class.lace_class)
			st.add_string (".")
			if named_argument_name /= Void then
				st.add_new_line
				st.add_string ("Could not find feature ") 
				st.add_string (named_argument_name)
				st.add_string (" in ")
				st.add_class (context_class.lace_class)
				st.add_string (".")
			else
				if named_argument_feature /= Void then
					st.add_new_line
					st.add_string ("Name of invalid custom attribute named argument ")
					st.add_feature (
						named_argument_feature.api_feature (creation_type.associated_class.class_id),
						named_argument_feature.feature_name)
					st.add_string (".")
				end
			end
			st.add_new_line
		end

invariant
	creation_type_not_void: creation_type /= Void

end

indexing
	description: "Errors when an incorrect named argument is provided in custom attribute."
	date: "$Date$"
	revision: "$Revision$"

class
	VICA

inherit
	ERROR

create
	make

feature {NONE} -- Initialization

	make (a_class: like context_class; a_creation_type: like creation_type) is
			-- Create new error because incorrect custom attribute creation
			-- of type `a_creation_type' in `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_creation_type: a_creation_type /= Void
		do
			context_class := a_class
			creation_type := a_creation_type
		ensure
			context_class_set: context_class = a_class
			creatiion_type_set: creation_type = a_creation_type
		end

feature -- Access

	context_class: CLASS_C
			-- Class in which custom attribute is in.
			
	creation_type: CL_TYPE_A
			-- Type of custom attribute.

	named_argument: FEATURE_I
			-- Feature being using for named argument setting.
			
	feature_name: STRING
			-- Name of not found `named_argument'.

feature -- Properties

	code: STRING is "VICA"
		-- Error code

feature -- Settings

	set_feature (a_feat: like named_argument) is
			-- Set feature associated to `named_argument' which is not valid for 
			-- custom attriibute creation.
		require
			a_feat_not_void: a_feat /= Void
		do
			named_argument := a_feat
		ensure
			named_argument_set: named_argument = a_feat
		end
		
	set_feature_name (a_name: like feature_name) is
			-- Set`feature_name' with `a_name'.
		require
			a_name_not_void: a_name /= Void
		do
			feature_name := a_name
		ensure
			feature_name_set: feature_name = a_name
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
			if feature_name /= Void then
				st.add_new_line
				st.add_string ("Could not find feature ") 
				st.add_string (feature_name)
				st.add_string (" in ")
				st.add_class (context_class.lace_class)
				st.add_string (".")
			else
				if named_argument /= Void then
					st.add_new_line
					st.add_string ("Name of invalid custom attribute named argument ")
					st.add_feature (
						named_argument.api_feature (creation_type.associated_class.class_id),
						named_argument.feature_name)
					st.add_string (".")
				end
			end
		end

invariant
	context_class_not_void: context_class /= Void
	creation_type_not_void: creation_type /= Void

end -- class VICA

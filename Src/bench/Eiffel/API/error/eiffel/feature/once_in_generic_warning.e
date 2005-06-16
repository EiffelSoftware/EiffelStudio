indexing
	description: "Warning for once routines declared in generic class."
	date: "$Date$";
	revision: "$Revision$"

class ONCE_IN_GENERIC_WARNING

inherit
	EIFFEL_WARNING
		redefine
			build_explain,
			help_file_name
		end
	
	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make
	
feature {NONE} -- Initialization

	make (a_class: like associated_class; a_feature: FEATURE_I) is
			-- New instance of unused local warnings in `a_feat' from `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_feature_not_void: a_feature /= Void
		do
			associated_class := a_class
			associated_feature := a_feature.api_feature (a_feature.written_in)
		ensure
			associated_class_set: associated_class = a_class
		end

feature -- Properties

	associated_feature: E_FEATURE
			-- Once feature

	code: STRING is "Once in generic"
			-- Error code

	help_file_name: STRING is "once_in_generic_warning"
			-- Name of file with error description

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Class: ")
			associated_class.append_name (st)
			st.add_new_line
			st.add_string ("Feature: ")
			associated_feature.append_name (st)
			st.add_new_line
		end

invariant
	associated_feature_not_void: associated_feature /= Void

end

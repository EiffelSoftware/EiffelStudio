indexing

	description: 
		"Error when there is an additional invalid selection.";
	date: "$Date$";
	revision: "$Revision $"

class VMRC2 

inherit

	VMRC
		redefine
			build_explain, subcode, is_defined
		end

feature -- Properties

	subcode: INTEGER is 2;

	selected_feature: E_FEATURE;

	invalid_feature: E_FEATURE;

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				selected_feature /= Void and then
				invalid_feature /= Void
		ensure then
			valid_selected_feature: Result implies selected_feature /= Void;
			valid_invalid_feature: Result implies invalid_feature /= Void
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		local
			u_class: CLASS_C;
			s_class: CLASS_C;
		do
			u_class := invalid_feature.written_class;
			s_class := selected_feature.written_class;
			st.add_string ("First version: ");
			selected_feature.append_name (st);
			st.add_string (" from class: ");
			s_class.append_name (st);
			st.add_new_line;
			st.add_string ("Second version: ");
			invalid_feature.append_name (st);
			st.add_string (" from class: ");
			u_class.append_name (st);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER}

	init (s: FEATURE_I; u: FEATURE_I) is
			-- Initialization
		require
			valid_args: s /= Void and then u /= Void
		do
			selected_feature := s.api_feature (s.written_in);
			invalid_feature := u.api_feature (u.written_in);
		end;

end -- class VMRC2

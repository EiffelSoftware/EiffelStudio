indexing
	description: "Error for a feature call."
	date: "$Date$"
	revision: "$Revision$"

class VUAR 

inherit
	FEATURE_ERROR
		redefine
			is_defined
		end
	
feature -- Properties

	called_feature: E_FEATURE

	code: STRING is "VUAR"

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				is_feature_defined and then
				called_feature /= Void
		ensure then
			valid_called_feature: Result implies called_feature /= Void
		end

feature -- Output

	print_called_feature (st: STRUCTURED_TEXT) is
		local
			a_class: CLASS_C
		do
			a_class := called_feature.written_class
			st.add_string ("Called feature: ")
			called_feature.append_signature (st)
			st.add_string (" from ")
			a_class.append_name (st)
			st.add_new_line
		end

feature {ACCESS_FEAT_AS, PRECURSOR_AS} -- Setting

	set_called_feature (f: FEATURE_I; class_id: INTEGER) is
		require
			valid_f: f /= Void
			valid_class_id: class_id > 0
		do
			called_feature := f.api_feature (class_id)
		ensure
			called_feature_not_void: called_feature /= Void
		end

end -- class VUAR

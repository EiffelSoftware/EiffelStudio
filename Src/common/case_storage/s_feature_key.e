indexing

	description: 
		"Information used to identify the FEATURE_DATA.";
	date: "$Date$";
	revision: "$Revision $"

class S_FEATURE_KEY

creation

	make

feature {NONE} -- Initialization

	make (f_name: STRING; cl_id: like class_id) is
			-- Set feature_name to `f_name' and
			-- set class_id to `cl_id'.
		require
			valid_name: f_name /= Void;
			valid_key: cl_id > 0
		do
			feature_name := f_name;
			class_id := cl_id;
		ensure
			name_set: feature_name = f_name;
			class_id_set: class_id = cl_id
		end;

feature -- Properties

	class_id: INTEGER;

	feature_name: STRING;

invariant

	valid_class_id: class_id /= Void;
	valid_feature_name: feature_name /= Void and then not feature_name.empty

end -- class S_FEATURE_KEY

-- Meting information for a feature

class FEAT_MELTED_INFO

inherit

	MELTED_INFO

creation

	make

feature

	feature_name: STRING;
			-- Feature to melt

	make (f: FEATURE_I) is
			-- Initialization
		require
			good_argument: f /= Void
		do
			feature_name := f.feature_name;
		end;

	associated_feature (feat_tbl: FEATURE_TABLE): FEATURE_I is
			-- Associated feature
		do
			check
				consistency: feat_tbl.has (feature_name)
			end;
			Result := feat_tbl.item (feature_name)
		end;

	is_valid (associated_class: CLASS_C): BOOLEAN is
			-- Is the melted info still valid ?
		local
			feat_tbl: FEATURE_TABLE;
			f: FEATURE_I;
		do
			feat_tbl := associated_class.feature_table;
			f := feat_tbl.item (feature_name)
			Result := f /= Void and then
				(not f.is_attribute or else f.to_generate_in (associated_class))
debug ("ACTIVITY")
	io.error.putstring ("FEAT_MELTED_INFO is_valid (");
	io.error.putstring (feature_name);
	io.error.putstring ("): ");
	io.error.putbool (Result);
	io.error.new_line;
end;
		end;

end

-- Melted information for invariant

class INV_MELTED_INFO

inherit

	MELTED_INFO

feature

	associated_feature (feat_tbl: FEATURE_TABLE): FEATURE_I is
			-- Associated feature
		do
			check
				concistecy: feat_tbl.associated_class.invariant_feature /= Void
			end;
			Result := feat_tbl.associated_class.invariant_feature
		end;

	feature_name: STRING is "_invariant";
			-- Feature name for invariant feature

	is_valid (associated_class: CLASS_C): BOOLEAN is
		do
			Result := associated_class.has_invariant
		end;

end

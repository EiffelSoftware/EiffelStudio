-- Data structure for checking feature adaptation

deferred class FEATURE_ADAPTATION 
	
feature 

	old_features: INHERIT_FEAT;
			-- Inherited features

	new_feature: FEATURE_I;
			-- Adapted feature

	check_adaptation (feat_tbl: FEATURE_TABLE) is
			-- Chec the adaptation with computed new feature table
			-- `feat_tbl'
		require
			good_context: not (new_feature = Void or else old_features = Void);
		deferred
		end;

	check_redeclaration
		(   feat_tbl, old_tbl: FEATURE_TABLE;
			pattern_list: LIST [INTEGER];
			origin_table: ORIGIN_TABLE) is
			-- Chec the adaptation with computed new feature table
			-- `feat_tbl'
		do
			-- Do nothing
		end;

	trace is
		do
			io.error.putstring ("Adapted feature: ");
			io.error.putstring (new_feature.feature_name);
			io.error.new_line;
			io.error.putstring ("inherited features%N");
			old_features.trace;
			io.error.new_line;
		end

invariant

	old_features_exists: old_features /= Void;
	new_feature_exists: new_feature /= Void;

end

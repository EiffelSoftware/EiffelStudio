indexing
	description: "Data structure for checking feature adaptation"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FEATURE_ADAPTATION 

feature {NONE} -- Initialization

	make (old_feats: INHERIT_FEAT; new_feat: FEATURE_I) is
			-- Creation
		require
			good_argument: not (old_feats = Void or else new_feat = Void)
			consistency: is_valid_old_features (old_feats)
		do
			old_features := old_feats
			new_feature := new_feat
		end

feature -- Access 

	old_features: INHERIT_FEAT
			-- Inherited features

	new_feature: FEATURE_I
			-- Adapted feature

feature -- Status report

	is_valid_old_features (old_feats: like old_features): BOOLEAN is
			-- Is `old_feats' valid for current Context?
			-- Redefined in JOIN.
		require
			old_feats_not_void: old_feats /= Void
		deferred
		end

feature -- Checking

	check_adaptation (feat_tbl: FEATURE_TABLE) is
			-- Chec adaptation with computed new feature table `feat_tbl'.
		require
			good_context: not (new_feature = Void or else old_features = Void)
		deferred
		end

	check_redeclaration (feat_tbl, old_tbl: FEATURE_TABLE
			pattern_list: LIST [INTEGER]
			origin_table: ORIGIN_TABLE)
		is
			-- Chec adaptation with computed new feature table `feat_tbl'.
		do
			-- Do nothing
		end

feature -- Debugging

	trace is
		do
			io.error.putstring ("Adapted feature: ")
			io.error.putstring (new_feature.feature_name)
			io.error.new_line
			io.error.putstring ("inherited features%N")
			old_features.trace
			io.error.new_line
		end

invariant
	old_features_exists: old_features /= Void
	new_feature_exists: new_feature /= Void
	deferred_to_join: is_valid_old_features (old_features)
	
end -- class FEATURE_ADAPTATION

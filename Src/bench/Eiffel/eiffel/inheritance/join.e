indexing
	description: "Join of deferred features"
	date: "$Date$"
	revision: "$Revision$"

class
	JOIN 

inherit
	FEATURE_ADAPTATION

creation
	make
	
feature -- Status Report

	is_valid_old_features (old_feats: INHERIT_FEAT): BOOLEAN is
			-- Is `old_feats' valid for a JOIN?
		do
			Result := old_feats.nb_deferred > 1
		end	

feature -- Checking

	check_adaptation (feat_tbl: FEATURE_TABLE) is
			-- Check if the signature of feature `new_feature' is
			-- identical to the signatures of the deferred features
			-- contained in `old_features'
		local
			deferred_features: LINKED_LIST [INHERIT_INFO]
			old_feat: FEATURE_I
			info: INHERIT_INFO
		do
				-- The signature of the chosen feature in the
				-- context of `feat_tbl' has ben already evluated by
				-- feature `check_types' of FEATURE_TABLE. (See class
				-- INHERIT_TABLE).
			from
				deferred_features := old_features.deferred_features
					-- The first deferred feature is skipped since it is
					-- `new_feature'
				check
					deferred_features.first.a_feature = new_feature
				end
				deferred_features.go_i_th (2)
			until
				deferred_features.after
			loop
				info := deferred_features.item
				old_feat := info.a_feature

					-- Evaluates signature of the old feature in the
					-- context of the new feature table
				old_feat.solve_types (feat_tbl)

					-- Check same signature for different features
				new_feature.check_same_signature (old_feat)

				deferred_features.forth
			end
		end

end

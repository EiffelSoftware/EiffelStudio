indexing
	description	: "Process redefined features. Formulate the assertion id set for a feature."
	date		: "$Date$"
	revision	: "$Revision$"

class REDEF_FEAT

inherit
	SHARED_WORKBENCH

feature -- Access

	class_id: INTEGER

feature -- Basic operation

	process (adaptations: LINKED_LIST [FEATURE_ADAPTATION]) is
			-- Process 'adaptions' to update the assert_id_set for
			-- redefined features. 
		local
			redef_assert_feats: LINKED_LIST [FEATURE_I]
			list: LINKED_LIST [INHERIT_INFO]
			feat: FEATURE_I
		do
			from
				adaptations.start
			until
				adaptations.after
			loop
				feat := adaptations.item.new_feature
				create redef_assert_feats.make

				from
					list := adaptations.item.old_features.deferred_features
					list.start
				until
					list.after
				loop
					redef_assert_feats.extend (list.item.a_feature)
					redef_assert_feats.forth
					list.forth
				end

				from
					list := adaptations.item.old_features.features;
					list.start
				until
					list.after
				loop
					redef_assert_feats.extend (list.item.a_feature)
					redef_assert_feats.forth
					list.forth
				end
				if redef_assert_feats.count > 0 then
					update_assert_set (redef_assert_feats, feat)
				end
				adaptations.forth
			end
		end

feature {NONE} -- Implementation

	update_assert_set (features: LINKED_LIST [FEATURE_I]; new_feat: FEATURE_I) is
			-- Update assert_id_set of `new_feat' from `features'.
		require
			valid_features		: features /= Void
			features_not_empty	: not features.is_empty
			valid_name			: new_feat /= Void
		local
			feat				: FEATURE_I
			feat_body_index		: INTEGER
			info				: INH_ASSERT_INFO
			new_assert_id_set	: ASSERT_ID_SET
			has_precondition	: BOOLEAN
			feat_assert_id_set	: ASSERT_ID_SET
			processed_features	: ARRAYED_LIST [INTEGER]
		do
			if not new_feat.is_attribute then

				create new_assert_id_set.make (5)

					-- Create the list of feature already processed. This is
					-- to avoid have two times the same assert_id_set in case of a
					-- repeated inheritance.
				create processed_features.make (5)
					
					-- By default, we suppose that the feature defines preconditions.
				has_precondition := True

					-- We will loop twice on the list of features.
					-- First we will add the inherited assertions of each feature.
					-- Then we will add the inner assertions of each feature 
					--
					-- First loop: Add the inherited assertions
				from
					features.start
				until
					features.after
				loop
					feat := features.item
					feat_body_index := feat.body_index
					feat_assert_id_set := feat.assert_id_set

						-- Merge in inherited assertion info for this routine.
					if feat_assert_id_set /= Void and then (not processed_features.has (feat_body_index)) then
						new_assert_id_set.merge (feat_assert_id_set)
						processed_features.extend (feat_body_index)
					end

						-- A feature has a precondition clause if it defines
						-- a precondition and has no parent, or if one of its 
						-- ancestors defines a precondition.
					has_precondition := has_precondition and (
						(feat.has_precondition and feat_assert_id_set = Void)
							or
						(feat_assert_id_set /= Void and then feat_assert_id_set.has_precondition)
					)

						-- Prepare next iteration.
					features.forth
				end

					-- Set the calculated precondition status
				new_assert_id_set.set_has_precondition (has_precondition)

					-- Second loop: Add the inner assertions

				from
					features.start
					processed_features.wipe_out
				until
					features.after
				loop
					feat := features.item
					feat_body_index := feat.body_index

					if not processed_features.has(feat_body_index) then
							-- Add assert info of feat.
						create info.make (feat)
						new_assert_id_set.force (info)
						processed_features.extend (feat_body_index)
					end

						-- Prepare next iteration.
					features.forth
				end

				new_feat.set_assert_id_set (new_assert_id_set)
				debug ("ASSERTION")
					trace (new_feat)
					io.new_line
				end
			end
		end

	trace (new_feat: FEATURE_I) is
		local
			assert_set: ASSERT_ID_SET
			i: INTEGER
		do
			io.putstring ("Feature joined or merged: ")
			io.putstring (new_feat.feature_name)
			io.new_line
			assert_set := new_feat.assert_id_set
			if assert_set /= Void then
				from
					i := 1
				until
					i > assert_set.count 
				loop
					assert_set.item (i).trace
					i := i + 1
				end
			end
		end

end

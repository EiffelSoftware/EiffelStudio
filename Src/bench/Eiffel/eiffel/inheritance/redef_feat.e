-- Process redefined features. Formulate the assertion id set
-- for a feature 

class REDEF_FEAT

inherit

	SHARED_WORKBENCH

feature

	class_id: INTEGER;

	process (adaptations: LINKED_LIST [FEATURE_ADAPTATION]) is
			-- Process 'adaptions' to update the assert_id_set for
			-- redefined features. 
		local
			redef_assert_feats: LINKED_LIST [FEATURE_I];
			list: LINKED_LIST [INHERIT_INFO];
			feat: FEATURE_I;
		do
			from
				adaptations.start;
			until
				adaptations.after
			loop
				feat := adaptations.item.new_feature;
				!! redef_assert_feats.make;

				from
					list := adaptations.item.old_features.deferred_features;
					list.start
				until
					list.after
				loop
					redef_assert_feats.extend (list.item.a_feature)
					redef_assert_feats.forth
					list.forth;
				end;

				from
					list := adaptations.item.old_features.features;
					list.start
				until
					list.after
				loop
					redef_assert_feats.extend (list.item.a_feature)
					redef_assert_feats.forth
					list.forth;
				end;
				if redef_assert_feats.count > 0 then
					update_assert_set (redef_assert_feats, feat);
				end;
				adaptations.forth;
			end;
		end;

feature {NONE}

	update_assert_set (features: LINKED_LIST [FEATURE_I]; new_feat: FEATURE_I) is
			-- Update assert_id_set of `new_feat' from `features'.
		require
			valid_features: features /= Void;
			features_not_empty: not features.empty;
			valid_name: new_feat /= Void
		local
			feat: FEATURE_I;
			info: INH_ASSERT_INFO;
			new_assert_id_set: ASSERT_ID_SET;
			old_assert_id_set: ASSERT_ID_SET;
		do
			if not new_feat.is_attribute then
				from
					!!new_assert_id_set.make (5);
					features.start;
				until
					features.after
				loop
					feat := features.item;
						--! Add assert info of feat
					!!info.make (feat);
					new_assert_id_set.force (info);
					if feat.assert_id_set /= Void then
						--! Merge in inherited assertion info for this routine
						new_assert_id_set.merge (feat.assert_id_set);
					end;
					features.forth
				end;
				new_feat.set_assert_id_set (new_assert_id_set);
debug ("ASSERTION")
	trace (new_feat);
	io.new_line;
end;
			end;
		end;

	trace (new_feat: FEATURE_I) is
		local
			assert_set: ASSERT_ID_SET;
			i: INTEGER
		do
			io.putstring ("Feature joined or merged: ");
			io.putstring (new_feat.feature_name);
			io.new_line;
			assert_set := new_feat.assert_id_set;
			if assert_set /= Void then
			from
				i := 1;
			until
				i > assert_set.count 
			loop
				assert_set.item (i).trace;
				i := i + 1;
			end
			end
		end;

end

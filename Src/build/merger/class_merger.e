class CLASS_MERGER

feature 

	merge3 (old_tmpl: CLASS_AS; user: CLASS_AS; new_tmpl: CLASS_AS) is
			-- Merge `new_temp' and `user', depending on `old_tmpl'.
		local
			indexes_merger: INDEXES_MERGER;
			parents_merger: PARENTS_MERGER;
			generics_merger: GENERICS_MERGER;
			creators_merger: CREATORS_MERGER;
			feature_clause_merger: FEATURE_CLAUSE_MERGER;
			invariant_part_merger: INVARIANT_PART_MERGER
        do
			!! merge_result

				-- Merge2 routines can be used here since the 
				-- old and new templates will be different
			!! indexes_merger;
			indexes_merger.merge2 (user.indexes, new_tmpl.indexes)
			merge_result.set_indexes (indexes_merger.merge_result)

			!! generics_merger;
			generics_merger.merge2 (user.generics, new_tmpl.generics)
			merge_result.set_generics (generics_merger.merge_result)

			!! creators_merger;
			creators_merger.merge2 (user.creators, new_tmpl.creators)
			merge_result.set_creators (creators_merger.merge_result)

			!! invariant_part_merger;
			invariant_part_merger.merge2 (user.invariant_part, new_tmpl.invariant_part)
			merge_result.set_invariant_part (invariant_part_merger.merge_result)
			!! parents_merger;
			parents_merger.merge3 (old_tmpl.parents, user.parents, new_tmpl.parents)
			merge_result.set_parents (parents_merger.merge_result)

			debug ("MERGER")
				io.error.putstring ("%T feature clause");
			end;
			!! feature_clause_merger;
			feature_clause_merger.merge3 (old_tmpl.features, user.features, new_tmpl.features)
			merge_result.set_features (feature_clause_merger.merge_result)

			merge_result.set_id (new_tmpl.id)
			merge_result.set_class_name (new_tmpl.class_name)
			debug ("MERGER")
				io.error.putstring ("finished feature %N");
			end;
        end;

	merge_result: CLASS_AS

end -- class CLASS_MERGER

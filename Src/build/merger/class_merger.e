class CLASS_MERGER

inherit
	COMPILER_EXPORTER

feature 

	merge3 (old_tmp: EXT_CLASS_AS; user: EXT_CLASS_AS; new_tmp: EXT_CLASS_AS) is
			-- Merge `new_tmp' and `user', depending on `old_tmp'.
			-- Actual merging is done in specific mergers.
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

			-- Merging indexes
			!! indexes_merger;
			indexes_merger.merge2 (user.indexes, new_tmp.indexes)
			merge_result.set_indexes (indexes_merger.merge_result)

			-- Merging generics
			!! generics_merger;
			generics_merger.merge2 (user.generics, new_tmp.generics)
			merge_result.set_generics (generics_merger.merge_result)

			-- Merging creators
			!! creators_merger;
			creators_merger.merge2 (user.creators, new_tmp.creators)
			merge_result.set_creators (creators_merger.merge_result)

			-- Merging invariants
			!! invariant_part_merger;
			invariant_part_merger.merge2 (user.invariant_part, new_tmp.invariant_part)
			merge_result.set_invariant_part (invariant_part_merger.merge_result)

			-- More information is necessary now. Using merge3.
			-- Old template will be taken in consideration.

			-- Merging parents
			!! parents_merger;
			parents_merger.merge3 (old_tmp.parents, user.parents, new_tmp.parents)
			merge_result.set_parents (parents_merger.merge_result)

debug ("MERGER")
	io.error.putstring ("%T feature clause");
end;

			-- Merging features
			!! feature_clause_merger;
			feature_clause_merger.merge3 (old_tmp.features, user.features, new_tmp.features)
			merge_result.set_features (feature_clause_merger.merge_result)

			-- Copying some information from `new_tmp'.

		--	merge_result.set_id (new_tmp.id)
			merge_result.set_class_name (new_tmp.class_name)
debug ("MERGER")
	io.error.putstring ("finished feature %N");
end;
        end;

	merge_result: CLASS_AS

end -- class CLASS_MERGER

indexing

	description:
		"Find the feature differences between two classes. %
		%Handle them, merge them. Assumes the feature clauses are%
		%the same (ie have same declarations), in the same order.";
	date: "$Date$";
	revision: "$Revision $"

class 
	FEATURES_MERGER 

inherit
	SHARED_TEXT_ITEMS
	COMPILER_EXPORTER

creation
	make

feature -- Initialization

	make (cm: like classes_merger) is
		do
			classes_merger := cm
			!! class_diffs.make
		end

feature -- Properties

		class_diffs: TWO_WAY_LIST [FEATURE_DIFF]
			-- List of feature differences for the currently 
			-- processed class.
			--| Clients must keep cursor where it is.

	--merging_window: MERGING_WINDOW is
	--		-- Merging window to which Current feature merger is associated
	--	do
	--		Result := classes_merger.merging_window
	--	end

	new_version_modified, old_version_modified: BOOLEAN
			-- Has new/old version of class been modified?
			-- (Does it require saving the new/old class text to disk?) 

	same_asts: BOOLEAN is
			-- Are the 2 asts representing 2 versions of a class
			-- identical (on the feature level)? 
		do
			Result := class_diffs.empty
		end

feature -- Setting 

	compare_asts is
			-- Compare 2 class asts, and build a list of diffs between them.
		do
			class_diffs.wipe_out
			compare_feature_clauses (new_class_ast.features, old_class_ast.features)
			class_diffs.start
		end

	merge_with_new_version is
			-- Merge the current class difference, by keeping the new
			-- (Case) version.
		local
			diff: FEATURE_DIFF
		do
			diff := class_diffs.item
			diff.merge_with_new_version (old_class_ast, new_class_ast)
			diff.set_is_merged
			old_version_modified := True
			classes_merger.set_old_version_dirty
			end_diff_merging
		end

	merge_with_old_version is
			-- Merge the current class difference, by keeping the old
			-- (Eiffel code) version.
		local
			diff: FEATURE_DIFF
		do
			diff := class_diffs.item
			diff.merge_with_old_version (old_class_ast, new_class_ast)
			diff.set_is_merged
			new_version_modified := True
			classes_merger.set_new_version_dirty
			end_diff_merging
		end

	set_new_version_modified is
			-- Set the `new_version_modified' flag to True
		do
			new_version_modified := True
		ensure
			new_version_modified_set: new_version_modified
		end

	set_old_version_modified is
			-- Set the `old_version_modified' flag to True
		do
			old_version_modified := True
		ensure
			old_version_modified_set: old_version_modified
		end

	unset_new_version_modified is
			-- Set the `new_version_modified' flag to False
		do
			new_version_modified := False
		ensure
			new_version_modified_unset: not new_version_modified
		end

	unset_old_version_modified is
			-- Set the `old_version_modified' flag to False
		do
			old_version_modified := False
		ensure
			old_version_modified_unset: not old_version_modified
		end

feature {NONE} -- Implementation

	compare_feature_clauses (new_fclist, old_fclist: EIFFEL_LIST [EXT_FEATURE_CLAUSE_AS]) is
			-- Compare the features of each feature clause, building
			-- a list `class_diffs' of feature differences between 
			-- the two version of the currently processed class.
			-- The feature clause merging must already have been done, 
			-- so as the two asts have the same feature clauses.
		require
			new_void_and_old: (new_fclist = Void) implies (old_fclist = Void)
			old_void_and_new: (old_fclist = Void) implies (new_fclist = Void)
			same_count: (new_fclist /= Void) implies 
							(new_fclist.count = old_fclist.count)
		local
			new_fc, old_fc: EXT_FEATURE_CLAUSE_AS
		do
			if new_fclist /= Void then 
				from
					new_fclist.start
					old_fclist.start
				until
					new_fclist.after or old_fclist.after
				loop
					new_fc := new_fclist.item
					old_fc := old_fclist.item
					if new_fc /= old_fc then
						compare_features (new_fc, old_fc)
					end
					new_fclist.forth
					old_fclist.forth
				end
			end
		end

	compare_features (new_fclause, old_fclause: EXT_FEATURE_CLAUSE_AS) is
			-- Compare the features of the two feature clauses, adding
			-- the differences to `class_diffs'.
		require
			new_fclause_exists: new_fclause /= Void
			old_fclause_exists: old_fclause /= Void
			--corresponding_feature_clauses: new_fclause.has_equiv_declaration (old_fclause)
			not_same_objects: new_fclause /= old_fclause
		local
			new_processed, old_processed: ARRAY [BOOLEAN]
			new_flist, old_flist: EIFFEL_LIST [EXT_FEATURE_AS]
			old_index, new_index, found_index: INTEGER
			new_feature, old_feature: EXT_FEATURE_AS
			diff: FEATURE_DIFF
		do
			new_flist := new_fclause.features
			old_flist := old_fclause.features
			!! new_processed.make (1, new_flist.count)
			!! old_processed.make (1, old_flist.count)
			from
				new_flist.start
				old_flist.start
			until
				new_flist.after or old_flist.after
			loop
				new_feature := new_flist.item
				old_feature := old_flist.item
				if (new_feature.feature_name.is_equal(old_feature.feature_name)) then
					if not new_feature.is_equiv (old_feature) then
							--| difference
						!FEATURE_MODIFIED! diff.make (new_feature, old_feature)
						class_diffs.extend (diff)
					end
					new_processed.put (True, new_flist.index)
					old_processed.put (True, old_flist.index)
					go_next_feature (new_flist, new_processed)
					go_next_feature (old_flist, old_processed)
				else
						--| different names
					old_index := old_flist.index
					search_next_feature_with_name (old_flist, new_feature.feature_name)
					if old_flist.after then
							--| new not found in old ==> addition
debug ("MERGING")
						print ("%NAdded: "); print (new_feature.feature_name);
						io.new_line
end
						old_flist.go_i_th (old_index)
						!FEATURE_ADDED! diff.make (new_feature, Void)
						class_diffs.extend (diff)
						new_processed.put (True, new_flist.index)
						go_next_feature (new_flist, new_processed)
					else
						found_index := old_flist.index
						old_flist.go_i_th (old_index)
						new_index := new_flist.index
						search_next_feature_with_name (new_flist, old_feature.feature_name)
						if new_flist.after then
								--| old not found in new ==> removed
debug ("MERGING")
							print ("%NRemoved: "); 
							print (old_feature.feature_name); io.new_line
end
							new_flist.go_i_th (new_index)
							!FEATURE_REMOVED! diff.make (Void, old_feature)
							class_diffs.extend (diff)
							old_processed.put (True, old_flist.index)
							go_next_feature (old_flist, old_processed)
						else
								--| moved and/or modified
							old_feature := old_flist.i_th (found_index)
							if not new_feature.is_equiv (old_feature) then
debug ("MERGING")
								print ("%NDiff2: "); 
								print (old_feature.feature_name); 
								io.new_line
end
								!FEATURE_MODIFIED! diff.make (new_feature, old_feature)
								class_diffs.extend (diff)
							end
							new_flist.go_i_th (new_index)
							new_processed.put (True, new_index)
							old_processed.put (True, found_index)
							go_next_feature (new_flist, new_processed)
						end
					end
				end --| if names =
			end --| loop
			if new_flist.after then
				from
				until
					old_flist.after
				loop
debug ("MERGING")
					print ("%NRemovedEnd: "); 
					print (old_flist.item.feature_name); io.new_line
end
					!FEATURE_REMOVED! diff.make (Void, old_flist.item)
					class_diffs.extend (diff)
					go_next_feature (old_flist, old_processed)
				end
			else
				from
				until
					new_flist.after
				loop
debug ("MERGING")
					print ("%NAddedEnd: "); 
					print (new_flist.item.feature_name); io.new_line
end
					!FEATURE_ADDED! diff.make (new_flist.item, Void)
					class_diffs.extend (diff)
					go_next_feature (new_flist, new_processed)
				end
			end
		end

	end_diff_merging is
			-- Actions performed after a feature difference has been 
			-- merged (consider the diff as merged, update the class 
			-- texts accordingly, going to a new diff if there is one).
		do
		--	class_diffs.remove
		--	if not class_diffs.after then
		--			-- on a new diff of that class
		--		class_diffs.item.set_is_current
		--		merging_window.show_class_diffs.update_page
		--	elseif not class_diffs.empty then
		--			-- still some diff on that class, but before
		--		class_diffs.back
		--		class_diffs.item.set_is_current
		--		merging_window.show_class_diffs.update_page
		--	else
		--			-- no more diff for that class
		--		merging_window.show_class_diffs.update_page
		--	end
		end

	go_next_feature (flist: EIFFEL_LIST [EXT_FEATURE_AS]; 
					processed: ARRAY [BOOLEAN]) is
			-- Go to next unprocessed feature
		require
			flist_exists: flist /= Void
			processed_exists: processed /= Void
			same_size: flist.count = processed.count
		do
			from
				flist.forth
			until
				flist.after or else (not processed.item (flist.index))
			loop
				flist.forth
			end
		end

	search_next_feature_with_name (flist: EIFFEL_LIST [EXT_FEATURE_AS]; 
					name: STRING) is
			-- Search the next feature in `flist' having the name `name'.
			-- Start from the current feature (excluded) in `flist'.
		require
			flist_exists: flist /= Void
			name_exists: name /= void
		do
			from
				flist.forth
			until
				flist.after or else 
				name.is_equal (flist.item.feature_name)
			loop
				flist.forth
			end
		end

feature {NONE} -- Implementation properties

	classes_merger: CLASSES_MERGER
			-- Associated classes merger (from which Current is used).

	new_class_ast: EXT_CLASS_AS is
			-- Ast corresponding to the new (Case) version of the 
			-- currently processed class.
		do
			Result := classes_merger.new_class_ast
		end

	old_class_ast: like new_class_ast is
			-- Ast corresponding to the old (Bench/code) version of the 
			-- currently processed class
		do
			Result := classes_merger.old_class_ast
		end

invariant
	classes_merger_exists: classes_merger /= Void

end -- class FEATURES_MERGER

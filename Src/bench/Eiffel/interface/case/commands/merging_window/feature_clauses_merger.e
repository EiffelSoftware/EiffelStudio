indexing

	description:
		"Find the differences (in feature clauses) between two %
		%classes, and automatically merge them (keep the new %
		%version of the feature clauses).";
	date: "$Date$";
	revision: "$Revision $"

class 
	FEATURE_CLAUSES_MERGER

inherit
	COMPILER_EXPORTER

creation
	make

feature -- Initialization

	make (cm: like classes_merger) is
		require
			cm_exists: cm /= Void
		do
			classes_merger := cm
			!! merged_classes.make
			!! class_diffs.make
		ensure
			classes_merger_set: classes_merger = cm
		end

feature -- Access

	has_merged (a_class: MERGING_CLASS): BOOLEAN is
			-- Have feature clauses been merged for `class_name'?
			--| NB: Means that there is now no feature clause difference
			--| (but not necessarily there were differences in the first
			--| place, or there is no feature difference...)
		do
			Result := merged_classes.has (a_class)
		end

feature -- Properties

	features_merging_necessary: BOOLEAN
			-- Is it necessary to call the system that will merge feature
			-- differences?
			--| False if one of the classes was empty.

	new_version_modified, old_version_modified: BOOLEAN
			-- Has new/old version of class been modified?
			-- (Does it require saving the new/old class text to disk?) 

	same_asts: BOOLEAN is
			-- Are the 2 asts representing 2 versions of a class
			-- identical (on the feature clause level)? 
		do
			Result := class_diffs.empty
		end

feature -- Setting 

	compare_asts is
			-- Compare 2 class asts, and build a list of diffs between them.
		do
			class_diffs.wipe_out
			compare_feature_clauses (new_class_ast, old_class_ast)
			class_diffs.start
		end

	merge_class_ast_into (oast, nast: EXT_CLASS_AS) is
			-- Merge the feature clauses of `oast' in `nast'
			--| Keeps the feature clauses of `oast', and the features
			--| of `nast'
		require
			nast_exists: nast /= Void
			oast_exists: oast /= Void
			not_same_objects: nast /= oast
		local
			tmp_fc_list: LINKED_LIST [like fc_ast_anchor]
			new_fc_list: EIFFEL_LIST [like fc_ast_anchor]
		do
			tmp_fc_list := merged_fc_list (oast, nast)
			if tmp_fc_list = Void then
				nast.set_features (Void)
			else
				!! new_fc_list.make_filled (tmp_fc_list.count) 
				-- makefilled added by pascalf, avoid Void elements 			
				from
					tmp_fc_list.start
					new_fc_list.start
				invariant
					same_index: tmp_fc_list.index = new_fc_list.index
--%%%XX			variant
--%%%XX				remaining_elements: tmp_fc_list.count - tmp_fc_list.index
--%%%XX this invariant breaks in melted mode, but not in step-by-step mode !!
--%%%XX so there is a bug, but maybe not in EiffelCase :-)
				until
					tmp_fc_list.off
				loop
					new_fc_list.replace (tmp_fc_list.item)
					tmp_fc_list.forth
					new_fc_list.forth
				end
				nast.set_features (new_fc_list)
			end
			merged_classes.extend (classes_merger.current_class)
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

feature {CLASSES_MERGER} -- Implementation properties

	class_diffs: TWO_WAY_LIST [FEATURE_CLAUSE_DIFF]
			-- List of feature clause differences for the currently 
			-- processed class.

feature {NONE} -- Implementation

	compare_feature_clauses (nast, oast: EXT_CLASS_AS) is
			-- Compare the feature clauses of the two classes, adding
			-- the differences to `class_diffs'.
		require
			nast_exists: nast /= Void
			oast_exists: oast /= Void
			not_same_objects: nast /= oast
		local
			new_processed, old_processed: ARRAY [BOOLEAN]
			new_fc_list, old_fc_list: EIFFEL_LIST [like fc_ast_anchor]
		do
			new_fc_list := nast.features
			old_fc_list := oast.features
			if new_fc_list = Void then
				if old_fc_list /= Void then
					!! old_processed.make (1, old_fc_list.count)
					features_merging_necessary := True
					old_fc_list.start
					non_parallel_comparison (new_fc_list, old_fc_list, Void, old_processed)
				end
			elseif old_fc_list = Void then
				!! new_processed.make (1, new_fc_list.count)
				features_merging_necessary := True
				new_fc_list.start
				non_parallel_comparison (new_fc_list, old_fc_list, new_processed, Void)
			else
				!! new_processed.make (1, new_fc_list.count)
				!! old_processed.make (1, old_fc_list.count)
				features_merging_necessary := False
				old_fc_list.start
				new_fc_list.start
				parallel_comparison (new_fc_list, old_fc_list, new_processed, old_processed)
				non_parallel_comparison (new_fc_list, old_fc_list, new_processed, old_processed)
			end
		end

	go_next_feature_clause (fc_list: EIFFEL_LIST [like fc_ast_anchor]; 
				processed: ARRAY [BOOLEAN]) is
			-- Go to next unprocessed feature clause in `fc_list', 
			-- starting from the current one (excluded)
		require
			fc_list_exists: fc_list /= Void
			processed_exists: processed /= Void
			same_size: fc_list.count = processed.count
		do
			from
				fc_list.forth
			until
				fc_list.after or else (not processed.item (fc_list.index))
			loop
				fc_list.forth
			end
		end

	merged_fc_list (oast, nast: EXT_CLASS_AS): LINKED_LIST [like fc_ast_anchor] is
			-- New feature clause list of `nast', which keeps the feature
			-- clauses of `oast', and the features of `nast'... 
		require
			nast_exists: nast /= Void
			oast_exists: oast /= Void
			not_same_objects: nast /= oast	
		local
			new_processed, old_processed: ARRAY [BOOLEAN]
			new_fc_list, old_fc_list: EIFFEL_LIST [like fc_ast_anchor]
			old_index, new_index, found_index: INTEGER
			new_fc, old_fc, tmp_fc: like fc_ast_anchor
			diff: FEATURE_CLAUSE_DIFF
		do
			new_fc_list := nast.features
			old_fc_list := oast.features
			if old_fc_list /= Void then
				if new_fc_list = Void then
					!! new_fc_list.make (0)
				end
				!! Result.make
				!! new_processed.make (1, new_fc_list.count)
				!! old_processed.make (1, old_fc_list.count)
				from
					new_fc_list.start
					old_fc_list.start
					Result.start
				invariant
					new_tagged: all_tagged_so_far (new_processed, new_fc_list.index)
					old_tagged: all_tagged_so_far (old_processed, old_fc_list.index)
				variant
					remaining_elements_in_both_lists: (new_fc_list.count - new_fc_list.index) + (old_fc_list.count - old_fc_list.index)
				until
					new_fc_list.after or else old_fc_list.after
				loop
					new_fc := new_fc_list.item
					old_fc := old_fc_list.item
					if (new_fc.has_equiv_declaration (old_fc)) then
						!! tmp_fc.make_from_other_and_features (old_fc, new_fc.features)
						Result.extend (tmp_fc)
						new_processed.put (True, new_fc_list.index)
						old_processed.put (True, old_fc_list.index)
						go_next_feature_clause (new_fc_list, new_processed)
						go_next_feature_clause (old_fc_list, old_processed)
					else
							--| different declarations
						old_index := old_fc_list.index
						search_next_corresponding_feature_clause (old_fc_list, new_fc)
						if old_fc_list.after then
								--| new not found in old ==> don't keep it
							old_fc_list.go_i_th (old_index)
							new_processed.put (True, new_fc_list.index)
							go_next_feature_clause (new_fc_list, new_processed)
						else
								--| new_fc exists in old_fc_list => moved ?
							found_index := old_fc_list.index
							old_fc_list.go_i_th (old_index)
							new_index := new_fc_list.index
							search_next_corresponding_feature_clause (new_fc_list, old_fc)
							if new_fc_list.after then
									--| old not found in new ==> removed
								new_fc_list.go_i_th (new_index)
								Result.extend (old_fc)
								old_processed.put (True, old_fc_list.index)
								go_next_feature_clause (old_fc_list, old_processed)
							else
									--| old found in new: moved or/and modified
								!! tmp_fc.make_from_other_and_features (old_fc, new_fc_list.item.features)
								Result.extend (tmp_fc)
								new_processed.put (True, new_fc_list.index)
								new_fc_list.go_i_th (new_index)
								old_processed.put (True, found_index)
								go_next_feature_clause (old_fc_list, old_processed)
							end
						end
					end --| if equiv_declarations
				end --| loop
				if new_fc_list.after then
					from
					until
						old_fc_list.after
					loop
						--| removed at end
						Result.extend (old_fc_list.item) 
						go_next_feature_clause (old_fc_list, old_processed)
					end
				end
			end
		end

	non_parallel_comparison (new_fc_list, old_fc_list: EIFFEL_LIST [like fc_ast_anchor]; new_processed, old_processed: ARRAY [BOOLEAN]) is
			-- Compare the feature clause lists specified, adding
			-- the differences to `class_diffs'. One of them must be 
			-- Void or `after'
		require
			new_processed_void_if_no_list: new_processed = Void implies new_fc_list = Void
			old_processed_void_if_no_list: old_processed = Void implies old_fc_list = Void
		local
			diff: FEATURE_CLAUSE_DIFF
		do
			if (new_fc_list = Void) or else (new_fc_list.after) then
				from
				until
					old_fc_list.after
				loop
debug ("FC_MERGING")
					print ("%NRemovedEnd: "); 
					print (old_fc_list.item); io.new_line
end
					!FEATURE_CLAUSE_REMOVED! diff.make (Void, old_fc_list.item)
					class_diffs.extend (diff)
					go_next_feature_clause (old_fc_list, old_processed)
				end
			else
				from
				until
					new_fc_list.after
				loop
debug ("MERGING")
					print ("%NAddedEnd: "); 
					print (new_fc_list.item); io.new_line
end
					!FEATURE_CLAUSE_ADDED! diff.make (new_fc_list.item, Void)
					class_diffs.extend (diff)
					go_next_feature_clause (new_fc_list, new_processed)
				end
			end
		end

	parallel_comparison (new_fc_list, old_fc_list: EIFFEL_LIST [like fc_ast_anchor]; new_processed, old_processed: ARRAY [BOOLEAN]) is
			-- Compare in parallel the 1 feature clause lists specified,
			-- adding the differences to `class_diffs'.
		require
			new_fc_list_exists: new_fc_list /= Void
			old_fc_list_exists: old_fc_list /= Void
			new_processed_exists: new_processed /= Void
			old_processed_exists: old_processed /= Void
			new_same_size: new_processed.count = new_fc_list.count
			old_same_size: old_processed.count = old_fc_list.count
		local
			old_index, new_index, found_index: INTEGER
			new_fc, old_fc: like fc_ast_anchor
			diff: FEATURE_CLAUSE_DIFF
		do
			from
			invariant
				new_tagged: all_tagged_so_far (new_processed, new_fc_list.index)
				old_tagged: all_tagged_so_far (old_processed, old_fc_list.index)			variant
				remaining_elements_in_both_lists: (new_fc_list.count - new_fc_list.index) + (old_fc_list.count - old_fc_list.index)
			until
				new_fc_list.after or else old_fc_list.after
			loop
				new_fc := new_fc_list.item
				old_fc := old_fc_list.item
				if (has_equiv_declaration (new_fc,old_fc)) then
					-- this is a new has_equiv... 
					-- the former one was stupid 
					-- pascalf
						--| We do not consider features at this stage.
					new_processed.put (True, new_fc_list.index)
					old_processed.put (True, old_fc_list.index)
					go_next_feature_clause (new_fc_list, new_processed)
					go_next_feature_clause (old_fc_list, old_processed)
				else
						--| different declarations
					old_index := old_fc_list.index
					search_next_corresponding_feature_clause (old_fc_list, new_fc)
					if old_fc_list.after then
							--| new not found in old ==> addition
debug ("FC_MERGING")
						print ("%NAdded: "); print (new_fc);
						io.new_line
end
						old_fc_list.go_i_th (old_index)
						!FEATURE_CLAUSE_ADDED! diff.make (new_fc, Void)
						class_diffs.extend (diff)
						new_processed.put (True, new_fc_list.index)
						go_next_feature_clause (new_fc_list, new_processed)
					else
						found_index := old_fc_list.index
						old_fc_list.go_i_th (old_index)
						new_index := new_fc_list.index
						search_next_corresponding_feature_clause (new_fc_list, old_fc)
						if new_fc_list.after then
								--| old not found in new ==> removed
debug ("FC_MERGING")
							print ("%NRemoved: "); 
							print (old_fc); io.new_line
end
							new_fc_list.go_i_th (new_index)
							!FEATURE_CLAUSE_REMOVED! diff.make (Void, old_fc)
							class_diffs.extend (diff)
							old_processed.put (True, old_fc_list.index)
							go_next_feature_clause (old_fc_list, old_processed)
						else
								--| moved or/and modified
							new_fc_list.go_i_th (new_index)
							new_processed.put (True, new_index)
							old_processed.put (True, found_index)
							go_next_feature_clause (new_fc_list, new_processed)
						end
					end
				end --| if equiv_declarations
			end --| loop
		end

	search_next_corresponding_feature_clause (fc_list: EIFFEL_LIST [like fc_ast_anchor]; fc: like fc_ast_anchor) is
			-- Search the next feature clause in `fc_list' that has the
			-- same declaration as feature clause `fc'. Start from the 
			-- current item (exluded) in `fc_list'.
		require
			fc_list_exists: fc_list /= Void
			fc_exists: fc /= Void
		do
			from
				fc_list.forth
			until
				fc_list.after or else
				fc.has_equiv_declaration (fc_list.item)
			loop
				fc_list.forth
			end
		end

feature {NONE} -- Implementation properties

	all_tagged_so_far (tags: ARRAY[BOOLEAN]; upper_index: INTEGER): BOOLEAN is
			-- Have all the elements of `tags' up to `upper_index' 
			-- been set to True ?
		local
			i: INTEGER
		do
			from
				i := 1
				Result := True
			until
				i >= upper_index or else not Result
			loop
				Result := tags.item (i)
				i := i + 1
			end
		end

	classes_merger: CLASSES_MERGER
			-- Associated classes merger (from which Current is used).

	current_class_name: STRING is
			-- Name of the class whose two versions are currently 
			-- processed
		do
			Result := new_class_ast.class_name
		end

	fc_ast_anchor: EXT_FEATURE_CLAUSE_AS is
			-- Anchor for feature clause ASTs.
		do
		end

	merged_classes: MERGING_CLASS_LIST
			-- Classes for which features clauses have been merged

	new_class_ast: EXT_CLASS_AS is
			-- Ast corresponding to the new (Case) version of the 
			-- currently processed class.
		do
			Result := classes_merger.new_class_ast
		end

	old_class_ast: like new_class_ast is
			-- Ast corresponding to the old (Bench/code) version of the 
			-- currently processed class.
		do
			Result := classes_merger.old_class_ast
		end

	has_equiv_declaration ( new_fc : EXT_FEATURE_CLAUSE_AS; old_fc: EXT_FEATURE_CLAUSE_AS): BOOLEAN is
		-- function added by pascalf, allows a sane comparison
	do
		if old_fc /= Void then
			if new_fc.has_same_clients ( old_fc ) then
				Result := TRUE
			end
		end
	end
invariant
	classes_merger_exists: classes_merger /= Void
	merged_classes_exists: merged_classes /= Void
	
end -- class FEATURE_CLAUSES_MERGER




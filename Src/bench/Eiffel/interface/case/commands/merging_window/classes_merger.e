indexing

	description: "Find the differences (in feature clauses and features) %
		  		 %between two classes. Handle them, merge them.";
	date: "$Date$";
	revision: "$Revision $"

class 
	CLASSES_MERGER

inherit
	COMPILER_EXPORTER
	SHARED_TEXT_ITEMS
	ONCES
	CONSTANTS

creation
	make

feature -- Initialization

	make (ctm: like classes_to_merge) is
		require
			ctm_exists: ctm /= Void
			ctm_not_empty: not ctm.empty
			sorted_ctm: ctm.sorted
		do
--			classes_to_merge := ctm
--			classes_to_merge.start
--			!! merged_classes.make
--			!! no_diff_classes.make
--			!! file_manager.make (Current)
--			!! yacc_initializer.make (Windows.error_popup)
--			!! class_parser
--			!! feature_clauses_merger.make (Current)
--			!! features_merger.make (Current)
--			set_feature_clauses_merging_mode
--			go_to_first_class_to_merge
		end

feature -- Properties

	class_diffs: TWO_WAY_LIST [CLASS_DIFF]
			-- List of class differences for the currently
			-- processed class (Void if no current class)
			--| Clients must keep cursor where it is.

	class_parser: CLASS_PARSER
			-- Class scanner and parser.

	classes_to_merge: MERGING_CLASS_LIST
			-- Classes that may have differences, and thus
			-- may need to be merged.

	current_class: MERGING_CLASS is
			-- Class being currently processed.
			-- Void if no more class to merge.
		do
			if not classes_to_merge.empty then
				Result := classes_to_merge.item
			end
		ensure
			no_current_implies_void: classes_to_merge.empty implies (Result = Void)
		end

	error_occurred: BOOLEAN
			-- Was there any error in this merging session?
			--| Used for final warning popup

	feature_clause_diffs: TWO_WAY_LIST [FEATURE_CLAUSE_DIFF] is
			-- Differences between the old (Bench/code) and new (Case)
			-- versions of `current_class'
		do
			Result := feature_clauses_merger.class_diffs
		end

	feature_clauses_merger: FEATURE_CLAUSES_MERGER
			-- Merger able to automatically process the feature
			-- clause differences in two version of a same class.

	feature_diffs: TWO_WAY_LIST [FEATURE_DIFF] is
			-- Differences between the old (Bench/code) and new (Case)
			-- versions of `current_class'
		do
			Result := features_merger.class_diffs
		end

	indexing_merger : INDEXING_MERGER

	generic_merger : GENERIC_MERGER

	invariant_merger : INVARIANT_MERGER

	inherit_merger : INHERIT_MERGER

	indexing_diffs : TWO_WAY_LIST [INDEXING_DIFF] is
		do
			Result := indexing_merger.class_diffs
		end
	
	indexing_diff : INDEXING_DIFF 

	features_merger: FEATURES_MERGER
			-- Merger able to process feature differences in two
			-- versions of a same class (with same feature clauses).
			
	file_manager: MERGING_WINDOW_FILE_MANAGER

	is_features_merging_mode: BOOLEAN is
			-- Is the system currently merging feature differences?
		do
			Result := (class_diffs = feature_diffs) and not class_diffs.empty
		end

	is_indexing_merging_mode : BOOLEAN is
		do
			Result := (class_diffs = indexing_merger.class_diffs)
		end

	is_feature_clauses_merging_mode: BOOLEAN is
			-- Is the system currently merging feature clause differences?
		do
			Result := (class_diffs = feature_clause_diffs)
		end

	merged_classes: like classes_to_merge
			-- Classes that have been merged (ie for which all differences 
			-- have been solved).

--	merging_window: MERGING_WINDOW
			-- Associated merging window.

	new_class_ast, old_class_ast: EXT_CLASS_AS
			-- Class asts corresponding to the new (respectively old)
			-- version of the currently processed class.

	new_class_file, old_class_file: PLAIN_TEXT_FILE
			-- File corresponding to the new (respectively old)
			-- version of the currently processed class.

	new_version_dirty: BOOLEAN
			-- Has new (Case) version of `current_class' been modified 
			-- the last changes were applied?

	new_version_modified: BOOLEAN is
			-- Has new (Case) version of class been modified since the
			-- merging began?
		do
			Result := features_merger.new_version_modified or else
					feature_clauses_merger.new_version_modified
		end

	no_diff_classes: like classes_to_merge
			-- Classes for which no difference has been detected

	old_version_dirty: BOOLEAN
			-- Has old (code) version of `current_class' been modified 
			-- the last changes were applied?

	old_version_modified: BOOLEAN is
			-- Has old (code) version of `current_class' been modified 
			-- since the merging began?
		do
			Result := features_merger.old_version_modified
					or else feature_clauses_merger.old_version_modified
		end

	version_dirty: BOOLEAN is
			-- Has one of the two versions of `current_class' 
			-- been modified the last changes were applied?
		do
			Result := old_version_dirty or else new_version_dirty
		end

	version_modified: BOOLEAN is
			-- Has one of the two versions of `current_class' been 
			-- modified since the merging began?
		do
			Result := old_version_modified or else new_version_modified
		end

feature -- Setting

	set_current_class_merged is
		require
			current_class_exists: current_class /= Void
		do
			merged_classes.extend (current_class)
			classes_to_merge.remove
		end

--	set_merging_window (mw: like merging_window) is
	--	do
	--		merging_window := mw
	--	end

	set_new_class_ast (ast: like new_class_ast) is
			-- Set the `new_class_ast' to `ast'
		do
			new_class_ast := ast
		ensure
			new_class_ast_set: new_class_ast = ast
		end

	set_new_version_dirty is
			-- Set `new_version_dirty' to True
		do
			new_version_dirty := True
		ensure
			new_version_dirty_set: new_version_dirty
		end

	set_old_class_ast (ast: like old_class_ast) is
			-- Set the `old_class_ast' to `ast'
		do
			old_class_ast := ast
		ensure
			old_class_ast_set: old_class_ast = ast
		end

	set_old_version_dirty is
			-- Set `old_version_dirty' to True
		do
			old_version_dirty := True
		ensure
			old_version_dirty_set: old_version_dirty
		end

	unset_new_version_dirty is
			-- Set `new_version_dirty' to False
		do
			new_version_dirty := False
		ensure
			new_version_dirty_unset: not new_version_dirty
		end

	unset_new_version_modified is
			-- Set the `new_version_modified' flag to False
		do
			feature_clauses_merger.unset_new_version_modified
			features_merger.unset_new_version_modified
		ensure
			new_version_not_modified: not new_version_modified
		end

	unset_old_version_dirty is
			-- Set `old_version_dirty' to False
		do
			old_version_dirty := False
		ensure
			new_version_dirty_unset: not new_version_dirty
		end

	unset_old_version_modified is
			-- Set the `old_version_modified' flag to False
		do
			feature_clauses_merger.unset_old_version_modified
			features_merger.unset_old_version_modified
		ensure
			old_version_not_modified: not old_version_modified
		end

feature -- Merging

	merge_all_with_case_version is
			-- Merge the current class, by keeping the new
			-- (Case) version for all diffs in the class.
		require
	--		merging_window_exists: merging_window /= Void
		do
		--	if is_feature_clauses_merging_mode then
		--		feature_clauses_merger.merge_class_ast_into (new_class_ast, old_class_ast)
		--		feature_clauses_merger.set_old_version_modified
		--		set_old_version_dirty
		--		feature_clause_diffs.wipe_out
		--	--	merging_window.show_class_diffs.generate_right_text_representation
		--		compare_versions
		--	else
		--		check
		--			features_merging_mode: is_features_merging_mode
		--		end
		--		features_merger.set_old_version_modified
		--		set_old_version_dirty
		--		old_class_ast := new_class_ast
		--		feature_diffs.wipe_out
		--		merging_window.show_class_diffs.generate_right_text_representation
		--	end
		--	--merging_window.apply_changes.execute (Void)
		end

	merge_all_with_code_version is
			-- Merge the current class, by keeping the old
			-- (code) version for all diffs in the class.
		--require
		--	merging_window_exists: merging_window /= Void
		do
		--	if is_feature_clauses_merging_mode then
		--		feature_clauses_merger.merge_class_ast_into (old_class_ast, new_class_ast)
		--		feature_clauses_merger.set_new_version_modified
		--		set_new_version_dirty
		--		feature_clause_diffs.wipe_out
		--		merging_window.show_class_diffs.generate_left_text_representation
		--		compare_versions
		--	else
		--		check
		--			features_merging_mode: is_features_merging_mode
		--		end
		--		features_merger.set_new_version_modified
		--		set_new_version_dirty
		--		new_class_ast := old_class_ast
		--		feature_diffs.wipe_out
		--		merging_window.show_class_diffs.generate_left_text_representation
		--	end
		--	--merging_window.apply_changes.execute (Void) 
		end

feature -- Movement

	go_to_first_class_to_merge is
			-- Find and go to the first class that actually needs to be merged
		do
			classes_to_merge.start
			error_occurred := False
			search_next_class_to_merge
			set_has_to_merge ( TRUE )
			check_end_of_merging
			set_has_to_merge ( FALSE )
		end

	go_to_other_class_to_merge is
			-- Search a new class to merge (forward, and then backward
			-- if necessary); display the appropriate message if all
			-- classes have been merged.
		do
			search_next_class_to_merge
			if not classes_to_merge.empty and then 
					classes_to_merge.after then
						-- next class to merge not found
				classes_to_merge.back
				search_previous_class_to_merge
			end
			check_end_of_merging
		end

feature {MERGING_WINDOW_FILE_MANAGER} -- Code generation

	end_new_eiffel_code_generation is
			-- Undo the changes done by `prepare_new_eiffel_code_generation'.
			-- Reset the correct difference symbols.
		local
			cur: CURSOR
			diff_prefix: DIFFERENCE_TEXT_ITEM
		do
			cur := class_diffs.cursor
			from
				class_diffs.start
			until
				class_diffs.after
			loop
				diff_prefix := class_diffs.item.new_prefix
				if diff_prefix /= Void then
					diff_prefix.restore_image
				end
				class_diffs.forth
			end
			class_diffs.go_to (cur)
			ti_No_diff.restore_image
		end

	end_old_eiffel_code_generation is
			-- Undo the changes done by `prepare_old_eiffel_code_generation'.
			-- Reset the correct difference symbols.
		local
			cur: CURSOR
			diff_prefix: DIFFERENCE_TEXT_ITEM
		do
			cur := class_diffs.cursor
			from
				class_diffs.start
			until
				class_diffs.after
			loop
				diff_prefix := class_diffs.item.old_prefix
				if diff_prefix /= Void then
					diff_prefix.restore_image
				end
				class_diffs.forth
			end
			class_diffs.go_to (cur)
			ti_No_diff.restore_image
		end

	prepare_new_eiffel_code_generation is
			-- Cleans the internal text representation of the new version
			-- to get rid of differences symbol
		local
			cur: CURSOR
			diff_prefix: DIFFERENCE_TEXT_ITEM
		do
			cur := class_diffs.cursor
			from
				class_diffs.start
			until
				class_diffs.after
			loop
				diff_prefix := class_diffs.item.new_prefix
				if diff_prefix /= Void then
					diff_prefix.set_empty_image
				end
				class_diffs.forth
			end
			class_diffs.go_to (cur)
			ti_No_diff.set_empty_image
		end

	prepare_old_eiffel_code_generation is
			-- Cleans the internal text representation of the old version
			-- to get rid of differences symbol
		local
			cur: CURSOR
			diff_prefix: DIFFERENCE_TEXT_ITEM
		do
			cur := class_diffs.cursor
			from
				class_diffs.start
			until
				class_diffs.after
			loop
				diff_prefix := class_diffs.item.old_prefix
				if diff_prefix /= Void then
					diff_prefix.set_empty_image
				end
				class_diffs.forth
			end
			class_diffs.go_to (cur)
			ti_No_diff.set_empty_image
		end

feature -- Class merging

	process_versions is
			-- Retrieve the 2 versions of a class, process feature clauses
			-- if necessary, and then features.
		local
			merging_class: MERGING_CLASS
			ew: ERROR_WINDOW
			ew_title: STRING
		do
		--	merging_class := current_class
		--	file_manager.set_current_class (merging_class)
		--	ew := Windows.error_popup
		--	ew.clear_window
		--	if merging_window = Void then
		--		!! merging_window.make (Current)
		--	end
		--	ew.set_calling_widget (merging_window)

		--	ew_title := "Error: EiffelCase version of class "
		--	ew_title.append (merging_class.name_with_cluster)
		--	ew.set_external_title (ew_title)
		--	parse_new_file
		--	if class_parser.error then
		--		Windows.clear_dialog
		--		merging_class.set_invalid_new_syntax
		--	else
		--		ew_title := "Error: Eiffel Code version of class "
		--		ew_title.append (merging_class.name_with_cluster)
		--		ew.set_external_title (ew_title)
		--		parse_old_file
		--		if class_parser.error then
		--			Windows.clear_dialog
		--			merging_class.set_invalid_old_syntax
		--		else
		--			compare_versions
		--		end
		--	end
		end

	compare_generic is
	do
		!! generic_merger.make ( Current )
		generic_merger.compare_asts
	end
	
	compare_indexing is
	do
		!! indexing_merger.make(Current)
		indexing_merger.compare_asts
	end
	
	compare_invariants is 
	do
		!! invariant_merger.make ( Current )
		invariant_merger.compare_asts
	end

	compare_inherit is
	do
		!!inherit_merger.make ( Current )
		inherit_merger.compare_asts
	end

	compare_versions is
			-- Compare the 2 versions of current class 
			-- (on a feature clause and feature level)
		local
			class_diff: CLASS_DIFF
		do
--			compare_generic
--			compare_indexing  -- indexing level
--			compare_invariants
--			compare_inherit
--			if feature_clauses_merger.has_merged (current_class) then
--				if feature_clauses_merger.features_merging_necessary then
--						set_features_merging_mode
--					features_merger.compare_asts
--				end
--						--| for case else, it's a dummy...
--			else
--				if not is_indexing_merging_mode then
--					set_feature_clauses_merging_mode
--				end
--				feature_clauses_merger.compare_asts
--				if feature_clauses_merger.same_asts then
--						set_features_merging_mode
--						features_merger.compare_asts
--				end
--			end
--			if	not class_diffs.empty	or
--				not indexing_merger.same_asts	or 
--				not invariant_merger.same_asts	or
--				not inherit_merger.same_asts	or
--				not generic_merger.same_asts
--			then
--			    if merging_window = Void then --added by pascalf
--				 	 Windows.create_merging_window (Current) --
--			    end	
--
--				if class_diffs /= Void then
--					if not class_diffs.empty then
--						class_diff := class_diffs.first
--						class_diff.set_is_current
--					else
--						merging_window.difference_dealt
--					end
--				end
--				if is_features_merging_mode and then
--					-- that avoids to show the two corresponding buttons
--					-- if no features to merge ...
--					not class_diffs.empty
--				then
--					merging_window.set_features_merging_mode 
--				else
--					merging_window.set_feature_clauses_merging_mode 
--				end
--				merging_window.show_class_diffs.update_page
--			elseif feature_clauses_merger.has_merged (current_class) then
--				if merging_window = Void then --added by pascalf
--				 	 Windows.create_merging_window (Current) --
--			    end	
--				merging_window.display
--				indexing_merger.buttons
--				inherit_merger.buttons
--				invariant_merger.buttons
--				generic_merger.buttons
--			end
		end

feature {NONE} -- Implementation properties

	same_asts: BOOLEAN is
			-- Are `new_class_ast' and `old_class_ast' identical
			--| (on a per feature clause and a per feature basis)
		do
			Result := feature_clauses_merger.same_asts and then
					features_merger.same_asts and then
					indexing_merger.same_asts and then	
					invariant_merger.same_asts and then
					generic_merger.same_asts and then
					inherit_merger.same_asts
		end

	set_has_to_merge ( b : BOOLEAN ) is 
		do
			has_sth_to_merge := b
		end	

	has_sth_to_merge : BOOLEAN

	yacc_initializer: YACC_INITIALIZER

feature {NONE} -- Implementation

	check_end_of_merging is
			-- Check if all classes have been merged, and triggers the
			-- required popups if necessary.
		do
--			if classes_to_merge.empty and 
--					then not error_occurred then  -- this line added by pascalf when
--						-- we wnat to switch from format stats
--				if merging_window /= void then
--						merging_window.destroy 
--						merging_window.set_end_message ( FALSE )
--				end
--		--		Windows.message (Windows.main_graph_window, "Mai", "")
--		--	elseif	(classes_to_merge.count = 1)	and then
--		--		current_class.invalid_syntax	then
--
--					if merging_window = void then
--						Windows.create_merging_window (Current)
--					end
--					merging_window.set_error_layout
--			elseif error_occurred then
--				-- addded by pascalf
--					if merging_window = void then
--						Windows.create_merging_window (Current)
--					end
--					merging_window.set_error_layout
--				-- 
--			end
		end

	parse_new_file is
			-- Read and parse the file corresponding to the new 
			-- version of the currently processed class. Set 
			-- `new_class_file' and `new_class_ast' accordingly
		local
			ext_class_ast: EXT_CLASS_AS
			e_file: EIFFEL_FILE
			error_fi : BOOLEAN
		do
--			if not error_fi then
--			new_class_file := file_manager.new_class_file
--			class_parser.parse (new_class_file)
--			if class_parser.error then
--				process_error
--			else
--				ext_class_ast ?= class_parser.ast
--				check
--					correct_ast: ext_class_ast /= Void
--						--| The ast returned by the CLASS_PARSER is
--						--| an EXT_CLASS_AS, if we use the correct
--						--| YACC_INITIALIZER
--				end
--				!! e_file.make (new_class_file.name, ext_class_ast.end_position)
--				ext_class_ast.extract_comments (e_file)
--				new_class_ast := ext_class_ast
--				new_version_dirty := False
--				unset_new_version_modified
--			end
--			if not new_class_file.is_closed then
--				new_class_file.close
--			end
--			else
--			--	Windows.error(Windows.main_graph_window, "E42", "" )
--			end
--		rescue
--			Windows.add_message ("Problem for parsing :",
--						1)
--			if not error_fi then
--				error_fi := TRUE
--				retry
--			end	
--
		end

	parse_old_file is
			-- Read and parse the file corresponding to the old 
			-- version of the currently processed class. Set 
			-- `old_class_file' and `old_class_ast' accordingly.
		local
			ext_class_ast: EXT_CLASS_AS
			e_file: EIFFEL_FILE
			error_fi : BOOLEAN
		do	
--			if not error_fi then
--			old_class_file := file_manager.old_class_file
--			class_parser.parse (old_class_file)
--			if class_parser.error then
--				process_error
--			else
--				ext_class_ast ?= class_parser.ast
--				check
--					correct_ast: ext_class_ast /= Void
--						--| The ast returned by the CLASS_PARSER is
--						--| an EXT_CLASS_AS, if we use the correct
--						--| YACC_INITIALIZER
--				end
--				!! e_file.make (old_class_file.name, ext_class_ast.end_position)
--				ext_class_ast.extract_comments (e_file)
--				old_class_ast := ext_class_ast
--				new_version_dirty := False
--				unset_new_version_modified
--			end
--			if not old_class_file.is_closed then
--				old_class_file.close
--			end
--			else
--		--		Windows.error ( Windows.main_graph_window, "E42","")
--			end
--		rescue
--		Windows.add_message ("problem parsing eiffel file",
--					1)
--		if not error_fi then
--			error_fi := TRUE
--			retry
--		end	
		end

	process_error is
			-- Handle error during parsing
			-- update merging window and set `error_occurred'
			-- to True
		local
			class_file: like new_class_file
			mw_title: STRING
		do
--			error_occurred := True
--			if merging_window = void then
--				Windows.create_merging_window (Current)
--			end
--			merging_window.show
--			merging_window.set_error_layout
--			mw_title := "Merging window: Syntax error in Class "
--			mw_title.append (current_class.name_with_cluster)
--			merging_window.set_title (mw_title)
--
--			class_file := file_manager.new_class_file
--			if class_file.is_closed then
--				class_file.open_read
--			end
--			class_file.start
--			class_file.read_stream (class_file.count)
--			merging_window.left_text.set_text (class_file.last_string)
--			class_file := file_manager.old_class_file
--			if class_file.is_closed then
--				class_file.open_read
--			end
--			class_file.start
--			class_file.read_stream (class_file.count)
--			merging_window.right_text.set_text (class_file.last_string)
		end

	search_next_class_to_merge is
			-- Forward search with removal, from current position (included)
			-- in `classes_to_merge'. Stop on the first class with a diff.
		local
			stop: BOOLEAN
		do
--			from
--			variant
--				remaining_classes: classes_to_merge.count
--			until
--				classes_to_merge.off or else stop
--			loop
--				process_versions
--				if class_parser.error then
--					stop := True
--				else
--					if same_asts then
--						if not no_diff_classes.has (current_class) then
--							no_diff_classes.extend (current_class)
--						end						classes_to_merge.remove
--						if classes_to_merge.after then
--							classes_to_merge.back
--						end
--					else
--						stop := True
--						if merging_window = Void then
--							Windows.create_merging_window (Current)
--						end
--						merging_window.show
--						indexing_merger.buttons
--						invariant_merger.buttons
--						inherit_merger.buttons
--						generic_merger.buttons
--					end
--				end
--			end --| loop
		end

	search_previous_class_to_merge is
			-- Backward search with removal, from current position (included)
			-- in `classes_to_merge'. Stop on the first class with a diff.
		local
			stop: BOOLEAN
		do
			from
			variant
				remaining_classes: classes_to_merge.count
			until
				classes_to_merge.off or else stop
			loop
				process_versions
				if class_parser.error then
					stop := True
				else
					if same_asts then
						if not no_diff_classes.has (current_class) then
							no_diff_classes.extend (current_class)
						end
						classes_to_merge.remove
						classes_to_merge.back
					else
						stop := True
					end
				end
			end --| loop
		end

	set_indexing_merging_mode is 
		do
			class_diffs := indexing_merger.class_diffs
		end

	set_features_merging_mode is
			-- Prepare merger for features merging
		do			
			class_diffs := feature_diffs
		end

	set_feature_clauses_merging_mode is
			-- Prepare merger for feature clauses merging
		do			
			class_diffs := feature_clause_diffs
		end

invariant
	new_dirty_implies_modified: new_version_dirty implies new_version_modified
	old_dirty_implies_modified: old_version_dirty implies old_version_modified
	is_features_merging_mode_ok: is_features_merging_mode implies (class_diffs = feature_diffs)
	is_feature_clauses_merging_mode_ok: is_feature_clauses_merging_mode implies (class_diffs = feature_clause_diffs)
	only_one_merging_mode: is_features_merging_mode = not is_feature_clauses_merging_mode
	
end -- class CLASSES_MERGER

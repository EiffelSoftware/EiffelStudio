indexing
	description: "Class responsible for comparing the asts of indexing clauses"
	date: "$Date$"
	revision: "$Revision$"

class
	INDEXING_MERGER

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
		--	merging_window := classes_merger.merging_window
		end

feature  -- properties

	class_diffs : TWO_WAY_LIST [ INDEXING_DIFF ]
			-- at the moment, only one element in this list

	indexing_diff : INDEXING_DIFF

	--merging_window : MERGING_WINDOW

	new_version_modified, old_version_modified: BOOLEAN
			-- Has new/old version of class been modified?
			-- (Does it require saving the new/old class text to disk?) 

	same_asts: BOOLEAN is
			-- Are the 2 asts representing 2 versions of a class
			-- identical (on the feature level)? 
		do
			Result := class_diffs.empty
		end

	compare_asts is
			-- Compare 2 class asts, and build a list of diffs between them.
		do
			class_diffs.wipe_out
			compare_indexing
			class_diffs.start
		end

	merge_with_new_version is
			-- Merge the current class difference, by keeping the new
			-- (Case) version.
		do
			indexing_diff.merge_with_new_version ( old_class_ast, new_class_ast )
			old_version_modified := TRUE
			classes_merger.set_old_version_dirty
			end_diff_merging
		end

	merge_with_old_version is
			-- Merge the current class difference, by keeping the old
			-- (Eiffel code) version.
		local
		do
			indexing_diff.merge_with_old_version ( old_class_ast, new_class_ast )
			new_version_modified := TRUE
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

compare_indexing is
	local
		old_l,new_l : LINKED_LIST[ STRING ]  -- indexing clauses
		old_plus,new_plus : LINKED_LIST [ STRING ] -- diffs
		ind_l : EIFFEL_LIST [ INDEX_AS ]
		st : STRING
	do 
		!! old_l.make
		!! new_l.make
		ind_l := classes_merger.new_class_ast.indexes
		if ind_l/= Void then
			from 
				ind_l.start
			until
				ind_l.after
			loop
				!! st.make(20)
				st.append(ind_l.item.tag)
				st.append(":")
				if ind_l.item.index_list/=Void then
					from
						ind_l.item.index_list.start
					until
						ind_l.item.index_list.after
					loop
						st.append(ind_l.item.index_list.item.string_value)
						ind_l.item.index_list.forth
					end
				end
				new_l.extend(st)
				ind_l.forth
			end
		end
		ind_l := classes_merger.old_class_ast.indexes
		if ind_l/= Void then
			from 
				ind_l.start
			until
				ind_l.after
			loop
				!! st.make(20)
				st.append( ind_l.item.tag )
				st.append(":")
				if ind_l.item.index_list/=Void then
					from
						ind_l.item.index_list.start
					until
						ind_l.item.index_list.after
					loop
						st.append(ind_l.item.index_list.item.string_value)
						ind_l.item.index_list.forth
					end
				end
				old_l.extend(st)
				ind_l.forth
			end
		end
		-- now start a comparison ( bourrin !! )
		-- ugly, has to be changed in the next version 4.4
		from
			old_l.start
		until
			old_l.after
		loop
			from
				new_l.start
			until
				new_l.after or old_l.after
			loop
				if old_l.item.is_equal(new_l.item) then
					old_l.remove
					new_l.remove
				else
					new_l.forth
				end
			end
			if not old_l.after then
				old_l.forth
			end
		end	
		!! indexing_diff.make_diff(classes_merger.new_class_ast.indexes,
				classes_merger.old_class_ast.indexes )
		if new_l.count>0 or old_l.count>0 then
			indexing_diff.set_diffs(new_l, old_l)
			!! indexing_diff.make_diff(classes_merger.new_class_ast.indexes,
				classes_merger.old_class_ast.indexes )
			!! class_diffs.make
			class_diffs.extend (	indexing_diff )
			-- we enlighten
			class_diffs.first.set_is_current	
		end
		-- now, let's hide them or show them depending on if there is
		-- at least a diff
	end


		end_diff_merging is
			-- Actions performed after a feature difference has been 
			-- merged (consider the diff as merged, update the class 
			-- texts accordingly, going to a new diff if there is one).
			-- Here, we think by block => diffs has only 1 element hence ...
		do
		--	if classes_merger.merging_window.current_class /= Void then
		--		classes_merger.merging_window.show_class_diffs.update_page
		--	end
		end

feature -- graphical 

	buttons is
		do
		--	if classes_merger.merging_window.ind_from_case_b /= Void and then
		--		 classes_merger.merging_window.ind_from_code_b /= Void then
		--			-- Added by pascalf, last minute fix.
		--		if classes_merger.merging_window.ind_from_case_b.realized and then
		--				classes_merger.merging_window.ind_from_code_b.realized then
		--			if same_asts then
		--				classes_merger.merging_window.ind_from_case_b.set_insensitive
		--				classes_merger.merging_window.ind_from_code_b.set_insensitive
		--			else
		--				classes_merger.merging_window.ind_from_case_b.set_sensitive
		--				classes_merger.merging_window.ind_from_code_b.set_sensitive
		--			end
		--		end
		--	end
		end

feature -- Implementation

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



end -- class INDEXING_MERGER

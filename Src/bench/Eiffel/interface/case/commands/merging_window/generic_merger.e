indexing
	description: "Class responsible for comparing the genericity field"
	date: "$Date$"
	revision: "$Revision$"

class
	GENERIC_MERGER

inherit
	
	SHARED_TEXT_ITEMS
	COMPILER_EXPORTER

creation
	make

feature -- Initialization

		make (cm: like classes_merger) is
		do
			classes_merger := cm
		--	merging_window := classes_merger.merging_window
		end

feature  -- properties

	--merging_window : MERGING_WINDOW

	new_version_modified, old_version_modified: BOOLEAN
			-- Has new/old version of class been modified?
			-- (Does it require saving the new/old class text to disk?) 

	same_asts: BOOLEAN is
			-- Are the 2 asts representing 2 versions of a class
			-- identical (on the feature level)? 
		do
			Result := same_as 
		end

	compare_asts is
			-- Compare 2 class asts, and build a list of diffs between them.
		do
			compare_genericity
		end

	merge_with_new_version is
			-- Merge the current class difference, by keeping the new
			-- (Case) version.
		do
			old_version_modified := TRUE
			if new_class_ast.generics/= Void then
				old_class_ast.set_generics (new_class_ast.generics)
			end
			classes_merger.set_old_version_dirty
			end_diff_merging
		end

	merge_with_old_version is
			-- Merge the current class difference, by keeping the old
			-- (Eiffel code) version.
		local
		do
			new_version_modified := TRUE
			if old_class_ast.generics/= Void then
				new_class_ast.set_generics (old_class_ast.generics)
			end
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

	same_as : BOOLEAN
		-- same asts ? ( internal value )

	compare_genericity is
	local
		gene_case, gene_eiffel : EIFFEL_LIST [ FORMAL_DEC_AS ]
		equ : BOOLEAN
	do 
		gene_case := new_class_ast.generics
		gene_eiffel := old_class_ast.generics
		same_as := new_class_ast.equivalent ( gene_case, gene_eiffel )
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
		--	if same_asts then
		--		classes_merger.merging_window.gen_from_case_b.set_insensitive
		--		classes_merger.merging_window.gen_from_code_b.set_insensitive
		--	else
		--		classes_merger.merging_window.gen_from_case_b.set_sensitive
		--		classes_merger.merging_window.gen_from_code_b.set_sensitive
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

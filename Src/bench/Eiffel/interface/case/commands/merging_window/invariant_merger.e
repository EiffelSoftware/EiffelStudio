indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INVARIANT_MERGER

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

feature -- Properties

		same_asts: BOOLEAN is
			-- Are the 2 asts representing 2 versions of a class
			-- identical (on the feature level)? 
		do
			Result := is_merged
		end

	is_merged : BOOLEAN

	compare_asts is
			-- Compare 2 class asts, and build a list of diffs between them.
		do
			compare_invariant
		end

	merge_with_new_version is
			-- Merge the current class difference, by keeping the new
			-- (Case) version.
		do
			old_class_ast.set_invariant_part(new_class_ast.invariant_part)
			old_version_modified := TRUE
			classes_merger.set_old_version_dirty
			end_diff_merging
		end

	merge_with_old_version is
			-- Merge the current class difference, by keeping the old
			-- (Eiffel code) version.
		local
		do
			new_class_ast.set_invariant_part(old_class_ast.invariant_part)
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

	new_version_modified, old_version_modified : BOOLEAN

	compare_invariant is
	local
		inv1,inv2 : INVARIANT_AS
	do
		inv1 := classes_merger.new_class_ast.invariant_part
		inv2 := classes_merger.old_class_ast.invariant_part
		if (inv1/= Void) and (inv2/=Void) and then (not inv1.is_equivalent(inv2)) then
				is_merged := FALSE 
		else
			if (inv2=Void and inv1/=Void) or (inv2/= Void and inv1=Void )then
				is_merged := FALSE  
			else
				is_merged := TRUE
			end
		end
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
		--		classes_merger.merging_window.inv_from_case_b.set_insensitive
		--		classes_merger.merging_window.inv_from_code_b.set_insensitive
		--	else
		--		classes_merger.merging_window.inv_from_case_b.set_sensitive
		--		classes_merger.merging_window.inv_from_code_b.set_sensitive
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


--	merging_window : MERGING_WINDOW


end -- class INVARIANT_MERGER

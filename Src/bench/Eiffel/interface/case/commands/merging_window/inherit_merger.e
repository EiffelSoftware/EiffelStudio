indexing
	description: "Class responsible for checking the ast of the inherit clauses ..."
	date: "$Date$"
	revision: "$Revision$"

class
	INHERIT_MERGER

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
				compare_inherit
		end

	merge_with_new_version is
			-- Merge the current class difference, by keeping the new
			-- (Case) version.
		do
			old_class_ast.set_parents(new_class_ast.parents)
			old_version_modified := TRUE
			classes_merger.set_old_version_dirty
			end_diff_merging
		end

	merge_with_old_version is
			-- Merge the current class difference, by keeping the old
			-- (Eiffel code) version.
		local
		do
			new_class_ast.set_parents(old_class_ast.parents)
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

	compare_inherit is
	local
		l1,l2 : EIFFEL_LIST[ PARENT_AS ]
		st1,st2 : STRING
		found : BOOLEAN
	do
		is_merged := TRUE
		-- we start by filling the renaming, export, redefine fields.
		-- we do not forget multiple inheritance ...
		l1 := new_class_ast.parents
		l2 := old_class_ast.parents
		if l1/= Void and then l2/= Void and then l1.is_equivalent(l2) then
			-- nothing
		else
		if l1/= Void and l2/= Void then
				from
					l1.start
				until
					l1.after
				loop
					from
						l2.start
					until
						l2.after 
					loop
						!! st1.make(20)
						st1.append ( l1.item.type.class_name )
						!! st2.make (20)
						st2.append (l2.item.type.class_name )
						if st1.is_equal(st2) then
							-- we found one !!
							l1.item.set_exports(l2.item.exports)
							l1.item.set_redefining(l2.item.redefining)
							l1.item.set_renaming(l2.item.renaming)
							l1.item.set_selecting(l2.item.selecting)
							l1.item.set_undefining(l2.item.undefining)
							-- now, we look for multiple inheritance
							if not l2.after
								then
								from
									l2.forth
								until
									l2.after
								loop
									!! st2.make (20)
									st2.append (l2.item.type.class_name )
									if st1.is_equal (st2) then
										l1.extend (l2.item)
									end
									l2.forth
								end
							end
							if not l2.after then
								l2.forth
							end
						else
							l2.forth
						end
					end
					l1.forth
				end
		end
		-- let's see now if they are equivalent ...
		if l1/= Void then
			from
				l1.start
				is_merged := TRUE
			until
				l1.after or is_merged = FALSE
			loop
				if l2/=Void then
					from	
						l2.start
						found := FALSE
					until
						l2.after or found
					loop
						if l1.item.is_equivalent(l2.item) then
							found := TRUE
						end
						l2.forth
					end
				else
					is_merged := FALSE
				end
				if not found then 
					is_merged := FALSE 
				end
				l1.forth
			end
		end
			-- now, the bijection
		if is_merged and then l2/= Void then
			from
				l2.start
				is_merged := TRUE
			until
				l2.after or is_merged = FALSE
			loop
				if l1/=Void then
					from	
						l1.start
						found := FALSE
					until
						l1.after or found
					loop
						if l2.item.is_equivalent(l1.item) then
							found := TRUE
						end
						l1.forth
					end
					if not found then is_merged := FALSE end
				else
					is_merged := FALSE
				end
				l2.forth
			end	
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
		--		classes_merger.merging_window.inh_from_case_b.set_insensitive
		--		classes_merger.merging_window.inh_from_code_b.set_insensitive
		--	else
		--		classes_merger.merging_window.inh_from_case_b.set_sensitive
		--		classes_merger.merging_window.inh_from_code_b.set_sensitive
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


	--merging_window : MERGING_WINDOW


end -- class INHERIT_MERGER

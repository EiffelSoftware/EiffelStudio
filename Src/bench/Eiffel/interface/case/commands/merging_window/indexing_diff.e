indexing
	description: "class which deals with the indexing differences"
	date: "$Date$"
	revision: "$Revision$"
	author : pascalf

class
	INDEXING_DIFF

inherit
	CLASS_DIFF
		redefine
				new_ast, old_ast
		end

creation
	make_diff

feature -- initialization

	make_diff ( n1,n2 : EIFFEL_LIST [ INDEX_AS ] )  is 
	do 
		new_astt := n1
		old_astt := n2
		new_prefix := clone (ti_Added)		
	end

feature -- Properties

	new_astt, old_astt: EIFFEL_LIST [ INDEX_AS ]
			-- Ast corresponding to the new (respectively old) version
			-- of the considered feature ast.
			--| May be Void

	new_ast, old_ast : EXT_INDEX_AS

feature -- Settings

	set_diffs ( nl,ol : LINKED_LIST [ STRING ] ) is
		do
			new_l := nl
			old_l := ol
		end

	new_l, old_l : LINKED_LIST [ STRING ] -- diffs with strings

	merge_with_new_version (old_class_ast, new_class_ast: CLASS_AS) is
			-- Merge Current class difference, by keeping the new
			-- version.
		do
			old_class_ast.set_indexes ( new_class_ast.indexes )
		end

	merge_with_old_version (old_class_ast, new_class_ast: CLASS_AS) is
			-- Merge Current class difference, by keeping the old
			-- version.
		do
			new_class_ast.set_indexes ( old_class_ast.indexes )
		end

	set_is_merged is
			-- Set Current difference as merged.
		do
			new_prefix.set_is_merged
		end

feature -- Properties II

	is_current : BOOLEAN is
		do
			Result := new_prefix.is_current
		end

	is_merged : BOOLEAN is
		do
			Result := new_prefix.is_merged
		end

	set_is_current is
	do
		new_prefix.set_is_current
	 end

	unset_is_current is 
	do 
		new_prefix.unset_is_current
	end

end -- class INDEXING_DIFF

indexing

	description: "Single difference between two class asts."
	date: "$Date$";
	revision: "$Revision $"

deferred class 
	CLASS_DIFF

inherit
	SHARED_TEXT_ITEMS
	COMPILER_EXPORTER

feature -- Initialization

	make (nast: like new_ast; oast: like old_ast) is
			-- Create a difference with the 2 versions of the considered
			-- feature ast.
			--| One of `nast' and `oast' may be Void.
		do
			new_ast := nast
			old_ast := oast
		ensure
			new_set: new_ast = nast
			old_set: old_ast = oast
		end

feature -- Properties

	is_current: BOOLEAN is
			-- Is Current class diff the currently processed diff?
		deferred
		end

	new_ast, old_ast: EXT_AST_EIFFEL
			-- Ast corresponding to the new (respectively old) version
			-- of the considered feature ast.
			--| May be Void

	new_prefix: DIFFERENCE_TEXT_ITEM
			-- Text prefix used to "highlight" the lines that are
			-- part of the new version of a class difference 
			-- (between two features asts).

	old_prefix: like new_prefix
			-- Text prefix used to "highlight" the lines that are
			-- part of the old version of a class difference 
			-- (between two features asts).

feature -- Settings

	set_is_current is
			-- Set Current difference as the one currently processed
			-- ("highlighed").
		deferred
		ensure
			current_set: is_current
		end

	unset_is_current is
			-- Set Current difference as a normal one (not "highlighed").
			--| Current diff is not the diff currently processed any more.
		deferred
		ensure
			not_current: not is_current
		end

end -- class CLASS_DIFF






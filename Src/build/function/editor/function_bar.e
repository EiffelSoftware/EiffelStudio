
class FUNCTION_BAR 

inherit

	FORM
		rename
			make as form_create
		end;
	CONSTANTS

creation

	make

feature {NONE}

	edit_hole: FUNC_EDIT_HOLE;

feature 

	make (a_name: STRING; a_parent: COMPOSITE; func: FUNC_EDITOR) is
			-- To allow proper compilation.
		do
		end;

	unregister_holes is
		do
		end;

	clear is
		do
			edit_hole.set_empty_symbol
		end;

	update_edit_hole_symbol is
		do
			edit_hole.set_full_symbol
		end;
		
end -- class FUNCTION_BAR

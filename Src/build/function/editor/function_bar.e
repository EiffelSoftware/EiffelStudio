
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
		
end -- class FUNCTION_BAR

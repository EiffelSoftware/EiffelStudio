
class FUNCTION_BAR 

inherit

	FORM
		rename
			make as form_create
		export
			{NONE} all
		end;

	WIDGET_NAMES
		export
			{NONE} all
		end;

	PIXMAPS
		export
			{NONE} all
		end;


creation

	make

	
feature {NONE}

	edit_hole: FUNC_EDIT_HOLE;

	
feature 

	make (a_name: STRING; a_parent: COMPOSITE; func: FUNC_EDITOR) is
			-- To allow proper compilation.
		do
		end;

	set_function (f: FUNCTION) is
		do
		end;
		
end -- class FUNCTION_BAR

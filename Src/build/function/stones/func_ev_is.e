
class FUNC_EV_IS 

inherit

	EV_ICON_STONE
		rename
			make as ev_icon_stone_make
		end;
	FUNCTION_ELEMENT
		rename
			target as source
		export
			{NONE} all
		redefine
			associated_editor
		end;
	REMOVABLE

creation

	make

	
feature {NONE}

	associated_editor: BEHAVIOR_EDITOR;

	
feature 

	make (ed: like associated_editor) is
		do
			initialize (ed);	
			register
		end; -- Create

	
feature {NONE}

	remove_yourself is
		do
			associated_editor.edited_function.remove_element_line (original_stone, True);
		end;
 
end

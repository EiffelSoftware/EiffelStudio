
class FUNC_EV_IS 

inherit

	EV_ICON_STONE
		-- added by samik
        undefine
            init_toolkit
        -- end of samik     
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
			associated_editor.edited_function.remove_element_line (data, True);
			App_editor.update_transitions_list (Void)
		end;
 
end


class FUNC_CON_IS 

inherit

	CON_ICON_STONE
		
		-- added by samik
		undefine
			init_toolkit
		-- end of samik     
		redefine
			transportable
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

	associated_editor: FUNC_EDITOR;

feature 

	transportable: BOOLEAN is
		do
			Result := data /= Void and then 
				not data.deleted
		end;

	make (ed: like associated_editor) is	
		do
			initialize (ed);	
			register
		end; -- Create

	update_label_text is
		do
			set_label (data.label)
		end;
	
feature {NONE}

	remove_yourself is
		do
			associated_editor.edited_function.remove_element_line (data, True);
			App_editor.update_transitions_list (Void)
		end;

end

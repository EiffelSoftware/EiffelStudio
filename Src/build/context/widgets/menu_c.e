
deferred class MENU_C 

inherit

	COMPOSITE_C
		rename
			copy_attributes as old_copy_attributes,
			reset_modified_flags as old_reset_modified_flags
		redefine
			option_list, context_initialization, widget
		end;

	COMPOSITE_C
		redefine
			context_initialization, reset_modified_flags, copy_attributes, 
			option_list, widget
		select
			copy_attributes, reset_modified_flags
		end



	
feature 

	widget: MENU;

	option_list: ARRAY [INTEGER] is
		do
			!!Result.make (1, 1);
			Result.put (menu_form_number, 1);
		end;

	title: STRING is
		do
			Result := widget.title
		end;

	
feature {NONE}

	title_modified: BOOLEAN;

	
feature 

	set_title (new_title: STRING) is
		do
			title_modified := True;
			if (new_title = Void) or else new_title.empty then
				widget.remove_title;
			else
				widget.set_title (new_title);
			end;
		end;

	reset_modified_flags is
		do
			old_reset_modified_flags;
			title_modified := False;
		end;

	
feature {NONE}

	copy_attributes (other_context: like Current) is
		do
			if title_modified then
				other_context.set_title (title);
			end;
			old_copy_attributes (other_context);
		end;

	
feature {CONTEXT}

	context_initialization (context_name: STRING): STRING is
		do
			!!Result.make (0);
			if title_modified and then not (title = Void) then
				function_string_to_string (Result, context_name, "set_title", title)
			end;
		end;

end


deferred class MENU_C 

inherit

	COMPOSITE_C
		rename
			copy_attributes as old_copy_attributes,
			reset_modified_flags as old_reset_modified_flags
		redefine
			context_initialization, widget,
			intermediate_name
		end;

	COMPOSITE_C
		redefine
			context_initialization, reset_modified_flags, copy_attributes, 
			widget, intermediate_name
		select
			copy_attributes, reset_modified_flags
		end

feature 

	widget: MENU;

	title: STRING is
		do
			Result := widget.title
		end;

feature -- Default event
	default_event: MOUSE_ENTER_EV is
		do
			Result := mouse_enter_ev
		end	

feature {NONE}

	title_modified: BOOLEAN;

feature 

	intermediate_name: STRING is
		do
			Result := parent.intermediate_name;
		end;

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

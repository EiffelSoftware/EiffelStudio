
class PERM_WIND_C 

inherit

	PIXMAPS
		rename
			Top_shell_pixmap as symbol
		export
			{NONE} all
		end;
	WINDOW_C
		rename
			remove_yourself as wind_remove_yourself,
			cut as old_cut,
			undo_cut as old_undo_cut,
			option_list as old_list,
			copy_attributes as old_copy_attributes,
			reset_modified_flags as old_reset_modified_flags,
			add_widget_callbacks as window_add_widget_callbacks
		redefine
			creation_procedure_text, stored_node,
			context_initialization, widget
		end;
	WINDOW_C
		redefine
			creation_procedure_text, stored_node, 
			reset_modified_flags, copy_attributes, 
			context_initialization, option_list, 
			widget, undo_cut, cut, add_widget_callbacks,
			remove_yourself
		select
			cut, undo_cut, option_list, copy_attributes, 
			reset_modified_flags, add_widget_callbacks,
			 remove_yourself
		end

feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.perm_wind_type
		end;

	widget: PERM_WIND;

	create_oui_widget (a_parent: COMPOSITE) is
		local
			contin_command: ITER_COMMAND;
		do
			!!widget.make (entity_name, eb_screen);
			widget_set_title (entity_name);
			title := entity_name;
			set_size (400, 500);
			widget.top_shell.set_action ("<Configure>", Current, Fourth);
			set_default_pixmap;
			!!contin_command;
			widget.top_shell.set_delete_command (contin_command);
		end;

	
feature {NONE}

	add_widget_callbacks is
			-- Define the general behavior of perm window.
		do
			--widget.set_action ("<ConfigureRequest>", Current, First);
			window_add_widget_callbacks;
		end;

	editor_form_cell: CELL [INTEGER] is
		once
			!!Result.put (0)
		end;

	namer: NAMER is
		once
			!!Result.make ("Perm_wind");
		end;

	
feature 

	eiffel_type: STRING is "PERM_WIND";

	remove_yourself is
		local
			child_temp_wind: TEMP_WIND_C;
		do
			from 
				window_list.start
			until
				window_list.after
			loop
				child_temp_wind ?= window_list.item;
				if child_temp_wind /= Void then
					if child_temp_wind.popup_parent = Current then
						child_temp_wind.remove_yourself;
						if not window_list.before then
							window_list.start;
						end;
					end;
				end;	
				window_list.forth;
			end;
			wind_remove_yourself;
		end;

	cut is
		do
			widget.hide;
			old_cut;
		end;

	undo_cut is
		do
			widget.show;
			old_undo_cut
		end;

	-- ***********************
	-- * specific attributes *
	-- ***********************

	option_list: ARRAY [INTEGER] is
		local
			i: INTEGER
		do
			Result := old_list;
			i := Result.upper+2;
			Result.force (perm_wind_form_number, Result.upper+1);
			from
			until
				i > Result.upper
			loop
				Result.put (-1, i);
				i := i + 1
			end
		end;

feature {NONE}

	widget_set_title (new_title: STRING) is
			-- Set`title' to `new_title'
		do
			title := new_title;
			widget.set_title (new_title);
		end;

	widget_forbid_resize is
		do
			widget.forbid_resize
        end;
 
    widget_allow_resize is
		do
			widget.allow_resize
		end;

feature

	set_icon_name (a_name: STRING) is
		do
			icon_name := a_name;
			icon_name_modified := True;
			widget.set_icon_name (a_name);
		end;


	set_icon_pixmap (a_name: STRING) is
		local
			a_pixmap: PIXMAP;
		do
			icon_pixmap_name := a_name;
			icon_pixmap_modified := True;
			if icon_pixmap_name /= Void then
				!!a_pixmap.make;
				a_pixmap.read_from_file (a_name);
				if a_pixmap.is_valid then
					widget.set_icon_pixmap (a_pixmap);
					icon_pixmap_modified := True;
				end;
			end
		end;


	icon_name_modified: BOOLEAN;

	icon_name: STRING;

	icon_pixmap_name: STRING;

	icon_pixmap_modified: BOOLEAN;

	set_iconic_state (flag: BOOLEAN) is
		do
			iconic_state_modified := True;
			widget.set_iconic_state (flag);
		end;

	iconic_state_modified: BOOLEAN;

	is_iconic_state: BOOLEAN is
		do
			Result := widget.is_iconic_state
		end;

	reset_modified_flags is
		do
			old_reset_modified_flags;
			icon_name_modified := False;
			iconic_state_modified := False;
			start_hidden_modified := False;
			start_hidden := False;
		end;

	
feature {NONE}

	copy_attributes (other_context: like Current) is
		do
			if title_modified then
				other_context.set_title (title);
			end;
			if resize_policy_modified then
				other_context.disable_resize_policy (resize_policy_disabled)
			end;
			if icon_name_modified then
				other_context.set_icon_name (icon_name);
			end;
			if iconic_state_modified then
				other_context.set_iconic_state (is_iconic_state)
			end;
			if icon_pixmap_modified then
				other_context.set_icon_pixmap (icon_pixmap_name);
			end;
			if start_hidden_modified then
				other_context.set_start_hidden (start_hidden)
			end;
			old_copy_attributes (other_context);
		end;

	
feature {CONTEXT}

	context_initialization (context_name: STRING): STRING is
		do
			!!Result.make (0);
			if title_modified then
				function_string_to_string (Result, context_name, "set_title", title)
			end;
			if resize_policy_modified then
				cond_f_to_string (Result, resize_policy_disabled, context_name, "forbid_resize", "allow_resize")
			end;
			if icon_name_modified then
				function_string_to_string (Result, context_name, "set_icon_name", icon_name)
			end;
			if icon_pixmap_modified then
				function_string_to_string (Result, context_name, "set_icon_pixmap_by_name", icon_pixmap_name)
			end;
			if iconic_state_modified then
				function_bool_to_string (Result, context_name, "set_iconic_state", is_iconic_state)
			end;
		end;

	
feature {NONE}

	creation_procedure_text: STRING is
		local
			creation_procedure: STRING;
		do
			creation_procedure := clone (eiffel_type);
			creation_procedure.to_lower;
			creation_procedure.append ("_make");

			!!Result.make (100);
			Result.append ("%N%Tmake (a_name: STRING; a_screen: SCREEN) is%N%T%Tdo%N%T%T%T");
			Result.append (creation_procedure);
			Result.append (" (a_name, a_screen);%N");
		end;

-- ****************
-- Storage features
-- ****************

	
feature 

	stored_node: S_PERM_WIND_R1 is
		do
			!!Result.make (Current);
		end;

end

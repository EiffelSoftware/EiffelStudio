
class TEMP_WIND_C 

inherit

	PIXMAPS
		rename
			Dialog_shell_pixmap as symbol
		export
			{NONE} all
		end;

	WINDOW_C
		rename
			option_list as old_list,
			copy_attributes as old_copy_attributes
		redefine
			show, hide, stored_node, widget,
			context_initialization
		end;

	WINDOW_C
		redefine
			show, hide, stored_node, widget, 
			copy_attributes, context_initialization, option_list
		select
			option_list, copy_attributes
		end



	
feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.temp_wind_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make (entity_name, main_panel.base);
			widget_set_title (entity_name);
			set_size (300, 300);
			set_default_pixmap;
			widget.popup;
		end;

	widget: TEMP_WIND;

	
feature {NONE}

	editor_form_cell: CELL [INTEGER] is
		once
			!!Result.put (0)
		end;

	namer: NAMER is
		once
			!!Result.make ("Temp_wind");
		end;

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

	eiffel_type: STRING is "TEMP_WIND";

	hide is
		do
			widget.popdown
		end;

	show is
		do
			widget.popup
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
			Result.force (temp_wind_form_number, Result.upper+1);
			from
			until
				i > Result.upper
			loop
				Result.put (-1, i);
				i := i + 1
			end
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
		end;

-- ****************
-- Storage features
-- ****************

	
feature 

	stored_node: S_TEMP_WIND is
		do
			!!Result.make (Current);
		end;

end

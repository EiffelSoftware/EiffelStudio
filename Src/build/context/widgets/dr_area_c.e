

class DR_AREA_C 

inherit

	PIXMAPS
		rename
			Drawing_area_pixmap as symbol
		export
			{NONE} all
		end;

	CONTEXT
		rename
			option_list as old_list,
			copy_attributes as old_copy_attributes,
			reset_modified_flags as old_reset_modified_flags,
			initialize_transport as old_initialize_transport,
			remove_widget_callbacks as old_remove_widget_callbacks
		redefine
				add_widget_callbacks, stored_node, context_initialization, widget
		end;

	CONTEXT
		redefine
			remove_widget_callbacks, initialize_transport, 
			option_list, reset_modified_flags, copy_attributes,
			add_widget_callbacks, stored_node, context_initialization, widget
		select
			option_list, reset_modified_flags, copy_attributes,
			remove_widget_callbacks, initialize_transport
		end




	
feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.scroll_page.drawing_area_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make (entity_name, a_parent);
			select_widget;
			set_size (80, 80);
			set_drawing_area_size (1000, 1000);
		end;

	widget: EB_DRAWING_BOX;
	
feature {NONE}

	add_widget_callbacks is
		do
			add_common_callbacks (widget);
			add_common_callbacks (widget.scrolled_window);
			initialize_transport;
			if (parent = Void) or else not parent.is_group_composite then
				 widget.scrolled_window.add_enter_action (eb_selection_mgr, Current);
			end;
		end;

	remove_widget_callbacks is
		do
			old_remove_widget_callbacks;
			widget.scrolled_window.remove_button_press_action (2, show_command, Current);
			widget.scrolled_window.remove_button_release_action (2, show_command, Nothing);
			widget.scrolled_window.remove_button_press_action (3, transport_command, Current);
		end;

	initialize_transport is
		do
			old_initialize_transport;
			widget.scrolled_window.add_button_press_action (2, show_command, Current);
			widget.scrolled_window.add_button_release_action (2, show_command, Nothing);
			widget.scrolled_window.add_button_press_action (3, transport_command, Current);
		end;

	editor_form_cell: CELL [INTEGER] is
		once
			!!Result.put (0)
		end;

	namer: NAMER is
		once
			!!Result.make ("Drawing_box");
		end;

	
feature 

	eiffel_type: STRING is "DRAWING_BOX";

	-- ***********************
	-- * specific attributes *
	-- ***********************

	option_list: ARRAY [INTEGER] is
		local
			i: INTEGER
		do
			Result := old_list;
			i := Result.upper+2;
			Result.force (drawing_box_form_number, Result.upper + 1);
			from
			until
				i > Result.upper
			loop
				Result.put (-1, i);
				i := i + 1;
			end
		end;

	set_fg_color_name (a_name: STRING) is
		local
			a_color: COLOR;
		do
			fg_color_name := a_name;
			if a_name /= Void then
				fg_color_modified := True;
				!!a_color.make;
				a_color.set_name (a_name);
				widget.set_foreground (a_color)
			else
				fg_color_modified := False
			end;
		end;

	drawing_area_width: INTEGER is
		do
			Result := widget.drawing_area_width
		end;

	drawing_area_height: INTEGER is
		do
			Result := widget.drawing_area_height
		end;

	drawing_area_size_modified: BOOLEAN;

	set_drawing_area_size (new_w, new_h: INTEGER) is
		do
			drawing_area_size_modified := True;
			widget.set_drawing_area_size (new_w, new_h)
		end;

	reset_modified_flags is
		do
			old_reset_modified_flags;
			drawing_area_size_modified := False;
		end;

	
feature {NONE}

	copy_attributes (other_context: like Current) is
		do
			if drawing_area_size_modified then
				other_context.set_drawing_area_size (drawing_area_width, drawing_area_height)
			end;
			old_copy_attributes (other_context);
		end;

	
feature {CONTEXT}

	context_initialization (context_name: STRING): STRING is
		do
			!!Result.make (0);
			if drawing_area_size_modified then
				function_int_int_to_string (Result, context_name, "set_drawing_area_size", drawing_area_width, drawing_area_height);
			end;
		end;

-- ****************
-- Storage features
-- ****************

	
feature 

	stored_node: S_DR_AREA is
		do
			!!Result.make (Current);
		end;

end

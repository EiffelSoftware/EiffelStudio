

class DR_AREA_C 

inherit

	CONTEXT
		rename
			copy_attributes as old_copy_attributes,
			reset_modified_flags as old_reset_modified_flags,
			initialize_transport as old_initialize_transport
		redefine
			add_widget_callbacks, stored_node, 
			context_initialization, widget
		end;

	CONTEXT
		redefine
			initialize_transport, 
			reset_modified_flags, copy_attributes,
			add_widget_callbacks, stored_node, 
			context_initialization, widget
		select
			reset_modified_flags, copy_attributes,
			initialize_transport
		end;
	COMMAND

feature 

	symbol: PIXMAP is
		do
			Result := Pixmaps.drawing_area_pixmap
		end;

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.scroll_page.drawing_area_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!! widget.make_unmanaged (entity_name, a_parent);
			!! horizontal_line.make;
			horizontal_line.set_line_width (2);
			!! vertical_line.make;
			vertical_line.set_line_width (2);
			widget.add_expose_action (Current, Void);
			horizontal_line.attach_drawing (widget);
			vertical_line.attach_drawing (widget);
			if retrieved_node = Void then
				set_size (80, 80);
				set_drawing_area_size (1000, 1000);
			end
		end;

	widget: DRAWING_BOX;

	vertical_line, horizontal_line: SEGMENT;
			-- Lines to indicate outer edge of drawing area

	execute (arg: ANY) is
			-- Redraw drawing area.
		do
			widget.clear;
			horizontal_line.draw;
			vertical_line.draw;
		end;

feature -- Default event
	default_event: INPUT_EV is
		do
			Result := input_ev
		end
	
feature {NONE}

	add_widget_callbacks is
		local
			mode_backup: INTEGER
		do
			mode_backup := executing_or_editing_mode
			set_mode (editing_mode)
			add_common_callbacks (widget);
			add_common_callbacks (widget.scrolled_window);
			widget.scrolled_window.add_pointer_motion_action (eb_selection_mgr, first_arg);

			initialize_transport;
			if (parent = Void) or else not parent.is_group_composite then
				widget.add_enter_action (eb_selection_mgr, Current);
				widget.scrolled_window.add_enter_action (eb_selection_mgr, Current);
			end;
			set_mode (mode_backup)
		end;

	initialize_transport is
		do
			old_initialize_transport;
			widget.scrolled_window.add_button_press_action (3, transport_command, Current);
		end;

	namer: NAMER is
		once
			!!Result.make ("Drawing_box");
		end;
	
	add_to_option_list (opt_list: ARRAY [INTEGER]) is
		do
			opt_list.put (Context_const.geometry_form_nbr,
					Context_const.Geometry_format_nbr); 
			opt_list.put (Context_const.drawing_box_att_form_nbr,
					Context_const.Attribute_format_nbr)
		end;

feature 

	eiffel_type: STRING is "DRAWING_BOX";

	full_type_name: STRING is "Drawing box"

	-- ***********************
	-- * specific attributes *
	-- **,*********************

	set_fg_color_name (a_name: STRING) is
		local
			a_color: COLOR;
		do
			if a_name = Void or else a_name.empty then
				fg_color_modified := False;
				fg_color_name := Void;
				a_color := default_foreground_color;
				if a_color /= Void then
					widget.set_foreground_color (a_color)
				end
			else
				if fg_color_name = Void then
					save_default_foreground_color
				end;
				fg_color_name := a_name;
				fg_color_modified := True;
				!!a_color.make;
				a_color.set_name (a_name);
				widget.set_foreground_color (a_color)
			end;
		end;

	save_default_foreground_color is
		do
			if default_foreground_color = Void then
				default_foreground_color := widget.foreground_color
			end
		end;

	reset_default_foreground_color is
		do
			widget.set_foreground_color (default_foreground_color);
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
		local
			p1, p2: COORD_XY_FIG
		do
			drawing_area_size_modified := True;
			widget.set_drawing_area_size (new_w, new_h)

			!! p1;
			!! p2;
			p1.set_x (widget.drawing_area_width - 1);
            p1.set_y (0);
			p2.set_x (widget.drawing_area_width - 1);
            p2.set_y (widget.drawing_area_height - 1);
			vertical_line.set (p1, p2);
			
			!! p1;
			!! p2;
			p1.set_x (0);
			p1.set_y (widget.drawing_area_height - 1);
			p2.set_x (widget.drawing_area_width - 1);
			p2.set_y (widget.drawing_area_height - 1);
			horizontal_line.set (p1, p2);
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

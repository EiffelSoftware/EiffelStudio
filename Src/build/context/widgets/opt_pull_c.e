

class OPT_PULL_C 

inherit

	PIXMAPS
		rename
			Opt_pull_pixmap as symbol
		export
			{NONE} all
		end;

	PULLDOWN_C
		redefine
			stored_node, real_y, real_x, 
			set_size, set_x_y, height, width, y, x, option_list, widget, 
			remove_widget_callbacks, initialize_transport, add_widget_callbacks
		end;

	PULLDOWN_C
		redefine
			stored_node, real_y, real_x, 
			set_size, set_x_y, height, width, y, x, option_list, widget, 
			remove_widget_callbacks, initialize_transport, add_widget_callbacks
		end;

feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.menu_page.option_btn_type
		end;

	
feature {NONE}

	add_widget_callbacks is
		do
			add_common_callbacks (widget.button);
			initialize_transport;
			if (parent = Void) or else not parent.is_group_composite then
				widget.button.add_enter_action (eb_selection_mgr, Current);
			end;
		end;

	initialize_transport is
		do
			widget.button.add_button_press_action (2, show_command, Current);
			widget.button.add_button_release_action (2, show_command, Nothing);
			widget.button.add_button_press_action (3, transport_command, Current);
		end;

	remove_widget_callbacks is
		do
			widget.button.remove_button_press_action (2, show_command, Current);
			widget.button.remove_button_release_action (2, show_command, Nothing);
			widget.button.remove_button_press_action (3, transport_command, Current);
		end;

	
feature 

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make (entity_name, a_parent);
			widget.set_text (label);
			widget.set_caption ("");
			if widget.button.realized then
				widget.button.show;
			end;
		end;

	widget: OPT_PULL;

	option_list: ARRAY [INTEGER] is
		do
			!!Result.make (1, 2);
			Result.put (geometry_form_number, 1);
			Result.put (pulldown_form_number, 2);
		end;

	
feature {NONE}

	editor_form_cell: CELL [INTEGER] is
		once
			!!Result.put (0)
		end;

	namer: NAMER is
		once
			!!Result.make ("Opt_pull");
		end;

	
feature 

	eiffel_type: STRING is "OPT_PULL";

	-- *********************
	-- * Widget attributes *
	-- *********************

	x: INTEGER is
			-- Horizontal position relative to parent
		do
			Result := widget.x
		end;

	y: INTEGER is
			-- Vertical position relative to parent
		do
			Result := widget.y
		end;

	width: INTEGER is
			-- Width of widget
		do
			Result := widget.width
		end;

	height: INTEGER is
			-- Height of widget
		do
			Result := widget.height
		end;

	set_x_y (new_x, new_y: INTEGER) is
			-- Set new position of widget
		local
			eb_bulletin: SCALABLE;
		do
			position_modified := True;
			if parent.is_bulletin then
				widget.set_x_y (new_x, new_y);
				eb_bulletin ?= parent.widget;
				eb_bulletin.update_ratios (widget.button);
			else
				widget.set_x_y (new_x, new_y);
			end;
		end;

	set_size (new_w, new_h: INTEGER) is
			-- Set new size of widget
		local
			eb_bulletin: SCALABLE;
		do
			size_modified := True;
			if parent.is_bulletin then
				widget.set_size (new_w, new_h);
				eb_bulletin ?= parent.widget;
				eb_bulletin.update_ratios (widget.button);
			else
				widget.set_size (new_w, new_h);
			end;
		end;

	real_x: INTEGER is
			-- Vertical position relative to root window
		do
			Result := widget.real_x
		end;

	real_y: INTEGER is
			-- horizontal position relative to root window
		do
			Result := widget.real_y
		end;

	
	forbid_recompute_size is
		do
			widget.forbid_recompute_size;
		end;


	allow_recompute_size is
		do
			widget.allow_recompute_size;
		end;


	widget_set_center_alignment is
		do
		end;

	widget_set_left_alignment is
		do
		end;


-- ****************
-- Storage features
-- ****************

	
feature 

	stored_node: S_OPT_PULL is
		do
			!!Result.make (Current);
		end;

end

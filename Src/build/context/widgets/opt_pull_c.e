

class OPT_PULL_C 

inherit

	PULLDOWN_C
		rename
			context_initialization as pull_context_initialization
		redefine
			stored_node, real_y, real_x,  
			set_size, set_x_y, height, width, y, x, widget, 
			is_resizable
		end

	PULLDOWN_C
		redefine
			stored_node, real_y, real_x, context_initialization,
			set_size, set_x_y, height, width, y, x, widget, 
			is_resizable
		select
			context_initialization
		end

-- samik	G_ANY

feature 

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.menu_page.option_btn_type
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.opt_pull_pixmap
		end;


	add_to_option_list (opt_list: ARRAY [INTEGER]) is
		do
			opt_list.put (Context_const.geometry_form_nbr,
						Context_const.Geometry_format_nbr);
			opt_list.put (Context_const.pulldown_sm_form_nbr,
						Context_const.Submenu_format_nbr);
		end;

	is_resizable: BOOLEAN is
		do
			Result := False
		end

feature 

	caption_modified: BOOLEAN;

	caption: STRING is
		do
			Result := widget.caption;
		end;

	context_initialization (context_name: STRING): STRING is
		do
			!!Result.make (0);
			if caption_modified then
				function_string_to_string (Result, context_name, "set_caption", caption);
			else
				function_string_to_string (Result, context_name, "set_caption", "");
			end;
			Result.append (pull_context_initialization (context_name));
		end
	
	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make_unmanaged (entity_name, a_parent);
			widget.set_text (label);
			widget.set_caption ("");
			--if widget.button.realized then
				--widget.button.show;
			--end;
		end;

	widget: OPT_PULL;

	set_default_selected_button (menu_entry_c: MENU_ENTRY_C) is
			-- Set the default selected button to the first child.
		require
			has_children: arity > 0;
			non_void_menu_entry: menu_entry_c /= Void;
			valid_menu_entry_c: menu_entry_c.parent = Current
		do
			if widget.selected_button = Void then
				widget.set_selected_button (menu_entry_c.widget)
			end
		end;

feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Opt_pull");
		end;

feature 

	eiffel_type: STRING is "OPT_PULL";

	full_type_name: STRING is "Option pull"

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

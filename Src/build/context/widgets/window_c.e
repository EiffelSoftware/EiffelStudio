
deferred class WINDOW_C 

inherit


	COMMAND;

	COMMAND_ARGS;
--		select
--			First, Second
--		end;

	CONTEXT_SHARED
		export
			{NONE} all
		end;
	COMPOSITE_C
		rename
			reset_modified_flags as composite_reset_modified_flags
		redefine
			create_context, cut, position_initialization,
			is_in_a_group, link_to_parent, root, set_position,
			intermediate_name, is_bulletin,
			deleted, remove_yourself, group_name,
			set_x_y, set_size, set_visual_name
		end;
	COMPOSITE_C
		redefine
			create_context, cut, position_initialization,
			is_in_a_group, link_to_parent, root, set_position,
			intermediate_name, is_bulletin,
			deleted, remove_yourself, group_name,
			set_x_y, set_size, set_visual_name,
			reset_modified_flags
		select
			reset_modified_flags
		end
	
feature 

	group_name: STRING is do end;

	title: STRING;

	title_modified: BOOLEAN;

	set_title (new_title: STRING) is
			-- Set`title' to `new_title'
		do
			title_modified := True;
			widget_set_title (new_title);
			visual_name := clone (new_title);
			update_tree_element
		end;

	resize_policy_disabled: BOOLEAN;

	resize_policy_modified: BOOLEAN;

	disable_resize_policy (flag: BOOLEAN) is
        do
            resize_policy_modified := True;
            resize_policy_disabled := flag;
            if flag then
                widget_forbid_resize;
                    -- The current size must be saved
                size_modified := True
            else
                widget_allow_resize
            end;
        end;

	reset_modified_flags is
		do
			composite_reset_modified_flags;
			title_modified := False;
			resize_policy_modified := False;
		end;

	set_grid (pix: PIXMAP) is
		local
			null_pointer: POINTER;
		do
			if pix = Void then
				if bg_pixmap_name /= Void then
					set_bg_pixmap_name (bg_pixmap_name)	
				else
					if default_pixmap_value /= null_pointer then
						c_efb_set_bg_pixmap (widget.implementation.screen_object, default_pixmap_value);  
					else
						set_default_pixmap;
						c_efb_set_bg_pixmap (widget.implementation.screen_object, default_pixmap_value); 
					end;
				end;
			else
				if pix.is_valid then
					widget.set_managed (False);
					widget.set_background_pixmap (pix);
					widget.set_managed (True);
				end;
			end
		end;

	default_pixmap_value: POINTER;

	set_default_pixmap is
		do
			default_pixmap_value := 
				c_efb_get_bg_pixmap (widget.implementation.screen_object)
		end;

feature {NONE}

	widget_set_title (s: STRING) is
		deferred
		end;

	widget_forbid_resize is
		deferred
		end;

	widget_allow_resize is
		deferred
		end;

feature 

	set_visual_name (s: STRING) is
		do
			if (s = Void) then
				visual_name := Void;
				update_tree_element;
				set_title (label)
			else
				set_title (s);
			end;
		end;

	is_bulletin: BOOLEAN is
		do
			Result := True
		end;

	is_in_a_group: BOOLEAN is
		do
			Result := False
		end;

	link_to_parent is
		require else
			True;
		do
			window_list.finish;
			window_list.add_right (Current);
		end;

	root: CONTEXT is
		do
			Result := Current
		end;

	set_position (x_pos, y_pos: INTEGER) is
		do
			set_x_y (x_pos, y_pos);
		end;

	set_x_y (new_x, new_y: INTEGER) is
			-- Set new position of widget
		do
			position_modified := True;
			widget.set_x_y (new_x, new_y);
		end;

	set_size (new_w, new_h: INTEGER) is
			-- Set new size of widget
		do
			size_modified := True;
			widget.set_size (new_w, new_h);
		end;

	
feature {CONTEXT}

	intermediate_name: STRING is
		do
			!!Result.make (0);
		end;

	
feature 

	create_context (a_parent: COMPOSITE_C): like Current is
			-- Create a context of the same type
		local
			void_parent: COMPOSITE;
			create_command: CONTEXT_CREATE_CMD;
		do
			Result := New;
			Result.link_to_parent;
			Result.generate_internal_name;
			Result.oui_create (void_parent);
			if not (widget = Void) then
				Result.set_size (width, height);
				copy_attributes (Result);
			end;
			!!create_command;
			create_command.execute (Result);
		end;

	deleted : BOOLEAN is
		do
			window_list.start;
			window_list.search (Current);
			Result := window_list.after
		end;

	remove_yourself is
		local
			command: CONTEXT_CUT_CMD
		do
			!!command;
			command.execute (Current);
			tree.display (Current)
		end;

	cut is
		do
			window_list.start;
			window_list.search (Current);
			if not window_list.exhausted then
				window_list.remove;
			end;
			widget.set_managed (False);
			tree.cut (tree_element);
			context_catalog.clear_editors (Current);
		end;

	
	execute (argument: like Current) is
		local
			ed: CONTEXT_EDITOR;
		do
			if argument = Current then
				ed := context_catalog.editor (Current, geometry_form_number);
				if ed /= Void then
					ed.current_form.reset_form;
				end;
			end;
		end;


feature {NONE}

	position_initialization (context_name: STRING): STRING is
			-- Eiffel code for the position of current context
			-- depending on the type of its parent
		do
			!!Result.make (0);
			if position_modified then
				function_int_int_to_string (Result, "", "set_x_y", x, y);
			end;
			if size_modified then
				function_int_int_to_string (Result, "", "set_size", width, height);
			end;
		end;

feature {NONE} -- External

	c_efb_get_bg_pixmap (w: POINTER): POINTER is
		external
			"C"
		end;

	c_efb_set_bg_pixmap (w, pix: POINTER) is
		external
			"C"
		end;

end

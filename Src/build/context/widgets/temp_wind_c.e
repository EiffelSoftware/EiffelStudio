
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
			copy_attributes as old_copy_attributes,
			cut as old_cut,
			undo_cut as old_undo_cut,
			create_context as window_create_context,
			retrieve_oui_widget as window_retrieve_oui_widget,
			import_oui_widget as window_import_oui_widget
		redefine
			show, hide, stored_node, widget,
			context_initialization, 
			position_initialization
		end;

	WINDOW_C
		redefine
			show, hide, stored_node, widget, 
			copy_attributes, context_initialization, option_list,
			cut, undo_cut, create_context, retrieve_oui_widget,
			import_oui_widget, position_initialization
		select
			option_list, copy_attributes, cut, undo_cut,
			create_context, retrieve_oui_widget, import_oui_widget
		end



	
feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.temp_wind_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make (entity_name, main_panel.base);
			widget.set_default_position (False);
			--popdown;
			disable_resize_policy (False);
			widget_set_title (entity_name);
			set_size (300, 300);
			widget.parent.set_action ("<Configure>", Current, Current);
			set_default_pixmap;
		end;


	widget: TEMP_WIND;

	popup is
		do
			widget.popup;
		end;

	popdown is
		do
			widget.popdown;
		end;

	popup_parent: COMPOSITE_C;

	set_popup_parent (c: COMPOSITE_C) is
		do
			popup_parent := c;
		end;

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
			Result.set_popup_parent (a_parent);
		end;

	retrieve_oui_widget is
		local
			parent_context: COMPOSITE_c;
			temp_node: S_TEMP_WIND;
		do
			temp_node ?= retrieved_node;
			parent_context := find_parent (temp_node.parent_name);
			set_popup_parent (parent_context);
			window_retrieve_oui_widget;
		end;

	import_oui_widget (group_table: INT_H_TABLE [INTEGER]) is
		local
			parent_context: COMPOSITE_c;
			temp_node: S_TEMP_WIND;
		do
			temp_node ?= retrieved_node;
			window_import_oui_widget (group_table);
			parent_context := find_parent (temp_node.parent_name);
			set_popup_parent (parent_context);
		end;

feature {NONE}

	find_parent (parent_name: STRING): COMPOSITE_C is
		local
			position: INTEGER;
			found_parent: CONTEXT;
		do
			position := window_list.index;
			from
				window_list.start
			until
				window_list.after or
				Result /= Void
			loop
				if window_list.item.entity_name.is_equal (parent_name) then
					found_parent := window_list.item;
					Result ?= found_parent;
				end;
				window_list.forth;
			end;
			window_list.go_i_th (position);
		end;


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

	cut is 
		do
			widget.hide;
			old_cut;
		end;

	undo_cut is
		do
			widget.show;
			old_undo_cut;
		end;

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

feature {NONE}

	position_initialization (context_name: STRING): STRING is
			-- Eiffel code for the position of current context
			-- depending on the type of its parent
		do
			!!Result.make (0);
			if position_modified then
				function_int_int_to_string (Result, "", "set_x_y", x, y);
			end;
			Result.append ("%T%T%Tpopdown;%N");
			if size_modified then
				function_int_int_to_string (Result, "", "set_size", width, height);
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

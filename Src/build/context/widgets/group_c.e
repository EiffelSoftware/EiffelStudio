class GROUP_C 

inherit

	SHARED_CONTEXT;
	SHARED_STORAGE_INFO;
	COMPOSITE_C
		rename
			reset_modified_flags as old_reset_modified_flags,
			cut_list as old_cut_list,
			cut as old_cut,
			undo_cut as old_undo_cut,
			eiffel_callback_calls as old_eiffel_callback_calls
		redefine
			retrieved_node, import_oui_widget, retrieve_oui_widget, 
			creation_procedure_text, children_callbacks, 
			children_color, children_initialization, eiffel_declaration, 
			full_name, intermediate_name, create_context, 
			show_tree_elements, hide_tree_elements, tree_element, 
			is_bulletin, is_in_a_group, is_a_group, save_widget, 
			stored_node, widget, set_modified_flags, 
			help_file_name, is_able_to_be_grouped,
			update_group_name_in_tree, remove_callbacks,
			reset_callbacks
		end;
	COMPOSITE_C
		redefine
			retrieved_node, import_oui_widget, retrieve_oui_widget, 
			creation_procedure_text, eiffel_callback_calls, children_callbacks, 
			children_color, children_initialization, eiffel_declaration, 
			full_name, intermediate_name, reset_modified_flags, create_context, 
			show_tree_elements, hide_tree_elements, undo_cut, cut, tree_element, 
			cut_list, is_bulletin, is_in_a_group, is_a_group, save_widget, 
			stored_node, widget, set_modified_flags, help_file_name,
			is_able_to_be_grouped, update_group_name_in_tree, 
			remove_callbacks, reset_callbacks
		select
			reset_modified_flags, cut_list, cut, 
			undo_cut, eiffel_callback_calls
		end

feature -- Reseting/reseting callbacks

	remove_callbacks is
		do
			remove_widget_callbacks;
			from
				subtree.start
			until
				subtree.after
			loop
				subtree.item.remove_callbacks;
				subtree.forth
			end;
		end;

	reset_callbacks is
		do
			reset_widget_callbacks;
			from
				subtree.start
			until
				subtree.after
			loop
				subtree.item.reset_callbacks;
				subtree.forth
			end;
		end;

feature 

	widget: EB_BULLETIN_EXT;

	symbol: PIXMAP is
		do
			Result := Pixmaps.group_pixmap
		end;

	help_file_name: STRING is
		do
			Result := Help_const.group_help_fn
		end;

	type: CONTEXT_GROUP_TYPE is
		do
			Result := group_type.context_type;
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		local
		do
			!! widget.make_unmanaged (entity_name, a_parent);
			group_type.increment_counter;
		end;

	add_to_option_list (opt_list: ARRAY [INTEGER]) is
		do
			opt_list.put (Context_const.geometry_form_nbr,
					Context_const.Geometry_format_nbr);
		end;

	save_widget (new_context: GROUP_C; table: HASH_TABLE [WIDGET, CONTEXT]) is
		local
			found: BOOLEAN;
			a_list: LINKED_LIST [CONTEXT]
		do
			table.put (new_context.widget, Current);
			a_list := new_context.subtree;
			from
				subtree.start
			until	
				subtree.after
			loop
				from
					a_list.start
				until
					a_list.after or found
				loop
					if subtree.item.entity_name.is_equal (a_list.item.entity_name) then
						found := True;
						subtree.item.save_widget (a_list.item, table);
					end;
					a_list.forth
				end;
				found := False;
				subtree.forth
			end;
		end;

	reparent_bulletin (a_bulletin: BULLETIN_C; a_list: LINKED_LIST [CONTEXT]) is
		do
			initialize;
			widget := a_bulletin.widget;
			!!tree_element.make (Current);

			group_type.increment_counter;
				-- update subtree
			subtree := a_list;
		end;

	set_modified_flags is
			-- set all the flags to true
			-- in a recursive way
			-- Useful for the code generation (groups) after ungrouping
		do
			position_modified := True;
			size_modified := True;
			if fg_color_name /= Void and then not fg_color_name.empty then
				fg_color_modified := True;
			end;
			if bg_color_name /= Void and then not bg_color_name.empty then
				bg_color_modified := True;
			end;
			if bg_pixmap_name /= Void and then not bg_pixmap_name.empty then
				bg_pixmap_modified := True;
			end;
			if font_name /= Void and then not font_name.empty then
				font_name_modified := True;
			end;
			from
				subtree.start
			until
				subtree.after
			loop
				subtree.item.reset_modified_flags;
				subtree.forth
			end;
		end;
	
feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Group");
		end;

feature 

	eiffel_type: STRING is 
		do
			Result := group_type.entity_name
		end;

	is_bulletin: BOOLEAN is
		do
			Result := True
		end;

	-- ***********************
	-- * specific attributes *
	-- ***********************

	tree_element: GROUP_TREE_ELEMENT;

	subtree: LINKED_LIST [CONTEXT];

	group_type: GROUP;

	set_type (a_type: GROUP) is
		do
			group_type := a_type;
			!!subtree.make;
		end;

	set_type_identifier (a_type: INTEGER) is
		local
			a_group: GROUP;
			found: BOOLEAN;
		do
			from
				Shared_group_list.start
			until
				Shared_group_list.after or found
			loop
				if Shared_group_list.item.identifier = a_type then
					set_type (Shared_group_list.item);
					found := true;
				else
					Shared_group_list.forth
				end;
			end;
		end;

	add_group_child (a_child: CONTEXT) is
		do
			subtree.finish;
			subtree.put_right (a_child);
		end;

	is_a_group: BOOLEAN is
		do
			Result := True
		end;

	is_able_to_be_grouped: BOOLEAN is
			-- Is Current group able to be grouped?
		do
			Result := not is_in_a_group and then
				grouped and then group.count > 1
		end;

	is_in_a_group: BOOLEAN is
		do
			Result := parent.is_in_a_group
		end;

	cut_list: LINKED_LIST [CONTEXT] is
		do
			Result := old_cut_list;
			from
				subtree.start
			until
				subtree.after
			loop
				Result.merge_right (subtree.item.cut_list);
				subtree.forth
			end;
		end;

	cut is
		do
			old_cut;
			group_type.decrement_counter;
		end;

	undo_cut is
		do
			old_undo_cut;
			group_type.increment_counter;
		end;

	show_tree_elements is
		do
			if tree_element.show_children then
				from
					subtree.start
				until
					subtree.after
				loop
					tree.append (subtree.item.tree_element);
					subtree.item.show_tree_elements;
					subtree.forth
				end;
			end;
		end;

	hide_tree_elements is
		do
			if tree_element.show_children then
				from
					subtree.start
				until
					subtree.after
				loop
					subtree.item.hide_tree_elements;
					tree.cut (subtree.item.tree_element);
					subtree.forth
				end;
			end;
		end;

	reset_modified_flags is
		do
			old_reset_modified_flags;
			from
				subtree.start
			until
				subtree.after
			loop
				subtree.item.reset_modified_flags;
				subtree.forth
			end;
		end;

	create_context (a_parent: COMPOSITE_C): like Current is
		local
			create_command: CONTEXT_CREATE_CMD;
		do
			!!Result;
			Result.set_type (group_type);
			a_parent.append (Result);
			Result.generate_internal_name;
			Result.oui_create (a_parent.widget);
				-- To give new identifier
			for_import.set_item (True);
			group_type.create_oui_group (Result);
			for_import.set_item (False);
				-- Clear the context table.
			context_table.clear_all;		

			Result.reset_modified_flags;

			!!create_command;
			create_command.execute (Result);
		end;

	-- *******************
	-- * Code generation *
	-- *******************
	
feature {CONTEXT}

	intermediate_name: STRING is
		do
			if group_text_generation then
				!!Result.make (0);
			else
				Result := parent.intermediate_name;
				if not Result.empty then
					Result.append (".");
				end;
				Result.append (entity_name);
			end;
		end;

	
feature 

	full_name: STRING is
		do
			Result := intermediate_name;
		end;

	
feature {NONE}

	group_text_generation: BOOLEAN;

	
feature {CONTEXT}

	eiffel_declaration: STRING is
		local
			class_name: STRING;
		do
			!!Result.make (0);
			Result.append ("%T");
			Result.append (entity_name);
			Result.append (": ");
			class_name := clone (eiffel_type);
			class_name.to_upper;
			Result.append (class_name);
			Result.append (";%N");
		end;

	
feature {NONE}

	creation_procedure_text: STRING is
		do
			!!Result.make (100);
			Result.append ("%N%Tmake (a_name: STRING; a_parent: COMPOSITE) is%N%T%Tdo%N%T%T%Teb_bulletin_make (a_name, a_parent);%N");
		end;

	group_creation (parent_name: STRING): STRING is
		do
			!!Result.make (0);
			from
				subtree.start
			until
				subtree.after
			loop
				Result.append (subtree.item.eiffel_creation (parent_name));
				subtree.forth;
			end;
		end;

	
feature {CONTEXT}

	children_initialization: STRING is
		do
			!!Result.make (0);
			from
				subtree.start
			until
				subtree.after
			loop
				Result.append (subtree.item.eiffel_initialization);
				subtree.forth
			end;
		end;

	
feature 

	children_color: STRING is
		local
			a_child: CONTEXT;
			context_name: STRING;
		do
			!!Result.make (0);
			from
				subtree.start
			until
				subtree.after
			loop
				a_child := subtree.item;
				context_name := a_child.full_name;
				context_name.append (".");
				Result.append (a_child.eiffel_color (context_name));
				subtree.forth;
			end;
		end;

feature {CONTEXT} -- Update name for group	

	update_group_name_in_tree (g: GROUP) is
			-- Update the eiffel_type for group_c in context
			-- tree using group `g'.
		local
			item: CONTEXT;
			group_c: GROUP_C
		do
			from
				subtree.start
			until
				subtree.after
			loop
				item := subtree.item;
				if item.is_a_group then
					group_c ?= item;
					if group_c.group_type = g then
						group_c.update_tree_element
					else
							-- Check to see if a group has `g'
						group_c.update_group_name_in_tree (g);
					end;
				end;
				subtree.forth
			end;
		end;

feature {CONTEXT}

	children_callbacks: STRING is
		do
			from
				!!Result.make (0);
				subtree.start
			until
				subtree.after
			loop
				Result.append (subtree.item.eiffel_callbacks);
				subtree.forth;
			end;
		end;

	
feature {CLBKS, CONTEXT}

	eiffel_callback_calls: STRING is
		do
			Result := old_eiffel_callback_calls;
			from
				subtree.start
			until
				subtree.after
			loop
				Result.append (subtree.item.eiffel_callback_calls);
				subtree.forth
			end
		end;

feature -- Code generation

	group_text: STRING is
			-- Text generated just after the creation of the first
			-- instance of `group_type', before the reset of the
			-- flags. Only generate the declaration for non-group
			-- composites, the creation and initialization routines.
			-- This does not generate the class_name, inheritance
			-- clause and declarations for groups. 
			--| The class name and declarations for groups are separated since
			--| group_text is only generated once (at point of group creation)
			--| and the group eiffel type may change.	
		local
			color_text: STRING;
		do
			group_text_generation := True;
			!!Result.make (100);

				-- Declaration (without groups)
			Result.append (declaration_without_groups);

				-- Creation
			Result.append (creation_procedure_text);
			Result.append (group_creation ("Current"));
			Result.append ("%T%T%Tset_values;%N");
			Result.append ("%T%Tend;%N");

				-- Initialization
			Result.append ("%N%Tset_values is%N%T%Tdo%N");
			Result.append (context_initialization (""));
			Result.append (font_creation (""));

				-- New position_initialization
			if size_modified then
				function_int_int_to_string (Result, "", "set_size", width, height);
			end; 
			Result.append (children_initialization);

				-- Colors

			color_text := children_color;
			if not color_text.empty then
				Result.append ("%T%T%Tset_colors;%N");
				Result.append ("%T%Tend;%N");
				Result.append ("%N%Tset_colors is%N%T%Tlocal%N%T%T%Ta_color: COLOR;%N%T%T%Ta_pixmap: PIXMAP%N%T%Tdo%N");
				Result.append (color_text);
			end;
			group_text_generation := False;
		end;

	declaration_without_groups: STRING is
			-- Eiffel declaration of widgets.
			-- Does not generate group declaration.
		local
			cont: CONTEXT
		do
			!!Result.make (0);
			from
				subtree.start
			until
				subtree.after
			loop
				cont := subtree.item;
				if not cont.is_a_group then
					Result.append (subtree.item.eiffel_declaration);
				end;
				subtree.forth;
			end;
		end;

feature -- Storage

	stored_node: S_GROUP is
		do
			!!Result.make (Current);
		end;

	retrieved_node: S_GROUP;

	retrieve_oui_widget is
			-- Retrieve oui widget info.
		local
			parent_widget: COMPOSITE
		do
			parent_widget ?= parent.widget;
			oui_create (parent_widget);
				-- When creating the group do not
				-- call set_context_attributes for children
				-- groups
			group_type.create_oui_group (Current);
			reset_modified_flags;
				-- This sets the context attributes to	
				-- all the children as well.
			retrieved_node.set_context_attributes (Current);
			widget.manage;
			retrieved_node := Void
		end;

	import_oui_widget (group_table: INT_H_TABLE [INTEGER]) is
		local
			new_id: INTEGER;
		do
			new_id := group_table.item (retrieved_node.group_type);
			set_type_identifier (new_id);
			generate_internal_name;
			retrieve_oui_widget;
		end;

end

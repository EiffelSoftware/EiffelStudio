class GROUP_C 

inherit

	SHARED_CONTEXT;
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
			reset_callbacks, remove_callbacks, stored_node, widget,
			set_modified_flags
		end;
	COMPOSITE_C
		redefine
			retrieved_node, import_oui_widget, retrieve_oui_widget, 
			creation_procedure_text, eiffel_callback_calls, children_callbacks, 
			children_color, children_initialization, eiffel_declaration, 
			full_name, intermediate_name, reset_modified_flags, create_context, 
			show_tree_elements, hide_tree_elements, undo_cut, cut, tree_element, 
			cut_list, is_bulletin, is_in_a_group, is_a_group, save_widget, 
			reset_callbacks, remove_callbacks, stored_node, widget,
			set_modified_flags
		select
			reset_modified_flags, cut_list, cut, 
			undo_cut, eiffel_callback_calls
		end
	
feature 

	symbol: PIXMAP is
		do
			Result := Pixmaps.group_pixmap
		end;

	context_type: CONTEXT_TYPE is
		do
			Result := group_type.context_type;
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		local
		do
			!! widget.make_unmanaged (entity_name, a_parent);
			group_type.increment_counter;
		end;

	widget: EBUILD_BULLETIN;

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

	is_in_a_group: BOOLEAN is
		do
			Result := True
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
					tree.cut (subtree.item.tree_element);
					subtree.item.hide_tree_elements;
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
			group_type.create_oui_group (Result);
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

	group_declaration: STRING is
		do
			!!Result.make (0);
			from
				subtree.start
			until
				subtree.after
			loop
				Result.append (subtree.item.eiffel_declaration);
				subtree.forth;
			end;
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

	
feature 

	group_text: STRING is
		-- Text generated just after the creation of the first
		-- instance of `group_type', before the reset of the
		-- flags
		local
			class_name: STRING;
			color_text: STRING;
		do
			group_text_generation := True;
			class_name := clone (eiffel_type);
			class_name.to_upper;
			!!Result.make (100);
			Result.append ("class ");
			Result.append (class_name);

			-- ***********
			-- Inheritance
			-- ***********
			Result.append ("%N%Ninherit%N%N%TEB_BULLETIN");
			Result.append ("%N%T%Trename%N%T%T%Tmake as eb_bulletin_make");
			Result.append ("%N%T%Tend;");

			-- ********
			-- Features
			-- ********
			Result.append ("%N%Ncreation%N%N%Tmake");
			Result.append ("%N%Nfeature%N%N");

			-- Declaration
			--============
			Result.append (group_declaration);

			-- Creation
			--=========
			Result.append (creation_procedure_text);
			Result.append (group_creation ("Current"));
			Result.append ("%T%T%Tset_values;%N");
			Result.append ("%T%Tend;%N");

			-- Initialization
			--===============
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
			Result.append ("%T%Tend;%N%Nend%N%N");
			group_text_generation := False;
		end;

	-- ****************
	-- Storage features
	-- ****************

	stored_node: S_GROUP is
		do
			!!Result.make (Current);
		end;

	retrieved_node: S_GROUP;

	retrieve_oui_widget is
		local
			parent_widget: COMPOSITE
		do
			parent_widget ?= parent.widget;
			oui_create (parent_widget);
			group_type.create_oui_group (Current);
			reset_modified_flags;
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
			retrieved_node.set_name_change (full_name);
			retrieve_oui_widget;
		end;

end


deferred class GROUP_COMPOSITE_C 

inherit

	COMPOSITE_C
		rename
			create_context as old_create_context
		redefine
			is_group_composite, set_size, 
			retrieve_oui_widget, import_oui_widget,
			is_resizable
		end;

	COMPOSITE_C
		redefine
			create_context, is_group_composite, set_size, 
			retrieve_oui_widget, import_oui_widget, is_resizable
		select
			create_context
		end
	
feature -- Default event
	default_event: MOUSE_ENTER_EV is
		do
			Result := mouse_enter_ev
		end

feature 

	--full_name: STRING is
			-- full name of the context i.e. with root, group, ...
		--do
			--Result := intermediate_name;
		--end;

	is_group_composite: BOOLEAN is
		do
			Result := True
		end;

	is_resizable: BOOLEAN is
		do
			Result := False
		end;

	create_new_child: CONTEXT is
		local
			tg: TOGGLE_B_C
		do
			Result := context_catalog.toggle_b_type.create_context (Current);
			Result.remove_resize_policy;
			tg ?= Result;
			if tg /= Void then
				tg.disable_resize_policy (False);
			end;
			Result.widget.manage
		end;

	create_context (a_parent: COMPOSITE_C): like Current is
			-- Add two children in the group container
			-- after its creation and the insertion in
			-- the history list
		local
			new_context: CONTEXT;
		do
			Result := old_create_context (a_parent);
			new_context := Result.create_new_child;
			new_context := Result.create_new_child;
		end;

	set_size (new_w, new_h: INTEGER) is
			-- Set new size of widget
			-- Create or delete toggle buttons if needed
		local
			children_number: INTEGER;
			new_number: INTEGER;
			command: CONTEXT_CUT_CMD;
			new_context: CONTEXT;
			a_child, previous_child: CONTEXT;
			modification: BOOLEAN;
		do
			size_modified := True;
			widget.unmanage;
			widget.set_height (new_h);
			if retrieved_node = Void then
					-- Figure out new children creation
					-- during session (not for retrieving).
				children_number := arity;
				if children_number = 0 then
						-- Create first child
					children_number := 1;
					new_context := create_new_child;
					modification := True;
				end;
				child_start;
				new_number := new_h // (child.height + 3);
				if (new_number > children_number) then
					from
					until
						children_number = new_number
					loop
						new_context :=  create_new_child;
						children_number := children_number + 1 ;
					end;
					modification := True;
				elseif (new_number >= 1 and then new_number < children_number) then
					from
						child_finish;
						a_child := child
					until
						children_number = new_number
					loop
						previous_child := a_child.left_sibling;
						!!command;
						command.execute (a_child);
						a_child := previous_child;
						children_number := children_number - 1 ;
					end;
					modification := True;
				end;
				if modification then
					tree.display (Current);
				end;
			end;
			widget.manage
		end;

	update_form_for_all_children (form_nr: INTEGER) is
			-- Update form `form_nr' for all children of Current.
		local
			toggle_b_c: TOGGLE_B_C
			other_editor: CONTEXT_EDITOR;
			old_pos: INTEGER
		do
			from
				child_start
			until
				child_offright
			loop
				toggle_b_c ?= child;
				if toggle_b_c /= Void then
					other_editor := context_catalog.editor (toggle_b_c, form_nr)
					if other_editor /= Void then
						other_editor.reset_current_form
					end
				end;
				child_forth
			end;
			other_editor := context_catalog.editor (Current, form_nr)
			if other_editor /= Void then
				other_editor.reset_current_form
			end;
		end;

	retrieve_oui_widget is
		local
			parent_widget: COMPOSITE
		do
			if not (parent = Void) then
				parent_widget ?= parent.widget;
			end;
			oui_create (parent_widget);
			from
				child_start
			until
				child_offright
			loop
				child.retrieve_oui_widget;
				child_forth
			end;
			retrieved_node.set_context_attributes (Current);
			widget.manage;
			retrieved_node := Void;
		end;


	import_oui_widget (group_table: INT_H_TABLE [INTEGER]) is
		local
			parent_widget: COMPOSITE
		do
			generate_internal_name;
			if not (parent = Void) then
				parent_widget ?= parent.widget;
			end;
			oui_create (parent_widget);
			from
				child_start
			until
				child_offright
			loop
				child.import_oui_widget (group_table);
				child_forth
			end;
			retrieved_node.set_context_attributes (Current);
			widget.manage;
			retrieved_node := Void
		end;

end

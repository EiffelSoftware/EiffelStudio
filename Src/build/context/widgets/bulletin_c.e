class BULLETIN_C 

inherit

	PIXMAPS
		rename
			Bulletin_pixmap as symbol
		export
			{NONE} all
		end;

	COMPOSITE_C
		redefine
			widget, stored_node, is_bulletin,
			original_stone, intermediate_name
		
		end
	
feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.set_page.bulletin_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		local
--temp: STRING;
--temp1: ANY	
		do
			!!widget.make (entity_name, a_parent);
			select_widget;
--temp := "resizePolicy";
--temp1 := temp.to_c;
--bulletin_c_set_int (widget.implementation.screen_object, 0, $temp1);
			set_size (40, 40);
		end;

	widget: EB_BULLETIN;

feature {NONE}

	editor_form_cell: CELL [INTEGER] is
		once
			!!Result.put (0)
		end;

	namer: NAMER is
		once
			!!Result.make ("Bulletin");
		end;

feature 

	eiffel_type: STRING is "EB_BULLETIN";

	intermediate_name: STRING is
			-- full name of the context i.e. with root, group, ...
		local
			bup: BULLETIN_C;
		do
			bup ?= parent;
			if bup /= Void then
				result := parent.intermediate_name;
			else
				Result := parent.full_name;
			end;
		end;

	is_bulletin: BOOLEAN is
		do
			Result := True
		end;

	transform_in_group (a_group: GROUP_C) is
			-- Transform the bulletin and its content in a group instance
			-- (Creation of the group)
		do
			parent.child_start;
			parent.search_same_child (Current);
			parent.remove_child;
			tree.cut (tree_element);
			context_catalog.clear_editors (Current);
			transformed_in_group :=  True;
			group_context :=  a_group;
			set_new_parent (a_group);
		end;

	transform_in_bulletin is
			-- Undo the transformation from bulletin to group instance
		do
			link_to_parent;
			widget.set_managed (True);
			tree.append (tree_element);
			transformed_in_group := False;
			set_new_parent (Current);
		end;

	group_context: GROUP_C;
		-- For the callbacks in the selection manager

	transformed_in_group: BOOLEAN;
		-- For the callbacks in the selection manager

	original_stone: CONTEXT is
		do
			if transformed_in_group then
				Result := group_context
			else
				Result := Current
			end;
		end;

	
feature {NONE}

	set_new_parent (a_parent: CONTEXT) is
			-- Change the parent of all the children
			-- (used for the transformation bulletin <-> group)
		do
			from
				child_start
			until
				child_offright
			loop
				child.set_parent(a_parent);
				child_forth;
			end;
		end;

-- ****************
-- Storage features
-- ****************
	
feature 

	stored_node: S_BULLETIN is
		do
			!!Result.make (Current);
		end;

feature {NONE} -- External features

	bulletin_c_set_int (a_w: POINTER; a_val: INTEGER; a_res: ANY) is
		external
			"C"
		alias
			"set_int"
		end; -- bulletin_c_set_int
end

class BULLETIN_C 

inherit

	COMPOSITE_C
		redefine
			widget, stored_node, is_bulletin,
			data, intermediate_name
		end

	
feature 

	symbol: PIXMAP is
		do
			Result := Pixmaps.bulletin_pixmap
		end;

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.set_page.bulletin_type
		end

	create_oui_widget (a_parent: COMPOSITE) is
		local
		do
			!! widget.make_unmanaged (entity_name, a_parent)
			set_size (40, 40)
		end

	widget: EB_BULLETIN_EXT

feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Bulletin")
		end;

	add_to_option_list (opt_list: ARRAY [INTEGER]) is
		do
			opt_list.put (Context_const.geometry_form_nbr,
							Context_const.Geometry_format_nbr);
		end;

feature 

	eiffel_type: STRING is "EB_BULLETIN"

	full_type_name: STRING is "Bulletin"

	intermediate_name: STRING is
			-- full name of the context i.e. with root, group, ...
		local
			bup: BULLETIN_C
		do
			bup ?= parent
			if bup /= Void then
				result := parent.intermediate_name
			else
				Result := parent.full_name
			end
		end;

	is_bulletin: BOOLEAN is
		do
			Result := True
		end

	transform_in_group (a_group: GROUP_C) is
			-- Transform the bulletin and its content in a group instance
			-- (Creation of the group)
		do
			parent.child_start
			parent.search_same_child (Current)
			parent.remove_child
			tree.cut (tree_element)
			context_catalog.clear_editors (Current)
			transformed_in_group :=  True
			group_context :=  a_group
			set_new_parent (a_group)
		end

	transform_in_bulletin is
			-- Undo the transformation from bulletin to group instance
		do
			link_to_parent
			widget.set_managed (True)
			tree.append (tree_element)
			transformed_in_group := False
			set_new_parent (Current)
		end

	group_context: GROUP_C
		-- For the callbacks in the selection manager

	transformed_in_group: BOOLEAN
		-- For the callbacks in the selection manager

	data: CONTEXT is
		do
			if transformed_in_group then
				Result := group_context
			else
				Result := Current
			end
		end

	
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
				child.set_parent(a_parent)
				child_forth
			end
		end

feature -- Storage 

	stored_node: S_BULLETIN is
		do
			!!Result.make (Current)
		end

end

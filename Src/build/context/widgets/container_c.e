indexing
	description: "Container context. Container that can hold children inside it."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONTAINER_C

inherit
	WIDGET_C
		redefine
			gui_object,
			add_pnd_callbacks,
			remove_pnd_callbacks,
			is_container
		end

	HOLDER_C
		redefine
			gui_object,
			is_container
		end

feature {NONE} -- Pick and drop

	add_pnd_callbacks is
		local
			rcmd: EV_ROUTINE_COMMAND
		do
			create rcmd.make (~process_type)
			gui_object.add_pnd_command (Pnd_types.widget_type, rcmd, Void)
			tree_element.add_pnd_command (Pnd_types.widget_type, rcmd, Void)
--			create rcmd.make (~process_context)
--			gui_object.add_pnd_command (Pnd_types.context_type, rcmd, Void)
		end

	remove_pnd_callbacks is
		do
			gui_object.remove_pnd_commands (Pnd_types.widget_type)
			tree_element.remove_pnd_commands (Pnd_types.widget_type)
--			gui_object.remove_pnd_commands (Pnd_types.context_type)
		end

feature -- Status report

	is_container: BOOLEAN is
		do
			Result := True
		end

	accept_child: BOOLEAN is
		do
			Result := gui_object.accept_child
		end

feature -- Basic operations

--	transform_in_group (a_group: GROUP_C) is
--			-- Transform the bulletin and its content in a group instance
--			-- (Creation of the group)
--		do
--			parent.child_start
--			parent.search_same_child (Current)
--			parent.remove_child
--			tree_element.destroy
--			context_catalog.clear_editors (Current)
--			transformed_in_group := True
--			group_context :=  a_group
--			set_new_parent (a_group)
--		end

	transform_in_bulletin is
			-- Undo the transformation from bulletin to group instance
		do
			link_to_parent
			gui_object.show
			create tree_element.make (Current)
			transformed_in_group := False
			set_new_parent (Current)
		end

--	group_context: GROUP_C
--		-- For the callbacks in the selection manager

	transformed_in_group: BOOLEAN
		-- For the callbacks in the selection manager

--	data: CONTEXT is
--		do
--			if transformed_in_group then
--				Result := group_context
--			else
--				Result := Current
--			end
--		end

feature -- Implementation

	set_new_parent (a_parent: CONTEXT) is
			-- Change the parent of all the children
			-- (used for the transformation bulletin <-> group)
		do
			from
				child_start
			until
				child_offright
			loop
				child.set_parent (a_parent)
				child_forth
			end
		end

	gui_object: EV_CONTAINER

end -- class CONTAINER_C


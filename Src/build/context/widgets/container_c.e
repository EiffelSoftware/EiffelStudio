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
			initialize_transport,
			is_container
		end

	HOLDER_C
		redefine
			gui_object,
			is_container
		end

feature {NONE} -- Pick and drop

	initialize_transport is
		local
			routine_cmd: EV_ROUTINE_COMMAND
		do
			{WIDGET_C} Precursor
--			create routine_cmd.make (~process_type)
--			gui_object.add_pnd_command (Pnd_types.type_data_type, routine_cmd, Void)
			create routine_cmd.make (~process_context)
			gui_object.add_pnd_command (Pnd_types.context_type, routine_cmd, Void)
		end

feature {CONTAINER_C} -- Pick and drop target

-- 	process_type (arg: EV_ARGUMENT; data: CONTEXT_TYPE) is --dropped: TYPE_STONE) is
-- 		local
-- 			context_stone: CONTEXT_STONE
-- --			a_type: CONTEXT_TYPE
-- --			group_stone: GROUP_ICON_STONE
-- 			a_context: CONTEXT
-- --			type_stone: TYPE_STONE
-- 		do
-- 			if not is_in_a_group and then not is_a_group then
-- --				type_stone ?= dropped
-- --				group_stone ?= type_stone
-- --				if group_stone /= Void then
-- --					type_stone := group_stone.data
-- --				end
-- --				a_type := type_stone.data.type
-- 				if data /= Void then
-- 					if data /= context_catalog.perm_wind_type then
-- 						if data = context_catalog.temp_wind_type
-- 						and type = context_catalog.perm_wind_type
-- 						then
-- 							a_context := data.create_context (Current)
-- 						elseif data /= context_catalog.temp_wind_type
-- 						and then data.is_valid_parent (Current)
-- 						then
-- 							a_context := data.create_context (Current)
-- 						end
-- 					end
-- 					process_created_context (a_context)
-- 				end
-- 			end
-- 		end

feature -- Status report

	is_container: BOOLEAN is
		do
			Result := True
		end

feature -- Basic operations
 
	transform_in_group (a_group: GROUP_C) is
			-- Transform the bulletin and its content in a group instance
			-- (Creation of the group)
		do
			parent.child_start
			parent.search_same_child (Current)
			parent.remove_child
			tree_element.destroy
			context_catalog.clear_editors (Current)
			transformed_in_group := True
			group_context :=  a_group
			set_new_parent (a_group)
		end

	transform_in_bulletin is
			-- Undo the transformation from bulletin to group instance
		do
			link_to_parent
			gui_object.show
			create tree_element.make (Current)
			transformed_in_group := False
			set_new_parent (Current)
		end

	group_context: GROUP_C
		-- For the callbacks in the selection manager

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


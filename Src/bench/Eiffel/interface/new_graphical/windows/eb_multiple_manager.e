indexing
	description: "Objects that can manage several tools"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_MULTIPLE_MANAGER

inherit
	EB_TOOL_MANAGER

feature -- Initialization

	init_list is
		do
			create list.make
		end

feature -- Implementation

	default_tree: BINARY_TREE [STRING] is
			-- Default tree.
		obsolete
			"Used before a specific parser is made"
		local
			bt1, bt2, bt3: BINARY_TREE [STRING]
		do
			create Result.make ("horizontal")

			create bt1.make ("select")
			Result.put_left_child (bt1)
			create bt1.make ("vertical")
			Result.put_right_child (bt1)

			create bt2.make ("feature")
			bt1.put_right_child (bt2)
			create bt2.make ("horizontal")
			bt1.put_left_child (bt2)

			create bt3.make ("debug")
			bt2.put_left_child (bt3)
			create bt3.make ("object")
			bt2.put_right_child (bt3)
		end

	build_from_tree (par: EV_CONTAINER; tree: BINARY_TREE [STRING]) is
			-- Create tool layout according with `tree' specifications, in `par'.
			-- Principal item store stored in `last_item_made'
		local
			spa: EV_SPLIT_AREA
		do
			if tree.is_leaf then
				add_new_tool (par, tree.item)
			else
				spa := add_split_area (par, tree.item)
				build_brothers (spa, tree)
				create {EB_MULTIPLE_MANAGER_BASIC_ITEM} last_item_made.make (spa)
			end
		end


	build_brothers (par: EV_CONTAINER; tree: BINARY_TREE [STRING]) is
		local
			left_item, right_item: EB_MULTIPLE_MANAGER_ITEM
			ti: EB_MULTIPLE_MANAGER_TOOL_ITEM
		do
			build_from_tree (par, tree.left_child)
			left_item := last_item_made
			build_from_tree (par, tree.right_child)
			right_item := last_item_made

			ti ?= left_item
			if ti /= Void then
				ti.set_brother (right_item.container)
			end
			ti ?= right_item
			if ti /= void then
				ti.set_brother (left_item.container)
			end
		end

	last_item_made: EB_MULTIPLE_MANAGER_ITEM

feature -- Access

	list: LINKED_LIST [EB_MULTIPLE_MANAGER_TOOL_ITEM]
			-- tools under management

	tool_parent (t: EB_TOOL): EV_CONTAINER is
			-- parent of `t'
		local
			ti: EB_MULTIPLE_MANAGER_TOOL_ITEM
		do
			ti := tool_item (t)
			Result := ti.parent
		end

	tool_item (t: EB_TOOL): EB_MULTIPLE_MANAGER_TOOL_ITEM is
		do
			from
				list.start
			until
				list.after or else Result /= Void
			loop
				if list.item.tool = t then
					Result := list.item
				end
				list.forth
			end
		end

feature {EB_TOOL} -- Tool management

	-- the call with `t' is mandatory because these features
	-- may be called during `tool''s creation, before we can
	-- use the `tool' attribute.

	destroy_tool (t: EB_TOOL) is
			-- destroy associated tool.
			-- supress split area if necessary
		local
			ti: EB_MULTIPLE_MANAGER_TOOL_ITEM
		do
			ti := tool_item (t)
			if ti /= Void then
				t.destroy_imp
				if ti.brother /= Void then
					ti.parent.hide
					ti.brother.set_parent (ti.parent.parent)
					ti.brother.show
					ti.parent.destroy
				end
			end
		end

	show_tool (t: EB_TOOL) is
			-- shows the tool.
		do
			t.show_imp
		end

	raise_tool (t: EB_TOOL) is
			-- shows the tool in the foreground.
			-- not implemented yet; does the same as `show_tool'
		do
			t.show_imp
--			set_focus
		end

	hide_tool (t: EB_TOOL) is
			-- hides `t'.
		do
			t.hide_imp
		end

feature -- Resize

	set_tool_size (t: EB_TOOL; new_width, new_height: INTEGER) is
		do
--			set_size (new_width, new_height)
		end

	set_tool_width (t: EB_TOOL; new_width: INTEGER) is
		do
--			set_width (new_width)
		end

	set_tool_height (t: EB_TOOL; new_height: INTEGER) is
		do
--			set_height (new_height)
		end

feature -- Tool status report

	tool_title (t: EB_TOOL): STRING is
		local
			ti: EB_MULTIPLE_MANAGER_TOOL_ITEM
		do
			ti := tool_item (t)
			if ti /= Void then
				Result := ti.title
			end
		end

	tool_icon_name (t: EB_TOOL): STRING is
		local
			ti: EB_MULTIPLE_MANAGER_TOOL_ITEM
		do
			ti := tool_item (t)
			if ti /= Void then
				Result := ti.icon_name
			end
		end

feature -- Tool status setting

	set_tool_title (t: EB_TOOL; s: STRING) is
		local
			ti: EB_MULTIPLE_MANAGER_TOOL_ITEM
		do
			ti := tool_item (t)
			if ti /= Void then
				ti.set_title (s)
			end
		end

	set_tool_icon_name (t: EB_TOOL; s: STRING) is
		local
			ti: EB_MULTIPLE_MANAGER_TOOL_ITEM
		do
			ti := tool_item (t)
			if ti /= Void then
--				set_icon_name (s)
--| FIXME
--| Christophe, 28 oct 1999
--| `set_icon_name' not impemented yet
			end
		end

feature {NONE} -- Implementation

	add_split_area (par: EV_CONTAINER; s: STRING): EV_SPLIT_AREA is
			-- New split area according to `s' specifications, with parent `par'
		do
			if s.is_equal ("vertical") then
				create {EV_VERTICAL_SPLIT_AREA} Result.make (par)
			elseif s.is_equal ("horizontal") then
				create {EV_HORIZONTAL_SPLIT_AREA} Result.make (par)
			else
				check
					only_two_values: False
				end
			end
		end

	add_new_tool (par: EV_CONTAINER; s: STRING) is
			-- Build a tool according to specifications made in `s',
			-- with parent `par'. Set last_item_made.
		local
			tool: EB_TOOL
			ti :EB_MULTIPLE_MANAGER_TOOL_ITEM
		do
			create ti
			list.extend (ti)
			ti.set_parent (par)
			
			if s.is_equal ("class") then
				create {EB_CLASS_TOOL} tool.make (Current)
			elseif s.is_equal ("debug") then
--				create {EB_DEBUG_TOOL} tool.make (Current)
				init_debug_tool
				tool := debug_tool
			elseif s.is_equal ("dynamic_lib") then
				create {EB_DYNAMIC_LIB_TOOL} tool.make (Current)
--			elseif s.is_equal ("explain") then
--				create {EB_EXPLAIN_TOOL} tool.make (Current)
			elseif s.is_equal ("feature") then
				create {EB_FEATURE_TOOL} tool.make (Current)
			elseif s.is_equal ("object") then
				create {EB_OBJECT_TOOL} tool.make (Current)
--			elseif s.is_equal ("preference") then
--				create {EB_PREFERENCE_TOOL} tool.make (Current)
			elseif s.is_equal ("profile") then
				create {EB_PROFILE_TOOL} tool.make (Current)
			elseif s.is_equal ("project") then
				create {EB_PROJECT_TOOL} tool.make (Current)
			elseif s.is_equal ("select") then
--				create {EB_SELECT_TOOL} tool.make (Current)
				init_select_tool
				tool := select_tool
			elseif s.is_equal ("system") then
				create {EB_SYSTEM_TOOL} tool.make (Current)
			else
				check
					hara_kiri: False
				end
			end
			ti.set_tool (tool)
			tool.build_interface
			last_item_made := ti
		end

	init_debug_tool is
			-- build a debug tool
		deferred
		end

	debug_tool: EB_DEBUG_TOOL is
		deferred
		end
			-- shared debug tool

	init_select_tool is
			-- build a select tool
		deferred
		end

	select_tool: EB_SELECT_TOOL is
		deferred
		end
			-- shared debug tool

	container: EV_CONTAINER is
			-- Widget where tools are displayed
		deferred
		end

end -- class EB_MULTIPLE_MANAGER

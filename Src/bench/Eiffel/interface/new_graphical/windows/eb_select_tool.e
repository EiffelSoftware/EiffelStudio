indexing
	description:
		"Selector for the class, feature and object tools."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SELECT_TOOL

inherit
	EB_TOOL
		redefine
			make
		end

	EV_COMMAND

--	HOLE 
--		redefine
--			compatible, process_class, process_classi, process_feature
--		end

--	WINDOW_ATTRIBUTES
	SHARED_EIFFEL_PROJECT
	NEW_EB_CONSTANTS

creation
	make

feature --Initialization
	
	make (man: EB_TOOL_MANAGER) is
		do
			precursor (man)
--			set_widget_attributes (Current)
		end

--	init_toggle (toggle: EV_TOGGLE_BUTTON) is
--			-- Init arm action.
--		do
--			toggle.add_click_command (Current, Void)
--			associated_toggle:=toggle
--			if Project_resources.selector_window.actual_value then
--				show_selector
--			else
--				hide_selector
--			end
--		end

	build_interface is
		do
			create container.make (parent)

			create list.make (container)
 			list.add_selection_command (Current, Void)
		end

feature -- Access

	empty_tool_name: STRING is "Selector"

feature -- Redefine

	stone_type:INTEGER is  
			-- A selector window does not have a correspondant stone.
		do
		end

--	target: EV_WIDGET is
--		do
--			Result := Current
--		end

	compatible(dropped: STONE): BOOLEAN is
		do
			Result := True
		end

	
feature -- Hole processing

	process_classi (a_stone: CLASSI_STONE) is
			-- Process dropped stone `a_stone'.
		local
--			new_tool: EB_CLASS_TOOL
		do
--			new_tool := tool_supervisor.new_class_tool
--			new_tool.raise
--			new_tool.process_classi (a_stone)
		end
 
	process_class (a_stone: CLASSC_STONE) is
			-- Process dropped stone `a_stone'.
		local
--			new_tool: EB_CLASS_TOOL
		do
--			new_tool := tool_supervisor.new_class_tool
--			new_tool.raise
--			new_tool.process_class (a_stone)
		end
 
	process_feature (a_stone: FEATURE_STONE) is
			-- Process dropped stone `a_stone'.
		local
--			new_tool: EB_FEATURE_TOOL
		do
--			new_tool := tool_supervisor.new_feature_tool
--			new_tool.raise
--			new_tool.process_feature (a_stone)
		end

feature -- Access

	container: EV_VERTICAL_BOX

	list: EV_LIST

	associated_toggle: EV_TOGGLE_BUTTON
			-- associated toggle button with toolbar

--	item: EB_SELECTOR_ITEM is
--		do
--			Result ?= list.item
--		end

feature -- User interface

--	show_selector is
--		do
--			manage
--			associated_toggle.set_toggle_on
--			selector_parent.manage
--		end

--	hide_selector is
--		do
--			unmanage
--			associated_toggle.set_toggle_off
--			selector_parent.unmanage
--		end

	add_tool_entry (tool: EB_TOOL) is
		local
			tmp: EB_SELECTOR_ITEM
		do
			create tmp.make_default (list, tool)
		end

	change_tool_entry (tool: EB_TOOL) is
		local
			tmp: EB_SELECTOR_ITEM
--			t_name:STRING
		do
--			t_name := clone (tool.icon_name)
			tmp ?= list.find_item_by_data (tool)

-- FIXME JOC: still need to decide what to do.
--    			if t_name /= Void and then is_tool_opened (t_name,tool)
--   			then
--				tmp.set_read_only
--  			end

			if tmp /= Void then 
				tmp.update
			end
		end

	remove_tool_entry (tool: EB_TOOL) is
		local
			li: EV_LIST_ITEM
		do
			li := list.find_item_by_data (tool)
			if li /= Void then
				li.destroy
			end
		end

feature -- Basic operations

	is_tool_opened (tool_name: STRING; tool: EB_TOOL) : BOOLEAN is
		obsolete
			"use find_item_by_data instead"
		local
--			tmp: STRING
		do
--			Result := False
--			from
--				start
--			until
--				after or Result
--			loop
--				if item.tool /= tool then
--					tmp := clone (item.value)
--					tmp.to_upper
--					if tmp /= Void and then tmp.is_equal (tool_name) then
--						Result := True
--					end
--				end
--				forth	
--			end
		end

	execute (argument: EV_ARGUMENT1 [STRING]; data: EV_EVENT_DATA) is
			-- Execute Current command.
			-- `argument' is automatically passed by
			-- EiffelVision when Current command is
			-- invoked as a callback.
		local
--			arg_string: STRING
			local_tool: EB_TOOL
			selection: EB_SELECTOR_ITEM
		do
--			arg_string := argument.first
--			if arg_string /= Void and then arg_string.is_equal ("selector_command") then
				selection ?= list.selected_item
				if selection /= Void then
					local_tool ?= selection.tool
					if local_tool /= Void and then not local_tool.destroyed then
						local_tool.raise
					end
				end
--			else
--				if associated_toggle.selected then
--					show_selector
--				else
--					hide_selector
--				end
--			end
		end

end -- class EB_SELECT_TOOL

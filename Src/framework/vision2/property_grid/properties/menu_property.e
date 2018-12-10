note
	description: "Property that allows user to choose from a menu"
	date: "$Date$"
	revision: "$Revision$"

class
	MENU_PROPERTY [G -> detachable ANY]

inherit
	ELLIPSIS_PROPERTY [G]
		redefine
			initialize
		end

create
	make,
	make_with_menu

feature{NONE} -- Initialization

	make_with_menu (a_name: like name; a_menu: like menu)
			-- Initialize `menu' with `a_menu'.
		require
			a_name_ok: a_name /= Void
		do
			make (a_name)
			set_menu (a_menu)
		end

	initialize
			-- Initialize.
		do
			Precursor
			ellipsis_actions.extend (agent show_menu)
		end

feature -- Access

	menu: detachable EV_MENU
			-- Menu to be displayed

	menu_position_function: detachable FUNCTION [TUPLE [a_menu: like menu; a_property: like Current], EV_RECTANGLE]
			-- Function to retrieve position (related to top-left corner of `a_property') at which `menu' will be displayed.
			-- Argument `a_menu' passed to function is the menu to be displayed.
			-- Argument `a_property' is Current property
			-- If this function is Void, `menu' will be displayed at pointer position.

	value_retriever: detachable FUNCTION [TUPLE [a_menu_item: EV_MENU_ITEM], G]
			-- Function to retrieve value from a selected menu item

	value_converter: detachable FUNCTION [TUPLE [a_displayed_value: like displayed_value], like value]
			-- Function to convert displayed value to value

feature -- Status report

	auto_set_data: BOOLEAN
			-- Should `data' be set automatically when a menu item is selected?
			-- If True and if `value_retriever' is not Void, `data' will be set with the value
			-- got from `value_retriever' with the selected menu item as the only argument.
			-- Default: False

feature -- Setting

	set_menu (a_menu: like menu)
			-- Set `menu' with `a_menu'.
		do
			if menu /= Void then
				detach_agents
			end
			menu := a_menu
		ensure
			menu_set: menu = a_menu
		end

	set_menu_position_function (a_function: like menu_position_function)
			-- Set `menu_position_function' with `a_function'.
		do
			menu_position_function := a_function
		ensure
			menu_position_function_set: menu_position_function = a_function
		end

	set_value_retriever (a_function: like value_retriever)
			-- Set `value_retriever' with `a_function'.
		do
			value_retriever := a_function
		ensure
			data_retriever_set: value_retriever = a_function
		end

	set_value_converter (a_function: like value_converter)
			-- Set `value_converter' with `a_function'.
		do
			value_converter := a_function
		ensure
			data_converter_set: value_converter = a_function
		end

	enable_auto_set_data
			-- Enable `auto_set_data'.
		do
			auto_set_data := True
		ensure
			auto_set_data_set: auto_set_data
		end

	disable_auto_set_data
			-- Disable `auto_set_data'.
		do
			detach_agents
			auto_set_data := False
		ensure
			auto_set_data_set: not auto_set_data
		end

feature {NONE} -- Implementation

	convert_to_data (a_string: like displayed_value): like value
			-- Convert displayed data into data.
		do
			if attached value_converter as l_converter then
				Result := l_converter.item ([a_string])
			end
		end

	show_menu
			-- Display `menu'.
		local
			l_pos_func: like menu_position_function
			l_pos: EV_RECTANGLE
		do
			if attached menu as l_menu then
				if auto_set_data then
					attach_agents
				end
				l_pos_func := menu_position_function
				if l_pos_func /= Void and then is_parented then
					l_pos := l_pos_func.item ([menu, Current])
					l_menu.show_at (parent, virtual_x_position + l_pos.x, virtual_y_position + l_pos.y)
				else
					l_menu.show
				end
			end
		end

	attach_agents
			-- Attach agents.
		do
			auto_set_data := True
			recursive_do (
				menu,
				agent (a_menu: EV_MENU)
					do
						if a_menu /= Void and then not a_menu.item_select_actions.has (on_menu_item_selected_agent) then
							a_menu.item_select_actions.extend (on_menu_item_selected_agent)
						end
					end
			)
		end

	detach_agents
			-- Detach agents.
		do
			recursive_do (
				menu,
				agent (a_menu: EV_MENU)
					do
						if a_menu /= Void and then a_menu.item_select_actions.has (on_menu_item_selected_agent) then
							a_menu.item_select_actions.prune_all (on_menu_item_selected_agent)
						end
					end
			)
		end

	recursive_do (a_menu: like menu; a_proc: PROCEDURE [TUPLE [a_menu: EV_MENU]])
			-- Recursive apply `a_proc' to every menu from `a_menu'.
		require
			a_proc_attached: a_proc /= Void
		do
			if a_menu /= Void then
				from
					a_menu.start
				until
					a_menu.after
				loop
					if attached {EV_MENU} a_menu.item as l_menu then
						recursive_do (l_menu, a_proc)
					else
						a_proc.call ([a_menu])
					end
					a_menu.forth
				end
			end
		end

feature{NONE} -- Actions

	on_menu_item_selected (a_item: EV_MENU_ITEM)
			-- Action to be performed when `a_item' from `menu' is selected
		require
			a_item_attached: a_item /= Void
		do
			if attached value_retriever as l_retriever then
				set_value (l_retriever.item ([a_item]))
			end
		end

	on_menu_item_selected_agent: PROCEDURE [EV_MENU_ITEM]
			-- Agent of `on_menu_item_selected'
		do
			if attached on_menu_item_selected_agent_internal as l_agent then
				Result := l_agent
			else
				Result := agent on_menu_item_selected
				on_menu_item_selected_agent_internal := Result
			end
		ensure
			result_attached: Result /= Void
		end

	on_menu_item_selected_agent_internal: detachable like on_menu_item_selected_agent
			-- Implementation of `on_menu_item_selected_agent'

;note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

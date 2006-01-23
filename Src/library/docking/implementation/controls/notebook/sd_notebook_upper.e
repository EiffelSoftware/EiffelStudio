 indexing
	description: "A notebook show mini tool bar and tabs at top."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	appearance:
		"[
			  _______  _______  _______                        _
			_/ tab_1 \/_tab_2_\/_tab_3_\______________________|X|
			|                              						|
			|         selected_item          					|
			|                                					|
			----------------------------------------------------
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_UPPER

inherit
	SD_NOTEBOOK
		redefine
			make,
			set_tab_position,
			extend,
			on_resize
		end
create
	make

feature {NONE} -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		do
			Precursor {SD_NOTEBOOK}	(a_docking_manager)

			create internal_top_box
			prune_vertical_box (internal_border_for_tab_area)
			start
			put_left (internal_border_for_tab_area)
			internal_border_for_tab_area.set_border_style ({SD_DOCKING_MANAGER}.dock_bottom)
			internal_border_for_tab_area.wipe_out
			internal_border_for_tab_area.extend (internal_top_box)
			internal_top_box.extend (internal_tab_box)
			internal_tab_box.set_gap (True)

			create custom_area
			internal_top_box.extend (custom_area)
			internal_top_box.disable_item_expand (custom_area)

			create internal_tool_bar
			create internal_normal_max_button
			internal_normal_max_button.set_pixmap (internal_shared.icons.maximize)
			create internal_close_button
			internal_close_button.set_pixmap (internal_shared.icons.close)
			internal_tool_bar.extend (internal_normal_max_button)
			internal_tool_bar.extend (internal_close_button)

--			internal_tool_bar.set_background_color (internal_shared.non_focused_color_lightness)
--			internal_tool_bar.set_background_color ((create {EV_STOCK_COLORS}).red)

			internal_top_box.extend (internal_tool_bar)
			internal_top_box.disable_item_expand (internal_tool_bar)

			init_action
		end

	init_action is
			-- Initialize actions.
		do
			create close_request_actions
			create normal_max_actions
			internal_normal_max_button.select_actions.extend (agent on_normal_max_window)
			internal_close_button.select_actions.extend (agent on_close_request)
		end

feature -- Query

	custom_area: EV_CELL
			-- Custom area which allow client programmer extend.

	close_request_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Close request actions.

	normal_max_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Normal\max actions.

	is_maximized: BOOLEAN
			-- If current is maximized?

feature -- Command

	set_mini_tool_bar (a_widget: EV_WIDGET) is
			-- Set `custom_area' widget.
		require
			a_widget_not_void: a_widget /= Void
		do
			custom_area.wipe_out
			custom_area.extend (a_widget)
		end

	set_tab_position (a_position: INTEGER) is
			-- Redefine
		do
			start
			search (internal_border_for_tab_area)
			inspect
				a_position
			when tab_top then
				if index /= 1 then
					swap (1)
--					disable_item_expand (internal_top_box)
				end
			when tab_bottom then
				if index /= 2 then
					swap (2)

				end
			end
			disable_item_expand (internal_border_for_tab_area)
		end

	set_show_maximized (a_maximized: BOOLEAN) is
			-- Set `internal_normal_max_button''s pixmap.
		do
			if a_maximized then
				internal_normal_max_button.set_pixmap (internal_shared.icons.normal)
			else
				internal_normal_max_button.set_pixmap (internal_shared.icons.maximize)
			end
			is_maximized := a_maximized
		end

	extend (a_content: SD_CONTENT) is
			-- Redefine.
		local
			l_tab: SD_NOTEBOOK_TAB
		do
			Precursor {SD_NOTEBOOK} (a_content)
			l_tab := internal_tabs.last
			l_tab.pointer_double_press_actions.force_extend (agent on_normal_max_window)
		end

	on_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Redefine.
		do
			internal_tab_box.on_resize (a_x, a_y, a_width - internal_tool_bar.width, a_height)
		end

feature {NONE}  -- Agents

	on_close_request is
			-- Handle close reqest.
		do
			close_request_actions.call ([])
		end

	on_normal_max_window is
			-- Handle normal max window.
		do
			normal_max_actions.call ([])
		end

feature {NONE}  -- Implementation

	internal_top_box: EV_HORIZONTAL_BOX
			-- Box which contain

	internal_button_box: EV_HORIZONTAL_BOX
			-- Box which contain `custom_area' and `internal_tool_bar'

	internal_tool_bar: EV_TOOL_BAR
			-- Tool bar has `internal_normal_max_button', `internal_close_button'.

	internal_normal_max_button: EV_TOOL_BAR_BUTTON
			-- Normal\max button

	internal_close_button: EV_TOOL_BAR_BUTTON
			-- Close button

invariant

	internal_tool_bar_not_void: internal_tool_bar /= Void
	internal_normal_max_button_not_void: internal_normal_max_button /= Void
	internal_clsoe_button_not_void: internal_close_button /= Void

	custom_area_not_void: custom_area /= Void
	internal_top_box_not_void: internal_top_box /= Void

	close_request_actions_not_void: close_request_actions /= Void
	normal_max_actions_not_void: normal_max_actions /= Void
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end

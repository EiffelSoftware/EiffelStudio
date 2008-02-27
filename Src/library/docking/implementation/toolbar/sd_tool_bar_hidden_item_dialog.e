indexing
	description: "Dialog to show hidden tool bar items."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_HIDDEN_ITEM_DIALOG

inherit
	EV_POPUP_WINDOW
		export
			{NONE}	all
			{ANY} show
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		undefine
			default_create, copy
		end

	SD_ACCESS
		undefine
			default_create,
			is_equal,
			copy
		end
		
create
	make,
	make_for_menu

feature {NONE}  -- Initlization

	make (a_hidden_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]; a_tool_bar: SD_TOOL_BAR_ZONE) is
			-- Creation method.
		require
			not_void: a_hidden_items /= Void
			not_void: a_tool_bar /= Void
		do
			parent_tool_bar := a_tool_bar
			make_with_shadow
			disable_user_resize
			disable_border
			create internal_vertical_box
			create internal_shared
			internal_vertical_box.set_border_width (internal_shared.border_width)
			internal_vertical_box.set_background_color (internal_shared.border_color)

			extend (internal_vertical_box)

			init_grouping (a_hidden_items)
			init_hidden_items (a_hidden_items)
			init_customize_label
			init_close
			internal_tool_bar.compute_minimum_size

			-- If we don't call this, the height will be 2 pixels less on Windows.
			set_height (item.minimum_height)
		ensure
			set: parent_tool_bar = a_tool_bar
		end

	make_for_menu (a_tool_bar: SD_TOOL_BAR_ZONE) is
			-- Creation method for right-click menu.
		require
			not_void: a_tool_bar /= Void
		local
			l_list: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			create l_list.make (1)
			make (l_list, a_tool_bar)
		end

	init_grouping (a_hidden_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]) is
			-- Grouping hidden items.
		local
			l_divider: SD_TOOL_BAR_HIDDEN_GROUP_DIVIDER
		do
			if a_hidden_items.count > 0 then
				create l_divider.make (a_hidden_items)
				l_divider.set_max_width_allowed ({SD_SHARED}.Tool_bar_hidden_item_dialog_max_width)
				l_divider.grouped_items
			end
		end

	init_hidden_items (a_hidden_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]) is
			-- Add hidden items to Current.
		local
			l_separator: SD_TOOL_BAR_SEPARATOR
			l_widget_item: SD_TOOL_BAR_WIDGET_ITEM
		do
			create internal_horizontal_box
			internal_vertical_box.extend (internal_horizontal_box)

			from
				a_hidden_items.start
				create internal_tool_bar.make (create {SD_TOOL_BAR}.make)
				internal_horizontal_box.extend (internal_tool_bar)
			until
				a_hidden_items.after
			loop
				l_separator ?= a_hidden_items.item
				l_widget_item ?= a_hidden_items.item
				if l_separator = Void then
					if l_widget_item /= Void and then l_widget_item.widget /= Void and then l_widget_item.widget.parent /= Void then
						l_widget_item.widget.parent.prune (l_widget_item.widget)
					end
					internal_tool_bar.extend (a_hidden_items.item)
				end
				a_hidden_items.forth
			end
		end

	init_customize_label is
			-- Add customize label.
		local
			l_separator: SD_TOOL_BAR_SEPARATOR
			l_button: SD_TOOL_BAR_BUTTON
		do
			if internal_tool_bar.items.count > 0 then
				create l_separator.make
				l_separator.set_wrap (True)
				internal_tool_bar.extend (l_separator)
			end

			create l_button.make
			l_button.set_text (internal_shared.interface_names.customize)
			l_button.select_actions.extend (agent on_customize)
			internal_tool_bar.extend (l_button)
		end

	init_close is
			-- Initialization close events.
		do
			focus_out_actions.extend (agent on_focus_out)
		end

feature {SD_TOOL_BAR_MANAGER} -- Command

	on_customize is
			-- Handle customize actions.
		local
			l_dialog: SD_TOOL_BAR_CUSTOMIZE_DIALOG
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_parent_window: EV_WINDOW
			l_vertical_docking: BOOLEAN
			l_docking_manager: SD_DOCKING_MANAGER
			l_assit: SD_TOOL_BAR_ZONE_ASSISTANT
		do
			if parent_tool_bar.customize_dialog /= Void and then not parent_tool_bar.customize_dialog.is_destroyed then
				parent_tool_bar.customize_dialog.set_focus
			else
				create l_dialog.make
				parent_tool_bar.set_customize_dialog (l_dialog)

				l_items := parent_tool_bar.content.items

				prepare_size (l_dialog, parent_tool_bar.assistant.last_state)

				if parent_tool_bar.is_floating then
					l_parent_window := parent_tool_bar.floating_tool_bar
				else
					l_parent_window := parent_tool_bar.docking_manager.main_window
				end
				l_dialog.customize_toolbar (l_parent_window, True, True, l_items)
				parent_tool_bar.set_customize_dialog (Void)
				parent_tool_bar.assistant.last_state.set_cutomize_dialog_size (l_dialog.w_width, l_dialog.w_height)
				if l_dialog.valid_data then
					l_assit := parent_tool_bar.assistant
					l_assit.save_items_layout (l_dialog.final_toolbar)

					l_vertical_docking := parent_tool_bar.content.is_docking and then parent_tool_bar.is_vertical
					if l_vertical_docking then
						l_docking_manager := parent_tool_bar.docking_manager
						l_docking_manager.command.lock_update (Void, True)
					end

					l_assit.open_items_layout

					if not parent_tool_bar.is_floating then
						parent_tool_bar.extend_one_item (parent_tool_bar.tail_indicator)
					end
					if l_vertical_docking then
						parent_tool_bar.change_direction (False)
						l_docking_manager.command.resize (True)
						l_docking_manager.command.unlock_update
					end

					parent_tool_bar.compute_minmum_size
				end
			end
		end

feature {NONE} -- Implementation

	prepare_size (a_dialog: EV_DIALOG; a_state: SD_TOOL_BAR_ZONE_STATE) is
			-- Try to use last customize dialog width and height.
		require
			not_void: a_dialog /= Void
			not_void: a_state /= Void
		local
			l_width, l_height: INTEGER
		do
			l_width := a_state.customize_dialog_width
			if l_width <= 0 then
				l_width := internal_shared.Tool_bar_customize_dialog_default_width
			end
			l_height := a_state.customize_dialog_height
			if l_height <= 0 then
				l_height := internal_shared.Tool_bar_customize_dialog_default_height
			end
			a_dialog.set_size (l_width, l_height)
		end

	save_items_layout (a_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]) is
			-- Save `a_tool_bar' items layout to it's data.
		require
			not_void: a_items /= Void
		local
			l_data: ARRAYED_LIST [TUPLE [STRING_GENERAL, BOOLEAN]]
		do
			from
				create l_data.make (a_items.count)
				a_items.start
			until
				a_items.after
			loop
				l_data.extend ([a_items.item.name, a_items.item.is_displayed])
				a_items.forth
			end
			parent_tool_bar.assistant.last_state.set_items_layout (l_data)
		ensure
			saved: parent_tool_bar.assistant.last_state.items_layout /= Void
		end

	parent_tool_bar: SD_TOOL_BAR_ZONE
			-- Tool bar which Current belong to.

	internal_tool_bar: SD_WIDGET_TOOL_BAR
			-- Tool bar contain all hidden items and "Customize" label.

	on_focus_out is
			-- Handle focus out actions.
		do
			if is_displayed then
				-- FIXIT: can't destroy directly?
--				destroy
				ev_application.do_once_on_idle (agent destroy)
				parent_tool_bar.docking_manager.command.resize (True)
			end
		end

	internal_vertical_box: EV_VERTICAL_BOX
			-- Top level vertical box.

	internal_horizontal_box: EV_HORIZONTAL_BOX
			-- Box which in `internal_vertical_box'.

	internal_label: EV_LABEL
			-- Label which show "Customize".

	internal_shared: SD_SHARED
			-- All singletons.

invariant
	parent_tool_bar_not_void: parent_tool_bar /= Void

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
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

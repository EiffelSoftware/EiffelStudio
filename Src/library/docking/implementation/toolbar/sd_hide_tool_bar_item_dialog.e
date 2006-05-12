indexing
	description: "Dialog to show hidden tool bar items."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_HIDDEN_ITEM_DIALOG

inherit
	EV_UNTITLED_DIALOG
		export
			{NONE}	all
			{ANY} show_relative_to_window
		end

create
	make

feature {NONE}  -- Initlization

	make (a_hidden_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]; a_tool_bar: SD_TOOL_BAR_ZONE) is
			-- Creation method.
		require
			not_void: a_hidden_items /= Void
			not_void: a_tool_bar /= Void
		do
			default_create
			create internal_vertical_box
			extend (internal_vertical_box)

			init_grouping (a_hidden_items)
			init_hidden_items (a_hidden_items)
			init_customize_label
			init_close
			internal_tool_bar.compute_minmum_size

			parent_tool_bar := a_tool_bar
		ensure
			set: parent_tool_bar = a_tool_bar
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
		do
			create internal_horizontal_box
			internal_vertical_box.extend (internal_horizontal_box)

			from
				a_hidden_items.start
				create internal_tool_bar.make
				internal_horizontal_box.extend (internal_tool_bar)
			until
				a_hidden_items.after
			loop
				l_separator ?= a_hidden_items.item
				if l_separator = Void then
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
			l_button.set_text ("Customize")
			l_button.select_actions.extend (agent on_customize)
			internal_tool_bar.extend (l_button)
		end

	init_close is
			-- Initialization close events.
		do
			focus_out_actions.extend (agent on_focus_out)
		end

feature {NONE} -- Implementation

	on_customize is
			-- Handle customize actions.
		local
			l_dialog: SD_TOOL_BAR_CUSTOMIZE_DIALOG
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			create l_dialog.make
			l_items := parent_tool_bar.content.items
			l_dialog.set_size (300, 300)
			l_dialog.customize_toolbar (parent_tool_bar.docking_manager.main_window, True, True, l_items)

			if l_dialog.valid_data then
				save_items_layout (l_dialog.final_toolbar)

				parent_tool_bar.assistant.open_items_layout

				if not parent_tool_bar.is_floating then
					parent_tool_bar.extend_one_item (parent_tool_bar.tail_indicator)
				end
				save_items_layout (l_dialog.final_toolbar)
				parent_tool_bar.compute_minmum_size
			end
		end

	save_items_layout (a_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]) is
			-- Save `a_tool_bar' items layout to it's data.
		require
			not_void: a_items /= Void
		local
			l_datas: ARRAYED_LIST [TUPLE [STRING, BOOLEAN]]
		do
			from
				create l_datas.make (a_items.count)
				a_items.start
			until
				a_items.after
			loop
				l_datas.extend ([a_items.item.name, a_items.item.is_displayed])
				a_items.forth
			end
			parent_tool_bar.assistant.last_state.set_items_layout (l_datas)
		ensure
			saved: parent_tool_bar.assistant.last_state.items_layout /= Void
		end

	parent_tool_bar: SD_TOOL_BAR_ZONE
			-- Tool bar which Current belong to.

	internal_tool_bar: SD_TOOL_BAR
			-- Tool bar contain all hidden items and "Customize" label.

	on_focus_out is
			-- Handle focus out actions.
		local
			l_env: EV_ENVIRONMENT
		do
			if is_displayed then
				-- FIXIT: can't destroy directly?
--				destroy
				create l_env
				l_env.application.idle_actions.extend_kamikaze (agent destroy)
			end
		end

	internal_vertical_box: EV_VERTICAL_BOX
			-- Top level vertical box.

	internal_horizontal_box: EV_HORIZONTAL_BOX
			-- Box which in `internal_vertical_box'.

	internal_label: EV_LABEL
			-- Label which show "Customize".

invariant
	not_void: parent_tool_bar /= Void

end

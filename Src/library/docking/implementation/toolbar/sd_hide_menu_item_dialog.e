indexing
	description: "Dialog to show hidden menu items."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HIDE_MENU_ITEM_DIALOG

inherit
	EV_UNTITLED_DIALOG
		export
			{NONE}	all
			{ANY} show_relative_to_window
		end

create
	make

feature {NONE}  -- Initlization

	make (a_hidden_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]) is
			-- Creation method.

		do
			default_create
			create internal_vertical_box
			extend (internal_vertical_box)

			init_hidden_items (a_hidden_items)
			init_customize_label
			init_close
		end

	init_hidden_items (a_hidden_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]) is
			-- Add hidden items to Current.
		local
			l_tool_bar: EV_TOOL_BAR
		do
			create internal_horizontal_box
			internal_vertical_box.extend (internal_horizontal_box)

			from
				a_hidden_items.start
			until
				a_hidden_items.after
			loop
				create l_tool_bar
				l_tool_bar.extend (a_hidden_items.item)
				internal_horizontal_box.extend (l_tool_bar)
				a_hidden_items.forth
			end
		end

	init_customize_label is
			-- Add customize label.
		local
			l_separator: EV_HORIZONTAL_SEPARATOR
		do
			create l_separator
			internal_vertical_box.extend (l_separator)
			create internal_label.make_with_text ("Customize...")
			internal_vertical_box.extend (internal_label)
		end

	init_close is
			-- Initialization close events.
		local
			l_env: EV_ENVIRONMENT
		do
			create l_env
			l_env.application.pointer_button_press_actions.force (agent on_any_pointer_press)
		end

feature {NONE} -- Implementation

	on_any_pointer_press (a_widget: EV_WIDGET; a_button, a_screen_x, a_screen_y: INTEGER) is
			-- Handle pointer press anctions.
		do
			destroy
		end

	internal_vertical_box: EV_VERTICAL_BOX
			-- Top level vertical box.

	internal_horizontal_box: EV_HORIZONTAL_BOX
			-- Box which in `internal_vertical_box'.

	internal_label: EV_LABEL
			-- Label which show "Customize".

end

indexing
	description: "Command linked with a menu and a radio tool bar button."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_RADIO_COMMAND_FEEDBACK

inherit
	EB_COMMAND_FEEDBACK
		redefine
			button,
			menu_item
		end

feature -- Status setting

	enable_select is
			-- Set both `button' and `menu_entry'
			-- to be selected.
		do
			if button /= Void then
				button.select_actions.block
				button.enable_select
				button.select_actions.resume
			end
			if menu_item /= Void then
				menu_item.select_actions.block
				menu_item.enable_select
				menu_item.select_actions.resume
			end
			if
				combo /= Void and then
				(combo.text.is_empty or else
				not combo.text.is_equal(capital_command_name))
			then
				combo.change_actions.block
				combo.set_text (capital_command_name)
				combo.change_actions.resume
			end
		ensure
			button_selected: not safety_flag and button /= Void implies button.is_selected
			menu_selected: not safety_flag and menu_item /= Void implies menu_item.is_selected
			combo_updated: not safety_flag and combo /= Void implies combo.text.is_equal (capital_command_name)
		end

feature -- Interface

	command_name: STRING is
			-- Name of current command throughout the interface (in lower case).
		deferred
		ensure
			valid_result: valid_string (Result)
			lower_case: is_lower_case (Result)
		end

	capital_command_name: STRING
			-- Name of current command throughout the interface (in lower case, but the first letter).

	menu_name: STRING is
			-- String representation in the associated menu.
		deferred
		ensure
			valid_result: Result /= Void
		end

feature -- Status setting

	set_combo_box (a_combo: EV_COMBO_BOX) is
			-- Set `combo' to `a_combo'.
		do
			combo := a_combo
		end

feature -- Access

	button: EV_TOOL_BAR_RADIO_BUTTON
			-- Button on the toolbar.

	menu_item: EV_RADIO_MENU_ITEM
			-- Menu entry in the menu.

	combo: EV_COMBO_BOX
			-- Combo box giving a choice between several radio commands.

	selected: BOOLEAN is
			-- Is current command selected?
		do
			if button /= Void then
				Result := button.is_selected
			elseif menu_item /= Void then
				Result := menu_item.is_selected
			elseif combo /= Void then
				Result := combo.text.is_equal (capital_command_name)
			end
		end

feature -- Implementation

	valid_string (str: STRING): BOOLEAN is
			-- Is `str' neither Void nor empty nor filled with blanks?
			--| Cannot be in a non exported part because post conditions use it.
		local
			blank_string: STRING
		do
			if str /= Void and then not str.is_equal ("") then
				create blank_string.make (str.count)
				blank_string.fill_blank
				Result := not str.is_equal (blank_string)
			end
		end

	is_lower_case (str: STRING): BOOLEAN is
			-- Is `str' lower case?
			--| Cannot be in a non exported part because post conditions use it.
		local
			str2: STRING
		do
			str2 := clone (str)
			str2.to_lower
			Result := str2.is_equal (str)
		end

feature {NONE} -- Implementation

	safety_flag: BOOLEAN
			-- Are we modifying the select status? (to prevent stack overflows)

end -- class EB_RADIO_COMMAND_FEEDBACK

indexing
	description: "[
			Abstraction of a list in which you can add/modify/remove items.
			+-----------------------------+
			| `first'                     |
			|  .....                      |
			| `last'                      |
			+-----------------------------+
			+-----------------------------+
			|                             |
			+-----------------------------+
			+------+ +---------+ +--------+
			| Add  | |  Apply  | | Remove |
			+------+ +---------+ +--------+
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ADD_REMOVE_LIST

inherit
	EV_VERTICAL_BOX
		rename
			is_empty as vbox_is_empty,
			count as vbox_count
		end

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create an Add/Remove list with `list' and `text'.
		do
			default_create
			build_widget
			create add_actions
			create remove_actions
			create modify_actions
		end
		
feature -- Access

	list: EV_LIST
			-- List containing items user want to add/remove.
			
	text_field: EV_TEXT_FIELD
			-- Text field used to interact with `list'.

	add_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when `Add' is pressed then released.

	remove_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when `Delete' is pressed then released.

	modify_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when `Apply' is pressed then released.

feature -- Status

	is_empty: BOOLEAN is
			-- Is `list' empty?
		do
			Result := list.is_empty
		end

	count: INTEGER is
			-- Number of items in `list'?
		do
			Result := list.count
		end

feature -- Cleaning

	reset is
			-- Reset content of Current
		do
			list.wipe_out
			text_field.remove_text	
		end
				
feature {NONE} -- GUI building

	build_widget is
			-- Build current widget.
		local
			hbox: EV_HORIZONTAL_BOX
			button: EV_BUTTON
			label: EV_LABEL
		do
			create list
			create text_field
			
			set_border_width (5)
			set_padding (5)
			
			extend (list)
			
			create hbox
			create label.make_with_text ("Entry: ")
			hbox.extend (label)
			hbox.disable_item_expand (label)
			hbox.extend (text_field)
			extend (hbox)
			disable_item_expand (hbox)
			
			create hbox
			hbox.set_border_width (5)
			hbox.extend (create {EV_CELL})
			create button.make_with_text ("Add")
			button.select_actions.extend (~add_item_in (list, text_field))
			button.disable_sensitive
			text_field.change_actions.extend (~disable_non_applicable_buttons (text_field, button))
			button.set_minimum_width (80)
			hbox.extend (button)
			hbox.disable_item_expand (button)
			hbox.extend (create {EV_CELL})
			create button.make_with_text ("Apply")
			button.select_actions.extend (~modify_item_in (list, text_field))
			button.set_minimum_width (80)
			hbox.extend (button)
			hbox.disable_item_expand (button)
			hbox.extend (create {EV_CELL})
			create button.make_with_text ("Remove")
			button.select_actions.extend (~remove_item_in (list, text_field))
			button.set_minimum_width (80)
			hbox.extend (button)
			hbox.disable_item_expand (button)
			hbox.extend (create {EV_CELL})
		
			extend (hbox)
			disable_item_expand (hbox)
		end

feature {NONE} -- Action

	add_item_in (l: EV_LIST; text: EV_TEXT_FIELD) is
			-- When user press `add' buttin, we insert content
			-- of `text' in `l'.
		require
			list_not_void: l /= Void
			text_not_void: text /= Void
		local
			list_item: EV_LIST_ITEM
			txt: STRING
		do
			txt := text.text
			if txt /= Void then
				create list_item.make_with_text (txt)
				list_item.select_actions.extend (text~set_text (txt))
				l.extend (list_item)
				l.i_th (l.count).enable_select
				text.remove_text
			end
			add_actions.call ([])
		end

	disable_non_applicable_buttons (text: EV_TEXT_FIELD; a_button: EV_BUTTON) is
		require
			a_button_not_void: a_button /= Void
		do
			if text.text /= Void then
				a_button.enable_sensitive
			else
				a_button.disable_sensitive
			end
		end

	remove_item_in (l: EV_LIST; text: EV_TEXT_FIELD) is
			-- Remove current selected item of `l' and clean
			-- `text'.
		require
			list_not_void: l /= Void
			text_not_void: text /= Void
		local
			list_item: EV_LIST_ITEM	
		do
			list_item := l.selected_item
			if list_item /= Void  then
				l.prune (list_item)
			end
			text.remove_text
			remove_actions.call ([])
		end
	
	modify_item_in (l: EV_LIST; text: EV_TEXT_FIELD) is
			-- Modify current selected item of `l' and clean
			-- `text'.
		require
			list_not_void: l /= Void
			text_not_void: text /= Void
		local
			list_item: EV_LIST_ITEM
			txt: STRING
		do
			txt := text.text
			list_item := l.selected_item
			if txt /= Void and then list_item /= Void then
				list_item.set_text (txt)
				list_item.select_actions.wipe_out
				list_item.select_actions.extend (text~set_text (txt))
			end
			modify_actions.call ([])
		end
	
invariant
	list_not_void: list /= Void
	text_field_not_void: text_field /= Void
	add_actions_not_void: add_actions /= Void
	remove_actions_not_void: remove_actions /= Void
	modify_actions_not_void: modify_actions /= Void

end -- class EV_ADD_REMOVE_LIST

indexing
	description: "Typed combo box."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_COMBO_BOX

inherit
	EV_COMBO_BOX

	DV_SENSITIVE_STRING
		rename
			set_value as set_string_value,
			value as string_value
		undefine
			default_create,
			is_equal,
			copy
		end

	DV_SENSITIVE_INTEGER
		undefine
			default_create,
			is_equal,
			copy
		end
	
	DV_SENSITIVE_CHECK
		undefine
			default_create,
			is_equal,
			copy
		end

	DV_MESSAGES
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make,
	make_with_string_data,
	make_with_integer_data,
	make_with_boolean_data

feature -- Initialization

	make is
			-- Create display.
		do
			default_create
		ensure
			has_normal_behavior: behavior_type = Normal
		end

	make_with_string_data is
			-- Create display. Combo box has a string data behavior:
			-- only predefined string values can be set from the GUI.
		do
			make
			disable_edit
			behavior_type := String_data
		ensure
			has_string_data_behavior: behavior_type = String_data
		end

	make_with_integer_data is
			-- Create display. Combo box has a integer data behavior:
			-- only predefined string values can be set from the GUI.
		do
			make
			disable_edit
			behavior_type := Integer_data
		ensure
			has_integer_data_behavior: behavior_type = Integer_data
		end

	make_with_boolean_data is
			-- Create display. Combo box has a boolean data behavior:
			-- only predefined string values can be set from the GUI.
		do
			make
			disable_edit
			behavior_type := Boolean_data
		ensure
			has_boolean_data_behavior: behavior_type = Boolean_data
		end

feature -- Access

	Normal: INTEGER is 0
			-- Combo box enable access to selected row label.

	String_data: INTEGER is 1
			-- Combo box enable access to selected string data.

	Integer_data: INTEGER is 2
			-- Combo box enable access to selected integer data.

	Boolean_data: INTEGER is 3
			-- Combo box enable access to selected boolean data.

	string_value: STRING is
			-- Display string.
		do
			check
				behavior_type = Normal or else behavior_type = String_data
			end
			if behavior_type = String_data then
				Result := selected_item.data.out
			else
				Result := text
			end
		end

	value: INTEGER is
			-- Integer value held.
		local
			integer_value: INTEGER_REF
		do
			check
				behavior_type = Integer_data
			end
				integer_value ?= selected_item.data
				check
					integer_value /= Void
				end
				Result := integer_value.item
		end

	checked: BOOLEAN is
			-- Boolean value held.
		local
			boolean_value: BOOLEAN_REF
		do
			check
				behavior_type = Boolean_data
			end
				boolean_value ?= selected_item.data
				check
					boolean_value /= Void
				end
				Result := boolean_value.item
		end
	
feature -- Status report

	behavior_type: INTEGER
			-- Component behavior type: normal (default), with string data,
			-- with integer data or with boolean data.

	valid_behavior_type (behavior: INTEGER): BOOLEAN is
			-- Is `behavior' valid?
		do
			Result := behavior >= Normal and then behavior <= Boolean_data
		end

	valid_data_type (a_data: ANY): BOOLEAN is
			-- Does `a_data' type correspond to combo box behavior type?
		require
			not_void: a_data /= Void
		local
			str_value: STRING
			integer_value: INTEGER_REF
			boolean_value: BOOLEAN_REF
		do
			if behavior_type = String_data then
				str_value ?= a_data
				Result := str_value /= Void
			elseif behavior_type = Integer_data then
				integer_value ?= a_data
				Result := integer_value /= Void
			elseif behavior_type = Boolean_data then
				boolean_value ?= a_data
				Result := boolean_value /= Void
			end
		end
		
feature -- Basic operations

	add_choice (a_choice: STRING) is
			-- Add `a_choice' to the combo box.
		require
			has_normal_behavior: behavior_type = Normal
			not_void: a_choice /= Void
			not_empty: not a_choice.is_empty
		local
			new_item: EV_LIST_ITEM
		do
			create new_item.make_with_text (a_choice)
			extend (new_item)
		end

	add_data_choice (a_data: ANY; a_label: STRING) is
			-- Add `a_data' to the combo box and enable its selection
			-- with `a_label'.
		require
			type_not_void: a_data /= Void
			valid_behavior_type: behavior_type /= Normal
			valid_data_type: valid_data_type (a_data)
			label_not_void: a_label /= Void
			label_not_empty: not a_label.is_empty
		local
			new_item: EV_LIST_ITEM
		do
			create new_item.make_with_text (a_label)
			new_item.set_data (a_data)
			extend (new_item)
		end

	set_string_value (a_text: STRING) is
			-- Set display string to `a_text'.
		local
			it: EV_LIST_ITEM
		do
			check
				behavior_type = Normal or else behavior_type = String_data
			end
			if behavior_type = String_data then
				if a_text /= Void then
					it := item_by_data (a_text)
				end
				if it = Void then
					if a_text.is_empty then
						add_data_choice (a_text, Empty_combo_item_label)
					else
						add_data_choice (a_text, a_text)
					end
					last.enable_select
				else
					it.enable_select
				end
			else
				if a_text /= Void and then not a_text.is_empty then
					set_text (a_text)
				else
					remove_text
				end
			end
		end

	set_value (i: INTEGER) is
			-- Set `i' to integer value.
		local
			it: EV_LIST_ITEM
		do
			check
				behavior_type = Integer_data
			end
			it := item_by_data (i)
			if it = Void then
				add_data_choice (i, i.out)
				last.enable_select
			else
				it.enable_select
			end
		end

	enable_checked is
			-- Check property.
		local
			it: EV_LIST_ITEM
		do
			check
				behavior_type = Boolean_data
			end
			it := item_by_data (True)
			if it = Void then
				add_boolean_choice (True)
				last.enable_select
			else
				it.enable_select
			end
		end

	disable_checked is
			-- Uncheck property.
		local
			it: EV_LIST_ITEM
		do
			check
				behavior_type = Boolean_data
			end
			it := item_by_data (False)
			if it = Void then
				add_boolean_choice (False)
				last.enable_select
			else
				it.enable_select
			end
		end

	request_sensitive is
			-- Request display sensitive.
		do
			if not is_locked then
				enable_sensitive
			end
		end

	request_insensitive is
			-- Request display insensitive.
		do
			if not is_locked then
				disable_sensitive
			end
		end

	lock_sensitiveness is
			-- Lock display string sensitiveness.
		do
			is_locked := True
		end

	unlock_sensitiveness is
			-- Unlock display string sensitiveness.
		do
			is_locked := False
		end

feature -- Status report

	is_locked: BOOLEAN
			-- Is label sensitiveness locked?

feature {NONE} -- Implementation

	add_boolean_choice (b: BOOLEAN) is
			-- Add boolean `b' choice to combo box.
		require
			has_boolean_behavior: behavior_type = Boolean_data
		local
			b_ref: BOOLEAN_REF
		do
			create b_ref
			b_ref.set_item (b)
			add_data_choice (b, b_ref.out)
		end

indexing

	library: "[
			EiffelStore: library of reusable components for ISE Eiffel.
			]"

	status: "[
			Copyright (C) 1986-2001 Interactive Software Engineering Inc.
			All rights reserved. Duplication and distribution prohibited.
			May be used only with ISE Eiffel, under terms of user license. 
			Contact ISE for any other use.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Contact: http://contact.eiffel.com
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class DV_COMBO_BOX


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


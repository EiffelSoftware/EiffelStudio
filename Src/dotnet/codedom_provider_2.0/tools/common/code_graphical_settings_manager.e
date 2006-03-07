indexing
	description: "Generic graphical settings class%
						%Can be used to persist graphical settings accross sessions."

deferred class
	CODE_GRAPHICAL_SETTINGS_MANAGER

inherit
	CODE_SETTINGS_MANAGER
		export
			{NONE} all
		end

feature -- Access

	saved_x_pos: INTEGER is
			-- Starting window x position
		do
			Result := setting (X_pos_key)
		end

	saved_y_pos: INTEGER is
			-- Starting window y position
		do
			Result := setting (Y_pos_key)
		end

	saved_width: INTEGER is
			-- Starting window width
		do
			Result := setting (Width_key)
		end

	saved_height: INTEGER is
			-- Starting window height
		do
			Result := setting (Height_key)
		end

	saved_boolean (a_name: STRING): BOOLEAN is
			-- Saved boolean value with name `a_name'
			-- False if not saved value with name `a_name'
		require
			non_void_name: a_name /= Void
		local
			l_value: INTEGER
		do
			l_value := setting (a_name)
			Result := l_value = True_value
		end

	saved_list (a_name: STRING): LIST [STRING] is
			-- List of saved values with key `a_name' if any
		require
			non_void_name: a_name /= Void
		local
			l_value: STRING
		do
			l_value := text_setting (a_name)
			if not l_value.is_empty then
				Result := decoded_list (l_value)
			end
		end

feature -- Basic Operation

	save_x_pos (a_value: INTEGER) is
			-- Set starting window x position.
		do
			set_setting (X_pos_key, a_value)
		end

	save_y_pos (a_value: INTEGER) is
			-- Set starting window y position.
		do
			set_setting (Y_pos_key, a_value)
		end

	save_width (a_value: INTEGER) is
			-- Set starting window width.
		do
			set_setting (Width_key, a_value)
		end

	save_height (a_value: INTEGER) is
			-- Set starting window height.
		do
			set_setting (Height_key, a_value)
		end

	save_boolean (a_name: STRING; a_boolean: BOOLEAN) is
			-- Save boolean value `a_boolean' with name `a_name'.
		do
			if a_boolean then
				set_setting (a_name, True_value)
			else
				set_setting (a_name, False_value)
			end
		end
		
	save_list (a_name: STRING; a_list: LIST [STRING]) is
			-- Save `a_list' using key `a_name'.
		require
			non_void_list: a_list /= Void
		do
			set_text_setting (a_name, encoded_list (a_list))
		end

	fill_combo (a_combo: EV_COMBO_BOX; a_list: LIST [STRING]) is
			-- Fill `a_combo' with strings in `a_list'.
		require
			non_void_combo: a_combo /= Void
			non_void_list: a_list /= Void
		do
			a_combo.wipe_out
			if not a_list.is_empty then
				from
					a_list.start
				until
					a_list.after
				loop
					a_combo.extend (create {EV_LIST_ITEM}.make_with_text (a_list.item))
					a_list.forth
				end
				a_combo.set_text (a_list.first)
			end
		end
		
	initialize_combo (a_combo: EV_COMBO_BOX; a_name: STRING) is
			-- Fill `a_combo' with saved values with key `a_name' if any.
			-- Will persist combo values in key with name `a_name'.
		require
			non_void_combo: a_combo /= Void
		local
			l_list: LIST [STRING]
		do
			a_combo.set_data (agent save_list (a_name, ?))
			l_list := saved_list (a_name)
			if l_list /= Void then
				fill_combo (a_combo, l_list)
			end
		end

	add_entry_to_combo_and_save (a_entry: STRING; a_combo: EV_COMBO_BOX) is
			-- Add entry `a_entry' to combo box `a_combo' if not there already.
			-- Persist combo box strings.
			-- Warning: this may cause the combo box select event to be triggered.
		local
			l_save_routine: ROUTINE [ANY, TUPLE [LIST [STRING]]]
			l_list, l_new_list: LIST [STRING]
		do
			if not a_entry.is_empty then
				l_list := a_combo.strings
				l_list.compare_objects
				if not l_list.has (a_entry) then
					if a_combo.count >= Max_combo_count then
						a_combo.finish
						a_combo.remove
					end
					a_combo.put_front (create {EV_LIST_ITEM}.make_with_text (a_entry))
					a_combo.set_text (a_entry)
				else
					if not a_combo.text.is_equal (a_entry) then
						a_combo.set_text (a_entry)						
					end
					if not a_combo.strings.first.is_equal (a_entry) then
						create {ARRAYED_LIST [STRING]} l_new_list.make (l_list.count)
						l_new_list.extend (a_entry)
						l_list.prune (a_entry)
						l_new_list.append (l_list)
						a_combo.change_actions.block
						a_combo.set_strings (l_new_list)
						a_combo.change_actions.resume
					end
				end
				l_save_routine ?= a_combo.data
				if l_save_routine /= Void then
					l_save_routine.call ([a_combo.strings])
				end
			end
		end

feature {NONE} -- Implementation

	encoded_list (a_list: LIST [STRING]): STRING is
			-- One string encoded list `a_list'
		require
			non_void_list: a_list /= Void
		do
			from
				create Result.make (240 * a_list.count)
				a_list.start
				if not a_list.after then
					Result.append (a_list.item)
					a_list.forth
				end
			until
				a_list.after
			loop
				Result.append_character (',')
				Result.append (a_list.item)
				a_list.forth
			end
		ensure
			non_void_encoded_list: Result /= Void
		end
	
	decoded_list (a_encoded_list: STRING): LIST [STRING] is
			-- List from encoded string created with `encoded_list'
		require
			non_void_encoded_list: a_encoded_list /= Void
		do
			Result := a_encoded_list.split (',')
		ensure
			non_void_result: Result /= Void
		end
		
feature {NONE} -- Private Access

	X_pos_key: STRING is "x_pos"
			-- X pos key name

	Y_pos_key: STRING is "y_pos"
			-- Y pos key name

	Height_key: STRING is "height"
			-- Height key name

	Width_key: STRING is "width"
			-- Width key name

	Max_combo_count: INTEGER is 10
			-- Maximum folders count in combo box

	True_value: INTEGER is 2
			-- Number used to encode boolean `True' value
	
	False_value: INTEGER is 1
			-- Number used to encode boolean `False' value

end -- class CODE_GRAPHICAL_SETTINGS_MANAGER

--+--------------------------------------------------------------------
--| CodeDom Tools Library
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
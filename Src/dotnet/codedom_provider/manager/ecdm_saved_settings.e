indexing
	description: "Graphical settings for Eiffel Codedom Provider Manager"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDM_SAVED_SETTINGS

inherit
	ECDM_REGISTRY_KEYS
		export
			{NONE} all
		end

feature -- Access

	saved_height: INTEGER is
			-- Starting window height
		do
			Result := registry_entry (height_key_name)
			if Result = 0 then
				Result := Default_values.item (height_key_name)
			end
		end

	saved_width: INTEGER is
			-- Starting window width
		do
			Result := registry_entry (width_key_name)
			if Result = 0 then
				Result := Default_values.item (width_key_name)
			end
		end

	saved_x_pos: INTEGER is
			-- Starting window x position
		do
			Result := registry_entry (x_pos_key_name)
			if Result = 0 then
				Result := Default_values.item (x_pos_key_name)
			end
		end

	saved_y_pos: INTEGER is
			-- Starting window y position
		do
			Result := registry_entry (y_pos_key_name)
			if Result = 0 then
				Result := Default_values.item (y_pos_key_name)
			end
		end

	saved_show_text: BOOLEAN is
			-- Should toolbar buttons text be shown?
		local
			l_value: INTEGER
		do
			l_value := registry_entry (show_text_name)
			if l_value = 0 then
				Result := Default_values.item (show_text_name) = 2
			else
				Result := l_value = 2
			end
		end

	saved_show_tooltip: BOOLEAN is
			-- Should toolbar buttons tooltips be shown?
		local
			l_value: INTEGER
		do
			l_value := registry_entry (show_tooltip_name)
			if l_value = 0 then
				Result := Default_values.item (show_tooltip_name) = 2
			else
				Result := l_value = 2
			end
		end

feature -- Element settings

	save_height (a_value: INTEGER) is
			-- Set starting window height
		do
			set_registry_entry (height_key_name, a_value)
		end

	save_width (a_value: INTEGER) is
			-- Set starting window width
		do
			set_registry_entry (width_key_name, a_value)
		end

	save_x_pos (a_value: INTEGER) is
			-- Set starting window x position
		do
			set_registry_entry (x_pos_key_name, a_value)
		end

	save_y_pos (a_value: INTEGER) is
			-- Set starting window y position.
		do
			set_registry_entry (y_pos_key_name, a_value)
		end

	save_show_text (a_value: BOOLEAN) is
			-- Set `show text' checkable menu item state.
		do
			if a_value then
				set_registry_entry (show_text_name, 2)
			else
				set_registry_entry (show_text_name, 1)
			end
		end
		
	save_show_tooltip (a_value: BOOLEAN) is
			-- Set `show text' checkable menu item state.
		do
			if a_value then
				set_registry_entry (show_tooltip_name, 2)
			else
				set_registry_entry (show_tooltip_name, 1)
			end
		end
		
feature {NONE} -- Implementation

	registry_entry (a_name: STRING): INTEGER is
			-- Integer value stored under `a_name' in manager settings hive
			-- 0 if none
		require
			non_void_name: a_name /= Void
		local
			l_key: REGISTRY_KEY
		do	
			l_key := feature {REGISTRY}.current_user.open_sub_key (Saved_settings_key, False)
			if l_key /= Void then
				Result ?= l_key.get_value (a_name)
			end
		ensure
			valid_entry: Result >= 0
		end

	set_registry_entry (a_name: STRING; a_value: INTEGER) is
			-- Set value stored under `a_name' in manager settings hive
		require
			non_void_name: a_name /= Void
			valid_value: a_value > 0
		local
			l_key: REGISTRY_KEY
		do 
			l_key := feature {REGISTRY}.current_user.open_sub_key (Saved_settings_key, True)
			if l_key = Void then
				l_key := feature {REGISTRY}.current_user.create_sub_key (Saved_settings_key)
			end
			l_key.set_value (a_name, a_value)
		ensure
			value_set: registry_entry (a_name) = a_value
		end

	Default_values: HASH_TABLE [INTEGER, STRING] is
			-- Default values if none were found in registry
		once
			create Result.make (4)
			Result.put (500, height_key_name)
			Result.put (500, width_key_name)
			Result.put (100, x_pos_key_name)
			Result.put (50, y_pos_key_name)
			Result.put (1, show_text_name)
			Result.put (1, show_tooltip_name)
		end

	height_key_name: STRING is "height"
			-- Height key name

	width_key_name: STRING is "width"
			-- Height key name

	x_pos_key_name: STRING is "x_pos"
			-- Height key name

	y_pos_key_name: STRING is "y_pos"
			-- Height key name

	show_text_name: STRING is "show_text"
			-- Show text menu item
			
	show_tooltip_name: STRING is "show_tooltip"
			-- Show tooltip menu item
			
end -- class ECDM_SAVED_SETTINGS

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Manager
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
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

	CODE_SETTINGS_MANAGER
		rename
			make as settings_make
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Intialization

	make is
			-- Initialize settings location.
		do
			settings_make (Saved_settings_key)
			Default_values.put (500, height_key_name)
			Default_values.put (500, width_key_name)
			Default_values.put (100, x_pos_key_name)
			Default_values.put (50, y_pos_key_name)
			Default_values.put (2, show_text_name)
			Default_values.put (2, show_tooltip_name)
		end
		
feature -- Access

	saved_height: INTEGER is
			-- Starting window height
		do
			Result := setting (height_key_name)
		end

	saved_width: INTEGER is
			-- Starting window width
		do
			Result := setting (width_key_name)
		end

	saved_x_pos: INTEGER is
			-- Starting window x position
		do
			Result := setting (x_pos_key_name)
		end

	saved_y_pos: INTEGER is
			-- Starting window y position
		do
			Result := setting (y_pos_key_name)
		end

	saved_show_text: BOOLEAN is
			-- Should toolbar buttons text be shown?
		do
			Result := setting (show_text_name) = 2
		end

	saved_show_tooltip: BOOLEAN is
			-- Should toolbar buttons tooltips be shown?
		do
			Result := setting (show_tooltip_name) = 2
		end

feature -- Element settings

	save_height (a_value: INTEGER) is
			-- Set starting window height
		do
			set_setting (height_key_name, a_value)
		end

	save_width (a_value: INTEGER) is
			-- Set starting window width
		do
			set_setting (width_key_name, a_value)
		end

	save_x_pos (a_value: INTEGER) is
			-- Set starting window x position
		do
			set_setting (x_pos_key_name, a_value)
		end

	save_y_pos (a_value: INTEGER) is
			-- Set starting window y position.
		do
			set_setting (y_pos_key_name, a_value)
		end

	save_show_text (a_value: BOOLEAN) is
			-- Set `show text' checkable menu item state.
		do
			if a_value then
				set_setting (show_text_name, 2)
			else
				set_setting (show_text_name, 1)
			end
		end
		
	save_show_tooltip (a_value: BOOLEAN) is
			-- Set `show text' checkable menu item state.
		do
			if a_value then
				set_setting (show_tooltip_name, 2)
			else
				set_setting (show_tooltip_name, 1)
			end
		end
		
feature {NONE} -- Implementation

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
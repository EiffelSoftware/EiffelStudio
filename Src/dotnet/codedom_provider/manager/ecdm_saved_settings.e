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

	saved_precompiled_paths: LIST [STRING] is
			-- List of saved values for precompiled library combo
		do
			Result := saved_list (precompiled_paths)
		end
		
	saved_metadata_cache_paths: LIST [STRING] is
			-- List of saved values for metadata cache combo
		do
			Result := saved_list (metadata_cache_paths)
		end
		
feature -- Element settings

	save_height (a_value: INTEGER) is
			-- Set starting window height
		do
			set_setting (Height_key_name, a_value)
		end

	save_width (a_value: INTEGER) is
			-- Set starting window width
		do
			set_setting (Width_key_name, a_value)
		end

	save_x_pos (a_value: INTEGER) is
			-- Set starting window x position
		do
			set_setting (X_pos_key_name, a_value)
		end

	save_y_pos (a_value: INTEGER) is
			-- Set starting window y position.
		do
			set_setting (Y_pos_key_name, a_value)
		end

	save_show_text (a_value: BOOLEAN) is
			-- Set `show text' checkable menu item state.
		do
			if a_value then
				set_setting (Show_text_name, 2)
			else
				set_setting (Show_text_name, 1)
			end
		end
		
	save_show_tooltip (a_value: BOOLEAN) is
			-- Set `show tooltip' checkable menu item state.
		do
			if a_value then
				set_setting (Show_tooltip_name, 2)
			else
				set_setting (Show_tooltip_name, 1)
			end
		end
	
	save_precompiled_paths (a_paths: LIST [STRING]) is
			-- Set precompiled library paths.
		require
			non_void_paths: a_paths /= Void
		do
			save_list (Precompiled_paths, a_paths)
		end
		
	save_metadata_cache_paths (a_paths: LIST [STRING]) is
			-- Set Metadata Cache paths.
		require
			non_void_paths: a_paths /= Void
		do
			save_list (Metadata_cache_paths, a_paths)
		end
		
feature {NONE} -- Implementation

	save_list (a_name: STRING; a_list: LIST [STRING]) is
			-- Save `a_list' using key `a_name'.
		require
			non_void_list: a_list /= Void
		local
			l_items: STRING
		do
			from
				create l_items.make (240 * a_list.count)
				a_list.start
				if not a_list.after then
					l_items.append (a_list.item)
					a_list.forth
				end
			until
				a_list.after
			loop
				l_items.append_character (';')
				l_items.append (a_list.item)
				a_list.forth
			end
			set_text_setting (a_name, l_items)
		end

	saved_list (a_name: STRING): LIST [STRING] is
			-- List of saved values with key `a_name' if any
		require
			non_void_name: a_name /= Void
		local
			l_paths: STRING
		do
			l_paths := text_setting (a_name)
			if l_paths /= Void then
				Result := l_paths.split (';')
			end
		end
		
feature {NONE} -- Private Access

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
			
	precompiled_paths: STRING is "precompiled_paths"
			-- Precompiled paths
			
	metadata_cache_paths: STRING is "metadata_cache_paths"
			-- Metadata Cache paths
			
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
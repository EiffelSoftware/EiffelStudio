indexing
	description: "Graphical settings saved between sessions"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TESTER_SAVED_SETTINGS

inherit
	CODE_SETTINGS_MANAGER
		rename
			make as manager_make
		end

	TESTER_REGISTRY_KEYS

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize settings manager.
		do
			manager_make (Tester_hive_path)
			Default_values.put (50, X_key)
			Default_values.put (50, Y_key)
			Default_values.put (650, Width_key)
			Default_values.put (650, Height_key)
			Default_text_values.put ("Eiffel", Codedom_provider_key)
		end
		
feature -- Access

	saved_x: INTEGER is
			-- Saved starting x
		do
			Result := setting (X_key)
		end
		
	saved_y: INTEGER is
			-- Saved starting y
		do
			Result := setting (Y_key)
		end
		
	saved_width: INTEGER is
			-- Saved starting width
		do
			Result := setting (Width_key)
		end
		
	saved_height: INTEGER is
			-- Saved starting height
		do
			Result := setting (Height_key)
		end
	
	saved_codedom_provider: STRING is
			-- Saved codedom provider
		do
			Result := text_setting (Codedom_provider_key)
		end
		
feature -- Basic Implementation

	set_saved_x (a_x: INTEGER) is
			-- Set `saved_x' with `a_x'.
		do
			set_setting (x_key, a_x)	
		end
		
	set_saved_y (a_y: INTEGER) is
			-- Set `saved_y' with `a_y'.
		do
			set_setting (y_key, a_y)	
		end
		
	set_saved_width (a_width: INTEGER) is
			-- Set `saved_width' with `a_width'.
		do
			set_setting (width_key, a_width)	
		end
		
	set_saved_height (a_height: INTEGER) is
			-- Set `saved_height' with `a_height'.
		do
			set_setting (height_key, a_height)	
		end
		
	set_saved_codedom_provider (a_codedom_provider: STRING) is
			-- Set `saved_codedom_provider' with `a_codedom_provider'.
		require
			non_void_provider: a_codedom_provider /= Void
		do
			set_text_setting (Codedom_provider_key, a_codedom_provider)
		end

end -- class TESTER_SAVED_SETTINGS

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Tester
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------

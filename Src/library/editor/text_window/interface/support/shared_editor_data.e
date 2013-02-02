note
	description: "Constants for editor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_EDITOR_DATA

feature -- Resources

	panel_manager: TEXT_PANEL_MANAGER
			-- List of open panels
		once
			create Result
		end

	editor_preferences: EDITOR_DATA
			-- Editor preferences
		do
			if attached editor_preferences_cell.item as l_item then
				Result := l_item
			else
					-- No preferences set, we create default ones
				create Result.make (create {PREFERENCES}.make)
			end
		end

feature -- Query

	initialized: BOOLEAN
			-- Have preferences been set and ready to be used?
		do
			Result := initialized_cell.item and then editor_preferences_cell.item /= Void
		end

feature {NONE} -- Implementation		

	editor_preferences_cell: CELL [detachable EDITOR_DATA]
			-- Storage for `editor_preferences'.
		once
			create Result.put (Void)
		end

	initialized_cell: CELL [BOOLEAN]
			-- Storage for `initialized'
		once
			create Result.put (False)
		end

	preference_codes: SHARED_PREFERENCE_CODES
	        -- Document preference codes
	    once
	        create Result
	    end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class SHARED_EDITOR_DATA

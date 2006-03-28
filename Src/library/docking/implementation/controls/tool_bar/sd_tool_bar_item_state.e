indexing
	description: "Tool bar item state."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_ITEM_STATE

feature -- Enumeration

	Normal: INTEGER is 1
			-- Normal	

	Hot: INTEGER is 2
			-- Hot

	Pressed: INTEGER is 3
			-- Pressed

	Disabled: INTEGER is 4
			-- Disabled

	Checked: INTEGER is 5
			-- Checked

	Hot_checked: INTEGER is 6
			-- Hot checked

feature -- Query

	is_valid (a_state: INTEGER): BOOLEAN is

		do
			Result := a_state = checked or a_state = disabled or a_state = hot or
						a_state = hot_checked or a_state = normal or a_state = pressed
		end

end

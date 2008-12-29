note
	description: "Tool bar button can show a narrow shape even it's wrap."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_NARROW_BUTTON

inherit
	SD_TOOL_BAR_BUTTON
		redefine
			rectangle
		end
create
	make

feature -- Redefine

	rectangle: EV_RECTANGLE
			-- Redefine
		do
			Result := Precursor {SD_TOOL_BAR_BUTTON}
			if is_wrap then
				Result.set_height (pixmap.height + tool_bar.padding_width * 2)
				Result.set_width (pixmap.width + tool_bar.padding_width * 2)
			end
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end

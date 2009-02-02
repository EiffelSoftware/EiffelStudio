note
	description: "Button which can set maximum width, when not enough space, it will truncate button text to ellipsis."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_WIDTH_BUTTON

inherit
	SD_TOOL_BAR_RADIO_BUTTON
		redefine
			width,
			text_rectangle
		end

create
	make

feature -- Command

	set_maximum_width (a_width: INTEGER)
			-- Set `maximum_width' with `a_width'
		require
			valid: a_width > 0
		do
			maximum_width := a_width
		ensure
			set: maximum_width = a_width
		end

feature -- Query

	width: INTEGER
			-- <Precursor>
		do
			Result := Precursor {SD_TOOL_BAR_RADIO_BUTTON}
			if Result > maximum_width then
				Result := maximum_width
			end
		end

	text_rectangle: EV_RECTANGLE
			-- <Precursor>
		local
			l_text_width: INTEGER
		do
			l_text_width := maximum_width - width_before_text
			Result := Precursor {SD_TOOL_BAR_RADIO_BUTTON}
			if Result.width > l_text_width then
				Result.set_width (l_text_width)
			end
			if state = {SD_TOOL_BAR_ITEM_STATE}.pressed or state = {SD_TOOL_BAR_ITEM_STATE}.hot_checked then
				Result.set_width (Result.width + 1)
			end
		end

	maximum_width: INTEGER;
			-- Maximum button width

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

note
	description: "Button on which can use speciall font instead of system theme font."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_FONT_BUTTON

inherit
	SD_TOOL_BAR_RADIO_BUTTON
		redefine
			text_width,
			is_selected
		end

create
	make

feature -- Command

	set_font (a_font: EV_FONT)
			-- Set `font' with `a_font'
		require
			not_void: a_font /= Void
		do
			font := a_font
		ensure
			set: font = a_font
		end

	enable_hot
			-- Enable hot state.
		do
			state := {SD_TOOL_BAR_ITEM_STATE}.hot
			last_state := state
			update
		end

feature -- Query

	font: detachable EV_FONT
		-- Text font

	text_width: INTEGER
			-- <Precursor>
		local
			l_font: EV_FONT
			l_text: like text
		do
			l_text := text
			if l_text /= Void then
				if attached font as l_attached_font then
					l_font := l_attached_font
				else
					l_font := internal_shared.tool_bar_font
				end
				Result := l_font.string_width (l_text)
			end
		end

	is_selected: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {SD_TOOL_BAR_RADIO_BUTTON} or state = {SD_TOOL_BAR_ITEM_STATE}.hot
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

indexing
	description: "[
		An EiffelVision2 link-like label.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	EVS_LINK_LABEL

inherit
	EV_LABEL
		export
			{ANY} all
		redefine
			initialize,
			set_text
		end

create
	default_create,
	make_with_text

feature {NONE} -- Initialization

	initialize
			-- Mark `Current' as initialized.
			-- This must be called during the creation procedure
			-- to satisfy the `is_initialized' invariant.
			-- Descendants may redefine initialize to perform
			-- additional setup tasks.
		do
			Precursor {EV_LABEL}
			create select_actions
			pointer_button_press_actions.extend (agent on_pointer_press)
			set_foreground_color ((create {EV_STOCK_COLORS}).blue)
			set_pointer_style (create {EV_POINTER_STYLE}.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.hyperlink_cursor))
			enable_tabable_to
			enable_tabable_from
		end

feature {NONE} -- Access

	default_font: EV_FONT is
			-- Font used to display labels.
		do
			Result := font.twin
			Result.set_weight ({EV_FONT_CONSTANTS}.weight_regular)
		end

	highlight_font: EV_FONT
			-- Highlight font
		do
			Result := font.twin
			Result.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
		end

feature -- Actions

	select_actions: EV_LITE_ACTION_SEQUENCE [TUPLE]
			-- Actions called when selected

feature -- Element change

	set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to text.
			-- (from EV_TEXTABLE)
		do
			set_minimum_size (maximum_label_width (a_text), maximum_label_height (a_text))
			Precursor {EV_LABEL} (a_text)
		end

feature {NONE} -- Query

	maximum_label_width (a_text: STRING_GENERAL): INTEGER is
			-- Maximum width of a label when set with text `a_text'
		require
			a_text_not_void: a_text /= Void
		local
			l_size: TUPLE [width, height, left_offset, right_offset: INTEGER]
			l_width: INTEGER
			l_other: INTEGER
		do
			l_size := default_font.string_size (a_text)
			l_width := l_size.width + l_size.left_offset + l_size.right_offset
			l_size := highlight_font.string_size (a_text)
			l_other := l_size.width + l_size.left_offset + l_size.right_offset + 2
			Result := l_width.max (l_other)
		end

	maximum_label_height (a_text: STRING_GENERAL): INTEGER is
			-- Maximum width of a label when set with text `a_text'
		require
			a_text_not_void: a_text /= Void
		local
			l_size: TUPLE [width, height, left_offset, right_offset: INTEGER]
			l_height: INTEGER
			l_other: INTEGER
		do
			l_size := default_font.string_size (a_text)
			l_height := l_size.height
			l_size := highlight_font.string_size (a_text)
			l_other := l_size.height
			Result := l_height.max (l_other)
		end

feature {NONE} -- Action handlers

	on_pointer_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Called when a pointer action has been performed
		do
			if a_button = 1 then
				select_actions.call ([])
			end
		end

invariant
	select_actions_attached: select_actions /= Void

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

note
	description: "[
		An EiffelVision2 link-like label with highlighting.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	EV_HIGHLIGHT_LINK_LABEL

inherit
	EV_LINK_LABEL
		redefine
			initialize,
			set_text,
			set_font
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
			Precursor
			pointer_enter_actions.force (agent on_pointer_entered)
			pointer_leave_actions.force (agent on_pointer_left)
		end

feature -- Access

	is_highlighted: BOOLEAN

feature {NONE} -- Access

	normal_font: EV_FONT
			-- Font used to display labels.
		do
			Result := internal_font
			if Result = Void then
				Result := font.twin
				Result.set_weight ({EV_FONT_CONSTANTS}.weight_regular)
				internal_font := Result
			end
		end

	highlight_font: EV_FONT
			-- Highlight font
		do
			Result := internal_highlight_font
			if Result = Void then
				Result := normal_font.twin
				Result.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
				internal_highlight_font := Result
			end
		end

feature -- Element change

	set_text (a_text: READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			set_minimum_size (maximum_label_width (a_text), maximum_label_height (a_text))
			Precursor (a_text)
		end

	set_font (a_font: EV_FONT)
			-- Assign `a_font' to normal_font.
		do
			if not is_internal_set_ev_font_operation then
					-- i.e call from {EV_FONT}.set_font, outside of Current
				internal_font := a_font
				internal_highlight_font := Void
				set_minimum_size (maximum_label_width (text), maximum_label_height (text))
			end
			if is_highlighted then
				Precursor (highlight_font)
			else
				Precursor (normal_font)
			end
		end

	set_highlight_font (a_font: EV_FONT)
			-- Assign `a_font' to highlight_font.
			-- note: always call after `set_font`
		require
			not_destroyed: not is_destroyed
			a_font_not_void: a_font /= Void
		do
			internal_highlight_font := a_font
			set_minimum_size (maximum_label_width (text), maximum_label_height (text))
			if is_highlighted then
				set_font (highlight_font)
			end
		end

feature {NONE} -- Query

	maximum_label_width (a_text: READABLE_STRING_GENERAL): INTEGER
			-- Maximum width of a label when set with text `a_text'
		require
			a_text_not_void: a_text /= Void
		local
			l_size: TUPLE [width, height, left_offset, right_offset: INTEGER]
			l_width: INTEGER
			l_other: INTEGER
		do
			l_size := normal_font.string_size (a_text)
			l_width := l_size.width + l_size.left_offset + l_size.right_offset
			l_size := highlight_font.string_size (a_text)
			l_other := l_size.width + l_size.left_offset + l_size.right_offset + 2
			Result := l_width.max (l_other)
		end

	maximum_label_height (a_text: READABLE_STRING_GENERAL): INTEGER
			-- Maximum width of a label when set with text `a_text'
		require
			a_text_not_void: a_text /= Void
		local
			l_size: TUPLE [width, height, left_offset, right_offset: INTEGER]
			l_height: INTEGER
			l_other: INTEGER
		do
			l_size := normal_font.string_size (a_text)
			l_height := l_size.height
			l_size := highlight_font.string_size (a_text)
			l_other := l_size.height
			Result := l_height.max (l_other)
		end

feature {NONE} -- Action handlers

	on_pointer_entered
			-- Called when the mouse cursor enters the label.
		require
			not_is_destroyed: not is_destroyed
		do
			is_internal_set_ev_font_operation := True
			is_highlighted := True
			set_font (highlight_font)
			is_internal_set_ev_font_operation := False
		ensure
			internal_font_unchanged: internal_font ~ old internal_font
		end

	on_pointer_left
			-- Called when the mouse cursor enters the label.
		require
			not_is_destroyed: not is_destroyed
		do
			is_internal_set_ev_font_operation := True
			is_highlighted := False
			set_font (normal_font)
			is_internal_set_ev_font_operation := False
		ensure
			internal_font_unchanged: internal_font ~ old internal_font
		end

feature {NONE} -- Implementation: Internal cache

	is_internal_set_ev_font_operation: BOOLEAN
			-- False by default, True when called from on_pointer_entered or on_pointer_left

	internal_font: detachable EV_FONT
			-- Cached internal normal_font

	internal_highlight_font: detachable EV_FONT
			-- Cached internal highlight_font

;

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

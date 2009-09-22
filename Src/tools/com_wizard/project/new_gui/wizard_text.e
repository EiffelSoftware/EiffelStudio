note
	description: "Custom/efficient text control"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_TEXT

inherit
	EV_WEL_CONTAINER

create
	make

feature {NONE} -- Initialization

	make
		do
			default_create
			create wel_text_edit.make (implementation_window, "", 0, 0, 0, 0, -1)
			put (wel_text_edit)
			wel_text_edit.set_text_limit (0)
			wel_text_edit.set_font (default_font)
			wel_text_edit.set_read_only
			font_height := font.height
		end

feature -- Access

	font: WEL_FONT
			-- Font
		do
			Result := wel_text_edit.font
		end

	first_visible_line: INTEGER
			-- First visible line
		do
			Result := wel_text_edit.first_visible_line
		ensure
			valid_indext: Result >= 0
		end

	line_count: INTEGER
			-- Line count in text
		do
			Result := wel_text_edit.line_count
		ensure
			valid_count: Result >= 0
		end

	font_height: INTEGER
			-- Height of font in pixels

	visible_lines_count: INTEGER
			-- Number of visible lines
		do
			Result := (implementation_window.height / font_height).truncated_to_integer + 1
		ensure
			valid_count: Result >= 0
		end

feature -- Element Settings

	set_font (a_font: WEL_FONT)
			-- Set `font' with `a_font'.
		require
			a_font_not_void: a_font /= Void
		do
			wel_text_edit.set_font (a_font)
		end

	set_text (a_text: STRING)
			-- Set rich edit text with `a_text'
		require
			non_void_text: a_text /= Void
		do
			wel_text_edit.set_text (a_text)
		end

feature -- Basic Operations

	save (a_file_name: STRING)
			-- Save content to `a_file_name'.
		require
			non_void_file_name: a_file_name /= Void
		local
			l_file: PLAIN_TEXT_FILE
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_file.make (a_file_name)
				l_file.open_write
				l_file.put_string (wel_text_edit.text)
				l_file.close
			end
		rescue
			l_retried := True
			retry
		end

	scroll_to_line (a_line: INTEGER)
			-- Scroll to line `a_line'.
		require
			valid_line: a_line > 0
		do
			wel_text_edit.scroll (0, a_line - first_visible_line - 1)
		end

	hide_scroll_bars
			-- Hide vertical scroll bar
		do
			wel_text_edit.hide_scroll_bars
		end

	show_scroll_bars
			-- Hide vertical scroll bar
		do
			wel_text_edit.show_scroll_bars
		end

feature {NONE} -- Implementation

	wel_text_edit: WIZARD_MULTIPLE_LINE_EDIT
			-- Wel control

	default_font: WEL_FONT
			-- Log font
		once
			create Result.make_indirect (create {WEL_LOG_FONT}.make (10, "Lucida Console"))
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class WIZARD_TEXT



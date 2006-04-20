indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PRINTER_TEXT_GENERATOR

inherit
	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_editor: like editor) is
			-- Set `editor' with `a_editor'.
			-- If `a_rtf', we generate RTF text, or we generate Postscript text.
		require
			a_editor_not_void: a_editor /= Void
		do
			editor := a_editor
			visit
		ensure
			editor_not_void: editor /= Void
		end

	visit is
			-- Visit tokens in `editor', and produce `text_for_printing'.
		local
			l_text: CLICKABLE_TEXT
			l_line: EIFFEL_EDITOR_LINE
			l_visitor: PRINTER_TOKEN_VISITOR
		do
			if preferences.misc_data.use_postscript then
				create {PRINTER_TOKEN_VISITOR_PS}l_visitor.make
			else
				create {PRINTER_TOKEN_VISITOR_RTF}l_visitor.make
			end
			create text_for_printing.make_empty
			l_text := editor.text_displayed
			from
				l_text.start
			until
				l_text.after
			loop
				l_line := l_text.current_line
				from
					l_line.start
				until
					l_line.after
				loop
					l_line.item.process (l_visitor)
					l_line.forth
				end
				l_text.forth
			end
			text_for_printing := l_visitor.text
		ensure
			text_for_printing_not_void: text_for_printing /= Void
		end

feature -- Access

	text_for_printing: STRING

feature {NONE} -- Implementation

	editor: EB_CLICKABLE_EDITOR
			-- Editor

invariant
	invariant_clause: True -- Your invariant here

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

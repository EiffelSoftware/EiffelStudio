indexing
	description: "Objects that ..."
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

end

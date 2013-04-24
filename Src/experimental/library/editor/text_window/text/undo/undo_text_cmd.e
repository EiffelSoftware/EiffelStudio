note
	description: "undo command with text to manipulate."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	UNDO_TEXT_CMD

inherit
	UNDO_CMD
		redefine
			undo_possible,
			redo_possible
		end

feature -- Status report

	undo_possible: BOOLEAN
			-- undo possible?
		do
			Result := text.has_cursor
		end

	redo_possible: BOOLEAN
			-- redo possible?
		do
			Result := text.has_cursor
		end

feature {NONE} -- Text

	text: EDITABLE_TEXT;
		-- Text related

invariant
	text_not_void: text /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class UNDO_CMD

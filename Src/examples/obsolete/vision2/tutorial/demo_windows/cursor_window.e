indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CURSOR_WINDOW

inherit
	DEMO_WINDOW

	EV_VERTICAL_BOX
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			frame: EV_FRAME
			color: EV_BASIC_COLORS
			code: EV_CURSOR_CODE
		do
			Precursor {EV_VERTICAL_BOX} (par)
			create color
			create code.make

			create frame.make_with_text (Current, "Normal Cursor")

			create frame.make_with_text (Current, "Busy Cursor")
			create cur.make_by_code (code.busy)
			frame.set_cursor (cur)
			create frame.make_with_text (Current, "Crosshair Cursor")
			create cur.make_by_code (code.crosshair)
			frame.set_cursor (cur)
			create frame.make_with_text (Current, "Help Cursor")
			create cur.make_by_code (code.help)
			frame.set_cursor (cur)
			create frame.make_with_text (Current, "Ibeam Cursor")
			create cur.make_by_code (code.ibeam)
			frame.set_cursor (cur)
			create frame.make_with_text (Current, "No Cursor")
			create cur.make_by_code (code.no)
			frame.set_cursor (cur)
			create frame.make_with_text (Current, "Sizeall Cursor")
			create cur.make_by_code (code.sizeall)
			frame.set_cursor (cur)
			create frame.make_with_text (Current, "Sizens Cursor")
			create cur.make_by_code (code.sizens)
			frame.set_cursor (cur)
			create frame.make_with_text (Current, "Sizewe Cursor")
			create cur.make_by_code (code.sizewe)
			frame.set_cursor (cur)
			create frame.make_with_text (Current, "Uparrow Cursor")
			create cur.make_by_code (code.uparrow)
			frame.set_cursor (cur)
			create frame.make_with_text (Current, "Wait Cursor")
			create cur.make_by_code (code.wait)
			frame.set_cursor (cur)
		end

	set_tabs is
			-- Set the tabs for the action window
		do
		end


feature -- Access

	cur: EV_CURSOR;
		-- A cursor used for the demo.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CURSOR_WINDOW


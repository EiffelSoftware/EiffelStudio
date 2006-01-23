indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	LINE_THICKNESS_DIALOG

inherit
	WEL_MODAL_DIALOG
		redefine
			on_ok,
			setup_dialog
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Make the dialog box and create `edit'.
		do
			make_by_id (a_parent, Dlg_line_thickness)
			create edit.make_by_id (Current, Idc_edit_width)
			pen_width := 1
		end

feature -- Access

	edit: WEL_SINGLE_LINE_EDIT
			-- Edit control to enter pen width

	pen_width: INTEGER
			-- Pen width entered

feature {NONE} -- Implementation

	setup_dialog is
			-- Set the width previously entered.
		local
			s: STRING
		do
			create s.make (0)
			s.append_integer (pen_width)
			edit.set_text (s)
		end

	on_ok is
			-- Ensure `edit' value is an integer, save it in
			-- `pen_width' and close the dialog box.
		do
			if edit.text.is_integer then
				pen_width := edit.text.to_integer
				terminate (Idok)
			end
		end

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


end -- class LINE_THICKNESS_DIALOG


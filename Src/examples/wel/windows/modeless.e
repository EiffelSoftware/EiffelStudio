indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	MODELESS

inherit
	WEL_MODELESS_DIALOG
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
		do
			make_by_id (a_parent, Modeless_dlg_id)
			create edit.make_by_id (Current, Edit_id)
			create edit_text.make (0)
		end

feature -- Access

	edit: WEL_SINGLE_LINE_EDIT
			-- Edit control

	edit_text: STRING	
			-- Text of the edit control

feature {NONE} -- Implementation

	setup_dialog is
			-- Restore the previous text in the edit control
		do
			edit.set_text (edit_text)
		end

	on_ok is
			-- Save the text from the edit control
		do
			edit_text := edit.text
			terminate (Idok)
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


end -- class MODELESS


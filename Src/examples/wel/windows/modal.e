class
	MODAL

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

creation
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW) is
		do
			make_by_id (a_parent, Modal_dlg_id)
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

end -- class MODAL

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------

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

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


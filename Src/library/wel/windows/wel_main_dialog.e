indexing
	description: "Modeless dialog box to use as a application's %
		%main window."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MAIN_DIALOG

inherit
	WEL_MODELESS_DIALOG
		rename
			make_by_id as dialog_make_by_id,
			make_by_name as dialog_make_name
		redefine
			activate
		end

creation
	make_by_id,
	make_by_name

feature {NONE} -- Initialization

	make_by_id (an_id: INTEGER) is
			-- Initialize a loadable dialog box identified by
			-- `an_id'.
		do
			parent := Void
			resource_id := an_id
			!! dialog_children.make
		ensure
			no_parent: parent = Void
			resource_id_set: resource_id = an_id
			dialog_children_not_void: dialog_children /= Void
		end

	make_by_name (a_name: STRING) is
			-- Initialize a loadable dialog box identified by
			-- `a_name'.
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		do
			parent := Void
			resource_name := clone (a_name)
			!! dialog_children.make
		ensure
			no_parent: parent = Void
			resource_name_set: resource_name.is_equal (a_name)
			dialog_children_not_void: dialog_children /= Void
		end

feature -- Basic operations

	activate is
			-- Activate the dialog.
		do
			internal_dialog_make (parent, resource_id,
				resource_name)
		end

end -- class WEL_MAIN_DIALOG

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


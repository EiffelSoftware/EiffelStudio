indexing
	description: "Modeless dialog box to use as a application's %
		%main window."
	legal: "See notice at end of class."
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

create
	make_by_id,
	make_by_name

feature {NONE} -- Initialization

	make_by_id (an_id: INTEGER) is
			-- Initialize a loadable dialog box identified by
			-- `an_id'.
		do
			parent := Void
			resource_id := an_id
			create dialog_children.make
		ensure
			no_parent: parent = Void
			resource_id_set: resource_id = an_id
			dialog_children_not_void: dialog_children /= Void
		end

	make_by_name (a_name: STRING_GENERAL) is
			-- Initialize a loadable dialog box identified by
			-- `a_name'.
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		do
			parent := Void
			resource_name := a_name.twin
			create dialog_children.make
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




end -- class WEL_MAIN_DIALOG


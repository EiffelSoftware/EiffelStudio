indexing
	description: "Container that will hold a WinForms control."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WINFORM_CONTAINER
	
inherit
	WEL_CONTROL_WINDOW
		rename
			make as control_make
		redefine
			on_size
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; an_item: WINFORMS_CONTROL) is
			-- Create current containing `an_item'.
		require
			a_parent_not_void: a_parent /= Void
			a_prent_exists: a_parent.exists
			an_item_not_void: an_item /= Void
		do
			control_make (a_parent, "WINFORM_CONTAINER")
			create winform_container.make
			an_item.set_parent (winform_container)
			cwin_set_parent (winform_container.get_handle, item)
			winform := an_item
		ensure
			parent_set: parent = a_parent
			exists: exists
			winform_set: winform = an_item
		end

feature {NONE} -- Messages

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Wm_size message
			-- See class WEL_SIZE_CONSTANTS for `size_type' value
		local
			l_size: DRAWING_SIZE
		do
			l_size.make_from_width_and_height (a_width, a_height)
			winform_container.set_size (l_size)
			winform.set_size (l_size)
		end

feature -- Access

	winform: WINFORMS_CONTROL
			-- Windows form object.

feature {NONE} -- Implementation

	winform_container: WINFORMS_CONTAINER_CONTROL
			-- Container for `winform'. It is needed as if we were directly
			-- inserting `winform' as child of `parent' some graphical operations
			-- made on `winform' will have no effect (e.g. populate a Winform
			-- datagrid).

invariant
	parent_not_void: parent /= Void
	winform_not_void: winform /= Void
	winform_container_not_void: winform_container /= Void

end -- class WEL_WINFORM_CONTAINER

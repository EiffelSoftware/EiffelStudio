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
			on_size,
			on_erase_background
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
			cwin_set_parent (winform_container.handle, item)
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

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
			disable_default_processing
			set_message_return_value (1)
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

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------


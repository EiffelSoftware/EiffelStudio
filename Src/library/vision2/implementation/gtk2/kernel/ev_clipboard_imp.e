indexing
	description: "Objects that allow access to the operating %N%
	%system clipboard."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CLIPBOARD_IMP

inherit
	EV_CLIPBOARD_I
		redefine
			interface
		end

	EV_ANY_IMP
		redefine
			interface
		end
create
	make

feature {NONE}-- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_label_new (NULL))
				-- We need a dummy c_object as the clipboards are not widgets.
		end

	initialize is
			-- initialize `Current'.
		local
			cs: C_STRING
		do
			create cs.make ("CLIPBOARD")
			clipboard_clipboard := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_clipboard_get (
							feature {EV_GTK_EXTERNALS}.gdk_atom_intern (cs.item, 1)
			)
			is_initialized := True
		end

feature -- Access

	text: STRING is
			-- `Result' is current clipboard content.
		do
		end

feature -- Status Setting

	set_text (a_text: STRING) is
			-- Assign `a_text' to clipboard.
		local
		do

		end
		
feature {NONE} -- Implementation

	clipboard_clipboard, clipboard_primary: POINTER
			-- Pointers to the CLIPBOARD and PRIMARY Gtk clipboards

feature {EV_ANY_I}

	interface: EV_CLIPBOARD
		-- Interface of `Current'

end -- class EV_CLIPBOARD_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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


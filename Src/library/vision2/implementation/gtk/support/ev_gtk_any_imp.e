indexing
	description: "Common anchestor for all Eiffel objects that represent%
					%a GtkObjects";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_GTK_ANY_IMP
inherit
	ANY	

	MEMORY
		export
			{NONE} all
		redefine
			dispose
		end

feature {NONE} -- Initialization

	make_by_pointer (a_pointer: POINTER) is
			-- Set `handle' with `a_pointer'.
			-- Since `handle' is shared, it does not need
			-- to be freed.
			-- Caution: `a_pointer' must be a pointer
			-- coming from the Operating System.
		do
			handle := a_pointer
			shared := True
		ensure
			handle_set: handle = a_pointer
			shared: shared
		end

feature -- Access

	handle: POINTER
			-- Generic GtkObject handle or structure pointer.

feature -- Status report

	shared: BOOLEAN
			-- Is `item' shared by another object?
			-- If False (by default), `item' will
			-- be destroyed by `destroy_item'.
			-- If True, `item' will not be destroyed.

	exists: BOOLEAN is
			-- Does the `handle' exist?
		do
			Result := handle /= default_pointer
		ensure
			Result = (handle /= default_pointer)
		end
		
	destroyed: BOOLEAN is
			-- Is the `handle' destroyed?
		do
			Result := not exists
		end

feature -- Element change

	set_handle (a_handle: POINTER) is
			-- Set `handle' with `a_handle'
		do
			handle := a_handle
		ensure
			handle_set: handle = a_handle
		end

feature -- Status setting

	set_shared is
			-- Set `shared' to True.
		do
			shared := True
		ensure
			shared: shared
		end

	set_unshared is
			-- Set `shared' to False.
		do
			shared := False
		ensure
			unshared: not shared
		end

feature -- Conversion

	to_integer: INTEGER is
			-- Converts `handle' to an integer.
		do
			Result := cgtk_pointer_to_integer (handle)
		ensure
			Result = cgtk_pointer_to_integer (handle)
		end

feature {NONE} -- Removal

	destroy is
			-- Called by the `dispose' routine to
			-- destroy `handle' by calling the
			-- corresponding Gtk function and
			-- set `handle' to `default_pointer'.
		require
			exists: exists
		deferred
		ensure
			handle_unset: handle = default_pointer
		end

	dispose is
			-- Ensure `handle' is destroyed when
			-- garbage collected by calling `destroy'
		do
			if exists and then not shared then
				destroy
			end
		end

feature {NONE} -- Externals

	cgtk_pointer_to_integer (p: POINTER): INTEGER is
			-- Converts a pointer `p' to an integer
		external
			"C [macro <gtk_eiffel.h>] (EIF_POINTER): EIF_INTEGER"
		end

	cgtk_integer_to_pointer (i: INTEGER): POINTER is
			-- Converts an integer `i' to a pointer
		external
			"C [macro <gtk_eiffel.h>] (EIF_INTEGER): EIF_POINTER"
		end

end -- class EV_GTK_OBJECT_MANAGER

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

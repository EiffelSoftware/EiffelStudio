indexing
	description: "Ancestor to all Windows objects and structures."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_ANY

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
			-- Set `item' with `a_pointer'.
			-- Since `item' is shared, it does not need
			-- to be freed.
			-- Caution: `a_pointer' must be a pointer
			-- coming from Windows.
		do
			item := a_pointer
			shared := True
		ensure
			item_set: item = a_pointer
			shared: shared
		end

feature -- Access

	item: POINTER
			-- Generic Windows handle or structure pointer.
			-- Can be a HWND, HICON, RECT *, WNDCLASS *, etc...

feature -- Status report

	shared: BOOLEAN
			-- Is `item' shared by another object?
			-- If False (by default), `item' will
			-- be destroyed by `destroy_item'.
			-- If True, `item' will not be destroyed.

	exists: BOOLEAN is
			-- Does the `item' exist?
		do
			Result := item /= default_pointer
		ensure
			Result = (item /= default_pointer)
		end

feature -- Element change

	set_item (an_item: POINTER) is
			-- Set `item' with `an_item'
		do
			item := an_item
		ensure
			item_set: item = an_item
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
			-- Converts `item' to an integer.
		do
			Result := cwel_pointer_to_integer (item)
		ensure
			Result = cwel_pointer_to_integer (item)
		end

feature -- Removal

	dispose is
			-- Destroy the inner structure of `Current'.
			--
			-- This function should be called by the GC when the
			-- object is collected or by the user if `Current' is
			-- no more usefull. 
		do
			if exists and then not shared then
				destroy_item
			end
		end

feature {NONE} -- Removal

	destroy_item is
			-- Called by the `dispose' routine to
			-- destroy `item' by calling the
			-- corresponding Windows function and
			-- set `item' to `default_pointer'.
		require
			exists: exists
		deferred
		end

feature {NONE} -- Externals

	cwel_pointer_to_integer (p: POINTER): INTEGER is
			-- Converts a pointer `p' to an integer
		external
			"C [macro <wel.h>] (EIF_POINTER): EIF_INTEGER"
		end

	cwel_integer_to_pointer (i: INTEGER): POINTER is
			-- Converts an integer `i' to a pointer
		external
			"C [macro <wel.h>] (EIF_INTEGER): EIF_POINTER"
		end

end -- class WEL_ANY


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


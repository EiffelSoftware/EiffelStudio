indexing
	description: "Ancestor to all Windows objects and structures."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_ANY

inherit
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
			-- comming from Windows.
		do
			item := a_pointer
			shared := True
		ensure
			item_set: item = a_pointer
			shared: shared
		end

feature -- Access

	item: POINTER
			-- Generic Windows handle or pointer.
			-- Can be a HWND, HICON, RECT *, WNDCLASS *, etc...

feature -- Element change

	set_item (a_item: POINTER) is
			-- Set `item' with `a_item'
		do
			item := a_item
		ensure
			item_set: item = a_item
		end

feature -- Status setting

	set_shared is
			-- Set `shared' to True
		do
			shared := True
		ensure
			shared: shared
		end

	set_unshared is
			-- Set `shared' to False
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

feature -- Status report

	exists: BOOLEAN is
			-- Does the `item' exist?
		do
			Result := item /= default_pointer
		ensure
			Result = (item /= default_pointer)
		end

feature {WEL_ANY} -- Status report

	shared: BOOLEAN
			-- Is `item' shared by another object?
			-- If False (by default), `item' will
			-- be destroyed by `destroy_item'.
			-- If True, `item' will not be destroyed.

feature {NONE} -- Removal

	destroy_item is
			-- Called by the `dispose' routine to
			-- destroy `item' by calling the
			-- corresponding Windows function and
			-- set `item' to `default_pointer'.
		require
			exists: exists
		deferred
		ensure
			not_exists: not exists
		end

	dispose is
			-- Ensure `item' is destroyed when
			-- garbage collected by calling `destroy_item'
		do
			if exists and then not shared then
				destroy_item
			end
		end

feature {NONE} -- Externals

	cwel_pointer_to_integer (p: POINTER): INTEGER is
			-- Converts a pointer `p' to an integer
		external
			"C [macro <wel.h>]"
		end

	cwel_integer_to_pointer (i: INTEGER): POINTER is
			-- Converts an integer `i' to a pointer
		external
			"C [macro <wel.h>]"
		end

end -- class WEL_ANY

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

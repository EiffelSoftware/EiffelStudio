note
	description: "Ancestor to all Windows objects and structures."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_ANY

inherit
	DISPOSABLE

feature {NONE} -- Initialization

	make_by_pointer (a_pointer: POINTER)
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

	exists: BOOLEAN
			-- Does the `item' exist?
		do
			Result := item /= default_pointer
		ensure
			Result = (item /= default_pointer)
		end

feature -- Element change

	set_item (an_item: POINTER)
			-- Set `item' with `an_item'
		do
			item := an_item
		ensure
			item_set: item = an_item
		end

feature -- Status setting

	set_shared
			-- Set `shared' to True.
		do
			shared := True
		ensure
			shared: shared
		end

	set_unshared
			-- Set `shared' to False.
		do
			shared := False
		ensure
			unshared: not shared
		end

feature -- Conversion

	to_integer: INTEGER
			-- Converts `item' to an integer.
		obsolete
			"Use `item' instead to ensure portability between 32 and 64 bits version of Windows."
		do
			Result := item.to_integer_32
		ensure
			Result = item.to_integer_32
		end

feature -- Removal

	dispose
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

	destroy_item
			-- Called by the `dispose' routine to
			-- destroy `item' by calling the
			-- corresponding Windows function and
			-- set `item' to `default_pointer'.
		require
			exists: exists
		deferred
		end

feature {WEL_ANY} -- Externals

	frozen cwel_integer_to_pointer (i: INTEGER): POINTER
			-- Converts an integer `i' to a pointer
		external
			"C [macro <wel.h>] (EIF_INTEGER): EIF_POINTER"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_ANY


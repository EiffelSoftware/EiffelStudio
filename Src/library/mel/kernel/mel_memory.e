indexing

	description: 
		"Class which can control the collection of external structures.%
		%If `is_shared' is True, then destroying the C handle (i.e `destroy') is %
		%the responsibility of the user. Otherwize, the `destroy' will be %
		%automatically called when the Current object is collected. ";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	MEL_MEMORY

inherit

	MEMORY
		export
			{NONE} all
		redefine
			is_equal, dispose
		end;

	ANY
		redefine
			is_equal
		end

feature {NONE} -- Initialization

	make_from_existing (a_handle: POINTER) is
			-- Initialize `a_handle' to `handle;.
		require
			a_handle_not_null: a_handle /= default_pointer
		do
			handle := a_handle;
		ensure
			set: handle = a_handle;
		end;

feature -- Access

	handle: POINTER;
			-- handle to C structure/identifier

	is_valid: BOOLEAN is
			-- Is the resource valid?
		do
			Result := handle /= default_pointer
		ensure
			valid_result: Result = not is_destroyed
		end;

	is_destroyed: BOOLEAN is
			-- Is the resource destroyed?
		do
			Result := not is_valid
		ensure
			valid_result: Result = not is_valid
		end;

feature -- Status report

	is_shared: BOOLEAN
			-- Is `handle' shared by another object?
			-- If False (by default except for descendents of
			-- MEL_RESOURCE), `handle' will be automatically destroyed by `dispose'.

feature -- Status setting

	set_shared is
			-- Set `shared' to True.
		do
			is_shared := True
		ensure
			is_shared: is_shared
		end;

	set_unshared is
			-- Set `is_shared' to False.
		do
			is_shared := False
		ensure
			unshared: not is_shared
		end

feature -- Comparison

	is_equal (other:like Current): BOOLEAN is
			-- Is Current `handle' equal to `other' handle?
		do
			Result := handle = other.handle
		end;

feature -- Removal

	destroy is
			-- Explicit destruction of associated `handle'.
		require
			exists: not is_destroyed
		deferred
		ensure
			destroyed: is_destroyed
		end

feature {NONE} -- Removal

	dispose is
			-- Ensure `item' is destroyed when
			-- garbage collected by calling `destroy_item'
		do
			if not is_shared and then not is_destroyed then
				destroy
			end
		end

end -- class MEL_MEMORY

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------

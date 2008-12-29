note

	description: 
		"Class which can control the collection of external structures.%
		%If `is_shared' is True, then destroying the C handle (i.e `destroy') is %
		%the responsibility of the user. Otherwize, the `destroy' will be %
		%automatically called when the Current object is collected. "
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	MEL_MEMORY

inherit
	DISPOSABLE
		redefine
			is_equal
		end

feature {NONE} -- Initialization

	make_from_existing (a_handle: POINTER)
			-- Initialize `a_handle' to `handle;.
		require
			a_handle_not_null: a_handle /= default_pointer
		do
			handle := a_handle
			set_shared
		ensure
			set: handle = a_handle;
		end;

feature -- Access

	handle: POINTER;
			-- handle to C structure/identifier

	is_valid: BOOLEAN
			-- Is the resource valid?
		do
			Result := handle /= default_pointer
		ensure
			valid_result: Result = not is_destroyed
		end;

	is_destroyed: BOOLEAN
			-- Is the resource destroyed?
		do
			Result := not is_valid
		ensure
			valid_result: Result = not is_valid
		end;

feature -- Status report

	is_shared: BOOLEAN
			-- Is `handle' shared by another object?
			-- If False (by default except for descendants of
			-- MEL_RESOURCE), `handle' will be automatically destroyed by `dispose'.

feature -- Status setting

	set_shared
			-- Set `shared' to True.
		do
			is_shared := True
		ensure
			is_shared: is_shared
		end;

	set_unshared
			-- Set `is_shared' to False.
		do
			is_shared := False
		ensure
			unshared: not is_shared
		end

feature -- Comparison

	is_equal (other:like Current): BOOLEAN
			-- Is Current `handle' equal to `other' handle?
		do
			Result := handle = other.handle
		end;

feature -- Removal

	destroy
			-- Explicit destruction of associated `handle'.
		require
			exists: not is_destroyed
		deferred
		ensure
			destroyed: is_destroyed
		end

feature {NONE} -- Removal

	dispose
			-- Ensure `item' is destroyed when
			-- garbage collected by calling `destroy_item'
		do
			if not is_shared and then not is_destroyed then
				destroy
			end
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




end -- class MEL_MEMORY



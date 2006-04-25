indexing
	description: "Wrapper of IEnumSTATSTG interface, used to enumerate%
		% through an array of STATSTG structures, which contains%
		% statistical information about an open storage, stream,%
		% or byte array object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_ENUM_STATSTG

inherit
	ECOM_WRAPPER

create
	make

feature -- Access

	next_item: ECOM_STATSTG is
			-- Next item in enumeration sequence
			-- Void if there is no next_item item
		local
			l_pointer: POINTER
			l_count: NATURAL_32
		do
			l_pointer := l_pointer.memory_alloc (c_sizeof_statstg)
			if c_next_item (item, l_pointer, $l_count) = 0 and then l_count = 1 then
				create Result.make (l_pointer)
			end
		end

	is_valid_name (name: STRING): BOOLEAN is
			-- Is object with name `name' part of storage object?
			-- Change position in enumeration.
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		local
			l_statstg: ECOM_STATSTG
		do
			from
				reset
				l_statstg := next_item
			until
				l_statstg = Void or Result
			loop
				Result := l_statstg.is_same_name (name)
				if not Result then
					l_statstg := next_item
				end
			end
		end

	creation_time (a_name: STRING): WEL_FILE_TIME is
			-- Creation time of element `a_name'
			-- Change position in enumeration.
		require
			non_void_name: a_name /= Void
			valid_name: is_valid_name (a_name)
		local
			l_statstg: ECOM_STATSTG
		do
			from
				reset
				l_statstg := next_item
			until
				Result /= Void
			loop
				if l_statstg.is_same_name (a_name) then
					Result := l_statstg.creation_time
				else
					l_statstg := next_item
				end
			end
		ensure
			non_void_result: Result /= Void
		end

	access_time (a_name: STRING): WEL_FILE_TIME is
			-- Access time of element `a_name'
			-- Change position in enumeration.
		require
			non_void_name: a_name /= Void
			valid_name: is_valid_name (a_name)
		local
			l_statstg: ECOM_STATSTG
		do
			from
				reset
				l_statstg := next_item
			until
				Result /= Void
			loop
				if l_statstg.is_same_name(a_name) then
					Result := l_statstg.access_time
				else
					l_statstg := next_item
				end
			end
		ensure
			non_void_result: Result /= Void
		end

	modification_time (a_name: STRING): WEL_FILE_TIME is
			-- Modification time of element `a_name'
			-- Change position in enumeration.
		require
			non_void_name: a_name /= Void
			valid_name: is_valid_name (a_name)
		local
			l_statstg: ECOM_STATSTG
		do
			from
				reset
				l_statstg := next_item
			until
				Result /= Void
			loop
				if l_statstg.is_same_name (a_name) then
					Result := l_statstg.modification_time
				else
					l_statstg := next_item
				end
			end
		ensure
			non_void_result: Result /= Void
		end

feature -- Basic Operations

	skip (n: NATURAL_32) is
			-- Skips over `n' items in enumeration sequence.
		do
			c_skip (item, n)
		end

	reset is
			-- Resets enumeration sequence to beginning.
		do
			c_reset (item)
		end

	clone_enum: like Current is
			-- Creates another enumerator that has
			-- same enumeration state as `Current'.
		local
			l_pointer: POINTER
		do
			c_clone (item, $l_pointer)
			if l_pointer /= default_pointer then
				create Result.make (l_pointer)
			end
		end

	memory_free is
			-- Free memory pointed by `item'.
		do
			c_release (item)
			item := default_pointer
		end

feature {NONE} -- Externals

	c_next_item (a_item: POINTER; a_res: POINTER; a_count: TYPED_POINTER [NATURAL_32]): NATURAL_32 is
		external
			"C inline use <windows.h>"
		alias
			"((IEnumSTATSTG*)$a_item)->lpVtbl->Next ((IEnumSTATSTG*)$a_item, 1, (STATSTG*)$a_res, (ULONG*)$a_count)"
		end

	c_skip (a_item: POINTER; n: NATURAL_32) is
		external
			"C inline use <windows.h>"
		alias
			"((IEnumSTATSTG*)$a_item)->lpVtbl->Skip ((IEnumSTATSTG*)$a_item, (ULONG*)$n)"
		end

	c_reset (a_item: POINTER) is
		external
			"C inline use <windows.h>"
		alias
			"((IEnumSTATSTG*)$a_item)->lpVtbl->Reset((IEnumSTATSTG*)$a_item)"
		end

	c_clone (a_item, a_res: POINTER) is
		external
			"C inline use <windows.h>"
		alias
			"((IEnumSTATSTG*)$a_item)->lpVtbl->Clone ((IEnumSTATSTG*)$a_item, (IEnumSTATSTG**)$a_res)"
		end

	c_release (a_item: POINTER) is
		external
			"C inline use <windows.h>"
		alias
			"((IEnumSTATSTG*)$a_item)->lpVtbl->Release((IEnumSTATSTG*)$a_item)"
		end

	c_sizeof_statstg: INTEGER is
		external
			"C inline use <windows.h>"
		alias
			"sizeof(STATSTG)"
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




end -- class ECOM_ENUM_STATSTG


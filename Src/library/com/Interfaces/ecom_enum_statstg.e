indexing
	description: "Wrapper of IEnumSTATSTG interface, used to enumerate%
		% through an array of STATSTG structures, which contains%
		% statistical information about an open storage, stream,%
		% or byte array object."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_ENUM_STATSTG

inherit
	ECOM_WRAPPER

creation
	make_from_pointer

feature -- Access

	next_item: ECOM_STATSTG is
			-- Next item in enumeration sequence
			-- Void if there is no next_item item
		local
			ptr: POINTER
		do
			ptr := ccom_next_item (initializer)
			if (ptr /= default_pointer) then
				!! Result.make_from_pointer (ptr)
			end
		end

	is_valid_name (name: STRING): BOOLEAN is
			-- Is object with name `name' part of storage object?
			-- Change position in enumeration.
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		local
			local_statstg: ECOM_STATSTG
		do
			from
				reset	
				local_statstg := next_item			
			until
				local_statstg = Void
			loop				
				if (local_statstg.is_same_name(name)) then
					Result := True
				end
				local_statstg := next_item
			end
		end

	creation_time (a_name: STRING): WEL_FILE_TIME is
			-- Creation time of element `a_name'
			-- Change position in enumeration.
		require
			non_void_name: a_name /= Void
			valid_name: is_valid_name (a_name)
		local
			local_statstg: ECOM_STATSTG
		do
			from
				reset	
				local_statstg := next_item			
			until
				Result /= Void
			loop				
				if (local_statstg.is_same_name(a_name)) then
					Result := local_statstg.creation_time
				end
				local_statstg := next_item
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
			local_statstg: ECOM_STATSTG
		do
			from
				reset	
				local_statstg := next_item			
			until
				Result /= Void
			loop				
				if (local_statstg.is_same_name(a_name)) then
					Result := local_statstg.access_time
				end
				local_statstg := next_item
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
			local_statstg: ECOM_STATSTG
		do
			from
				reset	
				local_statstg := next_item			
			until
				Result /= Void
			loop				
				if (local_statstg.is_same_name(a_name)) then
					Result := local_statstg.modification_time
				end
				local_statstg := next_item
			end
		ensure
			non_void_result: Result /= Void
		end

feature -- Basic Operations

	skip (n: INTEGER) is
			-- Skips over `n' items in enumeration sequence.
		require
			valid_skip_count: n >= 0
		do
			ccom_skip(initializer, n)
		end

	reset is
			-- Resets enumeration sequence to beginning.
		do
			ccom_reset(initializer)
		end

	clone_enum: like Current is
			-- Creates another enumerator that has 
			-- same enumeration state as `Current'. 
		do
			!! Result.make_from_pointer (ccom_clone (initializer))
		ensure
			Result /= Void
		end

feature {NONE} -- Implementation	

	create_wrapper (a_pointer: POINTER): POINTER is
			-- Create C wrapper using interface pointer.
		do
			Result := ccom_create_c_ienum_stastg (a_pointer)
		end

	delete_wrapper is
			-- Free corresponding C++ object.
		do
			ccom_delete_c_ienum (initializer)
		end

feature {NONE} -- Externals

	ccom_create_c_ienum_stastg (a_pointer: POINTER): POINTER is
		external
			"C++ [new E_IEnumSTATSTG %"E_IEnumSTATSTG.h%"](IEnumSTATSTG *)"
		end

	ccom_delete_c_ienum (cpp_obj: POINTER) is
		external
			"C++ [delete E_IEnumSTATSTG %"E_IEnumSTATSTG.h%"]()"
		end

	ccom_next_item (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_IEnumSTATSTG %"E_IEnumSTATSTG.h%"](): EIF_POINTER"
		end

	ccom_skip (cpp_obj: POINTER; n: INTEGER) is
		external
			"C++ [E_IEnumSTATSTG %"E_IEnumSTATSTG.h%"](ULONG)"
		end

	ccom_reset (cpp_obj: POINTER) is
		external
			"C++ [E_IEnumSTATSTG %"E_IEnumSTATSTG.h%"]()"
		end

	ccom_clone (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_IEnumSTATSTG %"E_IEnumSTATSTG.h%"](): EIF_POINTER"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_IEnumSTATSTG %"E_IEnumSTATSTG.h%"](): EIF_POINTER"
		end

end -- class ECOM_ENUM_STATSTG

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------


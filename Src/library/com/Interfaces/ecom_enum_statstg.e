indexing
	description: "Wrapper of IEnumSTATSTG interface, used to enumerate%
		% through an array of STATSTG structures, which contain%
		% statistical information about an open storage, stream,%
		% or byte array object. "
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_ENUM_STATSTG

inherit

	ECOM_INTERFACE

creation

	make_from_pointer

feature -- Basic Operations

	next: ECOM_STATSTG is
			-- Retrieves the next item in the enumeration sequence. 
			-- returns Void if ther is no next item
		local
			ptr: POINTER
		do
			ptr := ccom_next (initializer)
			if (ptr /= Default_pointer) then
				!!Result.make_from_pointer (ptr)
			end
		end

	skip (n: INTEGER) is
			-- Skips over `n' items in the enumeration sequence.
		do
			ccom_skip(initializer, n)
		end

	reset is
			-- Resets the enumeration sequence to the beginning.
		do
			ccom_reset(initializer)

		end

	clone_enum: like Current is
			-- Creates another enumerator that contains the 
			-- same enumeration state as the current one. 
		do
			!!Result.make_from_pointer (ccom_clone (initializer))
		ensure
			Result /= Void
		end

	is_valid_name (name: STRING): BOOLEAN is
			-- Check if object with `name' is part of the 
			-- storage object
		require
			valid_name: name /= Void
		local
			local_statstg: ECOM_STATSTG
		do
			from
				reset	
				local_statstg := next			
			until
				local_statstg = Void
			loop				
				if (local_statstg.is_same_name(name)) then
					Result := True
				end
				local_statstg := next
			end
		end

	element_creation_time (a_name: STRING): WEL_FILE_TIME is
			-- creation time of element `a_name'
		require
			valid_name: a_name /= Void and then is_valid_name (a_name)
		local
			local_statstg: ECOM_STATSTG
		do
			from
				reset	
				local_statstg := next			
			until
				local_statstg = Void
			loop				
				if (local_statstg.is_same_name(a_name)) then
					Result := local_statstg.creation_time
				end
				local_statstg := next
			end
		ensure
			non_void_result: Result /= Void
		end

	element_access_time (a_name: STRING): WEL_FILE_TIME is
			-- access time of element `a_name'
		require
			valid_name: a_name /= Void and then is_valid_name (a_name)
		local
			local_statstg: ECOM_STATSTG
		do
			from
				reset	
				local_statstg := next			
			until
				local_statstg = Void
			loop				
				if (local_statstg.is_same_name(a_name)) then
					Result := local_statstg.access_time
				end
				local_statstg := next
			end
		ensure
			non_void_result: Result /= Void
		end

	element_modification_time (a_name: STRING): WEL_FILE_TIME is
			-- modification time of element `a_name'
		require
			valid_name: a_name /= Void and then is_valid_name (a_name)
		local
			local_statstg: ECOM_STATSTG
		do
			from
				reset	
				local_statstg := next			
			until
				local_statstg = Void
			loop				
				if (local_statstg.is_same_name(a_name)) then
					Result := local_statstg.modification_time
				end
				local_statstg := next
			end
		ensure
			non_void_result: Result /= Void
		end

feature {NONE} -- Implementation	

	create_wrapper (a_pointer: POINTER): POINTER is
			-- Create C wrapper using interface pointer
		do
			Result := ccom_create_c_ienum_stastg (a_pointer)
		end

	release_interface is
			-- Free also corresponding C++ object
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

	ccom_next (cpp_obj: POINTER): POINTER is
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
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


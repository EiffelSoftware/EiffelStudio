indexing

	description: "Encapsulation of a C++ structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_OBJECT_WITH_POINTER

feature -- Element change

	allocate: POINTER is
			-- Create associated C++ structure.
			-- To be redefined by descendant if needed.
		do
		ensure
			valid_result: Result /= default_pointer
		end
		
	init is
			-- Initialize associated C++ structure.
		do
			destroy
			ole_ptr := allocate
			is_ole_ptr_attached := False
		ensure
			valid_c_structure_pointer: ole_ptr /= default_pointer
			not_attached: is_ole_ptr_attached = False
		end

	destroy is
			-- Destroy associated C++ structure.
		do
			if not is_ole_ptr_attached and then ole_ptr /= default_pointer then
				ole2_free_pointer (ole_ptr)
				ole_ptr := default_pointer
			end
		ensure
			destroyed: not is_ole_ptr_attached implies ole_ptr = default_pointer
		end

	attach (ptr: POINTER) is
			-- Attach associated C++ structure.
		require
			valid_pointer: ptr /= default_pointer
		do
			destroy
			ole_ptr := ptr
			is_ole_ptr_attached := True
		ensure
			ole_ptr_set: ole_ptr = ptr
			attached: is_ole_ptr_attached
		end

	detach is
			-- Detach associated C++ structure.
		do
			is_ole_ptr_attached := False
			destroy
		ensure
			detached: not is_ole_ptr_attached
			destroyed: ole_ptr = default_pointer
		end

feature -- Access

	ole_ptr: POINTER
			-- Pointer to associated C++ structure

	is_ole_ptr_attached: BOOLEAN
			-- Does associated C++ structure exist?
	
feature {NONE} -- Implementation
			
	ole2_free_pointer (ptr: POINTER) is
		external
			"C"
		alias
			"eole2_free_pointer"
		end

invariant

	valid_pointer: is_ole_ptr_attached implies ole_ptr /= default_pointer
	
end -- class EOLE_OBJECT_WITH_POINTER

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------

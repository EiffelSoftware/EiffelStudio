indexing

	description: "COM IPersist interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_PERSIST

inherit
	EOLE_UNKNOWN
		redefine
			interface_identifier,
			interface_identifier_list
		end

creation
	make
	
feature -- Access

	interface_identifier: STRING is
			-- Unique interface identifier
		once
			Result := Iid_persist
		end

	interface_identifier_list: LINKED_LIST [STRING] is
			-- List of supported interfaces
		once
			Result := precursor
			Result.extend (Iid_persist)
		end

feature -- Message Transmission

	get_class_id: STRING is
			-- Class identifier (CLSID) of component object
			-- Not meant to be redefined; redefine `on_get_class_id' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_get_class_id (ole_interface_ptr)
		end
		
feature {EOLE_CALL_DISPATCHER} -- Callback
		
	on_get_class_id: STRING is
			-- Class identifier (CLSID) of component object
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end
		
feature {NONE} -- Externals

	ole2_get_class_id (ptr: POINTER): STRING is
		external
			"C"
		alias
			"eole2_get_class_id"
		end
		
end -- class EOLE_PERSIST

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1998.
--| Modifications and extensions: copyright (C) ISE, 1998.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


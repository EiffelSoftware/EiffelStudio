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
			on_query_interface,
			create_ole_interface_ptr
		end

creation
	make
	
feature -- Element change

	create_ole_interface_ptr is
			-- Create associated OLE pointer
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (Iid_persist)
			ole_interface_ptr := ole2_create_interface_pointer ($Current, wel_string.item)
		end

feature -- Message Transmission

	get_class_id: STRING is
			-- Class identifier (CLSID) of component object
			-- Not meant to be redefined; redefine `on_get_class_id' instead.
		require
			valid_interface: ole_interface_ptr /= default_pointer
		do
			Result := ole2_get_class_id (ole_interface_ptr)
		end
		
feature {EOLE_CALL_DISPATCHER} -- Callback

	on_query_interface (iid: STRING): POINTER is
			-- Query `iid' interface.
		do
			if iid.is_equal (Iid_persist) or iid.is_equal (Iid_unknown) then
				Current.add_ref
				Result := Current.ole_interface_ptr
				set_last_hresult (S_ok)
			else
				set_last_hresult (E_nointerface)
			end
		end
		
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
------------------------------------------------------------------------------

indexing

	description: "COM IProvideClassInfo interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_PROVIDE_CLASS_INFO

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
			--  Create associated OLE pointer.
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (Iid_provide_class_info)
			ole_interface_ptr := ole2_create_interface_pointer ($Current, wel_string.item)
		end

feature -- Access

	get_class_info: EOLE_TYPE_INFO is
			-- EOLE_TYPE_INFO interface for object's type information 
			-- Not meant to be redefined; redefine `on_get_class_info' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_provide_class_info_get_class_info (ole_interface_ptr)
		end

feature {EOLE_CALL_DISPATCHER} -- Callback

	on_query_interface (iid: STRING): POINTER is
			-- Query `iid' interface.
			-- Return Void if interface is not supported.
		do
			if iid.is_equal (Iid_provide_class_info) or iid.is_equal (Iid_unknown) then
				Current.add_ref
				Result := Current.ole_interface_ptr
				set_last_hresult (S_ok)
			else
				set_last_hresult (E_nointerface)
			end
		end

	on_get_class_info: EOLE_TYPE_INFO is
			-- EOLE_TYPE_INFO interface for object's type information 
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end


feature {NONE} -- Externals

	ole2_provide_class_info_get_class_info (p: POINTER): EOLE_TYPE_INFO is
		external
			"C"
		alias
			"eole2_provide_class_info_get_class_info"
		end
	
end -- class EOLE_PROVIDE_CLASSINFO

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


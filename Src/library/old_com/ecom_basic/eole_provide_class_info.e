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
			interface_identifier,
			interface_identifier_list
		end

creation
	make
	
feature -- Access

	interface_identifier: STRING is
			-- Unique interface identifier
		once
			Result := Iid_provide_class_info
		end

	interface_identifier_list: LINKED_LIST [STRING] is
			-- List of supported interfaces
		once
			Result := Precursor
			Result.extend (interface_identifier)
		end

feature -- Message Transmission

	get_class_info: EOLE_TYPE_INFO is
			-- EOLE_TYPE_INFO interface for object's type information 
			-- Not meant to be redefined; redefine `on_get_class_info' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_provide_class_info_get_class_info (ole_interface_ptr)
		end

feature {EOLE_CALL_DISPATCHER} -- Callback

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


indexing

	description: "COM ITypeComp interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_TYPE_COMP

inherit
	EOLE_UNKNOWN
		export
			{NONE} create_ole_interface_ptr
		redefine
			interface_identifier,
			interface_identifier_list,
			is_initializable_from_eiffel
		end

	EOLE_INVOKE_KIND

creation
	make

feature -- Access

	interface_identifier: STRING is
			-- Unique interface identifier
		once
			Result := Iid_type_comp
		end

	interface_identifier_list: LINKED_LIST [STRING] is
			-- List of supported interfaces
		once
			Result := precursor
			Result.extend (Iid_type_comp)
		end

	is_initializable_from_eiffel: BOOLEAN is
			-- Does interface support Callbacks?
		once
			Result := False
		end
		
feature -- Message Transmission

	bind (name: STRING; flags: INTEGER): EOLE_BIND_RESULT is
			-- Map `name' to member of type, or bind `name' 
			-- contained in type library.
			-- See class EOLE_INVOKE_KIND for `flags' value.
		require
			valid_interface: is_valid_interface
			valid_flags: is_valid_invoke_kind (flags) or flags = 0
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (name)
			Result := ole2_typecomp_bind (ole_interface_ptr, wel_string.item, flags)
		end

	bind_type (name: STRING): EOLE_TYPE_INFO is
			-- Bind to type descriptions contained within type library.
		require
			valid_interface: is_valid_interface
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (name)
			!! Result.make
			Result.attach_ole_interface_ptr (ole2_typecomp_bind_type (ole_interface_ptr, wel_string.item))
		end


feature {NONE} -- Externals

	ole2_typecomp_bind (this, name: POINTER; flags: INTEGER): EOLE_BIND_RESULT is
		external
			"C"
		alias
			"eole2_typecomp_bind"
		end

	ole2_typecomp_bind_type (this, name: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_typecomp_bind_type"
		end
		
end -- class EOLE_TYPE_COMP

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


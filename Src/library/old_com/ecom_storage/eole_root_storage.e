indexing

	description: "COM IRootStorage interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_ROOT_STORAGE

inherit
	EOLE_UNKNOWN
		export
			{NONE}	create_ole_interface_ptr
		redefine
			interface_identifier,
			interface_identifier_list,
			is_initializable_from_eiffel
		end

creation
	make

feature -- Access

	interface_identifier: STRING is
			-- Interface identifier
		once
			Result := Iid_root_storage
		end

	interface_identifier_list: LINKED_LIST [STRING] is
			-- List of supported interfaces
		once
			Result := Precursor
			Result.extend (Iid_root_storage)
		end

	is_initializable_from_eiffel: BOOLEAN is
			-- Does interface support Callbacks?
		once
			Result := False
		end
	
feature -- Message Transmission

	switch_to_file (filename: STRING) is
			-- Copy file associated with Current to new file
			-- `filename'.
		require
			valid_filename: filename /= Void
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (filename)
			ole2_switch_to_file (ole_interface_ptr, wel_string.item)
		end
	
feature {NONE} -- Externals

	ole2_switch_to_file (this, filename: POINTER) is
		external
			"C"
		alias
			"eole2_switch_to_file"
		end
	
end -- class EOLE_ROOT_STORAGE

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


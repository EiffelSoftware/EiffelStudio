indexing

	description: "COM IEnumConnections interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_ENUM_CONNECTIONS

inherit
	EOLE_UNKNOWN
		redefine
			create_ole_interface_ptr,
			on_query_interface
		end

creation
	make
	
feature -- Element change
		
	create_ole_interface_ptr is
			--  Create associated OLE pointer.
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (Iid_enum_connections)
			ole_interface_ptr := ole2_create_interface_pointer ($Current, wel_string.item)
		end

feature -- Message Transmission

	next (count: INTEGER): ARRAY [EOLE_CONNECTDATA] is
			-- Retrieve `count' EOLE_CONNECTDATA structure(s) in enumeration sequence.
			-- Not meant to be redefined; redefine `on_next' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_enum_connections_next (ole_interface_ptr, count)
		end
		
	skip (count: INTEGER) is
			-- Skip over `count' EOLE_CONNECTDATA structure(s) in enumeration sequence.
			-- Not meant to be redefined; redefine `on_skip' instead.
		require
			valid_interface: is_valid_interface
		do
			ole2_enum_connections_skip (ole_interface_ptr, count)
		end

	reset is
			-- Reset enumeration sequence to beginning.  
			-- Not meant to be redefined; redefine `on_reset' instead.
		require
			valid_interface: is_valid_interface
		do
			ole2_enum_connections_reset (ole_interface_ptr)
		end

	ole_clone: like Current is
			-- Create a clone of Current.
		require
			valid_interface: is_valid_interface
		do
			!! Result.make
			Result.attach_ole_interface_ptr (ole2_enum_connections_clone (ole_interface_ptr))
		end
		
feature {EOLE_CALL_DISPATCHER} -- Callback

	on_query_interface (iid: STRING): POINTER is
			-- Query `iid' interface.
			-- Return Void if interface is not supported.
		do
			if iid.is_equal (Iid_enum_connections) or iid.is_equal (Iid_unknown) then
				Current.add_ref
				Result := Current.ole_interface_ptr
				set_last_hresult (S_ok)
			else
				set_last_hresult (E_nointerface)
			end
		end

	on_next (count: INTEGER): ARRAY[EOLE_CONNECTDATA] is
			-- Retrieve `count' EOLE_CONNECTDATA structure(s) in enumeration sequence.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_skip (count: INTEGER) is
			-- Skip over `count' EOLE_CONNECTDATA structure(s) in enumeration sequence.
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_reset is
			-- Reset enumeration sequence to beginning.  
			-- By default: set status code with `Eole_e_notimpl'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_clone: POINTER is
			-- Create a clone of Current.
		do
			Result := create_new_ole_interface_ptr
		end
		
feature {NONE} -- Implementation

	create_new_ole_interface_ptr: POINTER is
			-- Create a new OLE interface associated
			-- to Current.
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (Iid_enum_unknown)
			Result := ole2_create_interface_pointer ($Current, wel_string.item)
		end
				
feature {NONE} -- Externals

	ole2_enum_connections_next (ptr: POINTER; count: INTEGER): ARRAY [EOLE_CONNECTDATA] is
		external
			"C"
		alias
			"eole2_enum_connections_next"
		end
	
	ole2_enum_connections_skip (ptr: POINTER; count: INTEGER) is
		external
			"C"
		alias
			"eole2_enum_connections_skip"
		end

	ole2_enum_connections_reset (ptr: POINTER) is
		external
			"C"
		alias
			"eole2_enum_connections_reset"
		end

	ole2_enum_connections_clone (ptr: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_enum_connections_clone"
		end
		
end -- class EOLE_ENUM_CONNECTIONS

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


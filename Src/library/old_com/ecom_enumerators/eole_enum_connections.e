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
			!! wel_string.make (Iid_enum_connection_points)
			ole_interface_ptr := ole2_create_interface_pointer ($Current, wel_string.item)
		end

feature -- Message Transmission

	next (count: INTEGER): ARRAY [EOLE_CONNECTDATA] is
			-- Retrieve `count' EOLE_CONNECTDATA structure(s) in enumeration sequence.
			-- Not meant to be redefined; redefine `on_next' instead.
		require
			valid_interface: ole_interface_ptr /= default_pointer
		do
			Result := ole2_enum_connections_next (ole_interface_ptr, count)
		end
		
	skip (count: INTEGER) is
			-- Skip over `count' EOLE_CONNECTDATA structure(s) in enumeration sequence.
			-- Not meant to be redefined; redefine `on_skip' instead.
		require
			valid_interface: ole_interface_ptr /= default_pointer
		do
			ole2_enum_connections_skip (ole_interface_ptr, count)
		end

	reset is
			-- Reset enumeration sequence to beginning.  
			-- Not meant to be redefined; redefine `on_reset' instead.
		require
			valid_interface: ole_interface_ptr /= default_pointer
		do
			ole2_enum_connections_reset (ole_interface_ptr)
		end

feature {EOLE_CALL_DISPATCHER} -- Callback

	on_query_interface (iid: STRING): POINTER is
			-- Query `iid' interface.
			-- Return Void if interface is not supported.
		do
			if iid.is_equal (Iid_enum_connection_points) or iid.is_equal (Iid_unknown) then
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

end -- class EOLE_ENUM_CONNECTIONS

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

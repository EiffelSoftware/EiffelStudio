indexing

	description: "COM IConnectionPointContainer interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_CONNPT_CONTAINER

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
			!! wel_string.make (Iid_connection_point_container)
			ole_interface_ptr := ole2_create_interface_pointer ($Current, wel_string.item)
		end

feature -- Message Transmission

	enum_connection_points: EOLE_ENUM_CONNECTION_POINTS is
			-- Enumerate all connection points
			-- supported in this connectable object.
			-- Not meant to be redefined; redefine `on_enum_connection_points' instead.
		require
			valid_interface: ole_interface_ptr /= default_pointer
		do
			Result := ole2_connection_point_container_enum_connection_points (ole_interface_ptr)
		end

	find_connection_point (refiid: STRING): EOLE_CONNECTION_POINT is
			-- Request connection point outgoing interface `refiid'.
			-- Not meant to be redefined; redefine `on_find_connection_point' instead.
		require
			valid_interface: ole_interface_ptr /= default_pointer
			valid_refiid: refiid /= Void
		local
			wel_string: WEL_STRING;
		do
			!! wel_string.make (refiid)
			Result := ole2_connection_point_container_find_connection_point (ole_interface_ptr, wel_string.item)
		end
	
feature {EOLE_CALL_DISPATCHER} -- Callback

	on_query_interface (iid: STRING): POINTER is
			-- Query `iid' interface.
			-- Return Void if interface is not supported.
		do
			if iid.is_equal (Iid_connection_point_container) or iid.is_equal (Iid_unknown) then
				Current.add_ref
				Result := Current.ole_interface_ptr
				set_last_hresult (S_ok)
			else
				set_last_hresult (E_nointerface)
			end
		end

	on_enum_connection_points: EOLE_ENUM_CONNECTION_POINTS is
			-- Enumerate all connection points
			-- supported in this connectable object.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_find_connection_point (refiid: STRING): EOLE_CONNECTION_POINT is
			-- Request connection point outgoing interface `refiid'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end


feature {NONE} -- Externals

	ole2_connection_point_container_enum_connection_points (p: POINTER): EOLE_ENUM_CONNECTION_POINTS is
		external
			"C"
		alias
			"eole2_connection_point_container_enum_connection_points"
		end

	ole2_connection_point_container_find_connection_point (p: POINTER; riid: POINTER): EOLE_CONNECTION_POINT is
		external
			"C"
		alias
			"eole2_connection_point_container_find_connection_point"
		end
	
end -- class EOLE_CONNPT_CONTAINER

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

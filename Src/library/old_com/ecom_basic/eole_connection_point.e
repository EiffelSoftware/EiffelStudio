indexing

	description: "COM IConnectionPoint interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_CONNECTION_POINT

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
			Result := Iid_connection_point
		end

	interface_identifier_list: LINKED_LIST [STRING] is
			-- List of supported interfaces
		once
			Result := Precursor
			Result.extend (Iid_connection_point)
		end

feature -- Message Transmission

	advise (client_sink: EOLE_UNKNOWN): INTEGER is
			-- Create connection between connection point 
			-- and `client_sink', where `client_sink' implements the
			-- outgoing interface supported by this connection point.
			-- Result is corresponding connection token.
			-- Not meant to be redefined; redefine `on_advise' instead.
		require
			valid_interface: is_valid_interface
			valid_client_sink: client_sink /= Void and then client_sink.is_valid_interface
		do
			Result := ole2_connection_point_advise (ole_interface_ptr, client_sink.ole_interface_ptr)
		end

	unadvise (token: INTEGER) is
			-- Terminate notification with `token'
			-- previously given by `advise'.
			-- Not meant to be redefined; redefine `on_unadvise' instead.
		require
			valid_interface: is_valid_interface
		do
			ole2_connection_point_unadvise (ole_interface_ptr, token)
		end

	get_connection_interface: STRING is
			-- IID of outgoing interface
			-- Not meant to be redefined; redefine `on_get_connection_interface' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_connection_point_get_connection_interface (ole_interface_ptr)
		end

	get_connection_point_container: EOLE_CONNPT_CONTAINER is
			-- Parent (connectable) object’s 
			-- IConnectionPointContainer interface pointer
			-- Not meant to be redefined; redefine `on_get_connection_point_container' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_connection_point_get_connection_point_container (ole_interface_ptr);
		end

	enum_connections: EOLE_ENUM_CONNECTIONS is
			-- Enumerate current advisory connection
			-- Not meant to be redefined; redefine `on_enum_connections' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_connection_point_enum_connections (ole_interface_ptr);
		end
	

feature {EOLE_CALL_DISPATCHER} -- Callback

	on_advise (client_sink: EOLE_UNKNOWN): INTEGER is
			-- Create connection between connection point 
			-- and `client_sink', where `client_sink' implements the
			-- outgoing interface supported by this connection point.
			-- Result is corresponding connection token.
		do
			set_last_hresult (E_notimpl)
		end

	on_unadvise (token: INTEGER) is
			-- Terminate notification with `token'
			-- previously given by `advise'.
		do
			set_last_hresult (E_notimpl)
		end

	on_get_connection_interface: STRING is
			-- IID of outgoing interface
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_get_connection_point_container: EOLE_CONNPT_CONTAINER is
			-- Parent (connectable) object’s 
			-- IConnectionPointContainer interface pointer
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end

	on_enum_connections: EOLE_ENUM_CONNECTIONS is
			-- Enumerate current advisory connection
			-- Redefine in descendant if needed.
		do
			set_last_hresult (E_notimpl)
		end


feature {NONE} -- Externals

	ole2_connection_point_get_connection_interface (p: POINTER): STRING is
		external
			"C"
		alias
			"eole2_connection_point_get_connection_interface"
		end

	ole2_connection_point_get_connection_point_container (p: POINTER): EOLE_CONNPT_CONTAINER is
		external
			"C"
		alias
			"eole2_connection_point_get_connection_point_container"
		end

	ole2_connection_point_advise (p: POINTER; i_unknown: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_connection_point_advise"
		end

	ole2_connection_point_unadvise (p: POINTER; cookie: INTEGER) is
		external
			"C"
		alias
			"eole2_connection_point_unadvise"
		end

	ole2_connection_point_enum_connections (p: POINTER): EOLE_ENUM_CONNECTIONS is
		external
			"C"
		alias
			"eole2_connection_point_enum_connections"
		end
	
end -- class EOLE_CONNECTION_POINT

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


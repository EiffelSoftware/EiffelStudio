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
			interface_identifier,
			interface_identifier_list
		end

creation
	make
	
feature -- Access

	interface_identifier: STRING is
			-- Unique interface identifier
		once
			Result := Iid_connection_point_container
		end

	interface_identifier_list: LINKED_LIST [STRING] is
			-- List of supported interfaces
		once
			Result := precursor
			Result.extend (Iid_connection_point_container)
		end

feature -- Message Transmission

	enum_connection_points: EOLE_ENUM_CONNECTION_POINTS is
			-- Enumerate all connection points
			-- supported in this connectable object.
			-- Not meant to be redefined; redefine `on_enum_connection_points' instead.
		require
			valid_interface: is_valid_interface
		do
			Result := ole2_connection_point_container_enum_connection_points (ole_interface_ptr)
		end

	find_connection_point (refiid: STRING): EOLE_CONNECTION_POINT is
			-- Request connection point outgoing interface `refiid'.
			-- Not meant to be redefined; redefine `on_find_connection_point' instead.
		require
			valid_interface: is_valid_interface
			valid_refiid: refiid /= Void
		local
			wel_string: WEL_STRING;
		do
			!! wel_string.make (refiid)
			Result := ole2_connection_point_container_find_connection_point (ole_interface_ptr, wel_string.item)
		end
	
feature {EOLE_CALL_DISPATCHER} -- Callback

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


indexing

	description: "COM IClassFactory interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_CLASS_FACTORY

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
			-- Create associated OLE pointer.
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (iid_class_factory)
			ole_interface_ptr := ole2_create_interface_pointer ($Current, wel_string.item)
		end
		
	terminate is
			-- End server.
			-- Redefine in descendant.
		do
		end
		
feature -- Access
	
	server_locks: INTEGER
			-- Locks on server

feature -- Message Transmission.

	create_instance (controller_interface: POINTER; interface_identifier: STRING): POINTER is
			-- Create instance of class with `interface_identifier'
			-- interface, may optionally be controlled by `controller_interface'.
			-- Return Void if fails.
			-- Not meant to be redefined; redefine `on_create_instance' instead.
		require
			valid_interface: ole_interface_ptr /= default_pointer
			valid_interface_identifier: interface_identifier /= Void
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (interface_identifier)
			Result := ole2_clsfact_create_instance (ole_interface_ptr, controller_interface, wel_string.item)
		end
		
	lock_server (lock: BOOLEAN) is
			-- Keep server in memory even if not servicing when
			-- `lock' is true.
			-- Not meant to be redefined; redefine `on_lock_server' instead.
		require
			valid_interface: ole_interface_ptr /= default_pointer
		do
			ole2_clsfact_lock_server (ole_interface_ptr, lock)
		end
		
feature {EOLE_CALL_DISPATCHER} -- Callback

	on_query_interface (iid: STRING): POINTER is
			-- Query `iid' interface.
		do
			if iid.is_equal (Iid_class_factory) or iid.is_equal (Iid_unknown) then
				add_ref
				Result := ole_interface_ptr
				set_last_hresult (S_ok)
			else
				set_last_hresult (E_nointerface)
			end
		end

	on_create_instance (controller_interface: POINTER; interface_identifier: STRING): POINTER is
			-- Create an instance of an object with `interface_identifier'
			-- interface, which may optionally be controlled by
			-- `controller_interface'. Returns Void if fails.
			-- By default: set status code with `Class_e_classnotavailable'.
			-- Redefine in descendant if needed.
		do
			set_last_hresult (Class_e_classnotavailable)
		end

	on_lock_server (lock: BOOLEAN) is
			-- Keep server in memory even if not servicing when
			-- `lock' is true.
			-- By default: increment `server_locks' if `lock' is
			-- `True'; decrement `server_locks' otherwise.
			-- Redefine in descendant if needed.
		do
			if lock then
				server_locks := server_locks + 1
			else
				server_locks := server_locks - 1
				if server_locks = 0 and reference_counter = 0 then
					terminate
				end
			end
		ensure
			positive_locks: server_locks >= 0
		end
	
feature {NONE} -- Implementation

	server_locked: BOOLEAN
			-- When `True', server is locked in memory.
	
feature {NONE} -- Externals

	ole2_clsfact_create_instance (ip: POINTER; controller: POINTER; interface_identifier: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_clsfact_create_instance"
		end

	ole2_clsfact_lock_server (ip: POINTER; lock: BOOLEAN) is
		external
			"C"
		alias
			"eole2_clsfact_lock_server"
		end
	
end -- class EOLE_CLASS_FACTORY

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

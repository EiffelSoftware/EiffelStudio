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
			interface_identifier,
			interface_identifier_list,
			on_release
		end

creation
	make
			
feature -- Access

	interface_identifier: STRING is
			-- Unique interface identifier
		once
			Result := Iid_class_factory
		end

	interface_identifier_list: LINKED_LIST [STRING] is
			-- List of supported interfaces
		once
			Result := Precursor
			Result.extend (interface_identifier)
		end

	server_locks: INTEGER
			-- Locks on server

feature -- Message Transmission.

	create_instance (controller_interface: POINTER; interface_id: STRING): POINTER is
			-- Create instance of class with `interface_id'
			-- interface, may optionally be controlled by `controller_interface'.
			-- Return Void if fails.
			-- Not meant to be redefined; redefine `on_create_instance' instead.
		require
			valid_interface: is_valid_interface
			valid_interface_identifier: interface_id /= Void
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (interface_id)
			Result := ole2_clsfact_create_instance (ole_interface_ptr, controller_interface, wel_string.item)
		end
		
	lock_server (lock: BOOLEAN) is
			-- Keep server in memory even if not servicing when
			-- `lock' is true.
			-- Not meant to be redefined; redefine `on_lock_server' instead.
		require
			valid_interface: is_valid_interface
		do
			ole2_clsfact_lock_server (ole_interface_ptr, lock)
		end
		
feature {EOLE_CALL_DISPATCHER} -- Callback

	on_create_instance (controller_interface: POINTER; interface_id: STRING): POINTER is
			-- Create an instance of an object with `interface_id'
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
	
	on_release: INTEGER is
			-- By default: Decrement counter.
			-- Destroy associated C++ interface
			-- if reference counter = 0 and server lock counter = 0.
			-- Redefine in descendant if needed.
		do
			reference_counter := reference_counter - 1
			if reference_counter = 0  and server_locks = 0 then
				detach_ole_interface_ptr
			end
			Result := reference_counter
		end

feature {NONE} -- Implementation

	terminate is
			-- End server.
			-- redefine in descendant if needed.
		do
			detach_ole_interface_ptr
		end

	server_locked: BOOLEAN
			-- When `True', server is locked in memory.
	
feature {NONE} -- Externals

	ole2_clsfact_create_instance (ip: POINTER; controller: POINTER; interface_id: POINTER): POINTER is
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


indexing

	description: "COM Automation server"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EOLE_AUTOMATION_SERVER
	
inherit
	ARGUMENTS
	
	EOLE_COM
		rename
			status as co_status,
			make as co_make
		export
			{NONE} all
		end

	EOLE_CLSCTX
	
	WEL_SW_CONSTANTS
		export
			{NONE} all
		end
		
	WEL_APPLICATION
		rename
			make as wel_appl_make,
			run as wel_appl_run
		redefine
			default_show_command
		end
	
	EOLE_AUTOMATION_SERVER_CLASS_FACTORY
		export
			{NONE} all
		redefine
			dispatch_interface,
			terminate
		end
	
feature -- Initialization

	init is
			-- Initialize server.
		local
			exception: EXCEPTIONS
		do
			default_show_cmd := Sw_shownormal
			if argument_count /= 0 then
				if argument (1).is_equal ("-Embedding") or argument (1).is_equal ("/Embedding") then
					default_show_cmd := Sw_hide
					run
				elseif argument (1).is_equal ("-RegServer") or argument (1).is_equal ("/Regserver") then
					register_server
				elseif argument (1).is_equal ("-UnregServer") or argument (1).is_equal ("/UnregServer") then
					unregister_server
				else
					!! exception
					exception.raise ("Unknown argument")
				end
			else
				run
			end
		end
		
feature -- Access

	main_window: AUTOMATION_SERVER_MAIN_WINDOW is
			-- Server main window
		deferred
		end
		
	dispatch_interface: EOLE_DISPATCH is
			-- Dispatch interface
		deferred
		end
		
	class_identifier: STRING is
			-- Class identifier
		deferred
		ensure
			valid_class_identifier: Result /= Void and then is_valid_guid (Result)
		end
		
	context: INTEGER is
			-- Associated class context
			-- See EOLE_CLSCTX for `Result' value.
		deferred
		ensure
			valid_clsctx: is_valid_clsctx (Result)
		end
	
	register_flags: INTEGER is
			-- Register flags
			-- See EOLE_REGISTER_FLAGS for `Result' value.
		deferred
		ensure
			valid_register_flags: is_valid_register_flag (Result)
		end
		
	default_show_command: INTEGER is
			-- Default command used to show `main_window':
			-- hidden if server has been called with switch
			-- 'Embedding', shown otherwise.
		once
			Result := default_show_cmd
		end
		
	token: INTEGER
			-- Object identifier given by `co_register_class_object'
	
	ole_dispatcher: EOLE_CALL_DISPATCHER
			-- C - Eiffel dispatcher
		
feature -- Element Change

	register_server is
			-- Register server
		deferred
		end
		
	unregister_server is
			-- Unregister server
		deferred
		end

	run is
			-- Launch server.
		local
			exception: EXCEPTIONS
		do
			make
			!! ole_dispatcher.make
			add_ref
			if ole_initialize /= S_ok then
				exception.raise ("Could not initialize OLE")
			end
			token := co_register_class_object (class_identifier, Current, context, register_flags)
			if status.succeeded then
				wel_appl_make
			else
				!! exception
				exception.raise ("Could not initialize server")
			end
			terminate
		end
		
	terminate is
			-- End use of server
		local
			revoke_exception: EXCEPTIONS
			ref_counter: INTEGER
		do
			co_revoke_class_object (token)
			if not status.succeeded then
				revoke_exception.raise ("co_revoke_class_object error")
			end
			dispatch_interface.release
			release
		end
	
feature {NONE} -- Implementation

	default_show_cmd: INTEGER
			-- Default command used to show `main_window':
			-- hidden if server has been called with switch
			-- 'Embedding', shown otherwise.
			
end -- class EOLE_AUTOMATION_SERVER

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


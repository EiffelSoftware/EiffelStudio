indexing
	description: "Automation server"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ANALYZER_SERVER

inherit
	EOLE_AUTOMATION_SERVER
	
	EXECUTION_ENVIRONMENT
		rename
			command_line as exec_command_line
		export
			{NONE} all
		end

	WEL_REGISTRY
		export
			{NONE} all
		end
		
	ANALYZER_CLSID
		export
			{NONE} all
		end
		
	WEL_HKEY
		export
			{NONE} all
		end

	WEL_REGISTRY_ACCESS_MODE
		export
			{NONE} all
		end

	WEL_REGISTRY_KEY_VALUE_TYPE
		export
			{NONE} all
		end

creation
	init

feature -- Access

	main_window: MAIN_WINDOW is
			-- Server main window
		once
			!! Result.make
		end
		
	dispatch_interface: ANALYZER_DISPATCH is
		local
			ref_counter: INTEGER
		once
			!! Result.make (Current)
			Result.add_ref
		end
		
	class_identifier: STRING is
			-- Class identifier
		do
			Result := Analyzer_clsid
		end
		
	context: INTEGER is
			-- Associated class context
			-- See EOLE_CLSCTX for `Result value'
		do
			Result := Clsctx_local_server
		end
		
	register_flags: INTEGER is
			-- Register flags
			-- See EOLE_REGISTER_FLAGS for `Result' value
		do
			Result := Regcls_singleuse
		end

feature -- Element Change

	register_server is
			-- Register server.
			-- Must be run from directory were server is installed.
		local
			key, subkey: INTEGER
			key_name, path_to_server: STRING
			key_val: WEL_REGISTRY_KEY_VALUE
		do
			!! key_name.make (38)
			key_name.append ("CLSID\")
			key_name.append (Analyzer_clsid)
			key := create_key (Hkey_classes_root, key_name, Key_set_value)
			if is_new_key then
				!! key_val.make
				key_val.set_type (Reg_sz)
				key_val.set_string_value ("Analyzer server")
				set_key_value (key, Void, key_val)
				subkey := create_key (key, "LocalServer32", Key_set_value)
				!! path_to_server.make (200)
				path_to_server.append (current_working_directory)
				path_to_server.append ("\analyzer_server.exe")
				key_val.set_string_value (path_to_server)
				set_key_value (subkey, Void, key_val)
				close_key (subkey)
				subkey := create_key (key, "ProgID", Key_set_value)
				key_val.set_string_value ("Analyzer server 1.0")
				set_key_value (subkey, Void, key_val)
				close_key (subkey)
				subkey := create_key (key, "VersionIndependentProgID", Key_set_value)
				key_val.set_string_value ("Analyzer server")
				set_key_value (subkey, Void, key_val)
				close_key (subkey)
				close_key (key)
				key_val.destroy
			end
		end
		
	unregister_server is
			-- Unregister server
		local
			msg_box: WEL_MSG_BOX
			key, subkey: INTEGER
			key_name: STRING
		do
			!! key_name.make (38)
			key_name.append ("CLSID\")
			key := open_key (Hkey_classes_root, key_name, Key_set_value)
			key_name.append (Analyzer_clsid)
			subkey := open_key (Hkey_classes_root, key_name, Key_set_value)
			if subkey /= 0 then
				if not (
					delete_key (subkey, "VersionIndependentProgID") and
					delete_key (subkey, "ProgID") and 
					delete_key (subkey, "LocalServer32"))
				then
					!! msg_box.make
					msg_box.error_message_box (Void, "Could not delete registry keys", "Uninstall Error")
				else
					close_key (subkey)
					if not delete_key (key, Analyzer_clsid) then
						!! msg_box.make
						msg_box.error_message_box (Void, "Unexpected error", "Uninstall Error")
					end
				end
			end
			close_key (key)
		end
		
end -- class ANALYZER_SERVER

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
indexing
	description	: "Objects that map a networking path to a local drive"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_UNC_PATH_MAPPER

inherit
	WEL_NETWORKING_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_path: STRING) is
			-- Map the networking path `a_path' to a temporary path
		local
			net_resource: WEL_NET_RESOURCE
			null_pointer: POINTER
			access_name_str: WEL_STRING
			buffer_size: INTEGER
			result_info: INTEGER
			result_func: INTEGER
		do
			create net_resource.make
			net_resource.set_scope (Resource_globalnet)
			net_resource.set_type (Resource_type_disk)
			net_resource.set_display_type (Resource_display_type_generic)
			net_resource.set_usage (Resource_usage_connectable)
			net_resource.set_remote_name (a_path)
			
			buffer_size := Max_path
			create access_name_str.make_empty (buffer_size + 1)
			
			result_func := cwin_wnet_use_connection (
				null_pointer,  		-- Owner window
				net_resource.item,	-- Connection details
				null_pointer,		-- User
				null_pointer,		-- Password
				Connect_interactive | Connect_redirect,
				access_name_str.item,
				$buffer_size,
				$result_info)
			
			if result_func = 0 and then result_info = Connect_localdrive then
				access_name := access_name_str.string
			end
		end
		
feature -- Access
	
	access_name: STRING
			-- Local access to the mapped path.
			-- Example: "I:"
		
feature -- Removal
	
	destroy is
			-- Unmap the network path
		local
			result_func: INTEGER
			access_name_str: WEL_STRING
		do
			if access_name /= Void then
				create access_name_str.make (access_name)
				result_func := cwin_wnet_cancel_connection2 (access_name_str.item, 0, True)
				access_name := Void
			end
		end
	
feature {NONE} -- Externals

	cwin_wnet_use_connection (hwnd_owner: POINTER; net_resource: POINTER;
		user: POINTER; password: POINTER; flags: INTEGER; access_name_ptr: POINTER;
		buffer_size: POINTER; result_info: POINTER): INTEGER is
			-- SDK WNetUseConnection (with the result)
		local
			first_id: POINTER
			second_id: POINTER
		do
			if (create {WEL_WINDOWS_VERSION}).is_windows_NT then
				first_id := password
				second_id := user
			else
				first_id := user
				second_id := password
			end
			
			Result := cwin_internal_wnet_use_connection (hwnd_owner, net_resource, 
				first_id, second_id, flags, access_name_ptr, buffer_size, 
				result_info)
		end
		
	cwin_internal_wnet_use_connection (hwnd_owner: POINTER; net_resource: POINTER; 
		user_nt_or_password_9x: POINTER; password_nt_or_user_9x: POINTER; 
		flags: INTEGER; access_name_ptr: POINTER; buffer_size: POINTER; 
		result_info: POINTER): INTEGER is
			-- SDK WNetUseConnection (with the result)
			--
			-- Note: Windows 9x/Me: The lpUserID and lpPassword parameters are in
			--       reverse order from the order used on Windows NT/2000/XP.
		external
			"C [macro <Winnetwk.h>] (HWND, LPNETRESOURCE, %
				%LPCTSTR, LPCTSTR, DWORD, LPTSTR, LPDWORD, %
				%LPDWORD): DWORD"
		alias
			"WNetUseConnection"
		end

	cwin_wnet_cancel_connection2 (resource_name: POINTER; flags: INTEGER; force: BOOLEAN): INTEGER is
			-- SDK WNetCancelConnection2 (with the result)
		external
			"C [macro <Winnetwk.h>] (LPCTSTR, DWORD, BOOL): DWORD"
		alias
			"WNetCancelConnection2"
		end
		
end -- class WEL_UNC_PATH_MAPPER

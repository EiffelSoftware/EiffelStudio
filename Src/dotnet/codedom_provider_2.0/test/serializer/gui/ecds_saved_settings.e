note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECDS_SAVED_SETTINGS

inherit
	CODE_SETTINGS_MANAGER
		rename
			make as manager_make
		end

	ECDS_REGISTRY_KEYS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize settings manager.
		do
			manager_make (Serializer_hive_path)
			Default_values.put (50, X_key)
			Default_values.put (50, Y_key)
		end
		
feature -- Access

	start_destination_folder_path: STRING
			-- Destination folder default path
		do
			Result := text_setting (Start_destination_folder_path_key)
		end

	wsdl_start_directory: STRING
			-- WSDL file start directory
		do
			Result := text_setting (Wsdl_start_directory_key)
		end

	last_file_title: STRING
			-- Last serialized codedom tree file title
		do
			Result := text_setting (Last_file_title_key)
		end

	last_wsdl_url: STRING
			-- Last WSDL URL
		do
			Result := text_setting (Last_wsdl_url_key)
		end

	last_aspnet_url: STRING
			-- Last ASP.NET URL
		do
			Result := text_setting (Last_aspnet_url_key)
		end

	saved_x: INTEGER
			-- Saved starting x
		do
			Result := setting (X_key)
		end
		
	saved_y: INTEGER
			-- Saved starting y
		do
			Result := setting (Y_key)
		end
		
feature -- Basic Implementation

	set_start_destination_folder_path (a_path: STRING)
			-- Set `start_destination_folder_path' with `a_path'.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		do
			set_text_setting (Start_destination_folder_path_key, a_path)
		end
		
	set_wsdl_start_directory (a_path: STRING)
			-- Set `wsdl_start_directory' with `a_path'.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		do
			set_text_setting (Wsdl_start_directory_key, a_path)
		end
		
	set_last_file_title (a_title: STRING)
			-- Set `last_file_title' with `a_title'.
		require
			non_void_title: a_title /= Void
			valid_title: not a_title.is_empty
		do
			set_text_setting (Last_file_title_key, a_title)
		end
	
	set_last_wsdl_url (a_url: STRING)
			-- Set `last_wsdl_url' with `a_url'.
		require
			non_void_url: a_url /= Void
			valid_url: not a_url.is_empty
		do
			set_text_setting (Last_wsdl_url_key, a_url)
		end

	set_last_aspnet_url (a_url: STRING)
			-- Set `last_aspnet_url' with `a_url'.
		require
			non_void_url: a_url /= Void
			valid_url: not a_url.is_empty
		do
			set_text_setting (Last_aspnet_url_key, a_url)
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class ECDS_SAVED_SETTINGS


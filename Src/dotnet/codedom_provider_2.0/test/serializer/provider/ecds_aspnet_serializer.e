indexing
	description: "ASP.NET codedom tree serializer"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDS_ASPNET_SERIALIZER

inherit
	ECDS_SERIALIZER
		rename
			make as serializer_make
		end

create
	make

feature {NONE} -- Initialization

	make (a_dest_dir, a_file_title, a_url: STRING) is
			-- Initialize instance.
		require
			non_void_destination_directory: a_dest_dir /= Void
			valid_destination_Directory: not a_dest_dir.is_empty
			non_void_file_title: a_file_title /= Void
			valid_file_title: not a_file_title.is_empty
			non_void_url: a_url /= Void
			valid_url: not a_url.is_empty
		do
			serializer_make (a_dest_dir, a_file_title)
			url := a_url
		ensure
			destination_directory_set: destination_directory = a_dest_dir
			file_title_set: file_title = a_file_title
			url_set: url = a_url
		end

feature -- Access

	url: STRING
			-- Web page URL

feature -- Basic Operation

	serialize is
			-- Serialize codedom tree.
		local
			l_process: SYSTEM_DLL_PROCESS
			l_path: STRING
		do
			l_path := (create {EXECUTION_ENVIRONMENT}).get ("SYSTEMDRIVE")
			if l_path = Void then
				last_error_message := "Could not find system drive."
			else
				l_path.append ("\Program Files\Internet Explorer\iexplore.exe")
				if {SYSTEM_FILE}.exists (l_path) then
					create l_process.make
					change_provider
					l_process := {SYSTEM_DLL_PROCESS}.start (l_path, url)
					wait_for_file
					if last_serialization_successful then
						l_process.kill
					end
					restore_provider
				else
					last_error_message := "Could not find internet explorer at " + l_path
				end
			end
		end

feature {NONE} -- Implementation

	change_provider is
			-- Replace codedom provider with serializer's provider
			-- and save previous provider information.
		local
			l_config: CODE_MACHINE_CONFIGURATION
		do
			create l_config.make
			saved_provider := l_config.language_provider (Eiffel_language)
			if saved_provider = Void then
				saved_provider := No_provider
				saved_extension := ".es"
			else
				saved_extension := l_config.language_extension (Eiffel_language)
				l_config.remove_compiler_entry (Eiffel_language)
			end
			l_config.add_compiler_entry (Eiffel_language, saved_extension, (create {ECDS_PROVIDER}).get_type.assembly_qualified_name)
			provider_changed := True
		ensure
			provider_changed: provider_changed
		end

	restore_provider is
			-- Restore previous provider information
		require
			provider_changed: provider_changed
		local
			l_config: CODE_MACHINE_CONFIGURATION
		do
			create l_config.make
			l_config.remove_compiler_entry (Eiffel_language)
			if not saved_provider.is_equal (No_provider) then
				l_config.add_compiler_entry (Eiffel_language, saved_extension, saved_provider)
			end
			provider_changed := False
		ensure
			provider_restored: not provider_changed
		end

	saved_provider: STRING
			-- Saved Eiffel codedom provider type fully qualified name

	saved_extension: STRING
			-- Saved Eiffel language file extension

	No_provider: STRING is ""
			-- No provider was previously associated with Eiffel

	Eiffel_language: STRING is "Eiffel"
			-- Eiffel language name

	file_extension: STRING is ".ecda"
			-- Serialized codedom tree extension

invariant
	valid_saved_provider: provider_changed implies saved_provider /= Void
	valid_saved_extension: provider_changed implies saved_extension /= Void

end -- class ECDS_SERIALIZER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Serializer
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------

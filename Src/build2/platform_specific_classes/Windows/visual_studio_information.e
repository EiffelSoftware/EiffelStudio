indexing
	description: "Objects that provide information about VisualStudio installation."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VISUAL_STUDIO_INFORMATION

feature -- Access

	wizard_installation_path: STRING  is
			-- Result is path of installation directory on local machine which
			-- contains the Wizards directory.
		require
			visual_studio_wizard: is_visual_studio_wizard
		local
			reg: WEL_REGISTRY
			p: POINTER
			key: WEL_REGISTRY_KEY_VALUE
		do
			create reg
			p := reg.open_key_with_access ("hkey_local_machine\SOFTWARE\Microsoft\VisualStudio\7.0\Setup\Eiffel", feature {WEL_REGISTRY_ACCESS_MODE}.key_all_access)
			if p /= default_pointer then
				key := reg.key_value (p, "ProductDir")
				reg.close_key (p)
			end
			if key /= Void then
				Result := key.string_value
			end
		ensure
			Result_exists: Result /= Void and not Result.is_empty
		end
		
	is_visual_studio_wizard: BOOLEAN is
			-- Has Build been launched from
			-- VisualStudio in Wizard mode?
			-- This is a Once, as it will
			-- never change during the execution of
			-- the system.
		local
			shared_system_status: GB_SHARED_SYSTEM_STATUS
		once
			create shared_system_status
			if shared_system_status.system_status.is_wizard_system then
				Result := True
			end
		end
		
	visual_studio_pixmap_location: STRING is
			-- `Result' is location to icons used by Build.
			-- We only need the location to the icons, as
			-- none of the PNG's are needed in VisualStudio mode
			-- as we are always on Windows.
		require
			visual_studio_wizard: is_visual_studio_wizard
		local
			visual_studio_information: VISUAL_STUDIO_INFORMATION
			pixmap_file_location: FILE_NAME
		once
			create Result.make_from_string (wizard_installation_path)
			Result := Result + "\Wizards\Build\bitmaps\ico"
		ensure
			Result_exists: Result /= Void and not Result.is_empty
		end

end -- class VISUAL_STUDIO_INFORMATION

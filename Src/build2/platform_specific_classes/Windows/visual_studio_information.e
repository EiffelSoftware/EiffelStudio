indexing
	description: "Objects that provide information about VisualStudio installation."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VISUAL_STUDIO_INFORMATION

inherit
	EXECUTION_ENVIRONMENT
	
feature -- Access

	wizard_installation_path: STRING  is
			-- Result is path of installation directory on local machine which
			-- contains the Wizards directory.
		require
			visual_studio_wizard: is_visual_studio_wizard
		do
			Result := command_line.argument_array @ 1
		ensure
			Result_exists: Result /= Void and not Result.is_empty
		end
		
	is_visual_studio_wizard: BOOLEAN is
			-- Has Build been launched from	
			-- VisualStudio in Wizard mode?
		local
			shared_system_status: GB_SHARED_SYSTEM_STATUS
		do
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
		once
			create Result.make_from_string (wizard_installation_path)
			Result := Result + "\bitmaps\ico"
		ensure
			Result_exists: Result /= Void and not Result.is_empty
		end
		
	clr_version: STRING
		-- Version of clr used in generated ace files.

feature -- Satus setting

	set_clr_version (a_version: STRING) is
			-- Assign `a_version' to `clr_version'.
		require
			a_version /= Void
		do
			clr_version := a_version
		end

end -- class VISUAL_STUDIO_INFORMATION

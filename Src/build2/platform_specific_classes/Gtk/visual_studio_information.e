indexing
	description: "Objects that provide information about VisualStudio installation.%
		%As this is the Gtk version, will do nothing, but included for compilation."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VISUAL_STUDIO_INFORMATION

feature -- Access

	wizard_installation_path: STRING  is
			-- Result is path of installation directory on local machine which
			-- contains the Wizards directory.
		do
			check
				not_applicable: FALSE
			end
		end
		
	is_visual_studio_wizard: BOOLEAN is
			-- Has Build been launched from
			-- VisualStudio in Wizard mode?
			-- This is a Once, as it will
			-- never change during the execution of
			-- the system.
		once
			-- Cannot be a visual studio wizard, as
			-- we are running on Linux.
			Result := False
		end
		
	visual_studio_pixmap_location: STRING is
			-- `Result' is location to icons used by Build.
			-- We only need the location to the icons, as
			-- none of the PNG's are needed in VisualStudio mode
			-- as we are always on Windows.
		once
			check
				not_applicable: FALSE
			end
		end

end -- class VISUAL_STUDIO_INFORMATION

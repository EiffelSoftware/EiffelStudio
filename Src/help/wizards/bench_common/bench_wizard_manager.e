indexing
	description	: "Class which is launching the application."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	BENCH_WIZARD_MANAGER

inherit
	WIZARD_PROJECT_MANAGER
		redefine
			prepare
		end

feature -- Initialization

	prepare is
			-- Prepare the first window to be displayed.
		local
			icon_pixmap: EV_PIXMAP
			wizard_icon_filename: FILE_NAME
			retried: BOOLEAN
		do
			if not retried then
				Precursor
				
				create icon_pixmap
				wizard_icon_filename := clone (wizard_pixmaps_path)
				wizard_icon_filename.set_file_name ("wizard")
				wizard_icon_filename.add_extension ("png")
				icon_pixmap.set_with_named_file (wizard_icon_filename)
				first_window.set_icon_pixmap (icon_pixmap)
			end
		rescue
			retried := True
			retry
		end

end -- class WIZARD_MANAGER

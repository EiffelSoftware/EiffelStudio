note
	description: "Summary description for {WIZARD_LAYOUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_LAYOUT

inherit
	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make (d: like wizard_location; cb: like callback_file_location)
		do
			wizard_location := d.absolute_path
			callback_file_location := cb.absolute_path
		end

feature -- Access

	wizard_location: PATH

	resources_location: PATH
		do
			Result := wizard_location.extended ("resources")
		end

	pixmaps_location: PATH
		do
			Result := wizard_location.extended ("pixmaps")
		end

	templates_location: PATH
		do
			Result := wizard_location.extended ("templates")
		end

	resource_location (a_name: READABLE_STRING_GENERAL): PATH
		do
			Result := resources_location.extended (a_name)
		end

	pixmap_png_location (a_name: READABLE_STRING_GENERAL): PATH
		do
			Result := pixmaps_location.extended (a_name).appended_with_extension ("png")
		end

	callback_file_location: PATH

	default_projects_location: PATH
		do
			if attached execution_environment.item ("ISE_PROJECTS") as dn then
				create Result.make_from_string (dn)
			else
				Result := execution_environment.current_working_path
			end
		end

end

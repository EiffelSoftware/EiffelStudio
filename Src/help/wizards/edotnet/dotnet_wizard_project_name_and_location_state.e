indexing
	description	: "Second state of the dotnet wizard"

class
	DOTNET_WIZARD_PROJECT_NAME_AND_LOCATION_STATE

inherit
	WIZARD_PROJECT_NAME_AND_LOCATION_STATE
		redefine
			make
		end
		
create
	make

feature {NONE} -- Initialization

	make (an_info: like wizard_information) is
			-- Set `help_filename' with `h_filename'.
		do
			set_help_filename (h_filename)
			Precursor {WIZARD_PROJECT_NAME_AND_LOCATION_STATE} (an_info)
		end
		
feature -- Access

	h_filename: STRING is "help\wizards\edotnet\docs\reference\10_project_name_and_location\index.html"
			-- Path to HTML help file
			
end -- class DOTNET_WIZARD_PROJECT_NAME_AND_LOCATION_STATE


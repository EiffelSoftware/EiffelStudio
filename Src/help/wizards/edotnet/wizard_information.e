indexing
	description	: "All information about the wizard ... This class is inherited in each state "
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_INFORMATION

inherit
	BENCH_WIZARD_INFORMATION
		redefine
			make
		end

create
	make

feature  -- Initialization

	make is
			-- Assign default values
		do
			Precursor
			icon_location := wizard_resources_path + "\eiffel.ico"
			generate_dll := False
		end

feature -- Setting

	set_icon_location (new_value: STRING) is
			-- Set `icon_location' to `new_value'
		do
			icon_location := new_value
		end
		
	set_generate_dll (new_value: BOOLEAN) is
			-- Set `generate_dll' to `new_value'
		do
			generate_dll := new_value
		end

feature -- Access

	icon_location: STRING
			-- Location of the icon choose by the user
			
	generate_dll: BOOLEAN
			-- Should the compiler generate a DLL?
			-- If set to False, generate an EXE.
	
end -- class WIZARD_INFORMATION

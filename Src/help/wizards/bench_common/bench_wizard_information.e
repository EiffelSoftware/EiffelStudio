indexing
	description	: "All information about the wizard ... This class is inherited in each state "
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	BENCH_WIZARD_INFORMATION

inherit
	WIZARD_SHARED

creation
	make

feature {NONE} -- Initialization

	make is
			-- Assign default values
		do
			project_location := "C:\projects\my_project"
			compile_project := True
			project_name := "my_project"
			ace_location := ""
		end

feature -- Setting

	set_project_location (a_location: STRING) is
			-- Set the project location to `a_location'.
		do
			project_location := a_location
		end

	set_project_name (a_project_name: STRING) is
			-- Set the project name to `a_project_name'.
		do
			project_name := a_project_name
		end

	set_compile_project (enable_compilation: BOOLEAN) is
			-- Enable or disable the compilation of the project depending on
			-- `enable_compilation'.
		do
			compile_project := enable_compilation
		end

	set_ace_location (an_ace_location: STRING) is
			-- Set the location of the ace file to `an_ace_location'.
		do
			ace_location := an_ace_location
		end

feature -- Access

	project_location: STRING
			-- Location of the generated code.

	ace_location: STRING
			-- Location of the ace file.

	project_name: STRING
			-- Name of the project.

	compile_project: BOOLEAN
			-- Should the project be compiled upon generation?

end -- class BENCH_WIZARD_INFORMATION

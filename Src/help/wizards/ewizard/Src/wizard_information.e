indexing
	description: "All information about the wizard ... This class is inherited in each state "
	author: "davids"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INFORMATION

Creation
	make

feature  -- Initialization

	make is
		do
			location := "C:\MyProjects\"
			compile_project := True
			number_state := 1
			wizard_name := "my_wizard"
		end

feature -- Access

	compile_project: BOOLEAN
			-- Does the user want to compile the project at the end of the generation

	number_state: INTEGER
			-- Number of states in the wizard

	location: STRING
			-- Location of the generated code

	wizard_name: STRING

feature -- Element change

	set_compile_project (b: BOOLEAN) is
		do
			compile_project := b
		end

	set_number_state (i: INTEGER) is
		do
			number_state:= i
		end

	set_location (s: STRING) is
		do
			location := s
		end

	set_wizard_name (s: STRING) is
		do
			wizard_name := s
		end

end -- class WIZARD_INFORMATION

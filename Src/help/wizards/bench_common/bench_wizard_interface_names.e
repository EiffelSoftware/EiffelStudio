indexing
	description: "All string constants used in the Bench wizards"
	date: "$Date$"
	revision: "$Revision$"

class
	BENCH_WIZARD_INTERFACE_NAMES

feature -- Project name and Location state

	t_Project_name_and_location_state: STRING is "Project Name and Project location"

	st_Project_name_and_location_state: STRING is 
		"You can choose the name of the project and%N%
		%the directory where the project will be generated."
		
	m_Project_name_and_location_state: STRING is 
		"Please fill in:%N%
		%%T The name of the project (without spaces).%N%
		%%T The directory where you want the Eiffel classes to be generated."
			
	l_Project_name: STRING is "Project name"
	
	l_Project_location: STRING is "Project location"
	
	l_Compile_project: STRING is "Compile the generated project"
	
feature -- Project name error state

	t_Project_name_error_state: STRING is "Project Name Error"
	
	m_Project_name_error_state: STRING is 
		"The project name that you have specified does not conform%N%
		%to the Lace specification.%N%
		%%N%
		%A valid project name is not empty and only contains letters,%N%
		%digits, and underscores. Moreover the first character must%N%
		%be a letter.%N%
		%%N%
		%Click Back and choose a valid project name."

feature -- Location error state

	t_Location_state: STRING is "Location Error"
	
	m_Location_state: STRING is 
		"The directory you have choosen doesn't exist and%N%
		%the Wizard cannot create it.%N%
		%%N%
		%Click Back and choose another directory."

end -- class BENCH_WIZARD_INTERFACE_NAMES

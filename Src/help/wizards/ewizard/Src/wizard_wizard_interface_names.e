indexing
	description: "All string constants used in the Wizard wizard"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WIZARD_INTERFACE_NAMES

feature -- Initial state

	t_Initial_state: STRING is
		"Welcome to the New Wizard%NApplication Wizard"
		
	m_Initial_state: STRING is
		"Using this wizard you can create a Wizard application%N%
		%%N%
		%You will have to choose how many states should be in%N%
		%your wizard.%N%
		%Then all the useful classes will be generated, and you will%N%
		%just have to fill in the WIZARD_xxxx_STATE classes.%N%
		%%N%
		%%N%
		%To continue, click Next."
		
feature -- Second state

	t_Second_state: STRING is "Number of States"
		
	st_Second_state: STRING is "You can choose the number of states your wizard will have."
	
	m_Second_state: STRING is "The number of states is limited to 10."
	
	l_Number_of_state1: STRING is "Generate a wizard with "
		
	l_Number_of_state2: STRING is " states."
	
feature -- Final state

	t_Final_state: STRING is "Completing the New Wizard %NApplication Wizard"
	
	m_Final_state (compile_project: BOOLEAN; project_name: STRING; project_location: STRING): STRING is
		local
			word: STRING
		do
			if compile_project then
				word := "and compile "
			else
				word := ""
			end
			Result := "You have specified the following settings:%N%
				%%N%
				%Project name: %T" + project_name + "%N%
				%Location:     %T" + project_location + "%N%
				%%N%
				%%N%
				%Click Finish to generate " + word + "this project"
		end
		

end -- class WIZARD_WIZARD_INTERFACE_NAMES

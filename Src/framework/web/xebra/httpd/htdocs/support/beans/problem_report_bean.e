note
	description: "Summary description for {LOGIN_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROBLEM_REPORT_BEAN

create
	make

feature -- Initialization

	make
		do
			release := ""
		end

		
	release: STRING assign set_release
	
	set_release (a_release: STRING)
		do
			release := a_release
		end
		
	to_reproduce_text: STRING assign set_to_reproduce_text
	
	set_to_reproduce_text (a_to_reproduce_text: STRING)
		do
			to_reproduce_text := a_to_reproduce_text
		end
		
	description_text: STRING assign set_description_text
	
	set_description_text (a_description_text: STRING)
		do
			description_text := a_description_text
		end

	environment_text: STRING assign set_environment_text
	
	set_environment_text (a_environment_text: STRING)
		do
			environment_text := a_environment_text
		end

end

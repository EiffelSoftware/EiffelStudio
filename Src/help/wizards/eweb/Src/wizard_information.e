indexing
	description: "All information about the wizard ... "
	author: "davids"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INFORMATION

Creation
	make

feature {WIZARD_WINDOW} -- Initialization
	make is
		do
			Create list_of_html_pages.make
			generation_location:= ""
			project_location:= ""
		end

feature -- Setting

	set_project_location (a_location: STRING) is
		do
			project_location:= a_location
		end

	set_generation_location (a_location: STRING) is
		do
			generation_location:= a_location
		end

	set_new_project is
		do
			is_new_project := TRUE
		end

	is_new_project: BOOLEAN

	project_location: STRING

	generation_location: STRING

	list_of_html_pages: LINKED_LIST [STRING]

end -- class WIZARD_INFORMATION

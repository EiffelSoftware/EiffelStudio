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

	set_project_location (a_loc: STRING) is
		require
			not_void: a_loc /= Void
		do
			project_location:= a_loc
		ensure
			set: project_location = a_loc
		end

	set_generation_location (a_location: STRING) is
		require
			not_void: a_location /= Void
		do
			generation_location:= a_location
		ensure
			set: generation_location = a_location
		end

	set_new_project is
		do
			is_new_project := TRUE
		ensure
			is_new_project
		end

	set_files(li: LINKED_LIST[STRING]) is
		require
			list_exists: li /= Void
		do
			list_of_html_pages := li
		ensure
			set: li = list_of_html_pages
		end

feature -- Access

	is_new_project: BOOLEAN

	project_location: STRING

	generation_location: STRING

	list_of_html_pages: LINKED_LIST [STRING]

end -- class WIZARD_INFORMATION

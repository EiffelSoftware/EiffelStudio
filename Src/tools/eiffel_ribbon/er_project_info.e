note
	description: "[
					Users project info
					It will be saved and loaded during sessions
																	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_PROJECT_INFO

feature -- Query

	project_location: detachable STRING
			--

feature -- Command

	set_project_location (a_location: like project_location)
			--
		do
			project_location := a_location
		ensure
			set: project_location = a_location
		end

end

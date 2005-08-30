indexing
	description: "[
			Shared access to compliance project settings.
		]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_SHARED_PROJECT

feature -- Access
	
	project: EC_PROJECT_SETTINGS assign set_project is
			-- Compliance project.
		do
			Result := internal_project_settings.item
		ensure
			result_not_void: Result /= Void
		end
		
feature -- Element change

	set_project (a_project: like project) is
			-- Set `project' to `a_project'.
		require
			a_project_not_void: a_project /= Void
		do
			internal_project_settings.put (a_project)
		ensure
			project_assigned: project = a_project
		end

feature {NONE} -- Implementation

	internal_project_settings: CELL [EC_PROJECT_SETTINGS] is
			-- Cache project settings.
		once
			create Result
			Result.put (create {EC_PROJECT_SETTINGS}.make_empty)
		ensure
			result_not_void: Result /= Void
			result_item_not_void: Result.item /= Void
		end

end -- class EC_SHARED_PROJECT

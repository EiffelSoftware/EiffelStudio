indexing
	description: "$EiffelGraphicalCompiler$ resources, with access facilities"
	author: "Pascal Freund and Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_RECENT_PROJECTS

inherit
	EIFFEL_ENV

feature -- Access

	lop_resource: RESOURCE_STRUCTURE is
			-- Resources specified by the user
		once
			create Result
			Result.register_basic_types
			Result.make_from_location (default_file_name, Eiffel_recent_projects)
		end

feature -- Access

	last_opened_projects: ARRAY [STRING] is
		local
			r: ARRAY_RESOURCE
		do
			r ?= lop_resource.item (last_opened_projects_resource_name)
			if r /= Void then
				Result := r.actual_value
			else
				Result := <<>>
			end
		end

feature -- Saving

	save_last_opened_projects (new_value: ARRAY [STRING]) is
		local
			r: ARRAY_RESOURCE
		do
			r ?= lop_resource.item (last_opened_projects_resource_name)
			if r /= Void then
				r.set_actual_value (new_value)
			else
				create r.make (last_opened_projects_resource_name, new_value,
					Lop_resource.registered_types @ Lop_resource.Array_type_index
				)
				lop_resource.root_folder.resource_list.extend (r)
				lop_resource.put_resource (r)
			end
			lop_resource.save
		end

end -- class EB_RECENT_PROJECTS

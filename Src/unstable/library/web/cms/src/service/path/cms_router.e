note
	description: "Specific version of WSF_ROUTER for CMS component."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ROUTER

inherit
	WSF_ROUTER
		rename
			make as make_router
		redefine
			path_to_dispatch
		end

create
	make

feature {NONE} -- Initialization

	make (a_api: CMS_API; a_capacity: INTEGER)
		do
			api := a_api
			make_router (a_capacity)
		end

	api: CMS_API

feature {WSF_ROUTER_MAPPING} -- Dispatch helper

	path_to_dispatch (req: WSF_REQUEST): READABLE_STRING_8
			-- Path used by the router, to apply url dispatching of request `req'.
		local
			l_path: STRING_8
		do
			create l_path.make_from_string (Precursor (req))
			if not l_path.is_empty and l_path [1] = '/' then
				l_path.remove_head (1)
			end
			Result := api.source_of_path_alias (l_path)
			if Result.is_empty then
				Result := "/"
			elseif Result [1] /= '/' then
				create l_path.make (Result.count + 1)
				l_path.append_character ('/')
				l_path.append (Result)
				Result := l_path
			end
		end

end

note
	description: "Summary description for {WSF_ROUTER_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_ROUTER_VISITOR

feature -- Visitor

	process_router (r: WSF_ROUTER)
		deferred
		end

	process_item (i: WSF_ROUTER_ITEM)
		deferred
		end

	process_mapping (m: WSF_ROUTER_MAPPING)
		deferred
		end

	process_handler (h: WSF_HANDLER)
		deferred
		end

end

note
	description: "Summary description for {WSF_ROUTER_AGENT_ITERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_ROUTER_AGENT_ITERATOR

inherit
	WSF_ROUTER_ITERATOR
		redefine
			default_create,
			process_router,
			process_item,
			process_mapping,
			process_handler
		end

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create on_router_actions
			create on_item_actions
			create on_mapping_actions
			create on_handler_actions
		end

feature -- Actions

	on_router_actions: ACTION_SEQUENCE [TUPLE [WSF_ROUTER]]

	on_item_actions: ACTION_SEQUENCE [TUPLE [WSF_ROUTER_ITEM]]

	on_mapping_actions: ACTION_SEQUENCE [TUPLE [WSF_ROUTER_MAPPING]]

	on_handler_actions: ACTION_SEQUENCE [TUPLE [WSF_HANDLER]]

feature -- Visitor

	process_router (r: WSF_ROUTER)
		do
			on_router_actions.call ([r])
			Precursor (r)
		end

	process_item (i: WSF_ROUTER_ITEM)
		do
			on_item_actions.call ([i])
			Precursor (i)
		end

	process_mapping (m: WSF_ROUTER_MAPPING)
		do
			on_mapping_actions.call ([m])
			Precursor (m)
		end

	process_handler (h: WSF_HANDLER)
		do
			on_handler_actions.call ([h])
			Precursor (h)
		end

end

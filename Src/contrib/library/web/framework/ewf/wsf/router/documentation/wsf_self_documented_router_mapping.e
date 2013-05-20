note
	description: "Summary description for {WSF_SELF_DOCUMENTED_ROUTER_MAPPING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_SELF_DOCUMENTED_ROUTER_MAPPING

inherit
	WSF_ROUTER_MAPPING

feature -- Documentation

	documentation (a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
			-- Documentation associated with Current mapping, with methods `a_request_methods'.
			--| If the associated handler is a WSF_SELF_DOCUMENTED_HANDLER , then the handler will also
			--| Self described itself in the context of Current mapping and `a_request_methods'
		do
			if attached {WSF_SELF_DOCUMENTED_HANDLER} handler as obj then
				Result := obj.mapping_documentation (Current, a_request_methods)
			else
				create Result.make (Current)
			end
		end

end

note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class IV_INFO_NODE

feature -- Access

	node_info: attached IV_NODE_INFO
			-- Node info.
		do
			if not attached internal_node_info then
				create internal_node_info.make
			end
			Result := internal_node_info
		end

feature {NONE} -- Implementation

	internal_node_info: detachable IV_NODE_INFO
			-- Internal node info.

end

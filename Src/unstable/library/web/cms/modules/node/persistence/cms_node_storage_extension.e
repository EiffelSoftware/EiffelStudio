note
	description: "Node storage extension for specific node descendant."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_NODE_STORAGE_EXTENSION [G -> CMS_NODE]

feature -- Access

	content_type: READABLE_STRING_8
		deferred
		end

feature -- Status report

	is_accepted (a_node: CMS_NODE): BOOLEAN
			-- Is `a_node' accepted by current storage extension?
		do
			Result := attached {G} a_node
		end

feature -- Persistence

	store_node (a_node: CMS_NODE)
		require
			a_node_accepted: is_accepted (a_node)
		do
			if attached {G} a_node as obj then
				store (obj)
			end
		end

	load_node (a_node: CMS_NODE)
		require
			a_node_accepted: is_accepted (a_node)
		do
			if attached {G} a_node as obj then
				load (obj)
			end
		end

feature {NONE} -- Persistence implementation

	store (a_node: G)
		deferred
		end

	load (a_node: G)
		deferred
		end

end

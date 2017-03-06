note
	description: "[
			Interface defining a CMS content type.
		]"
	status: "draft"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_NODE_TYPE [G -> CMS_NODE]

inherit
	CMS_CONTENT_TYPE
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create available_formats.make (1)
		end

feature -- Access

	available_formats: ARRAYED_LIST [CONTENT_FORMAT]
			-- Available formats for Current type.	

feature -- Setting			

	is_path_alias_required: BOOLEAN
			-- Is path alias required for Current node type?
			-- By default: False.
			-- (i.e always set a path alias, instead of default /node/{id})
		do
		end

feature -- Factory

	new_node_with_title (a_title: READABLE_STRING_32; a_partial_node: detachable CMS_NODE): like new_node
			-- New node with `a_title' and fill from partial `a_partial_node' if set.
		deferred
		end

	new_node (a_partial_node: detachable CMS_NODE): G
			-- New node based on partial `a_partial_node' if set.
		deferred
		end

note
	copyright: "2011-2015, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

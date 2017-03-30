note
	description: "[
				Html builder for content type `content_type'.
				This is used to build webform and html output for a specific node, or node content type.
			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_NODE_TYPE_WEBFORM_MANAGER_I [G -> CMS_NODE]

inherit
	CMS_CONTENT_TYPE_WEBFORM_MANAGER [CMS_NODE]
		rename
			make as old_make
		redefine
			content_type
		end

feature {NONE} -- Initialization

	make (a_type: like content_type; a_node_api: CMS_NODE_API)
		do
			node_api := a_node_api
			old_make (a_type)
		end

feature -- Access

	content_type: CMS_NODE_TYPE [G]
			-- Associated content type.

	cms_api: CMS_API
			-- API for current instance of CMS.
		do
			Result := node_api.cms_api
		end

	node_api: CMS_NODE_API
			-- Associated node API.

feature -- Query			

	has_valid_node_type (a_node: CMS_NODE): BOOLEAN
			-- Accept `a_node' for Current operations.
		do
			Result := attached {like new_node} a_node
		end

feature -- Forms ...		

	populate_form (response: NODE_RESPONSE; a_form: WSF_FORM; a_node: detachable CMS_NODE)
			-- Fill the web form `a_form' with data from `a_node' if set.
		require
			a_node = Void or else has_valid_node_type (a_node)
		deferred
		end

feature -- Node ...		

	new_node (response: NODE_RESPONSE; a_form_data: WSF_FORM_DATA; a_node: detachable CMS_NODE): G
			-- New typed node with data from `a_form_data', and eventually data from `a_node' if set.
		require
			a_node = Void or else has_valid_node_type (a_node)
		deferred
			--| Possible implementation:
			--| Result := content_type.new_node (a_node)
		end

	update_node (response: NODE_RESPONSE; a_form_data: WSF_FORM_DATA; a_node: CMS_NODE)
			-- Update node `a_node' with data from `a_form_data'.
		require
			has_valid_node_type (a_node)
		deferred
		end

feature -- Output

	append_content_as_html_to_page (a_node: G; a_response: NODE_RESPONSE)
			-- Append an html representation of `a_node' to response `a_response'.
		require
			has_valid_node_type (a_node)
		local
			s: STRING
		do
			a_response.set_title (a_node.title)

			a_response.set_value (a_node, "node")
			a_response.set_value (a_node.content_type, "optional_content_type")
			create s.make_empty
			if a_node.is_not_published then
				a_response.add_warning_message ("This node is NOT published!")
			elseif a_node.is_trashed then
				a_response.add_warning_message ("This node is in the TRASH!")
			end
			append_content_as_html_to (a_node, False, s, a_response)
			a_response.set_main_content (s)
		end

end

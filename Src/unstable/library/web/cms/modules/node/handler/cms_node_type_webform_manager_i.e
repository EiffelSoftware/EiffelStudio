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
	CMS_CONTENT_TYPE_WEBFORM_MANAGER
		redefine
			content_type
		end

feature -- Access

	content_type: CMS_NODE_TYPE [G]
			-- Associated content type.

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

	append_html_output_to (a_node: CMS_NODE; a_response: NODE_RESPONSE)
			-- Append an html representation of `a_node' to response `a_response'.
		require
			has_valid_node_type (a_node)
		deferred
		end

end

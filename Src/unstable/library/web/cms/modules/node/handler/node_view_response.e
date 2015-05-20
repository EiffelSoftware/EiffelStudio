note
	description: "Summary description for {NODE_VIEW_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	NODE_VIEW_RESPONSE

inherit
	NODE_RESPONSE
		redefine
			make,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	make (req: WSF_REQUEST; res: WSF_RESPONSE; a_api: like api; a_node_api: like node_api)
		do
			create {WSF_NULL_THEME} wsf_theme.make
			Precursor (req, res, a_api, a_node_api)
		end

	initialize
		do
			Precursor
			create {CMS_TO_WSF_THEME} wsf_theme.make (Current, theme)
		end

	wsf_theme: WSF_THEME

feature -- Access

	node: detachable CMS_NODE

feature -- Element change

	set_node (a_node: like node)
		do
			node := a_node
		end

feature -- Execution

	process
			-- Computed response message.
		local
			b: STRING_8
			nid: INTEGER_64
			l_node: like node
		do
			l_node := node
			if l_node = Void then
				create b.make_empty
				nid := node_id_path_parameter (request)
				if nid > 0 then
					l_node := node_api.node (nid)
				end
			end
			if l_node /= Void then
				if
					attached node_api.node_type_for (l_node) as l_content_type and then
					attached node_api.node_type_webform_manager (l_content_type) as l_manager
				then
					l_manager.append_html_output_to (l_node, Current)
				end
			else
				set_main_content ("Missing node")
			end
		end

end

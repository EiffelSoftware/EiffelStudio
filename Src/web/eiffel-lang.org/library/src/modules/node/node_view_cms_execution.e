note
	description: "[
			]"

class
	NODE_VIEW_CMS_EXECUTION

inherit
	NODE_CMS_EXECUTION

create
	make

feature -- Execution

	process
			-- Computed response message.
		local
			b: STRING_8
		do
			if attached {WSF_STRING} request.path_parameter ("nid") as p_nid and then p_nid.is_integer then
				create b.make_empty

				if attached storage.node (p_nid.integer_value) as l_node then
					set_title ("Node [" + l_node.id.out + "]")
					add_to_menu (create {CMS_LOCAL_LINK}.make ("View", node_url (l_node)), primary_tabs)
					add_to_menu (create {CMS_LOCAL_LINK}.make ("Edit", "/node/" + l_node.id.out + "/edit"), primary_tabs)

					b.append (l_node.to_html (theme))
				else
					set_title ("Node [" + p_nid.value + "] does not exists!")
				end
				set_main_content (b)
			else
				set_title ("Node ...")
				create b.make_empty
				set_main_content (b)
			end
		end

end

note
	description: "Summary description for {NODE_VIEW_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	NODE_VIEW_RESPONSE

inherit
	NODE_RESPONSE

create
	make

feature -- Access

	node: detachable CMS_NODE

	revision: INTEGER_64
			-- If not zero, about history version of the node.

feature -- Element change

	set_node (a_node: like node)
		do
			node := a_node
		end

	set_revision (a_rev: like revision)
		do
			revision := a_rev
		end

feature -- Execution

	process
			-- Computed response message.
		local
			nid: INTEGER_64
			l_node: like node
			l_title: STRING_32
		do
			l_node := node
			if l_node = Void then
				nid := node_id_path_parameter
				if nid > 0 then
					l_node := node_api.node (nid)
				end
			end
			if l_node /= Void then
				set_optional_content_type (l_node.content_type)
				if
					attached node_api.node_type_for (l_node) as l_content_type and then
					attached node_api.node_type_webform_manager (l_content_type) as l_manager
				then
					l_manager.append_content_as_html_to_page (l_node, Current)
				end
				set_modification_date (l_node.modification_date)
				if attached l_node.summary as l_node_summary and then not l_node_summary.is_whitespace then
					set_description (l_node_summary)
				end
				set_metadata ("article", "type")
			elseif revision > 0 then
				set_main_content ("Missing revision node!")
			else
				set_main_content ("Missing node!")
			end
			if revision > 0 then
				add_warning_message ("The revisions let you track differences between multiple versions of a post.")
			end
			if l_node /= Void and then revision > 0 and then revision < l_node.revision then
				create l_title.make_from_string_general ("Revision #" + revision.out + " of %"")
				l_title.append (l_node.title)
				l_title.append_character ('"')
				set_title (l_title)
			end
		end

end

note
	description: "Summary description for {ER_XML_CALLBACKS}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_XML_CALLBACKS

inherit
	XML_CALLBACKS

create
	make

feature {NONE} -- Initialization

	make (a_tree: EV_TREE)
			--
		require
			not_void: a_tree /= Void
			valid: not a_tree.is_destroyed
		do
			tree := a_tree
			a_tree.wipe_out

			create last_node.make (50)
			create shared_singleton
		end

feature {NONE}	-- Implementation

	tree: EV_TREE
			--

	last_node: ARRAYED_LIST [EV_TREE_NODE]
			-- Last node stack

	shared_singleton: ER_SHARED_SINGLETON
			--

feature -- Document

	on_start
			-- <Precursor>
		do
			print ("%N on_start")
		end

	on_finish
			-- <Precursor>
		do
			print ("%N on_finish")
		end

	on_xml_declaration (a_version: STRING; an_encoding: detachable STRING; a_standalone: BOOLEAN)
			-- <Precursor>
		do
			print ("%N on_xml_declaration")
		end

feature -- Errors

	on_error (a_message: STRING)
			-- <Precursor>
		do
			print ("%N on_error")
		end

feature -- Meta

	on_processing_instruction (a_name: STRING; a_content: STRING)
			-- <Precursor>
		do
			print ("%N on_processing_instruction")
		end

	on_comment (a_content: STRING)
			-- <Precursor>
		do
			print ("%N on_comment")
		end

feature -- Tag

	on_start_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
			-- <Precursor>
		local
			l_parent_node: detachable EV_TREE_NODE
			l_new_node: EV_TREE_ITEM
		do
			print ("%N on_start_tag " + a_local_part)
			if last_node.count >= 1 then
				l_parent_node := last_node.last
			else
				-- this is first time
			end

			if attached shared_singleton.layout_constructor_cell.item as l_layout_constructor then
--				create l_new_node.make_with_text (a_local_part)
				l_new_node := l_layout_constructor.tree_item_factory_method (a_local_part)

				last_node.extend (l_new_node)

				if attached l_parent_node as l_parent then
					l_parent.extend (l_new_node)
				else
					tree.extend (l_new_node)
				end

			else
				check False end
			end

		end

	on_attribute (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING; a_value: STRING)
			-- <Precursor>
		local
			l_tree_node: EV_TREE_NODE
		do
			print ("%N on_attribute")
			l_tree_node := last_node.last
			if attached {ER_TREE_NODE_DATA} l_tree_node.data as l_data then
				l_data.update_for_xml_attribute (a_local_part, a_value)
			end
		end

	on_start_tag_finish
			-- <Precursor>
		do
			print ("%N on_start_tag_finish")
		end

	on_end_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
			-- <Precursor>
		local
--			l_list: detachable EV_ITEM_LIST [EV_TREE_NODE]
		do
			print ("%N on_end_tag")
			-- move parent one level up
			if attached last_node as l_last_node then
--				l_list := l_last_node.*parent
				if last_node.count >= 1 then
					last_node.finish
					last_node.remove
				else
					check False end
				end

			end
		end

feature -- Content

	on_content (a_content: STRING)
			-- <Precursor>
		do
			print ("%N on_content")
		end

end

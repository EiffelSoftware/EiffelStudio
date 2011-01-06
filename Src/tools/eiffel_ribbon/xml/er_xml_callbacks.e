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
			create constants
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
			debug ("Ribbon")
				print ("%N on_start")
			end
		end

	on_finish
			-- <Precursor>
		do
			debug ("Ribbon")
				print ("%N on_finish")
			end
		end

	on_xml_declaration (a_version: STRING; an_encoding: detachable STRING; a_standalone: BOOLEAN)
			-- <Precursor>
		do
			debug ("Ribbon")
				print ("%N on_xml_declaration")
			end
		end

feature -- Errors

	on_error (a_message: STRING)
			-- <Precursor>
		do
			debug ("Ribbon")
				print ("%N on_error")
			end
		end

feature -- Meta

	on_processing_instruction (a_name: STRING; a_content: STRING)
			-- <Precursor>
		do
			debug ("Ribbon")
				print ("%N on_processing_instruction")
			end
		end

	on_comment (a_content: STRING)
			-- <Precursor>
		do
			debug ("Ribbon")
				print ("%N on_comment")
			end
		end

feature -- Tag

	on_start_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
			-- <Precursor>
		local
			l_parent_node: detachable EV_TREE_NODE
			l_new_node: EV_TREE_ITEM
		do
			debug ("Ribbon")
				print ("%N on_start_tag " + a_local_part)
			end
			if last_node.count >= 1 then
				l_parent_node := last_node.last
			else
				-- this is first time
			end

			if attached data_callback as l_data_callback then
				l_data_callback.on_start_tag (a_namespace, a_prefix, a_local_part)
			else
				if attached shared_singleton.layout_constructor_cell.item as l_layout_constructor then
	--				create l_new_node.make_with_text (a_local_part)
					l_new_node := l_layout_constructor.tree_item_factory_method (a_local_part)

					last_node.extend (l_new_node)

					if attached l_parent_node as l_parent then
						l_parent.extend (l_new_node)
					else
						tree.extend (l_new_node)
					end

					if a_local_part.is_equal (constants.command) then
						if attached {ER_TREE_NODE_DATA} l_new_node.data as l_data then
							data_callback := l_data
						end
					end
				else
					check False end
				end
			end
		end

	on_attribute (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING; a_value: STRING)
			-- <Precursor>
		local
			l_tree_node: EV_TREE_NODE
		do
			debug ("Ribbon")
				print ("%N on_attribute")
			end
			l_tree_node := last_node.last
			if attached {ER_TREE_NODE_DATA} l_tree_node.data as l_data then
				l_data.update_for_xml_attribute (a_local_part, a_value)
			end
		end

	on_start_tag_finish
			-- <Precursor>
		do
			debug ("Ribbon")
				print ("%N on_start_tag_finish")
			end
		end

	on_end_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
			-- <Precursor>
		local
--			l_list: detachable EV_ITEM_LIST [EV_TREE_NODE]
		do
			debug ("Ribbon")
				print ("%N on_end_tag")
			end
			if a_local_part.is_equal (constants.command) then
				check set_by_on_start_tag: attached {ER_TREE_NODE_DATA} data_callback end
				data_callback := void

				remove_last_node
			elseif data_callback /= Void then
				-- nothing to do
			elseif attached last_node as l_last_node then
				-- move parent one level up
				remove_last_node
			end
		end

feature -- Content

	on_content (a_content: STRING)
			-- <Precursor>
		do
			debug ("Ribbon")
				print ("%N on_content")
			end
			if attached data_callback as l_data_callback then
				l_data_callback.on_content (a_content)
			end
		end

feature {NONE} -- Implementation

	remove_last_node
			--
		do
			if last_node.count >= 1 then
				last_node.finish
				last_node.remove
			else
				check False end
			end
		end

	data_callback: detachable ER_TREE_NODE_DATA
			-- When parsing some xml nodes, such as Command node. The sub nodes would be parsed by `data_callback' if available

	constants: ER_XML_CONSTANTS
			--
end

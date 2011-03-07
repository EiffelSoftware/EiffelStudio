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

	make
			--
		do
			create last_node.make (50)
			create shared_singleton
			create constants
			create name_space.make_default
		end

feature {NONE}	-- Implementation

	last_node: ARRAYED_LIST [ER_XML_TREE_ELEMENT]
			-- Last node stack

	shared_singleton: ER_SHARED_SINGLETON
			--

	name_space: XML_NAMESPACE
			--

feature -- Query

	xml_root: detachable ER_XML_TREE_ELEMENT
			--

feature -- Document

	on_start
			-- <Precursor>
		do
			debug ("Ribbon-xml")
				print ("%N on_start")
			end
		end

	on_finish
			-- <Precursor>
		do
			debug ("Ribbon-xml")
				print ("%N on_finish")
			end
		end

	on_xml_declaration (a_version: STRING; an_encoding: detachable STRING; a_standalone: BOOLEAN)
			-- <Precursor>
		do
			debug ("Ribbon-xml")
				print ("%N on_xml_declaration")
			end
		end

feature -- Errors

	on_error (a_message: STRING)
			-- <Precursor>
		do
			debug ("Ribbon-xml")
				print ("%N on_error")
			end
		end

feature -- Meta

	on_processing_instruction (a_name: STRING; a_content: STRING)
			-- <Precursor>
		do
			debug ("Ribbon-xml")
				print ("%N on_processing_instruction")
			end
		end

	on_comment (a_content: STRING)
			-- <Precursor>
		do
			debug ("Ribbon-xml")
				print ("%N on_comment")
			end
		end

feature -- Tag

	on_start_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
			-- <Precursor>
		local
			l_parent_node: detachable ER_XML_TREE_ELEMENT
			l_new_node: ER_XML_TREE_ELEMENT
		do
			debug ("Ribbon-xml")
				print ("%N on_start_tag " + a_local_part)
			end
			if last_node.count >= 1 then
				l_parent_node := last_node.last

				create l_new_node.make (l_parent_node, a_local_part, name_space)
				l_parent_node.put_last (l_new_node)

			else
				create l_new_node.make (void, a_local_part, name_space)
				xml_root := l_new_node
			end

			last_node.extend (l_new_node)
		end

	on_attribute (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING; a_value: STRING)
			-- <Precursor>
		local
			l_tree_node: ER_XML_TREE_ELEMENT
		do
			debug ("Ribbon-xml")
				print ("%N on_attribute")
			end

			l_tree_node := last_node.last
			l_tree_node.add_attribute (a_local_part, name_space, a_value)

		end

	on_start_tag_finish
			-- <Precursor>
		do
			debug ("Ribbon-xml")
				print ("%N on_start_tag_finish")
			end
		end

	on_end_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
			-- <Precursor>
		do
			debug ("Ribbon-xml")
				print ("%N on_end_tag")
			end
			remove_last_node

		end

feature -- Content

	on_content (a_content: STRING)
			-- <Precursor>
		local
			l_tree_node: ER_XML_TREE_ELEMENT
		do
			debug ("Ribbon-xml")
				print ("%N on_content")
			end

			l_tree_node := last_node.last
			l_tree_node.set_content (a_content)
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

	constants: ER_XML_CONSTANTS
			--
end

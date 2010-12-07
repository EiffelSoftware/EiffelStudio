note
	description: "Summary description for {ER_TREE_NODE_COMMAND_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_COMMAND_DATA

inherit
	ER_TREE_NODE_DATA
		redefine
			on_start_tag,
			on_content
		end

feature -- Query

	command_name: detachable STRING
			--

	label_title: detachable STRING
			--

	small_image: detachable STRING
			--

	large_image: detachable STRING
			--

feature -- Command

	set_command_name (a_command_name: detachable STRING)
			--
		do
			command_name := a_command_name
		end

	set_label_title (a_label_title: detachable STRING)
			--
		do
			label_title := a_label_title
		end

	set_small_image (a_small_image: detachable STRING)
			--
		do
			small_image := a_small_image
		end

	set_large_image (a_large_image: detachable STRING)
			--
		do
			large_image := a_large_image
		end

	update_for_xml_attribute (a_name, a_value: STRING)
			-- <Precursor>
		local
			l_constants: ER_XML_ATTRIBUTE_CONSTANTS
		do
			create l_constants
			check a_name.is_equal (l_constants.name) end
			command_name := a_value
		end

	add_sub_tree_nodes (a_parent_node: XML_ELEMENT; a_name_space: XML_NAMESPACE)
			-- When saving XML, adding sub tree nodes to `a_parent_node' if possible
		local
			l_item, l_sub_item: XML_ELEMENT
			l_item_text: XML_CHARACTER_DATA
			l_constants: ER_XML_CONSTANTS
		do
			create l_constants
			if attached label_title as l_title and then not l_title.is_empty then
				create l_item.make (a_parent_node, l_constants.command_label_title, a_name_space)
				a_parent_node.put_last (l_item)

				create l_sub_item.make (l_item, l_constants.string, a_name_space)
				l_item.put_last (l_sub_item)

				create l_item_text.make (l_sub_item, l_title)
				l_sub_item.put_last (l_item_text)
				-- Adding id attribute automatically here?
			end

			if attached large_image as l_image and then not l_image.is_empty then
				create l_item.make (a_parent_node, l_constants.command_large_images, a_name_space)
				a_parent_node.put_last (l_item)

				create l_sub_item.make (l_item, l_constants.image, a_name_space)
				l_item.put_last (l_sub_item)

				create l_item_text.make (l_sub_item, l_image)
				l_sub_item.put_last (l_item_text)
				-- Adding id attribute automatically here?
			end

			if attached small_image as l_image and then not l_image.is_empty then
				create l_item.make (a_parent_node, l_constants.command_small_images, a_name_space)
				a_parent_node.put_last (l_item)

				create l_sub_item.make (l_item, l_constants.image, a_name_space)
				l_item.put_last (l_sub_item)

				create l_item_text.make (l_sub_item, l_image)
				l_sub_item.put_last (l_item_text)
				-- Adding id attribute automatically here?
			end
		end

feature -- XML callbacks

	on_start_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
			-- <Precursor>
		local
			l_constants: ER_XML_CONSTANTS
		do
			create l_constants
			if a_local_part.is_equal (l_constants.command_label_title) then
				tag_of_start := a_local_part
			elseif a_local_part.is_equal (l_constants.command_small_images) then
				tag_of_start := a_local_part
			elseif a_local_part.is_equal (l_constants.command_large_images) then
				tag_of_start := a_local_part
			end

		end

	on_content (a_content: STRING)
			-- <Precursor>
		local
			l_constants: ER_XML_CONSTANTS
		do
			create l_constants
			if attached tag_of_start as l_start_tag then
				if l_start_tag.is_equal (l_constants.command_label_title) then
					label_title := a_content
				elseif l_start_tag.is_equal (l_constants.command_small_images) then
					small_image := a_content
				elseif l_start_tag.is_equal (l_constants.command_large_images) then
					large_image := a_content
				end

				tag_of_start := void
			end

		ensure then
			cleared: tag_of_start = void
		end

	tag_of_start: detachable STRING
			-- Set by `on_start_tag'
end

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

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			command_name_prefix := "command_"
			xml_constants := {ER_XML_CONSTANTS}.command
			new_unique_command_name
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
					if attached small_image as l_image then
						l_image.replace_substring_all ("\\", "\")
					end
				elseif l_start_tag.is_equal (l_constants.command_large_images) then
					large_image := a_content
					if attached large_image as l_image then
						l_image.replace_substring_all ("\\", "\")
					end
				end

				tag_of_start := void
			end

		ensure then
			cleared: tag_of_start = void
		end

	tag_of_start: detachable STRING
			-- Set by `on_start_tag'
end

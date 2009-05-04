note
	description: "[
		{XTL_PAGE_CONF_TAG_LIB}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTL_PAGE_CONF_TAG_LIB

inherit
	XTL_TAG_LIBRARY
		redefine
			create_tag,
			get_class_for_name,
			contains,
			argument_belongs_to_tag
		end

create
	make_with_arguments

feature -- Initialization

	make_with_arguments (a_id: STRING; a_parser_callback: XP_XML_PARSER_CALLBACKS)
		do
			make
			id := a_id
			parser_callback := a_parser_callback
		end

feature {NONE} -- Access

	parser_callback: XP_XML_PARSER_CALLBACKS

feature -- Access

	create_tag (a_prefix, a_local_part, a_class_name, a_debug_information: STRING): XP_TAG_ELEMENT
			-- Creates the appropriate XP_TAG_ELEMENT
		do
			if a_local_part.is_equal ("controller") then
				create {XP_AGENT_TAG_ELEMENT} Result.make (a_prefix, a_local_part, a_class_name, a_debug_information, agent handle_controller_attribute)
			elseif a_local_part.is_equal ("template") then
				parser_callback.is_template := True
				create Result.make (a_prefix, a_local_part, a_class_name, a_debug_information)
			elseif a_local_part.is_equal ("region") then
				parser_callback.is_template := True
				create {XP_REGION_TAG_ELEMENT} Result.make (a_prefix, a_local_part, a_class_name, a_debug_information)
			elseif a_local_part.is_equal ("include") then
				create {XP_INCLUDE_TAG_ELEMENT} Result.make (a_prefix, a_local_part, a_class_name, a_debug_information)
			else
				create Result.make (a_prefix, a_local_part, a_class_name, a_debug_information)
			end
		end

	get_class_for_name (a_name: STRING): STRING
			-- Searches for the class corresponding to
			-- the tag name. If no class is found
			-- the empty string is returned
		do
			Result := "XTAG_PAGE_NOOP_TAG"
		end

	argument_belongs_to_tag (a_attribute, a_tag: STRING) : BOOLEAN
			-- Verifies that `a_attribute' belongs to `a_tag'
		do
			Result := True
		end

	contains (tag_id: STRING): BOOLEAN
			-- Checks, if the tag is available in the tag library
		do
			Result := True
		end

	handle_controller_attribute (a_id, a_value: STRING)
		do
			if a_id.is_equal ("class") then
				parser_callback.put_class_name (a_value)
			end
		end

end

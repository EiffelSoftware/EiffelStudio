note
	description: "[
		Mimics a {XTL_TAG_LIBRARY} and provides a hardcoded library for <page:X> tags.
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
			-- `a_id': The id of the tag lib (namespace)
			-- `a_parser_callback': The parser_callback using Current
		require
			a_id_attached: a_id /= Void
			a_parser_callback_attached: a_parser_callback /= Void
		do
			make
			id := a_id
			parser_callback := a_parser_callback
		end

feature {NONE} -- Access

	parser_callback: XP_XML_PARSER_CALLBACKS
			-- The parser_callback using Current

feature -- Access

	create_tag (a_prefix, a_local_part, a_class_name, a_debug_information: STRING): XP_TAG_ELEMENT
			-- Creates the appropriate XP_TAG_ELEMENT
		require else
			a_prefix_attached: a_prefix /= Void
			a_local_part_attached: attached a_local_part
			a_class_name_attached: a_class_name /= Void
			a_debug_information_attached: a_debug_information /= Void
		do
			if a_local_part.is_equal ("controller") then
				create {XP_AGENT_TAG_ELEMENT} Result.make_with_additional_arguments (a_prefix, a_local_part, a_class_name, a_debug_information, agent handle_controller_attribute)
			elseif a_local_part.is_equal ("template") then
				parser_callback.is_template := True
				create Result.make (a_prefix, a_local_part, a_class_name, a_debug_information)
			elseif a_local_part.is_equal ("region") then
				parser_callback.is_template := True
				create {XP_REGION_TAG_ELEMENT} Result.make (a_prefix, a_local_part, a_class_name, a_debug_information)
			elseif a_local_part.is_equal ("include") then
					-- TODO Build the "inheritance tree" current template inherits from "template" attribute of INCLUDE_TAG.				
				create {XP_INCLUDE_TAG_ELEMENT} Result.make (a_prefix, a_local_part, a_class_name, a_debug_information)
			else
				create Result.make (a_prefix, a_local_part, a_class_name, a_debug_information)
			end
		end

	get_class_for_name (a_name: STRING): STRING
			-- Searches for the class corresponding to
			-- the tag name. If no class is found
			-- the empty string is returned
			-- Yeah, right...
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
			-- Handles attribute reading while parsing
		do
			if a_id.is_equal ("class") then
				parser_callback.put_class_name (a_value)
			end
		end

end

note
	description: "[
		Abstraction for parsing states in the {XP_XML_PARSER_CALLBACKS}
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XP_CALLBACK_STATE

feature -- Initialization

	make (a_parser_callback: XP_XML_PARSER_CALLBACKS)
			-- `a_parser_callback': The parser callback to write on
		require
			a_parser_callback_attached: a_parser_callback /= Void
		do
			parser_callback := a_parser_callback
		ensure
			parser_has_been_set: parser_callback = a_parser_callback
		end

feature -- Access

	parser_callback: XP_XML_PARSER_CALLBACKS
			-- The parser callbacks on which the tags should be added

	on_start_tag (a_namespace, a_prefix, a_local_part : STRING)
			-- Handle strings on start tag
		require
			a_prefix_valid: a_prefix /= Void
			a_local_part_valid: a_local_part /= Void
		deferred
		end

	on_content (a_content: STRING)
			-- Handle strings on content
		require
			a_content_valid: a_content /= Void
		deferred
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- Handle strings on end tag
		require
			a_namespace_valid: a_namespace /= Void
			a_prefix_valid: a_prefix /= Void
			a_local_part_valid: a_local_part /= Void
		deferred
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
			-- Handle strings on attribute
		require
			a_namespace_attached: a_namespace /= Void
			a_prefix_valid: a_prefix /= Void
			a_local_part_valid: a_local_part /= Void
			a_value_valid: a_value /= Void
		deferred
		end

	on_start_tag_finish
			-- Handle strings on end tag
		deferred
		end

	on_finish
			-- Handle strings on finish
		deferred
		end

	strip_off_dynamic_tags (a_string: STRING): STRING
			-- Strips off the "%=" and ending "%"		
		require
			a_string_attached: attached a_string
			a_string_is_valid: a_string.starts_with ("%%=") and a_string.ends_with ("%%")
		do
			Result := a_string.substring (3, a_string.count - 1)
		end

invariant
	parser_callback_attached: parser_callback /= Void
end

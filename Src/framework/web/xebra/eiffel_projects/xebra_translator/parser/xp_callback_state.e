note
	description: "[
		{XP_CALLBACK_STATE}.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XP_CALLBACK_STATE

feature -- Initialization

	make (a_parser_callback: XP_XML_PARSER_CALLBACKS)
		do
			parser_callback := a_parser_callback
		end

feature -- Access

	parser_callback: XP_XML_PARSER_CALLBACKS

	on_start_tag (a_namespace, a_prefix, a_local_part : STRING)
			-- Handle strings on start tag
		require
			a_prefix_valid: a_prefix /= Void
			a_local_part_valid: a_local_part /= Void
		deferred
		end

	on_content (a_content: STRING)
		require
			a_content_valid: a_content /= Void
		deferred
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
		require
			a_prefix_valid: a_prefix /= Void
			a_local_part_valid: a_local_part /= Void
		deferred
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
		require
			a_prefix_valid: a_prefix /= Void
			a_local_part_valid: a_local_part /= Void
			a_value_valid: a_value /= Void
		deferred
		end

	on_start_tag_finish
		deferred
		end

end

note

	description:

		"XSLT patterns that test for a node with a given local-name"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2007, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XSLT_LOCAL_NAME_TEST

inherit

	XM_XSLT_NODE_TEST
		undefine
			fingerprint, node_kind, is_local_name_test, as_local_name_test
		redefine
			default_priority
		end

	XM_XPATH_LOCAL_NAME_TEST
		rename
			make as make_xpath
		end

create

	make

feature {NONE} -- Initialization

	make (a_static_context: XM_XPATH_STATIC_CONTEXT; a_node_type: INTEGER; a_local_name, a_original_text: STRING)
		require
			static_context_not_void: a_static_context /= Void
			valid_node_type: is_node_type (a_node_type)
			valid_local_name: a_local_name /= Void and then is_ncname (a_local_name)
			original_text_not_void: a_original_text /= Void
		do
			system_id := a_static_context.system_id
			line_number := a_static_context.line_number
			initialize_dependencies
			make_xpath (a_node_type, a_local_name, a_original_text)
		ensure
			node_kind_set: node_kind = a_node_type
			local_name_set: local_name = a_local_name
			original_text_set: original_text = a_original_text
			system_id_set: STRING_.same_string (system_id, a_static_context.system_id)
			line_number_set: line_number = a_static_context.line_number
		end

feature -- Access

		frozen default_priority: MA_DECIMAL
			--  Determine the default priority to use if this pattern appears as a match pattern for a template with no explicit priority attribute.
		do
				create Result.make_from_string ("-0.25")
		end

end


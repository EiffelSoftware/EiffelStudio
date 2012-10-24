note
	description: "Summary description for {XML_PROCESSING_INSTRUCTION}."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_PROCESSING_INSTRUCTION

inherit
	XML_DOCUMENT_NODE

	XML_ELEMENT_NODE

create
	make,
	make_last,
	make_last_in_document

feature {NONE} -- Initialization

	make (a_parent: like parent; a_target: READABLE_STRING_GENERAL; a_data: READABLE_STRING_GENERAL)
			-- Create a new processing instruction node.
		require
			a_target_not_void: a_target /= Void
			a_data_not_void: a_data /= Void
		do
			set_target (a_target)
			set_data (a_data)
			parent := a_parent
		ensure
			parent_set: parent = a_parent
			target_set: a_target.same_string (internal_target)
			data_set: a_data.same_string (internal_data)
		end

	make_last (a_parent: XML_ELEMENT; a_target: READABLE_STRING_GENERAL; a_data: READABLE_STRING_GENERAL)
			-- Create a new processing instruction node,
			-- and add it to parent.
		require
			a_parent_not_void: a_parent /= Void
			a_target_not_void: a_target /= Void
			a_data_not_void: a_data /= Void
		do
			set_target (a_target)
			set_data (a_data)
			a_parent.force_last (Current)
		ensure
			parent_set: parent = a_parent
			in_parent: a_parent.last = Current
			target_set: a_target.same_string (internal_target)
			data_set: a_data.same_string (internal_data)
		end

	make_last_in_document (a_parent: XML_DOCUMENT; a_target: READABLE_STRING_GENERAL; a_data: READABLE_STRING_GENERAL)
			-- Create a new processing instruction node.
			-- and add it to parent.
		require
			a_parent_not_void: a_parent /= Void
			a_target_not_void: a_target /= Void
			a_data_not_void: a_data /= Void
		do
			set_target (a_target)
			set_data (a_data)
			a_parent.force_last (Current)
		ensure
			parent_set: parent = a_parent
			in_parent: a_parent.last = Current
			target_set: a_target.same_string (internal_target)
			data_set: a_data.same_string (internal_data)
		end

feature -- Status report

	target_is_valid_as_string_8: BOOLEAN
			-- Is the associated target a valid string_8 string?
		do
			Result := internal_target.is_valid_as_string_8
		end

	data_is_valid_as_string_8: BOOLEAN
			-- Is the associated data a valid string_8 string?
		do
			Result := internal_data.is_valid_as_string_8
		end

feature -- Access

	target_8, target: STRING_8
			-- Target of current processing instruction;
			-- XML defines this as being the first token following
			-- the markup that begins the processing instruction.
		require
			target_is_valid_as_string_8: target_is_valid_as_string_8
		do
			Result := internal_target.as_string_8
		end

	target_32: READABLE_STRING_32
			-- Target of current processing instruction;
			-- XML defines this as being the first token following
			-- the markup that begins the processing instruction.
		do
			Result := to_readable_string_32 (internal_target)
		end

	data_8, data: STRING_8
			-- Content of current processing instruction;
			-- This is from the first non white space character after
			-- the target to the character immediately preceding the ?>.
		require
			data_is_valid_as_string_8: data_is_valid_as_string_8
		do
			Result := internal_data.as_string_8
		end

	data_32: READABLE_STRING_32
			-- Content of current processing instruction;
			-- This is from the first non white space character after
			-- the target to the character immediately preceding the ?>.
		do
			Result := to_readable_string_32 (internal_data)
		end

feature {XML_EXPORTER} -- Access

	internal_target: READABLE_STRING_GENERAL
			-- Internal `target'

	internal_data: READABLE_STRING_GENERAL
			-- Internal `data'

feature -- Setting

	set_target (a_target: READABLE_STRING_GENERAL)
			-- Set target.
		require
			a_target_not_void: a_target /= Void
		do
			internal_target := a_target
		ensure
			set: a_target.same_string (internal_target)
		end

	set_data (a_data: READABLE_STRING_GENERAL)
			-- Set data.
		require
			a_data_not_void: a_data /= Void
		do
			internal_data := a_data
		ensure
			set: a_data.same_string (internal_data)
		end

feature -- Visitor processing

	process (a_processor: XML_NODE_VISITOR)
			-- Process current node with `a_processor'.
		do
			a_processor.process_processing_instruction (Current)
		end

invariant

	target_not_void: internal_target /= Void
	data_not_void: internal_data /= Void

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

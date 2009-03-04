note
	description: "Acts as a callback for xml parser events to parse xebra scriptlets."
	date: "$Date$"
	revision: "$Revision$"

class
	XB_XML_PARSER_CALLBACKS

inherit
	XM_CALLBACKS

create
	make

feature {NONE} -- Initialization

	make
			-- Run.
		do
		end

feature -- Constants

	Eiffel_tag_keyword: STRING = "eiffel"

feature -- Access


	root: ROOT_SERVLET_ELEMENT

	cursor_buf: UC_STRING

feature -- Document

	on_start
			-- Called when parsing starts.
		do
			create root.make ("HELLO_WORLD","HELLO_WORLD_CONTROLLER")
			create cursor_buf.make_empty
		end

	on_finish
			-- Called when parsing finished.
		do
			cursor_buf.append ("%N%N -->DONE: " + cursor_buf)

		end

	on_xml_declaration (a_version: STRING; an_encoding: STRING; a_standalone: BOOLEAN)
			-- XML declaration.		
		do
		end

feature -- Errors

	on_error (a_message: STRING)
			-- Event producer detected an error.
		do
			cursor_buf.append (a_message)
		end

feature -- Meta

	on_processing_instruction (a_name: STRING; a_content: STRING)
			-- Processing instruction.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
				cursor_buf.append ("<?eiffel: " + a_name + "++" + a_content + "?>")
		end

	on_comment (a_content: STRING)
			-- Processing a comment.
			-- Atomic: single comment produces single event
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
				cursor_buf.append ("<!-- " + a_content + "-->")
		end

feature -- Tag

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- Start of start tag.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
			--	if a_local_part.starts_with (Eiffel_tag_keyword) then
			--		tag_handler.start_handling (a_local_part)
			--	end

				cursor_buf.append ("<" + a_local_part)
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
			-- Start of attribute.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
					cursor_buf.append (" " + a_local_part + "=%"" + a_value + "%"")
		end

	on_start_tag_finish
			-- End of start tag.
		do
				cursor_buf.append (">")

		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- End tag.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
			cursor_buf.append ("</" + a_local_part + ">")
		end

feature -- Content

	on_content (a_content: STRING)
			-- Text content.
			-- NOT atomic: two on_content events may follow each other
			-- without a markup event in between.
			-- Warning: strings may be polymorphic, see XM_STRING_MODE.
		do
			cursor_buf.append (a_content)
		end

end

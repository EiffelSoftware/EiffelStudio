note

	description: "Descendant of callbacks interface forwarding to a client interface"
	date: "$Date$"
	revision: "$Revision$"

class XML_AGENT_CALLBACKS

inherit
	ANY

	XML_CALLBACKS
		export {NONE} all end

feature -- Access

	reset
			--
		do
			on_attribute_callback := Void
			on_comment_callback := Void
			on_content_callback := Void
			on_end_tag_callback := Void
			on_error_callback := Void
			on_finish_callback := Void
			on_processing_instruction_callback := Void
			on_start_callback := Void
			on_start_tag_callback := Void
			on_start_tag_finish_callback := Void
			on_xml_declaration_callback := Void
		end

feature -- Impl

	on_attribute_callback: detachable PROCEDURE [ANY, TUPLE [STRING, STRING, STRING, STRING]]
	on_comment_callback: detachable PROCEDURE [ANY, TUPLE [STRING]]
	on_content_callback: detachable PROCEDURE [ANY, TUPLE [STRING]]
	on_end_tag_callback: detachable PROCEDURE [ANY, TUPLE [STRING, STRING, STRING]]
	on_error_callback: detachable PROCEDURE [ANY, TUPLE [STRING]]
	on_finish_callback: detachable PROCEDURE [ANY, TUPLE]
	on_processing_instruction_callback: detachable PROCEDURE [ANY, TUPLE [STRING, STRING]]
	on_start_callback: detachable PROCEDURE [ANY, TUPLE]
	on_start_tag_callback: detachable PROCEDURE [ANY, TUPLE [STRING, STRING, STRING]]
	on_start_tag_finish_callback: detachable PROCEDURE [ANY, TUPLE]
	on_xml_declaration_callback: detachable PROCEDURE [ANY, TUPLE [STRING, STRING, BOOLEAN]]

feature -- Setting

	set_on_attribute_callback (a: like on_attribute_callback)
		do
			on_attribute_callback := a
		end
	set_on_comment_callback (a: like on_comment_callback)
		do
			on_comment_callback := a
		end
	set_on_content_callback (a: like on_content_callback)
		do
			on_content_callback := a
		end
	set_on_end_tag_callback (a: like on_end_tag_callback)
		do
			on_end_tag_callback := a
		end
	set_on_error_callback (a: like on_error_callback)
		do
			on_error_callback := a
		end
	set_on_finish_callback (a: like on_finish_callback)
		do
			on_finish_callback := a
		end
	set_on_processing_instruction_callback (a: like on_processing_instruction_callback)
		do
			on_processing_instruction_callback := a
		end
	set_on_start_callback (a: like on_start_callback)
		do
			on_start_callback := a
		end
	set_on_start_tag_callback (a: like on_start_tag_callback)
		do
			on_start_tag_callback := a
		end
	set_on_start_tag_finish_callback (a: like on_start_tag_finish_callback)
		do
			on_start_tag_finish_callback := a
		end
	set_on_xml_declaration_callback (a: like on_xml_declaration_callback)
		do
			on_xml_declaration_callback := a
		end

feature {NONE} -- Document

	on_start
			-- Forward start.
		do
			if on_start_callback /= Void then
				on_start_callback.call (Void)
			end
		end

	on_finish
			-- Forward finish.
		do
			if on_finish_callback /= Void then
				on_finish_callback.call (Void)
			end
		end

	on_xml_declaration (a_version: STRING; an_encoding: STRING; a_standalone: BOOLEAN)
			-- XML declaration.
		do
			if on_xml_declaration_callback /= Void then
				on_xml_declaration_callback.call ([a_version, an_encoding, a_standalone])
			end
		end

feature {NONE} -- Errors

	on_error (a_message: STRING)
			-- Event producer detected an error.
		do
			if on_error_callback /= Void then
				on_error_callback.call ([a_message])
			end
		end

feature {NONE} -- Meta

	on_processing_instruction (a_name, a_content: STRING)
			-- Forward PI.
		do
			if on_processing_instruction_callback /= Void then
				on_processing_instruction_callback.call ([a_name, a_content])
			end
		end

	on_comment (a_content: STRING)
			-- Forward comment.
		do
			if on_comment_callback /= Void then
				on_comment_callback.call ([a_content])
			end
		end

feature {NONE} -- Tag

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- Start of start tag.
		do
			if on_start_tag_callback /= Void then
				on_start_tag_callback.call ([a_namespace, a_prefix, a_local_part])
			end
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
			-- Process attribute.
		do
			if on_attribute_callback /= Void then
				on_attribute_callback.call ([a_namespace, a_prefix, a_local_part, a_value])
			end
		end

	on_start_tag_finish
			-- End of start tag.
		do
			if on_start_tag_finish_callback /= Void then
				on_start_tag_finish_callback.call (Void)
			end
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- End tag.
		do
			if on_end_tag_callback /= Void then
				on_end_tag_callback.call ([a_namespace, a_prefix, a_local_part])
			end
		end

feature {NONE} -- Content

	on_content (a_content: STRING)
			-- Forward content.
		do
			if on_content_callback /= Void then
				on_content_callback.call ([a_content])
			end
		end

note
	copyright: "Copyright (c) 2003-2010, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end

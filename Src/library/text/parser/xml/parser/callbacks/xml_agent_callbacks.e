note

	description: "Descendant of callbacks interface forwarding to a client interface"
	date: "$Date$"
	revision: "$Revision$"

class XML_AGENT_CALLBACKS

inherit
	XML_CALLBACKS

feature -- Access

	reset
			-- Reset callback to Void
		do
			on_attribute_action := Void
			on_comment_action := Void
			on_content_action := Void
			on_end_tag_action := Void
			on_error_action := Void
			on_finish_action := Void
			on_processing_instruction_action := Void
			on_start_action := Void
			on_start_tag_action := Void
			on_start_tag_finish_action := Void
			on_xml_declaration_action := Void
		end

feature -- Agents

	on_attribute_action: detachable PROCEDURE [detachable READABLE_STRING_32, detachable READABLE_STRING_32, READABLE_STRING_32, READABLE_STRING_32] assign set_on_attribute_action

	on_comment_action: detachable PROCEDURE [READABLE_STRING_32] assign set_on_comment_action

	on_content_action: detachable PROCEDURE [READABLE_STRING_32] assign set_on_content_action

	on_end_tag_action: detachable PROCEDURE [detachable READABLE_STRING_32, detachable READABLE_STRING_32, READABLE_STRING_32] assign set_on_end_tag_action

	on_error_action: detachable PROCEDURE [READABLE_STRING_32] assign set_on_error_action

	on_finish_action: detachable PROCEDURE assign set_on_finish_action

	on_processing_instruction_action: detachable PROCEDURE [READABLE_STRING_32, READABLE_STRING_32] assign set_on_processing_instruction_action

	on_start_action: detachable PROCEDURE assign set_on_start_action

	on_start_tag_action: detachable PROCEDURE [detachable READABLE_STRING_32, detachable READABLE_STRING_32, READABLE_STRING_32] assign set_on_start_tag_action

	on_start_tag_finish_action: detachable PROCEDURE assign set_on_start_tag_finish_action

	on_xml_declaration_action: detachable PROCEDURE [READABLE_STRING_32, detachable READABLE_STRING_32, BOOLEAN] assign set_on_xml_declaration_action


feature -- Setting

	set_on_attribute_action (a: like on_attribute_action)
		do
			on_attribute_action := a
		end

	set_on_comment_action (a: like on_comment_action)
		do
			on_comment_action := a
		end

	set_on_content_action (a: like on_content_action)
		do
			on_content_action := a
		end

	set_on_end_tag_action (a: like on_end_tag_action)
		do
			on_end_tag_action := a
		end

	set_on_error_action (a: like on_error_action)
		do
			on_error_action := a
		end

	set_on_finish_action (a: like on_finish_action)
		do
			on_finish_action := a
		end

	set_on_processing_instruction_action (a: like on_processing_instruction_action)
		do
			on_processing_instruction_action := a
		end

	set_on_start_action (a: like on_start_action)
		do
			on_start_action := a
		end

	set_on_start_tag_action (a: like on_start_tag_action)
		do
			on_start_tag_action := a
		end

	set_on_start_tag_finish_action (a: like on_start_tag_finish_action)
		do
			on_start_tag_finish_action := a
		end

	set_on_xml_declaration_action (a: like on_xml_declaration_action)
		do
			on_xml_declaration_action := a
		end

feature {NONE} -- Document

	on_start
			-- Forward start.
		do
			if attached on_start_action as act then
				act.call (Void)
			end
		end

	on_finish
			-- Forward finish.
		do
			if attached on_finish_action as act then
				act.call (Void)
			end
		end

	on_xml_declaration (a_version: READABLE_STRING_32; an_encoding: detachable READABLE_STRING_32; a_standalone: BOOLEAN)
			-- XML declaration.
		do
			if attached on_xml_declaration_action as act then
				act.call ([a_version, an_encoding, a_standalone])
			end
		end

feature {NONE} -- Errors

	on_error (a_message: READABLE_STRING_32)
			-- Event producer detected an error.
		do
			if attached on_error_action as act then
				act.call ([a_message])
			end
		end

feature {NONE} -- Meta

	on_processing_instruction (a_name, a_content: READABLE_STRING_32)
			-- Forward PI.
		do
			if attached on_processing_instruction_action as act then
				act.call ([a_name, a_content])
			end
		end

	on_comment (a_content: READABLE_STRING_32)
			-- Forward comment.
		do
			if attached on_comment_action as act then
				act.call ([a_content])
			end
		end

feature {NONE} -- Tag

	on_start_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			-- Start of start tag.
		do
			if attached on_start_tag_action as act then
				act.call ([a_namespace, a_prefix, a_local_part])
			end
		end

	on_attribute (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32; a_value: READABLE_STRING_32)
			-- Process attribute.
		do
			if attached on_attribute_action as act then
				act.call ([a_namespace, a_prefix, a_local_part, a_value])
			end
		end

	on_start_tag_finish
			-- End of start tag.
		do
			if attached on_start_tag_finish_action as act then
				act.call (Void)
			end
		end

	on_end_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			-- End tag.
		do
			if attached on_end_tag_action as act then
				act.call ([a_namespace, a_prefix, a_local_part])
			end
		end

feature {NONE} -- Content

	on_content (a_content: READABLE_STRING_32)
			-- Forward content.
		do
			if attached on_content_action as act then
				act.call ([a_content])
			end
		end

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

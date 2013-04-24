note
	description: "[
			XML callback interface that resolves namespaces

			Note: the original code is from Gobo's XM library (http://www.gobosoft.com/)
			]"
	date: "$Date$"
	revision: "$Revision$"

class XML_NAMESPACE_RESOLVER

inherit
	XML_CALLBACKS_FILTER
		redefine
			set_next,
			on_finish,
			on_start,
			on_start_tag,
			on_attribute,
			on_start_tag_finish,
			on_end_tag
		end

create
	make_null,
	set_next

feature {NONE} -- Initialization

	set_next (a_next: like next)
		do
			Precursor (a_next)
			initialize
		end

	initialize
		do
			create context.make
			attributes_make
		end

	reset
		do
			context.reset
			attributes_prefix.wipe_out
			attributes_local_part.wipe_out
			attributes_value.wipe_out
		end

feature -- Document

	on_finish
			-- Forward to `next'.
		do
			next.on_finish
		end

	on_start
			-- Initialize document variables.
		do
			reset
			Precursor
		end

feature -- Forwarding policy

	forward_xmlns: BOOLEAN
			-- Should xmlns[:] attributes be forwarded to next filter?

	set_forward_xmlns (a_boolean: BOOLEAN)
			-- Set forwarding of xmlns[:] attributes policy.
			-- Default (False): do not forward.
		do
			forward_xmlns := a_boolean
		ensure
			set: forward_xmlns = a_boolean
		end

feature -- Element

	on_start_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			-- Process start of start tag.
		do
			context.push
			check empty_attributes: attributes_is_empty end
				-- Save for when we can resolve it, event deferred.
			element_prefix := a_prefix
			element_local_part := a_local_part
		end

	on_attribute (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32; a_value: READABLE_STRING_32)
			-- Process attribute.
		do
			if not has_prefix (a_prefix) and is_xmlns (a_local_part) then
					-- Default declaration.
				context.add_default (a_value)
					-- Optionally do not eat xmlns attributes
				if forward_xmlns then
					attributes_force (a_prefix, a_local_part, a_value)
				end
			elseif a_prefix /= Void and then is_xmlns (a_prefix) then
					-- Prefix declaration.
				if context.shallow_has (a_prefix) then
					on_error (Duplicate_namespace_declaration_error)
				else
					context.add (a_value, a_local_part)
				end
					-- Optionally do not eat xmlns: attributes
				if forward_xmlns then
					attributes_force (a_prefix, a_local_part, a_value)
				end
			else
					-- Queue ordinary attribute for when all namespace
					-- declarations have been seen as they can be used
					-- to declare attributes prefixes.
				attributes_force (a_prefix, a_local_part, a_value)
			end
		end

	on_start_tag_finish
			-- Process end of start tag.
		local
			error_msg: STRING_GENERAL
			l_element_prefix: like element_prefix
		do
			if attached element_local_part as l_element_local_part then
				l_element_prefix := element_prefix
				if l_element_prefix /= Void and then has_prefix (l_element_prefix) then
					if context.has (l_element_prefix) then
						on_start_tag_resolved (context.resolve (l_element_prefix),
								l_element_prefix, l_element_local_part)
						on_delayed_attributes
					else
						create {STRING_32} error_msg.make_empty
						error_msg.append (Undeclared_namespace_error)
						error_msg.append (" in tag <")
						error_msg.append (l_element_prefix)
						error_msg.append (":")
						error_msg.append (l_element_local_part)
						error_msg.append (">")
						on_error (error_msg)
					end
				else
					on_start_tag_resolved (context.resolve_default,
							l_element_prefix, l_element_local_part)
					on_delayed_attributes
				end
			else
				check local_part_attached: False end
			end
			Precursor
		end

	on_end_tag (a_namespace: detachable READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
			-- Process end tag.
		do
			if a_prefix /= Void and then has_prefix (a_prefix) then
				Precursor (context.resolve (a_prefix), a_prefix, a_local_part)
			else
				Precursor (context.resolve_default, a_prefix, a_local_part)
			end
			context.pop
		end

feature {NONE} -- Attribute events

	on_delayed_attributes
			-- Resolve attributes.
		local
			l_att_prefix: detachable READABLE_STRING_32
		do
			from
			until
				attributes_is_empty
			loop
				l_att_prefix := attributes_prefix.item
				if l_att_prefix /= Void and then has_prefix (l_att_prefix) then
					-- Resolve the attribute's prefix if it has any.
					if context.has (l_att_prefix) then
						on_attribute_resolved (context.resolve (l_att_prefix),
							l_att_prefix, attributes_local_part.item,
							attributes_value.item)
					elseif is_xml (l_att_prefix) then
							-- xml: prefix has implicit namespace
						on_attribute_resolved (Xml_prefix_namespace,
							l_att_prefix,
							attributes_local_part.item,
							attributes_value.item)
					elseif is_xmlns (l_att_prefix) then
							-- xmlns: prefix has implicit namespace
						on_attribute_resolved (Xmlns_namespace,
							l_att_prefix,
							attributes_local_part.item,
							attributes_value.item)
					else
						on_error (Undeclared_namespace_error)
					end
				else
					on_attribute_resolved (Unprefixed_attribute_namespace,
						l_att_prefix, attributes_local_part.item,
						attributes_value.item)
				end
					-- Forth:
				attributes_remove
			end
		end

	on_start_tag_resolved (a_namespace: READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32)
		do
			next.on_start_tag (a_namespace, a_prefix, a_local_part)
		end

	on_attribute_resolved (a_namespace: READABLE_STRING_32; a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32; a_value: READABLE_STRING_32)
		do
			next.on_attribute (a_namespace, a_prefix, a_local_part, a_value)
		end

feature {NONE} -- Context

	context: XML_NAMESPACE_RESOLVER_CONTEXT
			-- Context

feature {NONE} -- Context

	is_xmlns (a: detachable READABLE_STRING_32): BOOLEAN
			-- Is this an xmlns[:] declaration?
		do
			Result := a /= Void and then same_string (Xmlns, a)
		end

	is_xml (a: READABLE_STRING_32): BOOLEAN
			-- Is this a xml: declaration?
		do
			Result := a /= Void and then same_string (Xml_prefix, a)
		end

	Unprefixed_attribute_namespace: READABLE_STRING_32
			-- Namespace used for unprefixed attributes.
		do
			Result := Default_namespace
		end

feature {NONE} -- Element

	element_prefix: detachable READABLE_STRING_32
	element_local_part: detachable READABLE_STRING_32

feature {NONE} -- Attributes

	attributes_make
			-- Intialize queue.
		do
			create attributes_prefix.make (5)
			create attributes_local_part.make (5)
			create attributes_value.make (5)
		end

	attributes_force (a_prefix: detachable READABLE_STRING_32; a_local_part: READABLE_STRING_32; a_value: READABLE_STRING_32)
			-- Like attributes.force.
		do
			attributes_prefix.force (a_prefix)
			attributes_local_part.force (a_local_part)
			attributes_value.force (a_value)
		end

	attributes_remove
			-- Like attributes.remove.
		require
			not_empty: not attributes_is_empty
		do
			attributes_prefix.remove
			attributes_local_part.remove
			attributes_value.remove
		end

	attributes_is_empty: BOOLEAN
			-- Like attributes.is_empty.
		do
			Result := attributes_prefix.is_empty
		end

	attributes_prefix: ARRAYED_QUEUE [detachable READABLE_STRING_32]
	attributes_local_part: ARRAYED_QUEUE [READABLE_STRING_32]
	attributes_value: ARRAYED_QUEUE [READABLE_STRING_32]

feature {NONE} -- Error

	Default_namespace: STRING_32 = ""
	Xml_prefix: STRING_32 = "xml"
	Xmlns: STRING_32 = "xmlns"

	Xml_prefix_namespace: STRING_32 = "http://www.w3.org/XML/1998/namespace"
	Xmlns_namespace: STRING_32 = "http://www.w3.org/2000/xmlns/"

	Undeclared_namespace_error: STRING_32 = "Undeclared namespace error"
			-- Error messages	

	Duplicate_namespace_declaration_error: STRING_32 = "Namespace declared twice"
			-- Error messages

feature {NONE} -- Implementation

	same_string (a,b: detachable READABLE_STRING_32): BOOLEAN
			-- Are `a' and `b' the same string?
		do
			if a = b then
				Result := True
			elseif a /= Void and b /= Void then
				Result := a.same_string (b)
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

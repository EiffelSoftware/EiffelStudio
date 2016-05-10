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
			initialize,
			make_null,
			on_finish,
			on_start,
			on_start_tag,
			on_attribute,
			on_start_tag_finish,
			on_end_tag
		end

create
	make_null,
	make_next

feature {NONE} -- Initialization

	make_null
			-- <Precursor>
		do
			initialize
			Precursor
		end

	initialize
		do
			Precursor
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

	on_start_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
			-- Process start of start tag.
		do
			context.push
			check empty_attributes: attributes_is_empty end
				-- Save for when we can resolve it, event deferred.
			element_prefix := a_prefix
			element_local_part := a_local_part
		end

	on_attribute (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING; a_value: STRING)
			-- Process attribute.
		do
			if not has_prefix (a_prefix) and is_xmlns (a_local_part) then
					-- Default declaration.
				context.add_default (a_value.string)
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
			error_msg: STRING
			l_element_prefix: like element_prefix
		do
			if attached element_local_part as l_element_local_part then
				l_element_prefix := element_prefix
				if l_element_prefix /= Void and then has_prefix (l_element_prefix) then
					if context.has (l_element_prefix) then
						next.on_start_tag (context.resolve (l_element_prefix),
								l_element_prefix, l_element_local_part)
						on_delayed_attributes
					else
						create error_msg.make_from_string (Undeclared_namespace_error)
						error_msg.append_string (" in tag <")
						error_msg.append_string (l_element_prefix)
						error_msg.append_character (':')
						error_msg.append_string (l_element_local_part)
						error_msg.append_character ('>')
						on_error (error_msg)
					end
				else
					next.on_start_tag (context.resolve_default,
							l_element_prefix, l_element_local_part)
					on_delayed_attributes
				end
			else
				check local_part_attached: False end
			end
			Precursor
		end

	on_end_tag (a_namespace: detachable STRING; a_prefix: detachable STRING; a_local_part: STRING)
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
			l_att_prefix: detachable STRING
		do
			from
			until
				attributes_is_empty
			loop
				l_att_prefix := attributes_prefix.item
				if l_att_prefix /= Void and then has_prefix (l_att_prefix) then
					-- Resolve the attribute's prefix if it has any.
					if context.has (l_att_prefix) then
						next.on_attribute (context.resolve (l_att_prefix),
							l_att_prefix, attributes_local_part.item,
							attributes_value.item)
					elseif is_xml (l_att_prefix) then
							-- xml: prefix has implicit namespace
						next.on_attribute (Xml_prefix_namespace,
							l_att_prefix,
							attributes_local_part.item,
							attributes_value.item)
					elseif is_xmlns (l_att_prefix) then
							-- xmlns: prefix has implicit namespace
						next.on_attribute (Xmlns_namespace,
							l_att_prefix,
							attributes_local_part.item,
							attributes_value.item)
					else
						on_error (Undeclared_namespace_error)
					end
				else
					next.on_attribute (Unprefixed_attribute_namespace,
						l_att_prefix, attributes_local_part.item,
						attributes_value.item)
				end
					-- Forth:
				attributes_remove
			end
		end

feature {NONE} -- Context

	context: XML_NAMESPACE_RESOLVER_CONTEXT
			-- Context

feature {NONE} -- Context

	is_xmlns (a: detachable STRING): BOOLEAN
			-- Is this an xmlns[:] declaration?
		do
			Result := a /= Void and then same_string (Xmlns, a)
		end

	is_xml (a: STRING): BOOLEAN
			-- Is this a xml: declaration?
		do
			Result := a /= Void and then same_string (Xml_prefix, a)
		end

	Unprefixed_attribute_namespace: STRING
			-- Namespace used for unprefixed attributes.
		do
			Result := Default_namespace
		end

feature {NONE} -- Element

	element_prefix: detachable STRING
	element_local_part: detachable STRING

feature {NONE} -- Attributes

	attributes_make
			-- Intialize queue.
		do
			create {ARRAYED_QUEUE [detachable STRING]} attributes_prefix.make (5)
			create {ARRAYED_QUEUE [STRING]} attributes_local_part.make (5)
			create {ARRAYED_QUEUE [STRING]} attributes_value.make (5)
		end

	attributes_force (a_prefix: detachable STRING; a_local_part: STRING; a_value: STRING)
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

	attributes_prefix: ARRAYED_QUEUE [detachable STRING]
	attributes_local_part: ARRAYED_QUEUE [STRING]
	attributes_value: ARRAYED_QUEUE [STRING]

feature {NONE} -- Error

	Default_namespace: STRING = ""
	Xml_prefix: STRING = "xml"
	Xmlns: STRING = "xmlns"

	Xml_prefix_namespace: STRING = "http://www.w3.org/XML/1998/namespace"
	Xmlns_namespace: STRING = "http://www.w3.org/2000/xmlns/"

	Undeclared_namespace_error: STRING = "Undeclared namespace error"
			-- Error messages	

	Duplicate_namespace_declaration_error: STRING = "Namespace declared twice"
			-- Error messages

feature {NONE} -- Implementation

	same_string (a,b: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Are `a' and `b' the same string?
		do
			if a = b then
				Result := True
			elseif a /= Void and b /= Void then
				Result := a.same_string (b)
			end
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

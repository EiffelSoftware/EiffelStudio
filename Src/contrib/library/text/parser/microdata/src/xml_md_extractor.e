note
	description: "Summary description for {XML_MD_EXTRACTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XML_MD_EXTRACTOR

inherit
	XML_NODE_ITERATOR
		redefine
			process_element
		end

create
	make,
	make_with_document

feature {NONE} -- Initialization

	make
		do
			make_with_document (create {MD_DOCUMENT}.make)
		end

	make_with_document (a_doc: MD_DOCUMENT)
		do
			document := a_doc
			create stack_of_nodes.make (1)
			create xml_associations.make (1)
		end

feature -- Access

	document: MD_DOCUMENT

feature -- Visit


	process_element (e: XML_ELEMENT)
		local
			l_id_node: detachable MD_ID_NODE
			l_item, l_new_item: detachable MD_ITEM
			l_prop, l_new_prop: detachable MD_PROPERTY
			l_last_container: like last_container
			l_node: detachable MD_NODE
			l_name,
			l_type: detachable READABLE_STRING_32
			l_value: detachable READABLE_STRING_32
			l_tagname: READABLE_STRING_32
		do
			l_last_container := last_container

			if attached e.attribute_by_name ("itemtype") as att_type then
				l_type := att_type.value
			end

			if attached e.attribute_by_name ("itemprop") as att_prop then
				l_name := att_prop.value
				l_tagname := e.name
				if e.has_attribute_by_name ("itemscope") then
					l_value := Void -- the item itself
				elseif l_tagname.is_case_insensitive_equal_general ("meta") then
					l_value := attribute_value (e, "content")
				elseif
					l_tagname.is_case_insensitive_equal_general ("a") or else
					l_tagname.is_case_insensitive_equal_general ("area") or else
					l_tagname.is_case_insensitive_equal_general ("link")
				then
					l_value := attribute_value (e, "href")
				elseif
					l_tagname.is_case_insensitive_equal_general ("img") or else
					l_tagname.is_case_insensitive_equal_general ("audio") or else
					l_tagname.is_case_insensitive_equal_general ("embed") or else
					l_tagname.is_case_insensitive_equal_general ("iframe") or else
					l_tagname.is_case_insensitive_equal_general ("source") or else
					l_tagname.is_case_insensitive_equal_general ("track") or else
					l_tagname.is_case_insensitive_equal_general ("video")
				then
					--FIXME: If the element is an audio, embed, iframe, img, source, track, or video element
					--		The value is the absolute URL that results from resolving the value of the
					--		element's src attribute relative to the element at the time the attribute is set,
					--		or the empty string if there is no such attribute or if resolving it results in an error.
					l_value := attribute_value (e, "src")
				elseif l_tagname.is_case_insensitive_equal_general ("object") then
					l_value := attribute_value (e, "data")
				elseif l_tagname.is_case_insensitive_equal_general ("data") then
					l_value := attribute_value (e, "value")
				elseif l_tagname.is_case_insensitive_equal_general ("time") then
					-- FIXME
					if e.has_attribute_by_name ("time") then
						l_value := attribute_value (e, "time")
					elseif e.has_attribute_by_name ("datetime") then
						l_value := attribute_value (e, "datetime")
					else
						l_value := element_text_content (e)
					end
				else
					l_value := element_text_content (e)
				end
				if e.has_attribute_by_name ("itemscope") then
					create l_item.make_with_name (l_name, l_type)
					if attached e.attribute_by_name ("itemid") as l_id then
						l_item.set_identifier (l_id.value)
					end
					if attached e.attribute_by_name ("itemref") as l_ref then
						l_item.set_references (l_ref.value)
					end
					l_node := l_item
				elseif l_value = Void then
					create l_prop.make (l_name, element_text_content (e), l_type)
					l_node := l_prop
				else
					create l_prop.make (l_name, l_value, l_type)
					l_node := l_prop
				end
				if l_item /= Void then
					push_on_stack (l_item, e)
				end
				Precursor (e)
				if l_last_container /= Void then
					if l_name.has (' ') then
						across
							l_name.split (' ') as c_names
						loop
							if l_item /= Void then
								l_new_item := l_item.twin
								l_new_item.set_name (c_names.item)
								l_last_container.put (l_new_item)
							elseif l_prop /= Void then
								l_new_prop := l_prop.twin
								l_new_prop.set_name (c_names.item)
								l_last_container.put (l_new_prop)
							else
								check is_item_or_prop: False end
							end
						end
					else
						l_last_container.put (l_node)
					end
				end
				if l_item /= Void then
					unpush_from_stack
				end
			elseif e.has_attribute_by_name ("itemscope") then
				create l_item.make (l_type)
				if attached e.attribute_by_name ("itemid") as l_id then
					l_item.set_identifier (l_id.value)
				end
				if attached e.attribute_by_name ("itemref") as l_ref then
					l_item.set_references (l_ref.value)
				end
				document.put (l_item)
				push_on_stack (l_item, e)
				Precursor (e)
				unpush_from_stack
			elseif e.has_attribute_by_name ("id") and then attached e.attribute_by_name ("id") as att_id then
				create l_id_node.make (att_id.value)
				document.register_id_node (l_id_node)
				push_on_stack (l_id_node, e)
				Precursor (e)
				unpush_from_stack
				if l_id_node.count = 0 then
						-- No properties, thus removing it
					document.unregister_id_node (l_id_node)
				end
			else
				Precursor (e)
			end
			if
				l_last_container /= Void and then
				associated_xml_element (l_last_container) = e -- missing an unpush_from_stack ??
			then
					-- Close current itemscope
				from
				until
					stack_of_nodes.is_empty or stack_of_nodes.item /= l_last_container
				loop
					stack_of_nodes.remove
				end
			end
		ensure then
			same_stack_count: stack_of_nodes.count = old stack_of_nodes.count
		end

feature {NONE} -- Helpers

	stack_of_nodes: ARRAYED_STACK [MD_NODE]

	xml_associations: ARRAYED_LIST [TUPLE [xml: XML_ELEMENT; md: MD_NODE]]

	unpush_from_stack
		require
			not stack_of_nodes.is_empty
		local
			l_xml_associations: like xml_associations
			done: BOOLEAN
			l_node: detachable MD_NODE
		do
			l_node := stack_of_nodes.item
			stack_of_nodes.remove
			from
				l_xml_associations := xml_associations
				l_xml_associations.start
			until
				done
			loop
				if l_xml_associations.item.md = l_node then
					l_xml_associations.remove
					done := True
				else
					l_xml_associations.forth
				end
			end
		end

	push_on_stack (a_node: MD_NODE; e: XML_ELEMENT)
		do
			xml_associations.force ([e, a_node])
			stack_of_nodes.put (a_node)
		end

	associated_xml_element (a_node: MD_NODE): detachable XML_ELEMENT
		do
			across
				xml_associations as c
			until
				Result /= Void
			loop
				if c.item.md = a_node then
					Result := c.item.xml
				end
			end
		end

	last_container: detachable MD_COMPOSITE
		do
			if not stack_of_nodes.is_empty then
				if attached {like last_container} stack_of_nodes.item as res then
					Result := res
				end
			end
		end

	attribute_value (e: XML_ELEMENT; a_attribute: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		do
			if attached e.attribute_by_name (a_attribute) as att then
				Result := att.value
			end
		end

	element_text_content (e: XML_ELEMENT): READABLE_STRING_32
		do
			Result := e.joined_content
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

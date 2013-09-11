note
	description: "Item qualified by `itemscope' and indicates that descendants of this element contain information about it."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=HTML Microdata Item", "protocol=URI", "src=http://www.w3.org/TR/microdata/#items"

class
	MD_ITEM

inherit
	MD_COMPOSITE

	MD_TYPED_NODE

create
	make,
	make_with_name

feature {NONE} -- Initialization

	make (a_type_url: detachable READABLE_STRING_GENERAL)
		do
			initialize
			set_type_url (a_type_url)
		end

	make_with_name (a_name: READABLE_STRING_GENERAL; a_type_url: detachable READABLE_STRING_GENERAL)
		do
			make (a_type_url)
			set_name (a_name)
		end

feature -- Access

	name: detachable IMMUTABLE_STRING_32
			-- Itemprop name

	identifier: detachable IMMUTABLE_STRING_32
			-- unique identifier of the item
			-- cf: itemid

	references: detachable LIST [READABLE_STRING_GENERAL]
			-- References to md item by its unique identifier
			-- cf: itemref

feature -- Change

	set_name (a_name: detachable READABLE_STRING_GENERAL)
			-- Update name
		do
			if a_name = Void then
				name := Void
			else
				create name.make_from_string_general (a_name)
			end
		end

	set_identifier (a_identifier: detachable READABLE_STRING_GENERAL)
		do
			if a_identifier = Void then
				identifier := Void
			else
				create identifier.make_from_string_general (a_identifier)
			end
		end

	set_references (a_refs: detachable READABLE_STRING_GENERAL)
		do
			if a_refs = Void then
				references := Void
			else
				across
					a_refs.split (' ') as c
				loop
					add_reference (c.item)
				end
			end
		end

	add_reference (a_ref: READABLE_STRING_GENERAL)
			-- Add `a_ref' to `references'
		local
			l_refs: like references
		do
			l_refs := references
			if l_refs = Void then
				create {ARRAYED_LIST [READABLE_STRING_GENERAL]} l_refs.make (1)
				references := l_refs
			end
			l_refs.force (a_ref)
		end

	import_references
			-- Import eventual references into Current
			-- remove the reference if imported, keep unresolved references
		local
			doc: like document
		do
			if attached references as refs then
				doc := document
				if doc /= Void then
					from
						refs.start
					until
						refs.after
					loop
						if attached doc.id_node (refs.item) as l_node then
							put (l_node.deep_twin)
							refs.remove
						else
							refs.forth
						end
					end
				end
				if refs.is_empty then
					references := Void
				end
			end
		end

feature -- Status report

	debug_output: STRING_32
			-- <Precursor>
		do
			create Result.make_empty
			if attached name as n then
				Result.append_character ('%"')
				Result.append_string_general (n)
				Result.append_character ('%"')
			else
				Result.append_string_general ("Item")
			end
			if attached type as l_itemtype then
				Result.append_character (' ')
				Result.append_character ('<')
				Result.append (l_itemtype.url)
				Result.append_character ('>')
			end
			if attached identifier as l_id then
				Result.append_character (' ')
				Result.append_character ('#')
				Result.append (l_id)
			end
			if count > 0 then
				Result.append_string_general (" : ")
				Result.append_integer (count)
				Result.append_string_general (" props")
			end
			if attached references as refs and then not refs.is_empty then
				Result.append_character (' ')
				Result.append_character ('(')
				Result.append_integer (refs.count)
				Result.append_string_general (" references")
				Result.append_character (')')
			end
		end

feature -- Visitor

	accept (vis: MD_VISITOR)
		do
			vis.visit_item (Current)
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

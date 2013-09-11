note
	description: "Summary description for {MD_PROPERTY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_PROPERTY

inherit
	MD_NAMED_NODE

	MD_TYPED_NODE

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_GENERAL; a_value: READABLE_STRING_GENERAL; a_type_url: detachable READABLE_STRING_GENERAL)
		do
			set_type_url (a_type_url)
			set_name (a_name)
			create {ARRAYED_LIST [IMMUTABLE_STRING_32]} values.make (1)
			add_value (a_value)
		end

feature -- Access

	values: LIST [IMMUTABLE_STRING_32]
			-- Associated values

	count: INTEGER
			-- Number of associated values.
		do
			Result := values.count
		end

feature -- Change

	add_value (a_value: READABLE_STRING_GENERAL)
		do
			if attached {IMMUTABLE_STRING_32} a_value as v  then
				values.force (v)
			else
				values.force (create {IMMUTABLE_STRING_32}.make_from_string_general (a_value))
			end
		end

	merge (a_prop: MD_PROPERTY)
		do
			across
				a_prop.values as c
			loop
				values.force (c.item)
			end
		end

feature -- Status report

	debug_output: STRING_32
			-- <Precursor>
		local
			f: BOOLEAN
		do
			create Result.make_empty
			Result.append_string_general ("Prop %"")
			Result.append_string_general (name)
			Result.append_character ('%"')
			if attached type as l_itemtype then
				Result.append_character (' ')
				Result.append_character ('<')
				Result.append (l_itemtype.url)
				Result.append_character ('>')
			end
			if attached values as l_values then
				Result.append_string_general (" = [")
				f := True
				across
					l_values as c
				loop
					if f then
						f := False
					else
						Result.append_character (',')
						Result.append_character (' ')
					end
					Result.append_character ('%"')
					Result.append_string_general (c.item)
					Result.append_character ('%"')
				end
				Result.append_character (']')
			end
		end

feature -- Visitor

	accept (vis: MD_VISITOR)
		do
			vis.visit_property (Current)
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

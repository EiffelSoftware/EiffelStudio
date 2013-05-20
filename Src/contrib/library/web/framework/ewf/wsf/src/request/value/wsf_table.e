note
	description: "[
			Table which can contain value indexed by a key
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_TABLE

inherit
	WSF_VALUE
		redefine
			as_string
		end

	ITERABLE [WSF_VALUE]

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_8)
		do
			name := url_decoded_string (a_name)
			url_encoded_name := a_name
			create values.make (5)
		end

feature -- Access

	name: READABLE_STRING_32
			-- Parameter name

	url_encoded_name: READABLE_STRING_8

	first_value: detachable WSF_VALUE
			-- First value if any.
		do
			across
				values as c
			until
				Result /= Void
			loop
				Result := c.item
			end
		end

	first_name: detachable READABLE_STRING_32
		do
			across
				values as c
			until
				Result /= Void
			loop
				Result := c.key
			end
		end

	values: HASH_TABLE [WSF_VALUE, STRING_32]

	value (k: READABLE_STRING_GENERAL): detachable WSF_VALUE
		do
			Result := values.item (k.to_string_32)
		end

	count: INTEGER
		do
			Result := values.count
		end

	frozen first_key: like first_name
		obsolete
			"Use first_name [2012-May-31]"
		do
			Result := first_name
		end

feature -- Element change

	change_name (a_name: like name)
		do
			name := url_decoded_string (a_name)
			url_encoded_name := a_name
		ensure then
			a_name.same_string (url_encoded_name)
		end

feature -- Status report

	is_string: BOOLEAN
			-- Is Current as a WSF_STRING representation?
		do
			if values.count = 1 and then attached first_value as fv then
				Result := fv.is_string
			end
		end

	is_empty: BOOLEAN
			-- Is Current empty?
		do
			Result := values.is_empty
		end

feature -- Conversion

	as_string: WSF_STRING
		do
			if values.count = 1 and then attached first_value as fv then
				Result := fv.as_string
			else
				Result := Precursor
			end
		end

	as_array_of_string: detachable ARRAY [READABLE_STRING_32]
			-- Return an array of STRING if possible., otherwise Void
		local
			i,n: INTEGER
			nb: INTEGER
		do
			from
				i := 1
				n := count
				create Result.make_filled ("", 1, n)
			until
				i > n or Result = Void
			loop
				if attached {WSF_STRING} value (i.out) as s then
					Result.put (s.value, i)
					nb := nb + 1
				else
					Result := Void
				end
				i := i + 1
			end
			if Result /= Void and then nb /= n then
				Result := Void
			end
		ensure
			is_array_of_string implies Result /= Void and then Result.count = count and then Result.lower = 1
		end

	is_array_of_string: BOOLEAN
			-- Is Current representable as an array of string?
		local
			i,n, nb: INTEGER
		do
			from
				i := 1
				n := count
				nb := 0
				Result := True
			until
				i > n or not Result
			loop
				if attached {WSF_STRING} value (i.out) then
					nb := nb + 1
				else
					Result := False
				end
				i := i + 1
			end
			if nb /= n then
				Result := False
			end
		end

feature -- Element change

	add_value (a_value: WSF_VALUE; k: READABLE_STRING_GENERAL)
		require
			same_name: a_value.name.same_string (name) or else (a_value.name.starts_with (name) and then a_value.name.item (name.count + 1) = '[')
		do
			values.force (a_value, k.to_string_32)
		end

feature -- Traversing

	new_cursor: ITERATION_CURSOR [WSF_VALUE]
		do
			Result := values.new_cursor
		end

feature -- Helper

	string_representation: STRING_32
		do
			create Result.make_from_string ("{")
			if values.count = 1 and then attached first_name as fk then
				Result.append (fk + ": ")
				if attached value (fk) as fv then
					Result.append (fv.string_representation)
				else
					Result.append ("???")
				end
			else
				across
					values as c
				loop
					if Result.count > 1 then
						Result.append_character (',')
					end
					Result.append (c.key + ": ")
					Result.append (c.item.string_representation)
				end
			end
			Result.append_character ('}')
		end

feature -- Visitor

	process (vis: WSF_VALUE_VISITOR)
		do
			vis.process_table (Current)
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

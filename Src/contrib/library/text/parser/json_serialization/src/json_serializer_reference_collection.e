note
	description: "Summary description for {JSON_SERIALIZER_REFERENCE_COLLECTION}."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_SERIALIZER_REFERENCE_COLLECTION

create
	make

feature {NONE} -- Initialization

	make
		do
			create json_values.make_caseless (1)
			create references.make (1)
		end

feature -- Cleaning

	reset
		do
			json_values.wipe_out
			references.wipe_out
		end

feature -- Access

	item (obj: ANY): detachable STRING_32
			-- Reference on `obj' if any.
			-- If reference exists, increase the number of callers.
		do
			if attached reference_info (obj) as l_info then
				l_info.caller_count := l_info.caller_count + 1
				Result := l_info.identifier
				if attached json_values.item (Result) as jv then
						-- In case, the json value is already associated, update it with ref right away.
						-- otherwise, it will be done, when the associated is done (when the ref item is fully serialized).
					update_reference (jv, Result)
				end
			end
		end

feature {NONE} -- Implementation		

	reference_info (obj: ANY): detachable TUPLE [identifier: STRING_32; value: ANY; caller_count: INTEGER]
		do
			across
				references as ic
			until
				Result /= Void
			loop
				if ic.item.value = obj then
					Result := ic.item
				end
			end
		end

	update_reference (a_json_value: detachable JSON_VALUE; a_ref: READABLE_STRING_GENERAL)
		do
			if attached {JSON_OBJECT} a_json_value as j then
				if attached {JSON_STRING} j.item ("$REF#") as j_ref_id then
					check same_ref: a_ref.same_string (j_ref_id.unescaped_string_32) end
				else
					j.put_string (a_ref, "$REF#")
				end
			else
					-- Ignore for String
				check False end
			end
		end

feature -- Element change

	record (obj: ANY; a_json_value: detachable JSON_VALUE; ctx: JSON_SERIALIZER_CONTEXT)
		local
			i: INTEGER
			s: STRING_32
			l_ref: READABLE_STRING_GENERAL
		do
			if attached reference_info (obj) as l_info then
					-- Update associated json value
				if l_info.value = a_json_value then
						-- Void or
				else
					l_ref := l_info.identifier
					check json_values.item (l_ref) = Void end
					if l_info.caller_count > 0 then
						update_reference (a_json_value, l_ref)
					end
					json_values.force (a_json_value, l_ref)
				end
			else
				i := counter + 1
				counter := i
				s := i.out
				debug
					create s.make_empty
					s.append_integer (i)
					s.append_character (':')
					s.append_string_general (ctx.serializer_location)
				end
				json_values.force (a_json_value, s)
				references.force ([s, obj, 0])
			end
		end

feature {NONE} -- Implementation

	counter: INTEGER

	json_values: STRING_TABLE [detachable JSON_VALUE]
			-- indexed by reference identifier.

	references: ARRAYED_LIST [TUPLE [identifier: STRING_32; value: ANY; caller_count: INTEGER]]
			-- indexed by reference identifier.			

invariant
	json_values.count = references.count

note
	copyright: "2016-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see https://www.eiffel.com/licensing/forum.txt)"
end

note
	description: "Summary description for {ES_CLOUD_API_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_API_RESPONSE

create
	make

create {ES_CLOUD_API_RESPONSE}
	make_from_json

feature {NONE} -- Creation

	make (a_resp: detachable HTTP_CLIENT_RESPONSE)
		local
			jp: JSON_PARSER
		do
			if a_resp = Void then
				create error.make ("Not available")
				has_internal_error := True
			elseif a_resp.error_occurred then
				create error.make (a_resp.error_message)
				has_internal_error := True
			elseif attached a_resp.body as s then
				create jp.make_with_string (s)
				jp.parse_content
				if
					not jp.has_error and then
					attached jp.parsed_json_value as j
				then
					make_from_json (j)
				else
					create error.make ("Invalid JSON content")
				end
			end
		end

	make_from_json (j: JSON_VALUE)
		do
			json := j
			if attached string_32_item ("error") as err then
				create error.make (err)
			end
		end

feature {NONE} -- Internal

	json: detachable JSON_VALUE

feature -- Access

	has_internal_error: BOOLEAN
			-- Is `error` an internal (network) error?

	has_error: BOOLEAN
		do
			Result := error /= Void
		end

	error: detachable ES_CLOUD_API_ERROR

	table_item (a_name: READABLE_STRING_GENERAL): detachable STRING_TABLE [ES_CLOUD_API_RESPONSE]
		do
			if attached {JSON_OBJECT} json_field (json, a_name) as j then
				create Result.make (j.count)
				across
					j as ic
				loop
					Result.force (create {ES_CLOUD_API_RESPONSE}.make_from_json (ic.item), ic.key.unescaped_string_32)
				end
			end
		end

	list_item (a_name: READABLE_STRING_GENERAL): detachable LIST [ES_CLOUD_API_RESPONSE]
		do
			if attached {JSON_ARRAY} json_field (json, a_name) as j then
				create {ARRAYED_LIST [ES_CLOUD_API_RESPONSE]} Result.make (j.count)
				across
					j as ic
				loop
					Result.force (create {ES_CLOUD_API_RESPONSE}.make_from_json (ic.item))
				end
			end
		end


	sub_item (a_name: READABLE_STRING_GENERAL): detachable ES_CLOUD_API_RESPONSE
		do
			if attached json_field (json, a_name) as j then
				create Result.make_from_json (j)
			end
		end

	integer_64_item (a_name: READABLE_STRING_GENERAL): detachable INTEGER_64
		do
			if attached {JSON_NUMBER} json_field (json, a_name) as j_num then
				Result := j_num.integer_64_item
			elseif attached string_32_item (a_name) as s_num then
				if s_num.is_integer_64 then
					Result := s_num.to_integer_64
				end
			end
		end

	string_32_item (a_name: READABLE_STRING_GENERAL): detachable STRING_32
		do
			if attached {JSON_STRING} json_field (json, a_name) as v then
				Result := v.unescaped_string_32
			end
		end

	string_8_item (a_name: READABLE_STRING_GENERAL): detachable STRING_8
		do
			if attached {JSON_STRING} json_field (json, a_name) as v then
				Result := v.unescaped_string_8
			end
		end

	date_time_item (a_name: READABLE_STRING_GENERAL): detachable DATE_TIME
		local
			hd: HTTP_DATE
		do
			if attached {JSON_STRING} json_field (json, a_name) as v then
				create hd.make_from_string (v.unescaped_string_8)
				check not hd.has_error end
				if not hd.has_error then
					Result := hd.date_time
				end
			end
		end

	string_item_same_caseless_as (a_name: READABLE_STRING_GENERAL; a_value: READABLE_STRING_GENERAL): BOOLEAN
		local
			s: detachable READABLE_STRING_GENERAL
		do
			s := string_32_item (a_name)
			Result := s /= Void and then a_value.is_case_insensitive_equal (s)
		end

	boolean_item_is_true (a_name: READABLE_STRING_GENERAL): BOOLEAN
		do
			if attached {JSON_BOOLEAN} json_field (json, a_name) as jb then
				Result := jb.item
			end
		end

	boolean_item_is_false (a_name: READABLE_STRING_GENERAL): BOOLEAN
		do
			if attached {JSON_BOOLEAN} json_field (json, a_name) as jb then
				Result := not jb.item
			end
		end

feature -- Access

	to_json_representation: STRING
		local
			pp: JSON_PRETTY_STRING_VISITOR
		do
			if attached json as j then
				create Result.make (1024)
				create pp.make (Result)
				j.accept (pp)
			end
		end

feature {NONE} -- Initialize

	json_field (j: detachable JSON_VALUE; a_fn: READABLE_STRING_GENERAL): detachable JSON_VALUE
		local
			exp: LIST [READABLE_STRING_GENERAL]
			l_obj: detachable JSON_OBJECT
			l_val: detachable JSON_VALUE
		do
			if j /= Void then
				if attached {JSON_OBJECT} j as jo then
					exp := a_fn.split ('|')
					from
						exp.start
						l_obj := jo
						l_val := l_obj
					until
						exp.after or l_obj = void
					loop
						l_val := l_obj.item (exp.item)
						if exp.islast then
								-- Result in `l_val`
						else
							if attached {JSON_OBJECT} l_val as o then
								l_obj := o
							end
							l_val := Void
						end
						exp.forth
					end
					Result := l_val
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

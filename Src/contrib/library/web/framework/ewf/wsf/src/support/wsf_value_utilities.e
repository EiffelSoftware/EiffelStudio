note
	description: "[
			Utility routines to handle parameters and convert them as string, list or table values.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_VALUE_UTILITIES

inherit
	ANY

	SHARED_WSF_PERCENT_ENCODER
		rename
			percent_encoder as url_encoder
		export
			{NONE} all
		end

feature -- Smart parameter identification

	add_utf_8_string_value_to_table (a_utf_8_name: READABLE_STRING_8; a_utf_8_value: READABLE_STRING_8; a_table: HASH_TABLE [WSF_VALUE, READABLE_STRING_GENERAL])
			-- Add a utf-8 string value `a_utf_8_value' associated with name `a_utf_8_name' to `a_table'.
		local
			utf: UTF_CONVERTER
			n,v: READABLE_STRING_32
		do
			n := utf.utf_8_string_8_to_string_32 (a_utf_8_name)
			v := utf.utf_8_string_8_to_string_32 (a_utf_8_value)
			add_value_to_table (n, new_string_value (n, v), a_table)
		end

	add_percent_encoded_string_value_to_table (a_encoded_name: READABLE_STRING_8; a_encoded_value: READABLE_STRING_8; a_table: HASH_TABLE [WSF_VALUE, READABLE_STRING_GENERAL])
			-- Add a percent-encoded string value `a_encoded_value' associated with name `a_encoded_name' to `a_table'.
		local
			v: WSF_STRING
		do
			v := new_string_value_with_percent_encoded_values (a_encoded_name, a_encoded_value)
			add_value_to_table (v.name, v, a_table)
		end

	add_value_to_table (a_name: READABLE_STRING_GENERAL; a_value: WSF_VALUE; a_table: HASH_TABLE [WSF_VALUE, READABLE_STRING_GENERAL])
			-- Add value `a_value' associated with unicode name `a_name' to `a_table'.
		local
			l_decoded_name: STRING_32
			l_encoded_name: READABLE_STRING_8
			v: detachable WSF_VALUE
			n,k,r,vn: STRING_32
			p,q: INTEGER
			tb,ptb: detachable WSF_TABLE
		do
				--| Check if this is a list format such as   choice[]  or choice[a] or even choice[a][] or choice[a][b][c]...
			l_decoded_name := a_name.as_string_32
			l_encoded_name := a_value.url_encoded_name
			p := l_decoded_name.index_of ({CHARACTER_32}'[', 1)
			n := l_decoded_name
			if p > 0 then
				q := l_decoded_name.index_of ({CHARACTER_32}']', p + 1)
				if q > p then
					n := l_decoded_name.substring (1, p - 1)
					r := l_decoded_name.substring (q + 1, l_decoded_name.count)
					r.left_adjust; r.right_adjust

					create tb.make (n)
					if attached {WSF_TABLE} a_table.item (tb.name) as l_existing_table then
						tb := l_existing_table
					end

					k := l_decoded_name.substring (p + 1, q - 1)
					k.left_adjust; k.right_adjust
					if k.is_empty then
						k.append_integer (tb.count + 1)
					end
					v := tb
					create vn.make_from_string (n)
					vn.append_character ({CHARACTER_32}'[')
					vn.append (k)
					vn.append_character ({CHARACTER_32}']')

					from
					until
						r.is_empty
					loop
						ptb := tb
						p := r.index_of ({CHARACTER_32} '[', 1)
						if p > 0 then
							q := r.index_of ({CHARACTER_32} ']', p + 1)
							if q > p then
								if attached {WSF_TABLE} ptb.value (k) as l_tb_value then
									tb := l_tb_value
								else
									create tb.make (n)
									ptb.add_value (tb, k)
								end

								k := r.substring (p + 1, q - 1)
								r := r.substring (q + 1, r.count)
								r.left_adjust; r.right_adjust
								if k.is_empty then
									k.append_integer (tb.count + 1)
								end
								vn.append_character ('[')
								vn.append (k)
								vn.append_character (']')
							end
						else
							r.wipe_out
							--| Ignore bad value
						end
					end
					a_value.change_name (vn)
					tb.add_value (a_value, k)
				else
					--| Missing end bracket
				end
			end
			if v = Void then
				a_value.change_name (l_decoded_name)
				v := a_value
			end
			if attached a_table.item (n) as l_existing_value then
				if tb /= Void then
					--| Already done in previous part
				elseif attached {WSF_MULTIPLE_STRING} l_existing_value as l_multi then
					l_multi.add_value (v)
				elseif attached {WSF_TABLE} l_existing_value as l_table then
					-- Keep previous values (most likely we have table[1]=foo, table[2]=bar ..and table=/foo/bar
					-- Anyway for this case, we keep the previous version, and ignore this "conflict"
				else
					a_table.force (create {WSF_MULTIPLE_STRING}.make_with_array (<<l_existing_value, v>>), v.name)
					check replaced: a_table.found and then a_table.found_item ~ l_existing_value end
				end
			else
				a_table.force (v, n)
			end
		end

feature -- Factory

	new_string_value (a_name: READABLE_STRING_GENERAL; a_value: READABLE_STRING_GENERAL): WSF_STRING
			-- New WSF_STRING value built from unicode `a_name' and `a_value'.
		do
			create Result.make (a_name, a_value)
		end

	new_string_value_with_percent_encoded_values (a_encoded_name: READABLE_STRING_8; a_encoded_value: READABLE_STRING_8): WSF_STRING
			-- New WSF_STRING value built from utf8+percent encoded `a_encoded_name' and `a_encoded_value'.
		do
			create Result.make_with_percent_encoded_values (a_encoded_name, a_encoded_value)
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

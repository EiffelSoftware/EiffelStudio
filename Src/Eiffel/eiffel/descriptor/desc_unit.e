note
	description: "Descriptor unit: block in class type descriptor corresponding to%
		%given parent class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DESC_UNIT

inherit
	TO_SPECIAL [ENTRY]

	COMPILER_EXPORTER

	SHARED_COUNTER

create
	make

feature {NONE} -- Creation

	make (c_id: INTEGER; sz: INTEGER)
		do
			class_id := c_id
			create area.make_filled (Void, sz)
			count := sz
		end

feature -- Status report

	count: INTEGER
			-- Number of elements in Current.

feature {NONE} -- Access

	class_id: INTEGER

feature -- Generation

	generate (buffer: GENERATION_BUFFER; cnt : COUNTER; id_string: STRING)
			-- C code of Current descriptor unit
			--|Note1: Currently the feature type is written for all the
			--|features when in practice it is used rather seldom. Try
			--|to find a better representation (without affecting the
			--|incrementality).
			--|Note2: The offset of an attribute is coded on 16 bits
			--|which might not be enough.
		require
			buffer_not_void: buffer /= Void
			valid_counter: cnt /= Void
		local
			i, j: INTEGER
			l_count, l_type_id: INTEGER
			l_area: like area
			entry_item: ENTRY
			gen_type, generic_union, non_generic_union: STRING
		do
			from
				gen_type := once "egt_"
				generic_union := once "EIF_GENERIC("
				non_generic_union := once "EIF_NON_GENERIC("
				l_count := count - 1
				l_area := area
			until
				i > l_count
			loop
				entry_item := l_area.item (i)
				buffer.put_three_character ('%N', '%T', '{')
				if entry_item /= Void then
						-- Write the type description of the feature.
					if not entry_item.type.is_void then
						if entry_item.needs_extended_info then
							buffer.put_string (generic_union)
							buffer.put_string (gen_type)
							buffer.put_integer (cnt.value)
							buffer.put_string (id_string)
							j := cnt.next
						else
								-- We do a special trick here to distinguish
								-- the value from a pointer, we store 1 in the low
								-- part and 1-bit above the actual type.
								-- As a result at runtime we can quickly check if
								-- we have a type array or a single value.
							l_type_id := entry_item.static_feature_type_id - 1
							check l_type_id_non_negative: l_type_id >= 0 end
							buffer.put_string (non_generic_union)
							buffer.put_hex_integer_32 (l_type_id |<< 1 | 1)
							buffer.put_three_character (' ', '/', '*')
							buffer.put_integer (l_type_id)
							buffer.put_two_character ('*', '/')
						end
					else
						buffer.put_string (generic_union)
						buffer.put_string ({C_CONST}.null)
					end
					buffer.put_character (')')

					buffer.put_two_character (',', ' ')
					if attached {ROUT_ENTRY} entry_item as re then
							-- The entry corresponds to a routine.
							-- Write the body index of the routine (index
							-- into the run-time dispatch table).
						buffer.put_real_body_index (re.real_body_index)
						buffer.put_two_character (',', ' ')
						if re.is_attribute then
							buffer.put_integer (re.workbench_offset)
						else
								-- No offset
							buffer.put_hex_integer_32 (-1)
						end
					elseif attached {ATTR_ENTRY} entry_item as ae then
							-- Do not write a body index.
						buffer.put_hex_integer_32 (-1)
						buffer.put_two_character (',', ' ')							-- Write the offset of the attribute in the
							-- run-time structure (object).
						buffer.put_integer (ae.workbench_offset)
					else
						check attribute_or_routine: False end
					end
					buffer.put_two_character ('}', ',')
				else
						-- The entry corresponds to a routine that is not present anymore.
					buffer.put_string (generic_union)
					buffer.put_string ({C_CONST}.null)
					buffer.put_three_character (')', ',', ' ')
					buffer.put_hex_integer_32 (-1)
					buffer.put_two_character (',', ' ')
					buffer.put_hex_integer_32 (-1)
					buffer.put_two_character ('}', ',')
				end
				i := i + 1
			end
		end

	generate_generic (buffer: GENERATION_BUFFER; cnt : COUNTER; id_string: STRING)
			-- C code for generic types in Current descriptor unit
		require
			buffer_not_void: buffer /= Void
			valid_counter : cnt /= Void
		local
			i, j: INTEGER
			l_count: INTEGER
			entry_item: ENTRY
			static_decl, start_decl: STRING
			l_area: like area
		do
			from
				static_decl := once "static const EIF_TYPE_INDEX egt_"
				start_decl := once " [] = {"
				l_count := count - 1
				l_area := area
			until
				i > l_count
			loop
				entry_item := l_area.item (i)
				if entry_item /= Void and then entry_item.needs_extended_info then
					buffer.put_string (static_decl)
					buffer.put_integer (cnt.value)
					buffer.put_string (id_string)
					j := cnt.next
					buffer.put_string (start_decl)
					entry_item.generate_cid (buffer, False)
					buffer.put_hex_natural_16 ({SHARED_GEN_CONF_LEVEL}.terminator_type)
					buffer.put_three_character ('}', ';', '%N')
				end
				i := i + 1
			end
		end

feature -- Melting

	make_byte_code (ba: BYTE_ARRAY)
			-- Append byte code of Current descriptor
			-- unit to the `ba' byte array.
			-- Format:
			--    1) Id of origin class (short)
			--    2) Number of elements (short)
			--    3) Sequence of triples (short, short, list_of_short)
		local
			i: INTEGER
			l_count: INTEGER
			entry_item: ENTRY
			l_area: like area
		do
				-- Append the id of the origin class
			ba.append_short_integer (class_id)

			l_count := count

				-- Append the size of the descriptor unit
			ba.append_short_integer (l_count)

				-- Append the descriptor entries
			from
					-- For loop purposes we decreased `l_count'.
				l_count := l_count - 1
				l_area := area
			until
				i > l_count
			loop
				entry_item := l_area.item (i)
				if entry_item /= Void then
						-- Write the type description of the feature.
					if not entry_item.type.is_void then
						if entry_item.needs_extended_info then
							ba.append_boolean (True)
							entry_item.make_gen_type_byte_code (ba)
							ba.append_short_integer (-1)
						else
							ba.append_boolean (False)
							check type_id_positive: entry_item.static_feature_type_id > 0 end
							ba.append_natural_16 (entry_item.static_feature_type_id.to_natural_16 - 1)
						end
					else
							-- Generate the NULL pointer array.
						ba.append_boolean (True)
						ba.append_short_integer (-1)
					end

					if attached {ROUT_ENTRY} entry_item as re then
							-- The entry corresponds to a routine.
							-- Write the body index of the routine (index
							-- into the run-time dispatch table).
						ba.append_uint32_integer (re.real_body_index - 1)
						if re.is_attribute then
								-- Write the offset of the attribute in the
								-- run-time structure (object).
							ba.append_uint32_integer (re.workbench_offset)
						else
							ba.append_uint32_integer (-1)
						end
					elseif attached {ATTR_ENTRY} entry_item as ae then
						ba.append_uint32_integer (-1)
							-- Write the offset of the attribute in the
							-- run-time structure (object).
						ba.append_uint32_integer (ae.workbench_offset)
					else
						check attribute_or_routine: False end
					end
				else
						-- The entry corresponds to a routine that is not present anymore.
					ba.append_boolean (True)
					ba.append_short_integer (-1)
					ba.append_uint32_integer (-1)
					ba.append_uint32_integer (-1)
				end
				i := i + 1
			end
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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

end -- class DESC_UNIT

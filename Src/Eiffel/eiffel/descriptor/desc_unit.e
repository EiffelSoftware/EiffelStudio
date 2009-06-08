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
			i,j: INTEGER
			l_count: INTEGER
			re: ROUT_ENTRY
			ae: ATTR_ENTRY
			l_area: like area
			entry_item: ENTRY
			body_index_cast, invalid_dtype_string, type_index_cast, gen_type, null_string: STRING
			l_static_feature_type_id, l_real_body_index: INTEGER
		do
			from
				body_index_cast := once "(BODY_INDEX)"
				invalid_dtype_string := once "INVALID_DTYPE"

				type_index_cast := once "(EIF_TYPE_INDEX)"
				gen_type := once "gen_type"
				null_string := once "NULL"
				l_count := count - 1
				l_area := area
			until
				i > l_count
			loop
				entry_item := l_area.item (i)
				buffer.put_three_character ('%N', '%T', '{')
				if entry_item /= Void then
					re ?= entry_item
					if re /= Void then
							-- The entry corresponds to a routine.
							-- Write the body index of the routine (index
							-- into the run-time dispatch table).
						l_real_body_index := re.real_body_index
						if l_real_body_index <= 0 then
							buffer.put_string (body_index_cast)
						end
						buffer.put_real_body_index (l_real_body_index)
						buffer.put_two_character (',', ' ')
							-- Write the offset of the attribute in the
							-- run-time structure (object) (if any).
						if re.is_attribute then
							buffer.put_integer (re.workbench_offset)
						else
							buffer.put_string (body_index_cast)
							buffer.put_integer (Invalid_index)
						end
					else
						ae ?= entry_item
						check
							ae_not_void: ae /= Void
						end
							-- The entry corresponds to an attribute.
						buffer.put_string (body_index_cast)
						buffer.put_integer (Invalid_index)
							-- Write the offset of the attribute in the
							-- run-time structure (object).
						buffer.put_two_character (',', ' ')
						buffer.put_integer (ae.workbench_offset)
					end
						-- Write the type of the feature.

					buffer.put_two_character (',', ' ')

					l_static_feature_type_id := entry_item.static_feature_type_id
					if l_static_feature_type_id <= 0 then
							-- For zero values and below we need to cast.
						buffer.put_string (type_index_cast)
					end
					buffer.put_static_type_id (l_static_feature_type_id)

					buffer.put_two_character (',', ' ')

					if entry_item.needs_extended_info then
						buffer.put_string (gen_type)
						buffer.put_integer (cnt.value)
						buffer.put_string (id_string)
						j := cnt.next
					else
						buffer.put_string (null_string)
					end

					buffer.put_two_character ('}', ',')

				else
						-- The entry corresponds to a routine that
						-- is not polymorphic.
					buffer.put_string (body_index_cast)
					buffer.put_integer (Invalid_index)
					buffer.put_two_character (',', ' ')
					buffer.put_string (body_index_cast)
					buffer.put_integer (Invalid_index)
					buffer.put_two_character (',', ' ')
					buffer.put_string (invalid_dtype_string)
					buffer.put_two_character (',', ' ')
					buffer.put_string (null_string)
					buffer.put_two_character ('}', ',')
				end
				i := i + 1
			end
		end

	generate_precomp (buffer: GENERATION_BUFFER; start: INTEGER; cnt : COUNTER; id_string: STRING)
			-- C code of Current precompiled descriptor unit
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
			i,j: INTEGER
			l_count: INTEGER
			re: ROUT_ENTRY
			ae: ATTR_ENTRY
			nb: INTEGER
			entry_item: ENTRY
			body_index, offset, desc1, desc2, gen_type, type: STRING
			non_generic, gen_type_string, end_of_line: STRING
			l_area: like area
		do
			from
					-- Initialize all the constant string used during this generation
				desc1 := "%Tdesc" + id_string + "["
				body_index := "].body_index = (BODY_INDEX) ("
				offset := "].offset = (BODY_INDEX) ("
				desc2 := ");%N%Tdesc" + id_string + "["
				type := "].type = (EIF_TYPE_INDEX) ("
				gen_type := "].gen_type = "
				non_generic := "NULL;%N"
				gen_type_string := " gen_type"
				end_of_line := ";%N"
				l_count := count - 1
				l_area := area
			until
				i > l_count
			loop
				nb := i + start
				buffer.put_string (desc1)
				buffer.put_integer (nb)
				buffer.put_string (body_index)
				entry_item := l_area.item (i)
				if entry_item /= Void then
					re ?= entry_item
					if re /= Void then
							-- The entry corresponds to a routine.
							-- Write the body index of the routine (index
							-- into the run-time dispatch table) and the type
							-- of the feature.
						buffer.put_real_body_index (re.real_body_index)
						buffer.put_string (desc2)
						buffer.put_integer (nb)
						buffer.put_string (offset)
							-- Write the offset of the attribute in the
							-- run-time structure (object) (if any).
						if re.is_attribute then
							buffer.put_integer (re.workbench_offset)
						else
							buffer.put_integer (Invalid_index)
						end
					else
						ae ?= entry_item
						check
							ae_not_void: ae /= Void
						end
							-- The entry corresponds to an attribute.
							-- Write the offset of the attribute in the
							-- run-time structure (object).
						buffer.put_integer (Invalid_index)
						buffer.put_string (desc2)
						buffer.put_integer (nb)
						buffer.put_string (offset)
						buffer.put_integer (ae.workbench_offset)
					end
						-- Write the type of the feature.
					buffer.put_string (desc2)
					buffer.put_integer (nb)
					buffer.put_string (type)
					entry_item.generated_static_feature_type_id (buffer)
					buffer.put_string (desc2)
					buffer.put_integer (nb)
					buffer.put_string (gen_type)

					if entry_item.needs_extended_info then
						buffer.put_string (gen_type_string)
						buffer.put_integer (cnt.value)
						buffer.put_string (id_string)
						buffer.put_string (end_of_line)
						j := cnt.next
					else
						buffer.put_string (non_generic)
					end

				else
						-- The entry corresponds to a routine that
						-- is not polymorphic.
					buffer.put_integer (Invalid_index)
					buffer.put_string (desc2)
					buffer.put_integer (nb)
					buffer.put_string (offset)
					buffer.put_integer (Invalid_index)
					buffer.put_string (desc2)
					buffer.put_integer (nb)
					buffer.put_string (type)
					buffer.put_integer (-1)
					buffer.put_string (desc2)
					buffer.put_integer (nb)
					buffer.put_string (gen_type)
					buffer.put_string (non_generic)
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
			static_decl, start_decl, end_decl: STRING
			l_area: like area
		do
			from
				static_decl := once "static EIF_TYPE_INDEX gen_type"
				start_decl := once " [] = {0,"
				end_decl := once "};%N"
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
					buffer.put_string (end_decl)
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
			re: ROUT_ENTRY
			ae: ATTR_ENTRY
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
					re ?= entry_item
					if re /= Void then
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
					else
						ae ?= entry_item
						check
							ae_not_void: ae /= Void
						end
							-- The entry corresponds to an attribute.
						ba.append_uint32_integer (-1)
							-- Write the offset of the attribute in the
							-- run-time structure (object).
						ba.append_uint32_integer (ae.workbench_offset)
					end
						-- Write the type of the feature.
					ba.append_short_integer (entry_item.static_feature_type_id - 1)

					if entry_item.needs_extended_info then
						ba.append_short_integer (0)
						entry_item.make_gen_type_byte_code (ba)
					end

					ba.append_short_integer (-1)
				else
						-- The entry corresponds to a routine that
						-- is not polymorphic.
					ba.append_uint32_integer (-1)
					ba.append_uint32_integer (-1)
					ba.append_short_integer (-1)
					ba.append_short_integer (-1)
				end
				i := i + 1
			end
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

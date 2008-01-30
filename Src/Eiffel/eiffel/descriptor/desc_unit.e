indexing
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

	make (c_id: INTEGER; sz: INTEGER) is
		do
			class_id := c_id
			create area.make (sz)
			count := sz
		end

feature -- Status report

	count: INTEGER
			-- Number of elements in Current.

feature {NONE} -- Access

	class_id: INTEGER

feature -- Generation

	generate (buffer: GENERATION_BUFFER; cnt : COUNTER; id_string: STRING) is
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
			body_index_type, body_index_type_separator, type_index, gen_type, separator, null_init: STRING
			invalid_entry: STRING
		do
			from
				body_index_type := "%N%T{(BODY_INDEX) "
				body_index_type_separator := ", (BODY_INDEX) "
				type_index := ", (EIF_TYPE_INDEX) "
				gen_type := ", gen_type"
				separator := "}, "
				null_init := ", NULL"
				Invalid_entry := ", INVALID_DTYPE, NULL},"
				l_count := count - 1
				l_area := area
			until
				i > l_count
			loop
				entry_item := l_area.item (i)
				buffer.put_string (body_index_type)
				if entry_item /= Void then
					re ?= entry_item
					if re /= Void then
							-- The entry corresponds to a routine.
							-- Write the body index of the routine (index
							-- into the run-time dispatch table).
						buffer.put_real_body_index (re.real_body_index)
						buffer.put_string (body_index_type_separator)
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
						buffer.put_integer (Invalid_index)
							-- Write the offset of the attribute in the
							-- run-time structure (object).
						buffer.put_string (body_index_type_separator)
						buffer.put_integer (ae.workbench_offset)
					end
						-- Write the type of the feature.
					buffer.put_string (type_index)
					buffer.put_static_type_id (entry_item.static_feature_type_id)

					if entry_item.is_generic then
						buffer.put_string (gen_type)
						buffer.put_integer (cnt.value)
						buffer.put_string (id_string)
						j := cnt.next
					else
						buffer.put_string (null_init)
					end

					buffer.put_string (separator)

				else
						-- The entry corresponds to a routine that
						-- is not polymorphic.
					buffer.put_integer (Invalid_index)
					buffer.put_string (body_index_type_separator)
					buffer.put_integer (Invalid_index)
					buffer.put_string (invalid_entry)
				end
				i := i + 1
			end
		end

	generate_precomp (buffer: GENERATION_BUFFER; start: INTEGER; cnt : COUNTER; id_string: STRING) is
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

					if entry_item.is_generic then
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

	generate_generic (buffer: GENERATION_BUFFER; cnt : COUNTER; id_string: STRING) is
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
				static_decl := "static EIF_TYPE_INDEX gen_type"
				start_decl := " [] = {0,"
				end_decl := "};%N"
				l_count := count - 1
				l_area := area
			until
				i > l_count
			loop
				entry_item := l_area.item (i)
				if entry_item /= Void and then entry_item.is_generic then
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

	make_byte_code (ba: BYTE_ARRAY) is
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

					if entry_item.is_generic then
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class DESC_UNIT

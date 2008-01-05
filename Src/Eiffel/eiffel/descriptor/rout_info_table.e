indexing
	description: "Direct access structure of ROUT_INFO objects indexed by the%
				%routine id's of the entire system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ROUT_INFO_TABLE

inherit
	HASH_TABLE [ROUT_INFO, INTEGER]
		rename
			make as ht_make,
			put as table_put
		end

	SHARED_WORKBENCH
		undefine
			copy, is_equal
		end

	SHARED_ARRAY_BYTE
		undefine
			copy, is_equal
		end

	COMPILER_EXPORTER
		undefine
			copy, is_equal
		end

create

	make

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Create an empty table.
		do
			ht_make (n)
			create offset_counters.make (n)
		end

feature -- Insertion

	put (rout_id: INTEGER; org: CLASS_C) is
			-- Record the routine id `rout_id', the origin
			-- of the corresponding routine and the offset of
			-- the routine in the origin class.
		require
			rout_id_not_void: rout_id /= 0
			org_not_void: org /= Void
		local
			info: ROUT_INFO
		do
			if has_key (rout_id) then
					-- The routine id has been recorded
					-- earlier.
				info := found_item
				if info.origin /= org.class_id then
						-- The origin of the routine has changed
						-- a new offset must be computed, and the
						-- origin value updated.
					info.make (org, new_offset (org))
				end
			else
					-- The routine is brand new.
				create info.make (org, new_offset (org))
				force (info, rout_id)
			end
		end

feature -- Offset processing

	new_offset (c: CLASS_C): INTEGER is
			-- New offset for class `c'. The routine offsets
			-- start from 0.
			--|Beware: this function has a side effect!
			--|Note: see if "obsolete" offsets could be reused.
		local
			class_id: INTEGER
			counter: COUNTER
		do
			class_id := c.class_id
			if not offset_counters.has_key (class_id) then
				create counter
					-- Routine offsets start from 0.
				counter.set_value (-1)
				offset_counters.put (counter, class_id)
			else
				counter := offset_counters.found_item
			end
			Result := counter.next
		end

	offset_counters: HASH_TABLE [COUNTER, INTEGER]
			-- Offset counters for feature introducted
			-- in the corresponding class

feature -- Query features

	origin (rout_id: INTEGER): CLASS_C is
			-- Origin of routine of id `rout_id'
		require
			rout_id_not_void: rout_id /= 0
			has_rout_id: has (rout_id)
		do
			Result := System.class_of_id (item (rout_id).origin)
		ensure
			origin_not_void: Result /= Void
		end

	offset (rout_id: INTEGER): INTEGER is
			-- Offset of routine of id `rout_id'
			-- in origin class
		require
			rout_id_not_void: rout_id /= 0
			has_rout_id: has (rout_id)
		do
			Result := item (rout_id).offset
		end

	descriptor_size (class_id: INTEGER): INTEGER is
			-- Number of routines introduced
			-- in class of id `class_id'
		do
			if offset_counters.has_key (class_id) then
				-- Offsets start from 0.
				Result := offset_counters.found_item.value + 1
			end
		end

	renumbered_table: ARRAY [ROUT_INFO] is
			-- Routine info indexed by routine ids after
			-- renumbering
		local
			rout_id, max: INTEGER
		do
			from start until after loop
				rout_id := key_for_iteration
				if max < rout_id then
					max := rout_id
				end
				forth
			end
			create Result.make (1, max)
			from
				start
			until
				after
			loop
				Result.put (item_for_iteration, key_for_iteration)
				forth
			end
		end

feature -- Generation

	generate (buffer: GENERATION_BUFFER) is
			-- C code of run-time structure representing Current
		require
			buffer_not_void: buffer /= Void
		local
			rout_infos: ARRAY [ROUT_INFO]
			nb_elements: INTEGER
			i: INTEGER
			ri: ROUT_INFO
		do
			rout_infos := renumbered_table
			nb_elements := rout_infos.count

			buffer.put_string ("#include %"eif_project.h%"%N%
						 %#include %"eif_macros.h%"%N%N")

			buffer.start_c_specific_code

			buffer.put_string ("struct rout_info egc_forg_table_init[] = {%N")
				-- C tables start at 0, we want to start at 1, to
				-- that effect we insert a dummy entry.
			buffer.put_string ("%T{INVALID_DTYPE, 0},%N")
				-- Entry for the invariant "routine"
			buffer.put_string ("%T{0, (uint16) 0},%N")

			from
				i := 2
			until
				i > nb_elements
			loop
				ri := rout_infos.item (i)
				if ri /= Void then
					buffer.put_string ("%N%T{")
					buffer.put_integer (ri.origin)
					buffer.put_string (", (uint16) ")
					buffer.put_integer (ri.offset)
					buffer.put_string ("},")
				else
					buffer.put_string ("%N%T{INVALID_DTYPE, 0},")
				end
				i := i + 1
			end

			buffer.put_string ("%N};%N")

			buffer.end_c_specific_code
		end

feature -- Melting

	melted: CHARACTER_ARRAY is
			-- Byte code of Current table.
			-- Format:
			--    1) Number of elements (uint32)
			--    2) Sequence of pairs (short, short)
		local
			rout_infos: ARRAY [ROUT_INFO]
			nb_elements: INTEGER
			i: INTEGER
			ri: ROUT_INFO
		do
			rout_infos := renumbered_table
			nb_elements := rout_infos.count

				-- Clear the byte array
			Byte_array.clear

				-- Number of elements
			Byte_array.append_uint32_integer (nb_elements + 1)

				-- C tables start at 0, we want to start at 1, to
				-- that effect we insert a dummy entry.
			Byte_array.append_short_integer (-1)
			Byte_array.append_short_integer (-1)

				-- Entry for the invariant "routine"
			Byte_array.append_short_integer (0)
			Byte_array.append_short_integer (0)

			from
				i := 2
			until
				i > nb_elements
			loop
				ri := rout_infos.item (i)
				if ri /= Void then
					Byte_array.append_short_integer (ri.origin)
					Byte_array.append_short_integer (ri.offset)
				else
					Byte_array.append_short_integer (-1)
					Byte_array.append_short_integer (-1)
				end
				i := i + 1
			end

				-- Return correctly sized structure.
			Result := Byte_array.character_array
			Byte_array.clear
		end

feature -- Merging

	append (other: like Current) is
			-- Append `other' to `Current'.
			-- Used when merging precompilations.
		require
			other_not_void: other /= Void
		do
			merge (other)
			offset_counters.merge (other.offset_counters)
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

end

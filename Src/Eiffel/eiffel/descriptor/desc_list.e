note
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- List of descriptors of a class (CLASS_C).
-- Note: with the current implementation of genericity, a class can
-- have several class types, one descriptor must be built for each class type.

class DESC_LIST

inherit
	FIXED_LIST [DESCRIPTOR]
		rename
			make as fl_make,
			put as fl_put
		end

	SHARED_WORKBENCH
		undefine
			copy, is_equal
		end

	SHARED_TMP_SERVER
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

create {DESC_LIST}
	fl_make, make_filled

feature -- Creation

	make (c: CLASS_C)
			-- Initialize descriptor list of class
			-- `c', and initialize the size of the
			-- individual descriptors to `s'.
		local
			i, nb, nb_entries: INTEGER
		do
			base_class := c
			class_types := c.types

			nb := class_types.count
			make_filled (nb)
				-- Compute the size of the DESCRIPTOR table.
			nb_entries := c.number_of_ancestors + 1
			from
				nb := count
			until
				i = nb
			loop
				area.put (create {DESCRIPTOR}.make (class_types.i_th (i + 1), nb_entries), i)
				i := i + 1
			end
		end

feature

	base_class: CLASS_C
			-- Base class of current descriptor list

	class_types: TYPE_LIST
			-- Class types associated with base class of
			-- Current descriptor list

feature -- Insertion

	put_invariant (f: INVARIANT_FEAT_I)
		local
			u: ENTRY
			local_class_types: TYPE_LIST
			i: INTEGER
			l_area: SPECIAL [DESCRIPTOR]
		do
			if f.has_entry then
				u := f.new_entry (System.routine_id_counter.invariant_rout_id)
				if u /= Void then
					from
						local_class_types := class_types
						l_area := area
						i := count - 1
					until
						i < 0
					loop
							-- `i = 0' is used to signify last iteration so that the entry
							-- object may be aliased without side effect.
						l_area.item (i).set_invariant_entry (u.entry (local_class_types.i_th (i + 1), i = 0))
						i := i - 1
					end
				end
			end
		end

	put (r_id: INTEGER; f: FEATURE_I)
			-- Insert the routine id `r_id' into the descriptors
			-- of `base_class', and associate it with the feature `f'.
			--|The (routine_id, FEATURE_I) pair is inserted into
			--|the descriptor DESC_UNIT substructure corresponding
			--|to the origin of the routine. The origin of the routine
			--|is found in the global system table Rout_info_table
			--|which is built during pass 2.
		local
			u: ENTRY
			ri: ROUT_INFO
			origin: INTEGER
			offset, nb_routines, i: INTEGER
			l_area: SPECIAL [DESCRIPTOR]
			desc: DESCRIPTOR
			du: DESC_UNIT
			local_class_types: TYPE_LIST
		do
				-- Get the polymorphical unit corresponding to `f'
				--|Note: see if and how `has_entry' may be used.

			if f.has_entry then
				u := f.new_entry (r_id)
				if u /= Void then

						-- Get the origin of the routine of id `r_id' and
						-- the offset of that routine in the origin class.
						-- Also get the number of routines introduced in the
						-- origin class.

					ri := System.rout_info_table.item (r_id)
					origin := ri.origin
					offset := ri.offset
					nb_routines := System.rout_info_table.descriptor_size (origin)

						-- For each class type, create the appropriate
						-- entry, and insert it into the appropriate
						-- DESC_UNIT structure.

					from
						local_class_types := class_types
						local_class_types.start
						l_area := area
						i := count - 1
					until
						i < 0
					loop
							-- Get the descriptor of the class type.
						desc := l_area.item (i)
							-- Create a desc_unit if an origin is encountered
							-- for the first time and insert it in the
							-- descriptor,  (otherwise recuperate existing one).
						du := desc.table_item (origin)
						if du = Void then
							create du.make (origin, nb_routines)
							desc.table_put (du, origin)
						end
							-- Insert the polymorphical entry correponding to
							-- the current class type and routine of id `r_id'
							-- into the descriptor unit, at the position
							-- `offset'.
						check
							du.valid_index (offset)
						end
							-- `i = 0' is used to signify last iteration so that the entry
							-- object may be aliased without side effect.
						du.put (u.entry (local_class_types.i_th (i + 1), i = 0), offset)
						i := i - 1
					end
				end
			end
		end

feature -- Melting

	melt
			-- Melt the list of descriptors
			-- Format:
			--    1) Number of descriptors (short)
			--    2) Sequence of descriptor byte code
		local
			ba: BYTE_ARRAY
			md: MELTED_DESC
			actual_count, i, nb: INTEGER
			l_area: SPECIAL [DESCRIPTOR]
		do
				-- Initialization.
			ba := Byte_array
			ba.clear

			from
				l_area := area
				nb := count
			until
				i = nb
			loop
				if l_area.item (i).class_type.is_modifiable then
					actual_count := actual_count + 1
				end
				i := i + 1
			end
				-- Write the number descriptors.
			ba.append_integer (actual_count)

				-- Append the byte of each individual
				-- class type descriptor.
			make_byte_code (ba)

				-- Put the byte code in server.
			md := ba.melted_descriptor
			md.set_class_id (base_class.class_id)
			Tmp_m_desc_server.put (md)
		end

	make_byte_code (ba: BYTE_ARRAY)
			-- Append the byte code of each individual
			-- descriptor to `ba'
		local
			des: DESCRIPTOR
			l_area: SPECIAL [DESCRIPTOR]
			i, nb: INTEGER
		do
			from
				l_area := area
				nb := count
			until
				i = nb
			loop
				des := l_area.item (i)
				if des.class_type.is_modifiable then
					des.make_byte_code (ba)
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

end

indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Table of execution units (either C routines or byte code arrays)

class EXECUTION_TABLE

inherit
	SEARCH_TABLE [EXECUTION_UNIT]
		rename
			make as search_table_make,
			search as table_search
		end

	SHARED_WORKBENCH
		undefine
			copy, is_equal
		end

	SHARED_SERVER
		undefine
			copy, is_equal
		end

	SHARED_BODY_ID
		undefine
			copy, is_equal
		end

	SHARED_CODE_FILES
		undefine
			copy, is_equal
		end

	SYSTEM_CONSTANTS
		undefine
			copy, is_equal
		end

	SHARED_GENERATION
		undefine
			copy, is_equal
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make

feature -- Initialization

	make is
			-- Create a new execution table.
		do
			create melted_list.make (10)
			search_table_make (Chunk)
			create counter.make
		end

	counter: REAL_BODY_ID_COUNTER
			-- Counter for real body id

feature -- Access

	melted_list: SEARCH_TABLE [EXECUTION_UNIT]
			-- List of melted unit

	last_unit: EXECUTION_UNIT
			-- Last unit evaluated by `put'

	real_body_index (body_index: INTEGER; class_type: CLASS_TYPE): INTEGER is
			-- Real body index associated to an instance of FEATURE_I of
			-- body index `body_index' in a class type `class_type'.
		local
			unit: EXECUTION_UNIT
		do
			unit := unit_of_body_index (body_index, class_type)
			if unit /= Void then
				Result := unit.real_body_index
			end
		end

	real_body_id (body_index: INTEGER; class_type: CLASS_TYPE): INTEGER is
			-- Real body id associated to an instance of FEATURE_I of
			-- body index `body_index' in a class type `class_type'.
		local
			unit: EXECUTION_UNIT
		do
			unit := unit_of_body_index (body_index, class_type)
			if unit /= Void then
				Result := unit.real_body_id
			end
		end

feature -- Element change

	update_with (t: EXECUTION_UNIT) is
			-- Find `t' in table. If found update found item
			-- with content of `t'. If not found, insert `t'
			-- in table.
			-- `last_unit' contains updated EXECUTION_UNIT.
		require
			execution_unit_not_void: t /= Void
		do
			last_unit := item (t)
			if last_unit = Void then
					-- New unit, we give a new `index'
					-- and we insert it.
				t.set_index (counter.next_id)
				put (t)
			else
					-- Give existing `real_body_index' to newly
					-- computed `EXECUTION_UNIT'.
				t.set_index (last_unit.real_body_index)

					-- And insert it in HASH_TABLE.
					-- Warning: This is using the knowledge of SEARCH_TABLE
					-- to replace equivalent item to `t' by `t'.
				content.put (t, position)
			end
			last_unit := t
		ensure
			last_unit_set: last_unit /= Void
			last_unit_correctly_set: last_unit.is_equal (t)
		end

	search (t: EXECUTION_UNIT) is
			-- If present `last_unit' contains already present element.
		require
			execution_unit_not_void: t /= Void
			has_item: has (t)
		do
			last_unit := item (t)
		ensure
			last_unit_set: last_unit /= Void
			found_correct_last_unit: last_unit.is_equal (t)
		end

feature -- Removal

	add_dead_function (body_index: INTEGER) is
			-- Add `body_index' into `dead_attributes'
		require
			positive_body_index: body_index > 0
		do
			if dead_attributes = Void then
				create dead_attributes.make (10)
			end
			dead_attributes.force (body_index)
		end

	has_dead_function (body_index: INTEGER): BOOLEAN is
			-- Check if `body_index' is in `dead_attributes'
		require
			positive_body_index: body_index > 0
		do
			Result := dead_attributes /= Void and then dead_attributes.has (body_index)
		end

	dead_attributes: SEARCH_TABLE [INTEGER]
			-- Record dead functions transformed into attributes.

feature -- Update

	mark_melted (t: EXECUTION_UNIT) is
			-- Insert `t' in `melted_list'.
		do
			melted_list.force (t)
		end

	freeze is
			-- Wipe out `melted_list'.
		do
			create melted_list.make (10)
		end

	nb_frozen_features: INTEGER is
			-- Melted/Frozen limit
		do
			Result := counter.count
		end

feature {SYSTEM_I} -- Shake table

	shake is
			-- Reorganize the table during a refreezing
		local
			u: EXECUTION_UNIT
		do
			from
				start
			until
				after
			loop
				u := item_for_iteration
				if not u.is_precompiled and then not u.is_valid then
					remove (u)
				end
				forth
			end
				-- All functions changed into attributes have been detected and
				-- removed from execution table, we can reset `dead_attributes'
				-- for next recompilation.
			dead_attributes := Void
		end

feature {NONE} -- Search

	unit_of_body_index (body_index: INTEGER; class_type: CLASS_TYPE): EXECUTION_UNIT is
			-- Unit associated to an instance of FEATURE_I of
			-- body index `body_index' in a class type `class_type'.
		do
			Marker.set_body_index (body_index)
			Marker.set_class_type (class_type)
			Result := item (Marker)
		end

	Marker: EXECUTION_UNIT is
			-- Marker for search
		once
			create Result.make (System.any_class.compiled_class.types.first)
			Result.set_body_index (1)
		end

feature -- Byte Code generation

	make_update (file: RAW_FILE) is
			-- Generate byte code for updating the execution table
		local
			e: EXECUTION_UNIT
			l_real_body_id: INTEGER
			melted_feature: MELT_FEATURE
			removed_list: LINKED_LIST [EXECUTION_UNIT]
		do
				-- First write the count of the byte code table
			write_int (file.file_pointer, counter.count)
			from
				melted_list.start
			until
				melted_list.after
			loop
				e := melted_list.item_for_iteration
				if e.is_valid then
					l_real_body_id := e.real_body_id
					melted_feature := M_feature_server.item (l_real_body_id)
						-- Write the body id
					write_int (file.file_pointer, l_real_body_id - 1)
						-- Write the size
					write_int (file.file_pointer, melted_feature.count)
						-- Write the pattern id
					write_int (file.file_pointer, e.real_pattern_id)
						-- Write the byte code
					melted_feature.store (file)

debug
	io.error.put_string ("Item written%N")
end
				else
					if removed_list = Void then
						create removed_list.make
					end
					removed_list.extend (e)
					removed_list.finish
				end

				melted_list.forth
			end;
				-- End of execution table update
			write_int (file.file_pointer, -1)

				-- Clean useless EXECUTION_UNIT
			if removed_list /= Void then
				from
					removed_list.start
				until
					removed_list.after
				loop
					melted_list.remove (removed_list.item)
					removed_list.forth
				end
			end
		end

feature -- C code generation

	generate is
			-- Generate the frozen execution table in `buffer'.
		local
			values: ARRAY [EXECUTION_UNIT]
			unit: EXECUTION_UNIT
			i, nb: INTEGER
			temp: GENERATION_BUFFER
			frozen_file: INDENT_FILE
			buffer: GENERATION_BUFFER
			l_names_heap: like Names_heap
		do
			create frozen_file.make_c_code_file (workbench_file_name (Efrozen, dot_c, 1));

			buffer := generation_buffer
			buffer.clear_all

			from
				nb := counter.count
				create values.make (1, nb)
				start
			until
				after
			loop
				unit := item_for_iteration
				values.put (unit, unit.real_body_index)
				forth
			end

				-- Generation
			from
				create include_set.make
				i := 1
				buffer.put_string ("#include %"eif_project.h%"%N%
								%#include %"eif_macros.h%"%N%
								%#include %"eif_struct.h%"")
				buffer.start_c_specific_code
			until
				i > nb
			loop
				buffer.flush_buffer (frozen_file)
				unit := values.item (i)
				if unit /= Void then
					unit.generate_declaration (buffer)
				end
				i := i + 1
			end

				-- Generate the include files associated with
				-- external features not encapsulated but with a list
				-- of include files (assuming the definition of the feature
				-- is in one of the include files)
			from
				buffer.end_c_specific_code
				l_names_heap := Names_heap
				include_set.start
			until
				include_set.after
			loop
				buffer.put_string ("%N#include ")
				buffer.put_string (l_names_heap.item (include_set.item))
				include_set.forth
			end
			include_set := Void

			from
				buffer.start_c_specific_code
				i := 1
				create temp.make (100000)
				temp.put_string ("%Nint egc_fpatidtab_init[] = {")
				buffer.put_string ("%Nfnptr egc_frozen_init[] = {")
			until
				i > nb
			loop
				buffer.flush_buffer (frozen_file)
				unit := values.item (i)
				if unit /= Void then
					unit.generate (buffer)
					temp.put_new_line_only
					temp.put_integer (unit.real_pattern_id)
					temp.put_character (',')
				else
					buffer.put_string ("%NNULL,")
					temp.put_four_character ('%N', '-', '1', ',')
				end
				i := i + 1
			end
			buffer.put_string ("%N};%N")
			temp.put_string ("%N};")
			temp.end_c_specific_code

			buffer.put_in_file (frozen_file)
			temp.put_in_file (frozen_file)

			frozen_file.close
		end

feature {NONE} -- Include set

	include_set: LINKED_SET [INTEGER]

feature {NONE} -- Constants

	Chunk: INTEGER is 5000
			-- Table chunk

feature {NONE} -- External features

	write_int (f: POINTER; v: INTEGER) is
			-- Write integer `v' in file `f'.
		external
			"C"
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

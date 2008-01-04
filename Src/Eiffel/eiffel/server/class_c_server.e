indexing
	description: "Server to keep track of all classes in system.%
				%Warning: this is not a real server!%
				%Indexed by class id."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_C_SERVER

inherit
	ARRAY [CLASS_C]
		rename
			put as array_put,
			has as array_has,
			make as array_make,
			count as array_count
		end

	SHARED_COUNTER
		undefine
			is_equal, copy
		end

	COMPILER_EXPORTER
		undefine
			is_equal, copy
		end

create

	make

feature -- Initialization

	make is
			-- Create a new class server.
		do
			array_make (1, Chunk)
			create sorted_classes.make (1, Chunk)
		end

feature -- Access

	sorted_classes: ARRAY [CLASS_C]
			-- Classes sorted by topological id

feature -- Status report

	has (id: INTEGER): BOOLEAN is
			-- Is there a class associated with `id'?
		require
			id_not_void: id > 0
		do
			Result := id <= upper and then item (id) /= Void
		end

feature -- Measurement

	count: INTEGER
			-- Number of classes

feature -- Element change

	put (class_c: CLASS_C; id: INTEGER) is
			-- Insert `class_c' at key `id'.
		require
			class_c_not_void: class_c /= Void
			id_not_void: id > 0
			not_has_id: not has (id)
		local
			l_sorted_classes: like sorted_classes
			l_new_size: INTEGER
		do
			l_sorted_classes := sorted_classes
 			if upper < id then
 				l_new_size := id + Chunk
 				conservative_resize (1, l_new_size)
				l_sorted_classes.conservative_resize (1, l_new_size)
 			end
 				-- `Current' and 'sorted_classes' arrays both have a lower of '1' so we can optimize
 				-- accordingly by accessing their SPECIAL directly (and decrementing insertion index by 1)
 			area.put (class_c, id - 1)
			l_sorted_classes.area.put (class_c, class_c.topological_id - 1)
 			count := count + 1
		ensure
			inserted: item (id) = class_c
		end

feature -- Removal

	remove (id: INTEGER) is
			-- Remove class with `id'.
		require
			id_not_void: id > 0
			has_id: has (id)
		local
			a_class: CLASS_C
		do
			a_class := item (id)
			sorted_classes.put (Void, a_class.topological_id)
			array_put (Void, id)
			count := count - 1
		ensure
			removed: not has (id)
		end

feature -- Sort

	sort is
			-- Sort `sorted_classes' by topological ids.
		local
			i, nb: INTEGER
			a_class: CLASS_C
			l_sorted_classes: like sorted_classes
			l_class_c_server_area, l_sorted_classes_area: SPECIAL [CLASS_C]
		do
				-- 'lower' for both `Current' and 'sorted_classes' arrays is '1' so we can optimize accordingly.
			l_sorted_classes := sorted_classes

				-- Wipe out 'sorted_classes'.
				-- This could also be performed with 'discard_item' but this creates another SPECIAL which may be costlier
				-- in the long run due to increased memory usage.
			from
				i := l_sorted_classes.upper
				l_sorted_classes_area := l_sorted_classes.area
			until
				i = 0
			loop
					-- 'i' is decremented before the action so that the exit loop can be compared against zero
					-- which is always faster than comparing against an arbitrary register value.
				i := i - 1
				l_sorted_classes_area.put (Void, i)
			end

			from
				i := 0
				l_class_c_server_area := area
				nb := count
			until
				nb = 0
			loop
				a_class := l_class_c_server_area [i]
				if a_class /= Void then
						-- Add sorted class at the index of its topological id (taking off 1 for zero based indexing)
					l_sorted_classes_area.put (a_class, a_class.topological_id - 1)
					nb := nb - 1
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	Chunk: INTEGER is 150
			-- Chunk size of class arrays

invariant

	sorted_classes_not_void: sorted_classes /= Void

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

end -- class CLASS_C_SERVER

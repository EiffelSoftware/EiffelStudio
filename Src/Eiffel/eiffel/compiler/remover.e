indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Dead code removal

class REMOVER

inherit
	FEAT_ITERATOR
		rename
			make as old_make
		redefine
			mark_alive
		end

	SHARED_EIFFEL_PROJECT

create
	make

feature

	make is
			-- Initialization
		do
			old_make
			create control.make (1000)
			create array_optimizer.make
			create inliner.make
		end

feature

	record (feat: FEATURE_I; in_class: CLASS_C) is
			-- Record Eiffel routines reachable by feature `feat' from
			-- static type `in_class'.
		local
			dep: DEPEND_UNIT
			routine_id: INTEGER
		do
			from
				create dep.make (in_class.class_id, feat)
				control.extend (dep)
			until
				control.is_empty
			loop
				dep := control.item
				routine_id := dep.rout_id
				if
					(not System.routine_id_counter.is_attribute (routine_id) or else
					(tmp_poly_server.has (routine_id) and then
					tmp_poly_server.item (routine_id).is_routine_table)) and then
					not is_treated (dep.body_index, routine_id)
				then
					mark_treated (dep.body_index, routine_id)
					mark (dep.body_index, dep.class_id, dep.written_in, routine_id)
				end
				control.remove
			end
		ensure
			control_empty: control.is_empty
		end

feature -- Array optimization

	record_array_descendants is
		do
			array_optimizer.record_array_descendants
		end

	array_optimizer: ARRAY_OPTIMIZER

feature -- Inlining

	inliner: INLINER

feature -- Control

	control: ARRAYED_QUEUE [DEPEND_UNIT]
			-- Control structure for traversal in breadth first order

feature {NONE}

	propagate_feature (written_class_id: INTEGER; original_body_index: INTEGER; depend_list: FEATURE_DEPENDANCE) is
		local
			depend_unit: DEPEND_UNIT
			rout_id: INTEGER
		do
			from
				depend_list.start
			until
				depend_list.after
			loop
				depend_unit := depend_list.item
				if depend_unit.is_needed_for_dead_code_removal then
					rout_id := depend_unit.rout_id
					if
						not is_treated (depend_unit.body_index, rout_id)
					then
						control.extend (depend_unit)
					end

				end
				depend_list.forth
			end
				-- Array optimization
			array_optimizer.process (System.class_of_id (written_class_id), original_body_index, depend_list)
		end

	features: INTEGER
		-- Number of features for the current dot

	features_per_message: INTEGER is 100

	mark_alive (body_index: INTEGER) is
			-- Record feature `feat'
		do
			Precursor {FEAT_ITERATOR} (body_index)

			features := features + 1
			if features = features_per_message then
				Degree_output.put_dead_code_removal_message (features, control.count)
debug ("COUNT")
	io.error.put_string ("[")
	io.error.put_integer (control.count)
	io.error.put_string ("]%N")
end
				features := 0
			end
		end

feature -- for debug purpose

	print_dep (dep: DEPEND_UNIT) is
		local
			a_class: CLASS_C
		do
			a_class := System.class_of_id (dep.class_id)
			io.put_string (a_class.feature_table.feature_of_body_index (dep.body_index).feature_name)
			io.put_string (" (bid: ")
			io.put_integer (dep.body_index)
			io.put_string ("; rid: ")
			io.put_integer (dep.rout_id)
			io.put_string (") of ")
			io.put_string (a_class.lace_class.name)
			io.put_string (" (")
			io.put_integer (a_class.class_id)
			io.put_string (") originally in ")
			a_class := System.class_of_id (dep.written_in)
			io.put_string (a_class.lace_class.name)
			io.put_string (" (")
			io.put_integer (a_class.class_id)
			io.put_string (")%N")
		end

	dump_alive is
		local
			i, j: INTEGER
		do
			io.put_string ("Used Table:%N")
			from
				i := 1
			until
				i = used_table.upper
			loop
				io.put_integer (i)
				io.put_string (" : ")
				io.put_boolean (used_table.item (i))
				if used_table.item (i) then
					j := j + 1
				end
				io.put_string ("%N")
				i := i + 1
			end
			io.put_string ("END OF USED TABLE%N")
			io.put_string ("nb of body_index alive: ")
			io.put_integer (j)
			io.put_string ("%N")
		end

	dump_marked is
		local
			i, j: INTEGER
			marked: BOOLEAN
		do
			io.put_string ("Marked Table:%N")
			from
				i := 1
			until
				i = used_table.upper
			loop
				io.put_integer (i)
				io.put_string (" : ")
				marked := marked_table.item (i) /= Void
				io.put_boolean (marked)
				if marked then
					j := j + 1
				end
				io.put_string ("%N")
				i := i + 1
			end
			io.put_string ("END OF Marked TABLE%N")
			io.put_string ("nb of body_index marked: ")
			io.put_integer (j)
			io.put_string ("%N%N%N")
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

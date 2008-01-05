indexing

	description: "Degree -1 during Eiffel compilation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DEGREE_MINUS_1

inherit

	DEGREE
	SHARED_SERVER

create

	make

feature -- Access

	Degree_number: INTEGER is -1
			-- Degree number

feature -- Processing

	execute is
			-- Process Degree -1.
			-- Freeze system: generate C files.
		local
			i, nb: INTEGER
			l_area: SPECIAL [CLASS_C]
			a_class: CLASS_C
			eif_class: EIFFEL_CLASS_C
			l_degree_output: like degree_output
			l_system: like system
			l_m_desc_server: like m_desc_server
		do
			l_system := system
			l_degree_output := degree_output
			l_area := l_system.classes.sorted_classes.area
				-- Generation of the descriptor tables.
			if Compilation_modes.is_precompiling then
				nb := count
				l_degree_output.put_start_degree (Degree_number, nb)
				l_system.open_log_files
				from i := 0 until nb = 0 loop
					a_class := l_area [i].eiffel_class_c
					if a_class /= Void and then a_class.degree_minus_1_needed then
							-- only eiffel classes have degree -1
						check
							eiffel_class: a_class.is_eiffel_class_c
						end
						eif_class := a_class.eiffel_class_c

						l_degree_output.put_degree_minus_1 (eif_class, nb)
						eif_class.generate_descriptor_tables
						eif_class.pass4
						eif_class.remove_from_degree_minus_1
						nb := nb - 1
					end
					i := i + 1
				end
			else
				if l_system.first_compilation then
					from
						l_m_desc_server := m_desc_server
						l_m_desc_server.start
					until
						l_m_desc_server.after
					loop
						a_class := l_system.class_of_id (l_m_desc_server.key_for_iteration)
						if a_class /= Void then
							insert_class (a_class)
						end
						l_m_desc_server.forth
					end
				end
				nb := count
				l_degree_output.put_start_degree (Degree_number, nb)
				l_system.open_log_files
				from i := 0 until nb = 0 loop
					a_class := l_area [i]
					if a_class /= Void and then a_class.degree_minus_1_needed then
							-- only eiffel classes have degree -1
						check
							eiffel_class: a_class.is_eiffel_class_c
						end
						eif_class := a_class.eiffel_class_c

						l_degree_output.put_degree_minus_1 (eif_class, nb)
						eif_class.generate_workbench_files
						eif_class.remove_from_degree_minus_1
						nb := nb - 1
					end
					i := i + 1
				end
			end
			count := 0
			l_system.close_log_files
			l_degree_output.put_end_degree
		end

	make_update_feature_tables (file: RAW_FILE) is
			-- Write the byte code for feature tables to be updated
			-- into `file'.
		require
			file_not_void: file /= Void
			file_open_write: file.is_open_write
		local
			i, nb: INTEGER
			l_area: SPECIAL [CLASS_C]
			a_class: CLASS_C
			types: TYPE_LIST
			nb_tables: INTEGER
			feat_tbl: MELTED_FEATURE_TABLE
			l_m_feat_tbl_server: like m_feat_tbl_server
		do
			l_area := System.classes.sorted_classes.area
			l_m_feat_tbl_server := m_feat_tbl_server
						debug ("ACTIVITY")
							io.error.put_string ("%Tfeature tables%N")
						end
				-- Count of feature tables to update.
			nb := count
			from i := 0 until nb = 0 loop
				a_class := l_area [i]
				if a_class /= Void and then a_class.degree_minus_1_needed then
						debug ("ACTIVITY")
							io.error.put_string ("%T%T")
							io.error.put_string (a_class.name)
							io.error.put_new_line
						end
					nb_tables := nb_tables + a_class.types.nb_modifiable_types
					nb := nb - 1
				end
				i := i + 1
			end

				-- Write the number of feature tables to update.
			write_int (file.file_pointer, nb_tables)

						debug ("ACTIVITY")
							io.error.put_string ("%Tbyte code%N")
						end
				-- Write then the byte code for feature tables to update.
			nb := count
			from i := 0 until nb = 0 loop
				a_class := l_area [i]
				if a_class /= Void and then a_class.degree_minus_1_needed then
								debug ("ACTIVITY")
									io.error.put_string ("%T%T")
									io.error.put_string (a_class.name)
									io.error.put_new_line
								end
					types := a_class.types
					from types.start until types.after loop
						if types.item.is_modifiable then
							feat_tbl := l_m_feat_tbl_server.item (types.item.static_type_id)

								debug ("ACTIVITY")
									io.error.put_string ("melting class desc of ")
									types.item.type.trace
									io.error.put_new_line
								end
							feat_tbl.store (file)
						end
						types.forth
					end
					nb := nb - 1
				end
				i := i + 1
			end
		end

feature -- Element change

	insert_class (a_class: CLASS_C) is
			-- Add `a_class' to be processed.
		do
			if not a_class.is_true_external and not a_class.degree_minus_1_needed then
				a_class.add_to_degree_minus_1
				count := count + 1
			end
		end

feature -- Removal

	remove_class (a_class: CLASS_C) is
			-- Remove `a_class'.
		do
			if a_class.degree_minus_1_needed then
				a_class.remove_from_degree_minus_1
				count := count - 1
			end
		end

	wipe_out is
			-- Remove all classes.
		local
			i, nb: INTEGER
			classes: ARRAY [CLASS_C]
			a_class: CLASS_C
		do
			from
				i := 1
				nb := count
				classes := System.classes.sorted_classes
			until
				nb = 0
			loop
				a_class := classes.item (i)
				if a_class /= Void and then a_class.degree_minus_1_needed then
					a_class.remove_from_degree_minus_1
					nb := nb - 1
				end
				i := i + 1
			end
			count := 0
		end

feature {NONE} -- External features

	write_int (f: POINTER; v: INTEGER) is
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

end -- class DEGREE_MINUS_1


indexing

	description: "Degree -1 during Eiffel compilation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class DEGREE_MINUS_1

inherit

	DEGREE
	SHARED_SERVER

creation

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
			classes: ARRAY [CLASS_C]
			a_class: CLASS_C
			descriptors: ARRAY [INTEGER]
		do
			classes := System.classes.sorted_classes
				-- Generation of the descriptor tables.
			if System.first_compilation and Compilation_modes.is_precompiling then
				nb := count
				Degree_output.put_start_degree (Degree_number, nb)
				System.open_log_files
				from i := 1 until nb = 0 loop
					a_class := classes.item (i)
					if a_class /= Void and then a_class.degree_minus_1_needed then
						Degree_output.put_degree_minus_1 (a_class, nb)
								debug ("COUNT")
									io.error.put_string ("[")
									io.error.put_integer (nb)
									io.error.put_string ("] ")
								end
						a_class.generate_descriptor_tables
						a_class.pass4

						a_class.remove_from_degree_minus_1
						nb := nb - 1
					end
					i := i + 1
				end
			elseif System.first_compilation then
				nb := count
				Degree_output.put_start_degree (Degree_number, nb)
				System.open_log_files
				from i := 1 until nb = 0 loop
					a_class := classes.item (i)
					if a_class /= Void and then a_class.degree_minus_1_needed then
						Degree_output.put_degree_minus_1 (a_class, nb)
								debug ("COUNT")
									io.error.put_string ("[")
									io.error.put_integer (nb)
									io.error.put_string ("] ")
								end
						a_class.generate_workbench_files

						a_class.remove_from_degree_minus_1
						nb := nb - 1
					end
					i := i + 1
				end
			elseif Compilation_modes.is_precompiling then
				nb := count
				Degree_output.put_start_degree (Degree_number, nb)
				System.open_log_files
				from i := 1 until nb = 0 loop
					a_class := classes.item (i)
					if a_class /= Void and then a_class.degree_minus_1_needed then
						Degree_output.put_degree_minus_1 (a_class, nb)
								debug ("COUNT")
									io.error.put_string ("[")
									io.error.put_integer (nb)
									io.error.put_string ("] ")
								end
						a_class.generate_descriptor_tables
						a_class.pass4
						a_class.remove_from_degree_minus_1
						nb := nb - 1
					end
					i := i + 1
				end
			else
				descriptors := m_desc_server.current_keys
				nb := descriptors.count
				from i := 1 until i > nb loop
					a_class := System.class_of_id (descriptors.item (i))
					if a_class /= Void then
						insert_class (a_class)
					end
					i := i + 1
				end
				nb := count
				Degree_output.put_start_degree (Degree_number, nb)
				System.open_log_files
				from i := 1 until nb = 0 loop
					a_class := classes.item (i)
					if a_class /= Void and then a_class.degree_minus_1_needed then
						Degree_output.put_degree_minus_1 (a_class, nb)
								debug ("COUNT")
									io.error.put_string ("[")
									io.error.put_integer (nb)
									io.error.put_string ("] ")
								end
						a_class.generate_workbench_files

						a_class.remove_from_degree_minus_1
						nb := nb - 1
					end
					i := i + 1
				end
			end
			count := 0
			System.close_log_files
			Degree_output.put_end_degree
		end

	make_update_feature_tables (file: RAW_FILE) is
			-- Write the byte code for feature tables to be updated
			-- into `file'.
		require
			file_not_void: file /= Void
			file_open_write: file.is_open_write
		local
			i, nb: INTEGER
			classes: ARRAY [CLASS_C]
			a_class: CLASS_C
			types: TYPE_LIST
			nb_tables: INTEGER
			feat_tbl: MELTED_FEATURE_TABLE
		do
			classes := System.classes.sorted_classes
						debug ("ACTIVITY")
							io.error.put_string ("%Tfeature tables%N")
						end
				-- Count of feature tables to update.
			nb := count
			from i := 1 until nb = 0 loop
				a_class := classes.item (i)
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
			from i := 1 until nb = 0 loop
				a_class := classes.item (i)
				if a_class /= Void and then a_class.degree_minus_1_needed then
								debug ("ACTIVITY")
									io.error.put_string ("%T%T")
									io.error.put_string (a_class.name)
									io.error.put_new_line
								end
					types := a_class.types
					from types.start until types.after loop
						if types.item.is_modifiable then
							feat_tbl := m_feat_tbl_server.item (types.item.static_type_id)

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
			if not a_class.degree_minus_1_needed then
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

end -- class DEGREE_MINUS_1


--|----------------------------------------------------------------
--| Copyright (C) 1992-2000, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

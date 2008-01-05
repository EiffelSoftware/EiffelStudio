indexing

	description: "Degree 5 during Eiffel compilation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DEGREE_5

inherit

	DEGREE
		redefine
			insert_new_class
		end

	COMPILER_EXPORTER
	SHARED_SERVER
	SHARED_ERROR_HANDLER

create

	make

feature -- Access

	Degree_number: INTEGER is 5
			-- Degree number

feature -- Status report

	is_in_tmp_ast_server (a_class: CLASS_C): BOOLEAN is
			-- Is `a_class' ast in the temporary server?
		require
			a_class_not_void: a_class /= Void
		do
			Result := Tmp_ast_server.has (a_class.class_id)
		end

feature -- Processing

	execute is
			-- Process all classes.
		local
			i, nb_errors: INTEGER
			l_classes: ARRAY [CLASS_C]
			l_class: CLASS_C
			l_error_level: NATURAL
			l_classes_with_error: ARRAY [BOOLEAN]
			l_degree_output: like degree_output
			l_system: like system
			l_error_handler: like error_handler
			l_class_counter: CLASS_COUNTER
		do
			l_degree_output := Degree_output
			l_degree_output.put_start_degree (Degree_number, count)

			l_system := system
			l_error_handler := error_handler
			l_classes := l_system.classes
				-- We do not process more than once classes that had an error.
			create l_classes_with_error.make (l_classes.lower, l_classes.lower - 1)
			Workbench.set_compilation_started
				-- We loop until we reached the number of classes with an error or found more errors
				-- than classes to process.
			from
				l_class_counter := l_system.class_counter
			until
				count <= nb_errors
			loop
					-- Traverse several times the list of classes
					-- because syntactical clients may be added to
					-- Degree 5 before the current cursor position
					-- during the process.
				from
					i := 1
				until
					i > l_class_counter.count
				loop
					l_class := l_classes.item (i)
					if
						l_class /= Void and then l_class.degree_5_needed and then
						(not l_classes_with_error.valid_index (i) or else not l_classes_with_error [i])
					then
						l_degree_output.put_degree_5 (l_class, count)
						l_system.set_current_class (l_class)
						l_error_level := l_error_handler.error_level
						process_class (l_class)
						if l_error_handler.error_level /= l_error_level then
							l_classes_with_error.force (True, i)
							nb_errors := nb_errors + 1
						elseif l_class.degree_5_needed then
								-- Remove class if not already done.
							l_class.remove_from_degree_5
							count := count - 1
						end
					end
					i := i + 1
				end
			end
			l_error_handler.checksum
			l_degree_output.put_end_degree
		end

	post_degree_5_execute is
			-- Initialize `parents' for all recompiled classes.
			-- It needs to be done after all VTCT errors have been reported.
		local
			i, nb: INTEGER
			classes: ARRAY [CLASS_C]
			a_class: CLASS_C
			l_old_info: CLASS_INFO
			l_removed_classes: SEARCH_TABLE [CLASS_C]
			l_error_level: NATURAL
		do
			from
				classes := system.classes
				l_removed_classes := system.removed_classes
				i := classes.lower
				nb := classes.upper
			until
				i > nb
			loop
				a_class := classes.item (i)
					-- Perform processing only on classes still in system.
				if a_class /= Void and then (l_removed_classes = Void or else not l_removed_classes.has (a_class)) then
					if a_class.need_new_parents then
						System.set_current_class (a_class)
						l_error_level := error_handler.error_level
						if class_info_server.server_has (a_class.class_id) then
							l_old_info := class_info_server.server_item (a_class.class_id)
						else
							l_old_info := Void
						end
						a_class.fill_parents (l_old_info, class_info_server.item (a_class.class_id))
						if Error_handler.error_level /= l_error_level then
							insert_class (a_class)
						end
					end
				end
				i := i + 1
			end
			System.set_current_class (Void)
			error_handler.checksum
		end

feature {NONE} -- Processing

	process_class (a_class: CLASS_C) is
			-- Syntax analysis on `a_class'.
		require
			a_class_not_void: a_class /= Void
		local
			ast: CLASS_AS
			eif_class: EIFFEL_CLASS_C
			class_id: INTEGER
		do
			class_id := a_class.class_id
			if a_class.is_external_class_c then
				a_class.external_class_c.process_degree_5
				a_class.lace_class.config_class.set_up_to_date
			else
				eif_class := a_class.eiffel_class_c
				if eif_class.parsing_needed then
						-- Parse class and save a backup if requested and generates warning.
					ast := eif_class.build_ast (True, True)
				else
					ast := Tmp_ast_server.item (class_id)
					if ast = Void then
						ast := Ast_server.item (class_id)
					end
				end

				if ast /= Void then
					eif_class.end_of_pass1 (ast)
					a_class.lace_class.config_class.set_up_to_date
				end
			end
		end

feature -- Element change

	insert_class (a_class: CLASS_C) is
			-- Add `a_class' to be processed.
		do
			if not a_class.degree_5_needed then
				a_class.add_to_degree_5
				count := count + 1
			end
		end

	insert_new_class (a_class: CLASS_C) is
			-- Add `a_class' to be processed.
			-- Mark it as new compilation.
		do
			insert_class (a_class)
			a_class.set_parsing_needed (True)
		end

	insert_changed_class (a_class: CLASS_C) is
			--
		require
			a_class_not_void: a_class /= Void
		do
			insert_class (a_class)
		end

feature -- Removal

	remove_class (a_class: CLASS_C) is
			-- Remove `a_class'.
		do
			if a_class.degree_5_needed then
				a_class.remove_from_degree_5
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
				classes := System.classes
			until
				nb = 0
			loop
				a_class := classes.item (i)
				if a_class /= Void and then a_class.degree_5_needed then
					a_class.remove_from_degree_5
					nb := nb - 1
				end
				i := i + 1
			end
			count := 0
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

end -- class DEGREE_5


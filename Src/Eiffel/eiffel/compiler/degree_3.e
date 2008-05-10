indexing

	description: "Degree 3 during Eiffel compilation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DEGREE_3

inherit
	DEGREE
		redefine
			make
		end



	COMPILER_EXPORTER
	SHARED_ERROR_HANDLER

create
	make

feature {NONE} -- Initialization

	make is
		do
			create ignored_classes.make (0)
		end

feature -- Access

	Degree_number: INTEGER is 3
			-- Degree number

feature -- Processing

	execute is
			-- Process Degree 3.
			-- Byte code production and type checking.
		local
			i, nb: INTEGER
			classes: ARRAY [CLASS_C]
			l_class_c: CLASS_C
			l_class: EIFFEL_CLASS_C
			l_conv_checker: CONVERTIBILITY_CHECKER
			l_error_level: NATURAL_32
			l_degree_output: like degree_output
			l_system: like system
			l_error_handler: like error_handler
			l_full_class_checking_agent: PROCEDURE [ANY, TUPLE [CLASS_C]]
		do
			l_degree_output := degree_output
			l_system := system
			l_error_handler := error_handler

				-- Create full class checking agent outside of loop to prevent unnecessary agent creation.
			l_full_class_checking_agent := agent insert_class (?)

			ignored_classes.wipe_out
			l_degree_output.put_start_degree (Degree_number, count)
			classes := l_system.classes.sorted_classes

				-- Check convertibility validity, there should be only one way
				-- to convert one type to the other.
			create l_conv_checker
			l_conv_checker.system_validity_checking (classes)
			l_error_handler.checksum

			from
				i := classes.lower
				nb := classes.upper
			until
				i > nb
			loop
				l_class_c := classes.item (i)

				if l_class_c /= Void and then l_class_c.degree_3_needed then
						-- only normal eiffel classes have a degree 3
					check
						eiffel_class_c: l_class_c.is_eiffel_class_c
					end
					l_class := l_class_c.eiffel_class_c

					l_degree_output.put_degree_3 (l_class, count)
					l_system.set_current_class (l_class)
					l_error_level := l_error_handler.error_level
					process_class (l_class)
					if l_class.is_full_class_checking then
							-- We need to add the descendant classes for checking
							-- to ensure code is still valid.
						l_class.direct_descendants.do_all (l_full_class_checking_agent)
					end
						-- If class was in `ignored_classes', then we still need
						-- to recheck it at the next compilation as otherwise we
						-- would not typecheck inherited features after the ancestor
						-- class fixed the error.
					if ignored_classes.count = 0 or else not ignored_classes.has (l_class) then
						if l_error_handler.error_level = l_error_level then
								-- No errors we can safely remove it from degree 3
							l_class.remove_from_degree_3
							count := count - 1
						else
							ignored_classes.put (l_class)
							remove_descendant_classes_from_processing (l_class)
						end
					end
				end
				i := i + 1
			end

				-- If there was an error, we cannot continue
			l_error_handler.checksum

			update_assertions

			l_system.set_current_class (Void)
			l_degree_output.put_end_degree
		end

feature {NONE} -- Processing

	process_class (a_class: EIFFEL_CLASS_C) is
			-- Byte code production and type checking: Degree 3
			-- contains classes marked `changed' and/or changed3. For
			-- the classes marked `changed', produce byte code and type
			-- check the features marked `melted'; if the class is also
			-- marked `changed3' type check also the other features. For
			-- classes marked `changed3' only, type check all the
			-- features.
		require
			a_class_not_void: a_class /= Void
		local
			retried: BOOLEAN
		do
				-- We still protect ourselves against exception raised just in case while the
				-- error code handling is fully redesigned.
			if not retried then
					-- Process creation feature of `a_class'.
				a_class.process_creation_feature
				a_class.pass3 (ignored_classes.count = 0 or else not ignored_classes.has (a_class))

					-- Type checking and maybe byte code production for `a_class'.
				if System.il_generation then
					a_class.update_anchors
				end
			end
		rescue
			if error_handler.rescue_status.is_error_exception  then
					-- When an error is triggered we do as if no error had occurred.
				retried := True
				retry
			end
		end

	ignored_classes: SEARCH_TABLE [CLASS_C]
			-- List of classes that should not be processed at degree 4 due to an
			-- error in one of their ancestors.

	remove_descendant_classes_from_processing (a_class: CLASS_C) is
			-- Add all descendants of `a_class' to `ignored_classes'.
		require
			a_class_not_void: a_class /= Void
		local
			l_descendants: ARRAYED_LIST [CLASS_C]
		do
			from
				l_descendants := a_class.direct_descendants
				l_descendants.start
			until
				l_descendants.after
			loop
				ignored_classes.put (l_descendants.item)
				remove_descendant_classes_from_processing (l_descendants.item)
				l_descendants.forth
			end
		end

feature -- Assertion changes

	update_assertions is
			-- Go through all classes to melt features that have just their assertions
			-- changed
		local
			i, nb: INTEGER
			classes: ARRAY [CLASS_C]
			a_class: CLASS_C
		do
			from
				classes := System.classes
				i := classes.lower
				nb := classes.upper
			until
				i > nb
			loop
				a_class := classes.item (i)
				if a_class /= Void and then a_class.assert_prop_list /= Void then
					a_class.feature_table.propagate_assertions (a_class.assert_prop_list)
					a_class.set_assertion_prop_list (Void)
				end
				i := i + 1
			end
		end

feature -- Element change

	insert_class (a_class: CLASS_C) is
			-- Add `a_class' to be processed.
		do
			if not a_class.is_true_external and then not a_class.degree_3_needed then
				a_class.add_to_degree_3
				count := count + 1
			end
		end

feature -- Removal

	remove_class (a_class: CLASS_C) is
			-- Remove `a_class'.
		do
			if a_class.degree_3_needed then
				a_class.remove_from_degree_3
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
				if a_class /= Void and then a_class.degree_3_needed then
					a_class.remove_from_degree_3
					nb := nb - 1
				end
				i := i + 1
			end
			count := 0
		end

invariant
	ignored_classes_not_void: ignored_classes /= Void

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

end -- class DEGREE_3


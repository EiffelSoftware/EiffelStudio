indexing

	description: "Degree 1 during Eiffel compilation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DEGREE_1

inherit

	DEGREE
	SHARED_DEGREES

create

	make

feature -- Access

	Degree_number: INTEGER is 1
			-- Degree number

feature -- Processing

	execute is
			-- Process Degree 1.
			-- Melt the feature tables.
			-- Open first the file for writing on disk melted feature
			-- tables.
		local
			i, nb: INTEGER
			classes: ARRAY [CLASS_C]
			a_class: CLASS_C
			eif_class: EIFFEL_CLASS_C
		do
			nb := count
			Degree_output.put_start_degree (Degree_number, nb)
			classes := System.classes.sorted_classes
			from i := 1 until nb = 0 loop
				a_class := classes.item (i)
				if a_class /= Void and then a_class.degree_1_needed then
						-- only eiffel classes have degree1
					check
						eiffel_class: a_class.is_eiffel_class_c
					end
					eif_class := a_class.eiffel_class_c

					Degree_output.put_degree_1 (eif_class, nb)
					eif_class.melt_feature_and_descriptor_tables
					nb := nb - 1
				end
				i := i + 1
			end
			Degree_output.put_end_degree
		end

feature -- Status report

	has_class (a_class: CLASS_C): BOOLEAN is
			-- Does `a_class' need to be processed in Degree 1?
		require
			a_class_not_void: a_class /= Void
		do
			Result := a_class.degree_1_needed
		end

feature -- Element change

	insert_class (a_class: CLASS_C) is
			-- Add `a_class' to be processed.
		do
			if not a_class.is_true_external and not a_class.degree_1_needed then
				a_class.add_to_degree_1
				count := count + 1
			end
		end

feature -- Removal

	remove_class (a_class: CLASS_C) is
			-- Remove `a_class'.
		do
			if a_class.degree_1_needed then
				a_class.remove_from_degree_1
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
				if a_class /= Void and then a_class.degree_1_needed then
					a_class.remove_from_degree_1
					nb := nb - 1
				end
				i := i + 1
			end
			count := 0
		end

	transfer_to (a_degree: DEGREE) is
			-- Transfer classes to `a_degree'.
		require
			a_degree_not_void: a_degree /= Void
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
				if a_class /= Void and then a_class.degree_1_needed then
					a_class.remove_from_degree_1
					a_degree.insert_class (a_class)
					nb := nb - 1
				end
				i := i + 1
			end
			count := 0
		ensure
			wiped_out: is_empty
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

end -- class DEGREE_1



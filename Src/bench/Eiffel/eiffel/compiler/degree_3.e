indexing

	description: "Degree 3 during Eiffel compilation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class DEGREE_3

inherit

	DEGREE
	COMPILER_EXPORTER
	SHARED_ERROR_HANDLER

creation

	make

feature -- Access

	Degree_number: INTEGER is 3
			-- Degree number

feature -- Processing

	execute is
			-- Process Degree 3.
			-- Byte code production and type checking.
		local
			i, nb, j: INTEGER
			classes: ARRAY [CLASS_C]
			a_class: CLASS_C
			mem: MEMORY
		do
			nb := count
			Degree_output.put_start_degree (Degree_number, nb)
			classes := System.classes.sorted_classes
			create mem
			from i := 1 until nb = 0 loop
				a_class := classes.item (i)
				if a_class /= Void and then a_class.degree_3_needed then
					Degree_output.put_degree_3 (a_class, nb)
					System.set_current_class (a_class)
					process_class (a_class)
					a_class.remove_from_degree_3
					count := count - 1
					nb := nb - 1

					j := j + 1
					if (j \\ 700) = 0 then
						mem.full_collect
						mem.full_coalesce
					end
				end
				i := i + 1
			end

			update_assertions

			System.set_current_class (Void)
			Degree_output.put_end_degree
		end

feature {NONE} -- Processing

	process_class (a_class: CLASS_C) is
			-- Byte code production and type checking: Degree 3
			-- contains classes marked `changed' and/or changed3. For
			-- the classes marked `changed', produce byte code and type
			-- check the features marked `melted'; if the class is also
			-- marked `changed3' type check also the other features. For
			-- classes marked `changed3' only, type check all the
			-- features.
		require
			a_class_not_void: a_class /= Void
		do
				-- Type checking and maybe byte code production for `a_class'.
			a_class.pass3
			a_class.set_reverse_engineered (False)

				-- No error happened: set the compilation
				-- status of class `class_c'.
			check
				No_error: not Error_handler.has_error
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
			if not a_class.degree_3_needed then
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

end -- class DEGREE_3


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

indexing

	description: "Degree 2 during Eiffel compilation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class DEGREE_2

inherit

	DEGREE

	SHARED_EXPANDED_CHECKER

create

	make

feature -- Access

	Degree_number: INTEGER is 2
			-- Degree number

feature -- Processing

	execute is
			-- Process Degree 2.
			-- Melt features (write feature byte code on disk).
		local
			i, nb: INTEGER
			classes: ARRAY [CLASS_C]
			a_class: CLASS_C
		do
			nb := count
			Degree_output.put_start_degree (Degree_number, nb)
			classes := System.classes.sorted_classes
			if System.freeze or System.il_generation then
				from i := 1 until nb = 0 loop
					a_class := classes.item (i)
					if a_class /= Void and then a_class.degree_2_needed then
						System.set_current_class (a_class)
						if a_class.has_features_to_melt then
							Degree_output.put_degree_2 (a_class, nb)
							a_class.update_execution_table
						end
						a_class.remove_from_degree_2
						nb := nb - 1
					end
					i := i + 1
				end
			else
				from i := 1 until nb = 0 loop
					a_class := classes.item (i)
					if a_class /= Void and then a_class.degree_2_needed then
						System.set_current_class (a_class)
						if a_class.has_features_to_melt then
							Degree_output.put_degree_2 (a_class, nb)
							a_class.melt
						end
						a_class.remove_from_degree_2
						nb := nb - 1
					end
					i := i + 1
				end
			end
			count := 0
			System.set_current_class (Void)
			Degree_output.put_end_degree
		end

	initialize_non_generic_types is
			-- Initialize types of non-generic classes.
		local
			i, nb: INTEGER
			classes: ARRAY [CLASS_C]
			a_class: CLASS_C
		do
			nb := count
			classes := System.classes.sorted_classes
			from i := 1 until nb = 0 loop
				a_class := classes.item (i)
				if a_class /= Void and then a_class.degree_2_needed then
					if a_class.changed and then a_class.generics = Void then
						if a_class.types.is_empty then
								-- For non generic classes, standard initialization
								-- of their attribute `types'.
							a_class.init_types
						end
					end
					nb := nb - 1
				end
				i := i + 1
			end
		end

	process_skeleton is
			-- Type skeleton processing: If skeleton of a class type changed,
			-- it must be re-processed and marked `is_changed'.
		local
			i, nb: INTEGER
			classes: ARRAY [CLASS_C]
			a_class: CLASS_C
			l_old_skeletons: ARRAY [SKELETON]
		do
			classes := System.classes.sorted_classes
			create l_old_skeletons.make (0, System.type_id_counter.value)
			from
				i := classes.lower
				nb := classes.upper
			until
				i > nb
			loop
				a_class := classes.item (i)
				if a_class /= Void then
					if a_class.has_types then
							-- Fill `old_skeletons' with old version of skeleton if it exists.
						a_class.init_process_skeleton (l_old_skeletons)
					end
				end
				i := i + 1
			end
			from
				i := classes.lower
				nb := classes.upper
			until
				i > nb
			loop
				a_class := classes.item (i)
				if a_class /= Void then
					if a_class.has_types then
							-- Process skeleton(s) for `a_class'.
						a_class.process_skeleton (l_old_skeletons)

							-- Check validity of special classes ARRAY,
							-- STRING, TO_SPECIAL, SPECIAL.
						a_class.check_validity
					end
				end
				i := i + 1
			end
		end

	check_expanded (has_expanded: BOOLEAN) is
			-- Check expanded client relation.
		local
			i, nb: INTEGER
			class_type: CLASS_TYPE
			types: TYPE_LIST
			classes: ARRAY [CLASS_C]
			a_class: CLASS_C
		do
			nb := count
			classes := System.classes.sorted_classes
			from i := 1 until nb = 0 loop
				a_class := classes.item (i)
				if a_class /= Void and then a_class.degree_2_needed then
									debug ("CHECK_EXPANDED")
										io.error.put_string ("Check expanded on ")
										io.error.put_string (a_class.name)
										io.error.put_new_line
									end
					types := a_class.types
					from types.start until types.after loop
						class_type := types.item
						if class_type.is_changed then
									debug ("CHECK_EXPANDED")
										io.error.put_string ("Check expanded on type of ")
										io.error.put_string (a_class.name)
										io.error.put_new_line
									end
							if has_expanded then
								Expanded_checker.set_current_type (class_type)
								Expanded_checker.check_expanded
							end
							class_type.set_is_changed (False)
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
			if not a_class.degree_2_needed then
				a_class.add_to_degree_2
				count := count + 1
			end
		end

feature -- Removal

	remove_class (a_class: CLASS_C) is
			-- Remove `a_class'.
		do
			if a_class.degree_2_needed then
				a_class.remove_from_degree_2
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
				if a_class /= Void and then a_class.degree_2_needed then
					a_class.remove_from_degree_2
					nb := nb - 1
				end
				i := i + 1
			end
			count := 0
		end

end -- class DEGREE_2


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

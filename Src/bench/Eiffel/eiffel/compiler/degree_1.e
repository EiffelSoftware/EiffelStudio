indexing

	description: "Degree 1 during Eiffel compilation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class DEGREE_1

inherit

	DEGREE
	SHARED_DEGREES

creation

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
		do
			nb := count
			Degree_output.put_start_degree (Degree_number, nb)
			classes := System.classes.sorted_classes
			from i := 1 until nb = 0 loop
				a_class := classes.item (i)
				if a_class /= Void and then a_class.degree_1_needed then
					Degree_output.put_degree_1 (a_class, nb)
					a_class.melt_feature_and_descriptor_tables
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
			if not a_class.degree_1_needed then
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

end -- class DEGREE_1


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

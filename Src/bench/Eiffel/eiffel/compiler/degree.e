indexing

	description: "Degrees during Eiffel compilation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class DEGREE

inherit

	SHARED_WORKBENCH
	SHARED_EIFFEL_PROJECT

feature {NONE} -- Initialization

	make is
			-- Create a new degree.
		do
		end

feature -- Access

	Degree_number: INTEGER is
			-- Degree number
		deferred
		end

feature -- Status report

	is_empty: BOOLEAN is
			-- Is there no class to be processed?
		do
			Result := count = 0
		ensure
			definition: Result = (count = 0)
		end

feature -- Measurement

	count: INTEGER
			-- Number of classes to be processed

feature -- Processing

	execute is
			-- Process all classes.
		deferred
		end

feature -- Element change

	insert_class (a_class: CLASS_C) is
			-- Add `a_class' to be processed.
		require
			a_class_not_void: a_class /= Void
		deferred
		end

	insert_new_class (a_class: CLASS_C) is
			-- Add `a_class' to be processed.
			-- Mark it as new compilation.
		require
			a_class_not_void: a_class /= Void
		do
			insert_class (a_class)
		end

feature -- Removal

	remove_class (a_class: CLASS_C) is
			-- Remove `a_class'.
		require
			a_class_not_void: a_class /= Void
		deferred
		end

	wipe_out is
			-- Remove all classes.
		deferred
		ensure
			wiped_out: is_empty
		end

invariant

	count_positive: count >= 0

end -- class DEGREE


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

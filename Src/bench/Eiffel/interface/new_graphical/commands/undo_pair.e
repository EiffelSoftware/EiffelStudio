indexing
	description:
		"A reversable operation."
	status: "See notice at end of class"
	keywords: "undo, reverse, redo"
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO_PAIR

inherit
	ANY
		redefine
			is_equal
		end

create
	make

feature -- Initialization

	make (an_undo_procedure, a_redo_procedure: PROCEDURE [ANY, TUPLE]) is
			-- Create with `an_undo_procedure' and `a_redo_procedure'.
		require
			an_undo_procedure /= Void
			a_redo_procedure /= Void
		do
			undo_procedure := an_undo_procedure
			redo_procedure := a_redo_procedure
		ensure
			undo_procedure = an_undo_procedure
			redo_procedure = a_redo_procedure
		end

feature -- Access

	undo_count: INTEGER
			-- Number of `undo_procedure' calls.

	redo_count: INTEGER
			-- Number of `redo_procedure' calls.
	
	name: STRING
			-- Name.
	
	set_name (a_name: STRING) is
			-- Assign `a_name' to `name'.
		require
			a_name /= Void
		do
			name := clone (a_name)
		ensure
			a_name.is_equal (name) and a_name /= name
		end

feature -- Basic operation.

	undo is
			-- Reverse operation.
		require
			undo_count = redo_count
		do
			undo_procedure.call (Void)
			undo_count := undo_count + 1
		ensure
			undo_count = old undo_count + 1
		end

	redo is
			-- Reperform operation.
		require
			undo_count = redo_count + 1
		do
			redo_procedure.call (Void)
			redo_count := redo_count + 1
		ensure
			redo_count = old redo_count + 1
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result :=
				undo_procedure.is_equal (other.undo_procedure)
				and
				redo_procedure.is_equal (other.redo_procedure)
		end

	is_inverse (other: like Current): BOOLEAN is
			-- Is `other' the inverse operation?
		do
			Result :=
				undo_procedure.is_equal (other.redo_procedure)
				and
				redo_procedure.is_equal (other.undo_procedure)
		end

feature {UNDO_PAIR} -- Implementation

	undo_procedure: PROCEDURE [ANY, TUPLE]
			-- Reverses operation.

	redo_procedure: PROCEDURE [ANY, TUPLE]
			-- Reperforms operation.

invariant
	undo_procedure /= Void
	redo_procedure /= Void
	undo_count >= 0
	redo_count >= 0
	conservation_of_dos: (undo_count - redo_count).abs <= 1

end -- class UNDO_PAIR

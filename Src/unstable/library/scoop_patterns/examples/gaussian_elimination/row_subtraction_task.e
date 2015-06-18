note
	description: "Future object that computes a single row subtraction%
				 % in a system of linear equations."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	ROW_SUBTRACTION_TASK

inherit

	CP_COMPUTATION [LINEAR_EQUATION]

create
	make, make_from_separate

feature {NONE} -- Initialization

	make (a_subtrahend: like subtrahend; a_minuend: like minuend; a_pivot: like pivot)
			-- Initialization for `Current'.
		do
			subtrahend := a_subtrahend
			minuend := a_minuend
			pivot := a_pivot
		end

feature {CP_DYNAMIC_TYPE_IMPORTER} -- Initialization

	make_from_separate (other: separate like Current)
			-- <Precursor>
		do
			create subtrahend.make_from_separate (other.subtrahend)
			create minuend.make_from_separate (other.minuend)
			pivot := other.pivot
			promise := other.promise
		end

feature -- Access

	minuend: LINEAR_EQUATION
			-- The base row to be subtracted from.	

	subtrahend: LINEAR_EQUATION
			-- The subtrahend row.

	pivot: INTEGER
			-- The index of the pivot element.

feature -- Basic operations

	computed: LINEAR_EQUATION
			-- <Precursor>
		local
			scalar: DOUBLE
		do
				-- Calculate the scalar value.
			scalar := minuend [pivot] / subtrahend [pivot]

				-- Do the row subtraction.
			minuend.subtract (scalar, subtrahend)

				-- We can reuse the minuend object, since we have a private copy anyway.
			Result := minuend
		end

end

indexing
	description: "Structures that may be traversed forward and backward"
	class_type: Interface
	external_name: "ISE.Base.Bilinear"

deferred class
	BILINEAR [G]
	
inherit

	LINEAR [G]

feature -- Cursor movement

	before: BOOLEAN is
		indexing
			description: "Is there no valid position to the left of current one?"
		deferred
		end

	back is
		indexing
			description: "Move to previous position."
		require
			not_before: not before
		deferred
		ensure then
			-- moved_forth_after_start: (not before) implies index = old index - 1
		end

--invariant
--	not_both: not (after and before)
--	before_constraint: before implies off

end -- class BILINEAR




indexing
	description: "Objects that may be compared according to a partial order relation"
	class_type: Interface
	external_name: "ISE.Base.PartComparable"

deferred class
	PART_COMPARABLE

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
		indexing
			description: "Is current object less than `other'?"
		require
			other_exists: other /= Void
		deferred
		end

	infix "<=" (other: like Current): BOOLEAN is
		indexing
			description: "Is current object less than or equal to `other'?"
		require
			other_exists: other /= Void
		deferred
		end

	infix ">" (other: like Current): BOOLEAN is
		indexing
			description: "Is current object greater than `other'?"
		require
			other_exists: other /= Void
		deferred
		end

	infix ">=" (other: like Current): BOOLEAN is
		indexing
			description: "Is current object greater than or equal to `other'?"
		require
			other_exists: other /= Void
		deferred
		end

end -- class PART_COMPARABLE




indexing
	description: "Record the features using loops."
	date: "$Date$"
	revision: "$Revision$"

class
	OPTIMIZE_UNIT

inherit
	HASHABLE
		redefine
			is_equal
		end

creation
	make

feature -- Initialization

	make (c_id: INTEGER; b_index: INTEGER) is
		do
			class_id := c_id
			body_index := b_index
		end

feature -- Access

	class_id: INTEGER
			-- Class id in which loop appears.

	body_index: INTEGER
			-- Body index of feature in which loop appears.

feature -- Hashable

	hash_code: INTEGER is
		do
			Result := (class_id |<< 16)	+ body_index
		end

	is_equal (other: like Current): BOOLEAN is
			-- Are `other' and `Current' equal?
		do
			Result := body_index = other.body_index and class_id = other.class_id
		end

end

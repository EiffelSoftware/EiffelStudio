-- Record the features using loops

class OPTIMIZE_UNIT

inherit
	COMPARABLE
		redefine
			is_equal
		end;

creation
	make

feature

	class_id: CLASS_ID;

	body_index: INTEGER;

feature

	make (c_id: CLASS_ID; b_index: INTEGER) is
		do
			class_id := c_id;
			body_index := b_index;
		end;

	class_c: CLASS_C is
		do
		end;

	feature_i: FEATURE_I is
		do
		end;

feature -- Comparable

	infix "<" (other: OPTIMIZE_UNIT): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			Result := class_id < other.class_id or else
			(equal (class_id, other.class_id) and then body_index < other.body_index);
		end;

	is_equal (other: like Current): BOOLEAN is
			-- Are `other' and `Current' equal?
		do
			Result := body_index = other.body_index and
					equal (class_id, other.class_id)
		end


end

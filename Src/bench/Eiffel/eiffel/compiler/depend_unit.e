-- Dependance unit

class DEPEND_UNIT 

inherit

	COMPARABLE

creation

	make

feature 

	id: INTEGER;
			-- Class id

	feature_id: INTEGER;
			-- Feature id

	make (i, j: INTEGER) is
			-- Initialization
		do
			id := i;
			feature_id := j;
		end;

	infix "<" (other: DEPEND_UNIT): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			Result := id < other.id;
		end; -- infix "<"

end

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
			Result := id < other.id or else
				(id = other.id and then feature_id < other.feature_id);
		end; -- infix "<"

feature -- Debug

	trace is
		do
			io.error.putstring ("Class id: ");
			io.error.putint (id);
			io.error.putstring (" feature id: ");
			io.error.putint (feature_id);
			io.error.new_line;
		end;

end

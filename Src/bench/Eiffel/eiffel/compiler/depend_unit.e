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
			--| Note:	-1 is used for creation without creation routine
			--|			-2 for expanded in local clause

	make (i, j: INTEGER) is
			-- Initialization
		do
			id := i;
			feature_id := j;
		end;

	is_special: BOOLEAN is
			-- Is `Current' a special depend_unit, i.e. used
			-- for propagations
		do
			Result := feature_id < 0
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

class EXPORT_ALL_I 

inherit

	EXPORT_I
		redefine
			is_all
		end
	
feature 

	valid_for (client: CLASS_C): BOOLEAN is
			-- Is the export  clause valid for client `client' ?
		do
			Result := True;
		end;

	is_all: BOOLEAN is
			-- Is the current object an instance of EXPORT_ALL_I ?
		do
			Result := True;
		end;

	concatenation (other: EXPORT_I): EXPORT_I is
			-- Concatenation of Current and `other'
		do
			Result := Current;
		end;

	equiv (other: EXPORT_I): BOOLEAN is
			-- Is `other' equivalent to Current ?
			-- [Semantic: old_status.equiv (new_status) ]
		do
			Result := other.is_all;
		end;

	same_as (other: EXPORT_I): BOOLEAN is
			-- Is `other' the same as Current ?
		do
			Result := other.is_all
		end;


	trace is
			-- Debug purpose
		do
			io.error.putstring ("ALL");
		end;

	infix "<" (other: EXPORT_I): BOOLEAN is
			-- is Current less restrictive than other
		do
			Result := not other.is_all;
		end;

end

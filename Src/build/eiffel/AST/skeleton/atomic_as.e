-- Atomic node: strings, integers, reals etc...

deferred class ATOMIC_AS

inherit

	AST_EIFFEL

feature

	is_unique: BOOLEAN is
			-- Is the terminal a unique constant ?
		do
			Result := False;
		end;

	is_integer: BOOLEAN is
			-- Is the atomic an integer value ?
		do
			-- Do nothing
		end;

	is_character: BOOLEAN is
			-- Is the atomic a character value ?
		do
			-- Do nothing
		end;

	is_id: BOOLEAN is
			-- Is the atomic an id value ?
		do
			-- Do nothing
		end;

feature -- Type check and dead code removal

	good_integer: BOOLEAN is
			-- Is the atomic a good integer bound for multi-branch ?
		do
			-- Do nothing
		end;

	good_character: BOOLEAN is
			-- Is the atomic a good character bound for multi-branch ?
		do
			-- Do nothing
		end;

	record_dependances is
			-- Record the dependances
		do
		end;

	string_value: STRING is
		do
			!! Result.make (0)
			--Result := value_i.dump
		end;

end

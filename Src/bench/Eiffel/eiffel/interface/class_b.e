-- Internal description of a basic class such as INTEGER, BOOLEAN etc..

class CLASS_B 

inherit
	CLASS_C
		redefine
			actual_type, valid_redeclaration, is_basic
		end

creation
	make
	
feature 

	actual_type: BASIC_A is
			-- Actual type for the class
		do
		end; -- actual_type

	valid_redeclaration (a_precursor: TYPE_A; redeclared: TYPE_A): BOOLEAN is
			-- Is the redeclaration of `a_precursor' into `redeclared' valid
			-- in the current class ?
		do
			Result := redeclared.conform_to (a_precursor);
		end;

	is_basic: BOOLEAN is True
			-- Is the current class a basic class ?

end

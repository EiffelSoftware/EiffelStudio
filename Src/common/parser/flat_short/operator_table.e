indexing
	description: 
		"Table hashed on internal_name of features to give%
		%corresponding feature_name to be displayed.";
	date: "$Date$";
	revision: "$Revision $"

class OPERATOR_TABLE

create

	make

feature {NONE} -- Initialization

	make is
			-- Names of standard operator, when not immediately
			-- extracted from internal name
		do
			create operator_table.make (14);
			operator_table.put ("^", "power");
			operator_table.put ("^", "shift");
			operator_table.put ("*", "star");
			operator_table.put ("/", "slash");
			operator_table.put ("//", "div");
			operator_table.put ("\\", "mod");
			operator_table.put ("+", "plus");
			operator_table.put ("-", "minus");
			operator_table.put ("<", "lt");
			operator_table.put ("<=", "le");
			operator_table.put (">", "gt");
			operator_table.put (">=", "ge");
			operator_table.put ("and then", "and_then");
			operator_table.put ("or else", "or_else");
		end;

feature

	name (operator: STRING): STRING is
			-- What's the name of operator?
		do
			Result := operator_table.item (operator);
			if Result = void then
				Result := operator;
			end;
		end;

feature {NONE} -- Implementation

	operator_table: HASH_TABLE [STRING, STRING];
			-- Internal table to record operators

end -- class OPERATOR_TABLE

indexing

	description:
		"Operator between two sub queries.";
	date: "$Date$";
	revision: "$Revision$"

class SUBQUERY_OPERATOR

inherit
	ACTIVATABLE

create
	make

feature -- Initialization

	make (op: STRING) is
			-- Create an active operator 'op'.
		do
			int_operator := op;
			activate;
		ensure
			activated: is_active;
			correct_body: actual_operator.is_equal (op);
		end;

feature -- Properties

	actual_operator: STRING is
		do
			Result := int_operator;
		end;

feature -- Setting

	change_operator (new_op: STRING) is
		require
			new_op_is_and_or_or: new_op.is_equal("and") or else
								 new_op.is_equal("or");
		do
			int_operator := new_op;
		ensure
			changed: actual_operator = new_op;
		end;

feature {NONE} -- Attributes

	int_operator: STRING

end -- class SUBQUERY_OPERATOR

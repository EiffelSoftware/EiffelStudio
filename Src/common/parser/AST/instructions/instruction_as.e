indexing

	description: "Abstract class for instruction AS node";
	date: "$Date$";
	revision: "$Revision$"

deferred class INSTRUCTION_AS

inherit

	AST_EIFFEL

feature

	is_equiv (other: INSTRUCTION_AS): BOOLEAN is
		deferred
		end;

	equiv (other: INSTRUCTION_AS): BOOLEAN is
		deferred
		end;

end -- class INSTRUCTION_AS

-- Abstract class for instruction AS node

deferred class INSTRUCTION_AS

inherit

	AST_EIFFEL

feature

	is_equiv (other: INSTRUCTION_AS): BOOLEAN is
		deferred
		end;

	equiv (other: like Current): BOOLEAN is
		deferred
		end;

end

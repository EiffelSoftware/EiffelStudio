
-- Abstract description of a formal generic parameter.
-- Instances produced by Yacc.

class FORMAL_DEC_AS

inherit

	FORMAL_AS
		redefine
			set
		end

feature -- Attributes

	formal_name: ID_AS;
			-- Formal generic parameter name

	constraint: TYPE;
			-- Constraint of the formal generic

feature -- Initialization

	set is
			-- Yacc initialization
		do
			formal_name ?= yacc_arg (0);
			constraint ?= yacc_arg (1);
			position := yacc_int_arg (0);
		ensure then
			formal_name_exists: formal_name /= Void
		end; 

	constraint_type: TYPE_A is
			-- Actual type of the constraint.
		do
			if constraint = Void then
					-- Default constraint to ANY
				Result := Any_constraint_type;
			else
				Result := constraint.actual_type;
			end;
		end;

	Any_constraint_type: CL_TYPE_A is
			-- Default constraint actual type
		once
			!!Result;
			Result.set_base_type (System.any_id);
		end;

end

indexing

	description:
			"Abstract description of a formal generic parameter. %
			%Instances produced by Yacc. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class FORMAL_DEC_AS_B

inherit

	FORMAL_DEC_AS
		undefine
			same_as, associated_eiffel_class
		redefine
			formal_name, constraint
		end;

	FORMAL_AS_B
		undefine
			set, is_equivalent, text_position, simple_format
		end

feature -- Attributes

	formal_name: ID_AS_B;
			-- Formal generic parameter name

	constraint: TYPE_B;
			-- Constraint of the formal generic

feature -- Initialization

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
			Result.set_base_class_id (System.any_id);
		end;

	equiv (other: like Current): BOOLEAN is
			-- Is `other' equivalent to `Current'
			-- Incrementality of the generic parameters
		require
			good_argument: other /= Void
		local
			ct, o_ct: TYPE_A;
		do
				-- Test on void is done only to
				-- protect incorrect generic constraints
			ct := constraint_type;
			o_ct := other.constraint_type;
			if ct /= Void then
				if o_ct /= Void then
					Result := ct.same_as (o_ct)
				end;
			else
				Result := o_ct = Void
			end;
		end;

end -- class FORMAL_DEC_AS_B

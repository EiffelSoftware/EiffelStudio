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
			same_as
		redefine
			formal_name, constraint, is_deep_equal
		end;

	FORMAL_AS_B
		undefine
			set, is_deep_equal, text_position,
			simple_format
		redefine
			format
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

	is_deep_equal (other: TYPE_B): BOOLEAN is
		local
			o: like Current;
			o_c: TYPE_B;
		do
			o ?= other;
			Result := o /= Void and then
				formal_name.is_equal (o.formal_name) and then
				position = o.position;
			if Result then
				o_c := o.constraint;
				if constraint = Void then
					Result := o_c = Void
				else
					Result := o_c /= Void and then
					constraint.is_deep_equal (o_c)
				end;
			end;
		end;

	Any_constraint_type: CL_TYPE_A is
			-- Default constraint actual type
		once
			!!Result;
			Result.set_base_type (System.any_id);
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

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		local
			s: STRING;
		do
			s := clone (formal_name)
			s.to_upper;
			ctxt.put_string (s);
			if constraint /= void then
				ctxt.put_space;
				ctxt.put_text_item (ti_Constraint);
				ctxt.put_space;
				constraint.format (ctxt);
			end;
			ctxt.always_succeed;
		end;
		
end -- class FORMAL_DEC_AS_B


-- Abstract description of a formal generic parameter.
-- Instances produced by Yacc.

class FORMAL_DEC_AS

inherit

	FORMAL_AS
		redefine
			set, format, is_deep_equal
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

	is_deep_equal (other: TYPE): BOOLEAN is
		local
			o: FORMAL_DEC_AS;
			o_c: TYPE;
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

	format (ctxt: FORMAT_CONTEXT) is
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
		
end

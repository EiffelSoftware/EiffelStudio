-- Access to a C external

class EXTERNAL_B 

inherit

	CALL_ACCESS_B
		redefine
			same, is_external, set_parameters, parameters, enlarged		
		end;

feature 

	feature_name: STRING;
			-- Name of the feature called

	feature_id: INTEGER;
			-- Feature id: this is the key for the call in workbench mode

	type: TYPE_I;
			-- Type of the call

	parameters: BYTE_LIST [BYTE_NODE];
			-- Feature parameters {list of EXPR_B}: can be Void

	set_parameters (p: like parameters) is
			-- Assign `p' to `parameters'.
		do
			parameters := p;
		end;

	set_type (t: TYPE_I) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

	init (f: EXTERNAL_I) is
			-- Initialization
		require
			good_argument: f /= Void;
			not_attribute: not f.is_attribute;
		do
			feature_name := f.feature_name;
			feature_id := f.feature_id;
		end;

	external_name: STRING;
			-- Name of the C external

	encapsulated: BOOLEAN;
			-- Has the feature some assertion declared ?

	set_external_name (s: STRING) is
			-- Assign `s' to `external_name'.
		do
			external_name := s;
		end;

	set_encapsulated (b: BOOLEAN) is
			-- Assign `b' to `encapsulated'
		do
			encapsulated := b;
		end;

	is_external: BOOLEAN is true;
			-- Access is an external call

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			external_b: EXTERNAL_B;
		do
			external_b ?= other;
			if external_b /= Void then
				Result := external_name.is_equal (external_b.external_name);
			end;
		end;

	enlarged: EXTERNAL_BL is
			-- Enlarges the tree to get more attributes and returns the
			-- new enlarged tree node.
		do
			if context.final_mode then
				!!Result;
			else
				!EXTERNAL_BW!Result.make;
			end;
			Result.fill_from (Current);
		end;

feature -- Byte code generation

	make_code (ba: BYTE_ARRAY; flag: BOOLEAN) is
			-- Generate byte code for a call to an external. If not `flag',
			-- generate an invariant check before the call.
		local
			nb_protections, i: INTEGER;
			param: EXPR_B;
		do
			if parameters /= Void then
				from
					parameters.start
				until
					parameters.after
				loop
					param ?= parameters.item;
					param.make_byte_code (ba);
					if 	(not param.is_hector)
						and then
						context.real_type (param.type).c_type.is_pointer
					then
						ba.append (Bc_protect);
						nb_protections := nb_protections + 1;
					end;
					parameters.forth;
				end;
			end;

			standard_make_code (ba, flag);
	
				-- Generation hector realease if any
			if nb_protections > 0 then
				ba.append (Bc_release);
				ba.append_short_integer (nb_protections);
			end;
		end;

	code_first: CHARACTER is
			-- Code when external call is first (no invariant)
		do
			Result := Bc_extern
		end;

	code_next: CHARACTER is
			-- Code when external call is nested (invariant)
		do
			Result := Bc_extern_inv
		end;

end

-- Access to a C external

class EXTERNAL_B 

inherit

	CALL_ACCESS_B
		redefine
			same, is_external, set_parameters, parameters, enlarged		
		end;

	SHARED_INCLUDE

feature 

	feature_name: STRING;
			-- Name of the feature called

	feature_id: INTEGER;
			-- Feature id: this is the key for the call in workbench mode

	type: TYPE_I;
			-- Type of the call

	parameters: BYTE_LIST [BYTE_NODE];
			-- Feature parameters {list of EXPR_B}: can be Void

	is_special_ext: BOOLEAN is
			-- Does the external declaration include a macro, a dll16 or dll32 ?
		do
			Result := (special_file_name /= Void);
		end;

	has_include_list: BOOLEAN is
			-- Does the external declaration include a list of include files ?
		do
			Result := (include_list /= Void) and then (include_list.count > 0);
		end;

	special_type: STRING;
			-- special type of external if it is

	special_file_name: STRING;
			-- File name including the macro definition

	include_list: ARRAY[STRING];
			-- List of include files

	has_signature: BOOLEAN is
			-- Does the external declaration include a signature ?
		do
			Result := (has_arg_list or else has_return_type);
		end;

	has_arg_list: BOOLEAN is
			-- Does the signature include arguments ?
		do
			Result := (arg_list /= Void) and then (arg_list.count > 0);
		end;

	has_return_type: BOOLEAN is
			-- Does the signature include a result type ?
		do
			Result := (return_type /= Void);
		end;

	arg_list: ARRAY[STRING];
			-- List of arguments for the signature

	return_type: STRING;
			-- Result type of signature

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

	set_special_type (s: STRING) is
			-- Assign `s' to `special_type'
		do
			special_type := s;
		end;

	set_special_file_name (s: STRING) is
			-- Assign `s' to `special_file_name'
		do
			special_file_name := s;
		end;

	set_include_list (a: ARRAY[STRING]) is
			-- Assign `a' to `include_list'
		do
			include_list := a;
		end;

	set_arg_list (a: ARRAY[STRING]) is
			-- Assign `a' to `arg_list'
		do
			arg_list := a;
		end;

	set_return_type (s: STRING) is
			-- Assign `s' to `return_type'
		do
			return_type := s;
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

indexing
	description: "Accessing a pre-defined register"
	note: "Does not apply for IL or Byte code generation"
	date: "$Date$"
	version: "$Revision$"

class ACCESS_REG_B 

inherit

	ACCESS_B
		redefine
			print_register, generate,
			register, set_register,
			analyze, unanalyze,
			is_temporary, is_predefined,
			register_name
		end;
	
feature 

	type: TYPE_I;
			-- The type of the register

	register: REGISTRABLE;
			-- The register

	set_type (t: TYPE_I) is
			-- Assign `t' to `type'
		do
			type := t;
		end;

	set_register (r: REGISTRABLE) is
			-- Assign `r' to `register'
		do
			register := r;
		end;

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			access_reg: ACCESS_REG_B;
		do
			access_reg ?= other;
			if access_reg /= Void then
				Result := access_reg.register = register;
			end;
		end;
	
	analyze is
			-- Do nothing
		do
		end;

	unanalyze is
			-- Do nothing
		do
		end;

	generate is
			-- Do nothing
		do
		end;

	print_register is
			-- Print register
		do
			register.print_register;
		end;

	is_temporary: BOOLEAN is
			-- Is register a temporary one ?
		do
			Result := register.is_temporary
		end;

	is_predefined: BOOLEAN is
			-- Is register a temporary one ?
		do
			Result := register.is_predefined
		end;

	register_name: STRING is
			-- The ASCII representation of the register
		do
			Result := register.register_name
		end
end

-- Enlarge node for attribute access in workbench mode

class ATTRIBUTE_BW 

inherit

	ATTRIBUTE_BL
		redefine
			check_dt_current, is_polymorphic, generate_access_on_type
		end

feature

	check_dt_current (reg: REGISTRABLE) is
			-- Check whether we need to compute the dynamic type of current
			-- and call context.add_dt_current accordingly. The parameter
			-- `reg' is the entity on which the access is made.
		local
			type_i: TYPE_I;
			class_type: CL_TYPE_I;
		do
				-- Do nothing if `reg' is not the current entity
			if reg.is_current then
				class_type ?= context_type;
				if class_type /= Void then
					context.add_dt_current;
				end;
			end;
		end;

	
	is_polymorphic: BOOLEAN is True;
			-- Is the attribute access polymorphic ?

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_I) is
			-- Generate attribute access in a `typ' context
		local
			is_nested: BOOLEAN;
			type_i: TYPE_i;
			type_c: TYPE_C
		do
			is_nested := not is_first;
			type_i := real_type (type);
			type_c := type.c_type;
			if not type_i.is_expanded and then not type_c.is_bit then
					-- For dereferencing, we need a star...
				generated_file.putchar ('*');
					-- ...followed by the appropriate access cast
				type_c.generate_access_cast (generated_file);
			end;
			generated_file.putchar ('(');
			reg.print_register;
			if reg.is_predefined or reg.register /= No_register then
				generated_file.putstring (" + ");
			else
				generated_file.putstring (" +");
				generated_file.new_line;
				generated_file.indent;
			end;
			if is_nested then
				generated_file.putstring ("RTVA(");
			else
				generated_file.putstring ("RTWA(");
			end;
			generated_file.putint (typ.associated_class_type.id - 1);
			generated_file.putstring (", ");
			generated_file.putint (real_feature_id);
			generated_file.putstring (", ");
			if is_nested then
				generated_file.putchar ('"');
				generated_file.putstring (attribute_name);
				generated_file.putstring ("%", ");
				reg.print_register;
			else
				if context.dt_current > 1 then
					generated_file.putstring ("dtype");
				else
					generated_file.putstring ("Dtype(");
					context.Current_register.print_register_by_name;
					generated_file.putchar (')');
				end;
			end;
			generated_file.putstring ("))");
			if not (reg.is_predefined or reg.register /= No_register) then
			  generated_file.exdent;
			end;
		end;

end

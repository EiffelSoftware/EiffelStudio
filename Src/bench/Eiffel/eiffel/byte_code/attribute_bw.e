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
			type_c: TYPE_C;
			r_id: ROUTINE_ID;
			rout_info: ROUT_INFO;
			base_class: CLASS_C
			f: INDENT_FILE
		do
			f := generated_file
			is_nested := not is_first;
			type_i := real_type (type);
			type_c := type_i.c_type;
			if not type_i.is_expanded and then not type_c.is_bit then
					-- For dereferencing, we need a star...
				f.putchar ('*');
					-- ...followed by the appropriate access cast
				type_c.generate_access_cast (f);
			end;
			f.putchar ('(');
			reg.print_register;
			if reg.is_predefined or reg.register /= No_register then
				f.putstring (gc_plus);
			else
				f.putstring (" +");
				f.new_line;
				f.indent;
			end;
			base_class := typ.base_class;
			if
				Compilation_modes.is_precompiling or else
				base_class.is_precompiled
			then
				if is_nested then
					f.putstring ("RTVPA(");
				else
					f.putstring ("RTWPA(");
				end;
				r_id := base_class.feature_table.item
					(attribute_name).rout_id_set.first;
				rout_info := System.rout_info_table.item (r_id);
				f.putstring (rout_info.origin.generated_id);
				f.putstring (gc_comma);
				f.putint (rout_info.offset)
			else
				if is_nested then
					f.putstring ("RTVA(");
				else
					f.putstring ("RTWA(");
				end;
				f.putint (typ.associated_class_type.id.id - 1);
				f.putstring (gc_comma);
				f.putint (real_feature_id);
			end;
			f.putstring (gc_comma);
			if is_nested then
				f.putchar ('"');
				f.putstring (attribute_name);
				f.putstring ("%", ");
				reg.print_register;
			else
				context.generate_current_dtype;
			end;
			f.putstring ("))");
			if not (reg.is_predefined or reg.register /= No_register) then
			  f.exdent;
			end;
		end;
	
end

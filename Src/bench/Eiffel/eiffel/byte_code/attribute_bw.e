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
		do
			if typ.is_separate then
				generate_for_separate_attribute_call(reg, typ);
			else
			is_nested := not is_first;
			type_i := real_type (type);
			type_c := type_i.c_type;
			if not type_i.is_expanded and then not type_c.is_bit then
					-- For dereferencing, we need a star...
				generated_file.putchar ('*');
					-- ...followed by the appropriate access cast
				type_c.generate_access_cast (generated_file);
			end;
			generated_file.putchar ('(');
			reg.print_register;
			if reg.is_predefined or reg.register /= No_register then
				generated_file.putstring (gc_plus);
			else
				generated_file.putstring (" +");
				generated_file.new_line;
				generated_file.indent;
			end;
			base_class := typ.base_class;
			if
				Compilation_modes.is_precompiling or
				base_class.is_precompiled
			then
				if is_nested then
					generated_file.putstring ("RTVPA(");
				else
					generated_file.putstring ("RTWPA(");
				end;
				r_id := base_class.feature_table.item
					(attribute_name).rout_id_set.first;
				rout_info := System.rout_info_table.item (r_id);
				generated_file.putstring (rout_info.origin.generated_id);
				generated_file.putstring (gc_comma);
				generated_file.putint (rout_info.offset)
			else
				if is_nested then
					generated_file.putstring ("RTVA(");
				else
					generated_file.putstring ("RTWA(");
				end;
				generated_file.putint (typ.associated_class_type.id.id - 1);
				generated_file.putstring (gc_comma);
				generated_file.putint (real_feature_id);
			end;
			generated_file.putstring (gc_comma);
			if is_nested then
				generated_file.putchar ('"');
				generated_file.putstring (attribute_name);
				generated_file.putstring ("%", ");
				reg.print_register;
			else
				context.generate_current_dtype;
			end;
			generated_file.putstring ("))");
			if not (reg.is_predefined or reg.register /= No_register) then
			  generated_file.exdent;
			end;
			end
		end;
	
feature -- Concurrent Eiffel

	generate_for_separate_attribute_call(reg:  REGISTRABLE; typ: CL_TYPE_I) is
		-- generate code for separate attribute call.
		local
            is_nested: BOOLEAN;
            type_i: TYPE_i;
            type_c: TYPE_C;
            r_id: ROUTINE_ID;
            rout_info: ROUT_INFO;
            base_class: CLASS_C;
			cl_type: CL_TYPE_I;
			evaluated_type: TYPE_I
		do
			generated_file.putstring ("if (on_local_processor(")
			reg.print_register;
			generated_file.putstring (")) {")
			generated_file.new_line
			generated_file.indent
	
			evaluated_type := Context.real_type (type)
			cl_type ?= evaluated_type

			if cl_type.is_boolean then
				generated_file.putstring("CURPB(")
			elseif cl_type.is_char then
				generated_file.putstring("CURPC(")
			elseif cl_type.is_double then
				generated_file.putstring("CURPD(")
			elseif cl_type.is_float then
				generated_file.putstring("CURPR(")
			elseif cl_type.is_long then
				generated_file.putstring("CURPI(")
			elseif cl_type.is_expanded then
				generated_file.putstring("CURPO(")
				-- FIXCONCURRENCY: We should make a clone here.
			elseif cl_type.is_separate then
				generated_file.putstring("CURPSO(")
			else
			-- if cl_type.is_reference and not cl_type.is_separate then
				generated_file.putstring("CURPSO(CURLTS(")
			end

            is_nested := not is_first;
            type_i := real_type (type);
            type_c := type_i.c_type;
            if not type_i.is_expanded and then not type_c.is_bit then
                    -- For dereferencing, we need a star...
                generated_file.putchar ('*');
                    -- ...followed by the appropriate access cast
                type_c.generate_access_cast (generated_file);
            end;
            generated_file.putstring ("(CURPROXY_OBJ(");
            reg.print_register;
            generated_file.putstring (")");
            if reg.is_predefined or reg.register /= No_register then
                generated_file.putstring (gc_plus);
            else
                generated_file.putstring (" +");
                generated_file.new_line;
                generated_file.indent;
            end;
            base_class := typ.base_class;
            if
                Compilation_modes.is_precompiling or
                base_class.is_precompiled
            then
                if is_nested then
                    generated_file.putstring ("RTVPA(");
                else
                    generated_file.putstring ("RTWPA(");
                end;
                r_id := base_class.feature_table.item
                    (attribute_name).rout_id_set.first;
                rout_info := System.rout_info_table.item (r_id);
                generated_file.putstring (rout_info.origin.generated_id);
                generated_file.putstring (gc_comma);
                generated_file.putint (rout_info.offset)
            else
                if is_nested then
                    generated_file.putstring ("RTVA(");
                else
                    generated_file.putstring ("RTWA(");
                end;
                generated_file.putint (typ.associated_class_type.id.id - 1);
                generated_file.putstring (gc_comma);
                generated_file.putint (real_feature_id);
            end;
            generated_file.putstring (gc_comma);
            if is_nested then
                generated_file.putchar ('"');
                generated_file.putstring (attribute_name);
                generated_file.putstring ("%", ");
                generated_file.putstring ("CURPROXY_OBJ(");
                reg.print_register;
                generated_file.putstring (")");
            else
                context.generate_current_dtype;
            end;
            generated_file.putstring ("))");
            if not (reg.is_predefined or reg.register /= No_register) then
              generated_file.exdent;
            end;
	
			if not(cl_type.is_separate or cl_type.is_long or cl_type.is_boolean or cl_type.is_char or cl_type.is_double or cl_type.is_float) then
                generated_file.putstring(")")
            end
			generated_file.putstring (", 0);");
	
			generated_file.new_line
			generated_file.exdent
			generated_file.putstring ("}");
			generated_file.new_line
			generated_file.putstring ("else {");
			generated_file.new_line
			generated_file.indent
			generated_file.putstring ("CURSARI(constant_execute_query, oid_of_sep_obj(")
			reg.print_register;
			generated_file.putstring ("), constant_query, %"")
			generated_file.putstring(typ.base_class.e_class.name_in_upper)
			generated_file.putstring("%", %"")
			generated_file.putstring(attribute_name)
			generated_file.putstring ("%", 0);")
			generated_file.new_line
			generated_file.putstring ("CURSG(");
			reg.print_register;
			generated_file.putstring (");");
			generated_file.new_line;
			generated_file.exdent
			generated_file.putstring ("}");
			generated_file.new_line
		end
	
end

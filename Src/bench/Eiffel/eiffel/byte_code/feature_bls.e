-- Enlarged access to an Eiffel feature

class FEATURE_BLS 

inherit

	FEATURE_BL
		rename 
			generate_access_on_type as old_generate_access_on_type
		end;

	FEATURE_BL
		redefine 
			generate_access_on_type 
		select 
			generate_access_on_type
		end;

feature 

	NOput_parameters_into_array is
		local
			expr: PARAMETER_B;
			para_type: TYPE_I;
			i: INTEGER;
			loc_idx: INTEGER
		do
			if parameters /= Void then
				from
					parameters.start;
					i := 0;
				until
					parameters.after
				loop
					expr ?= parameters.item;	-- Cannot fail
					para_type := real_type(expr.attachment_type);
					if para_type.is_boolean then
						generated_file.putstring ("CURPB(");
						expr.print_register;
						generated_file.putstring (", ");
						generated_file.putint (i);
						generated_file.putstring (");");
						generated_file.new_line;
					elseif para_type.is_long then
						generated_file.putstring ("CURPI(");
						expr.print_register;
						generated_file.putstring (", ");
						generated_file.putint (i);
						generated_file.putstring (");");
						generated_file.new_line;
					elseif para_type.is_feature_pointer then
						generated_file.putstring ("CURPP(");
						expr.print_register;
						generated_file.putstring (", ");
						generated_file.putint (i);
						generated_file.putstring (");");
						generated_file.new_line;
					elseif para_type.is_char then
						generated_file.putstring ("CURPC(");
						expr.print_register;
						generated_file.putstring (", ");
						generated_file.putint (i);
						generated_file.putstring (");");
						generated_file.new_line;
					elseif para_type.is_double then
						generated_file.putstring ("CURPD(");
						expr.print_register;
						generated_file.putstring (", ");
						generated_file.putint (i);
						generated_file.putstring (");");
						generated_file.new_line;
					elseif para_type.is_float then
						generated_file.putstring ("CURPR(");
						expr.print_register;
						generated_file.putstring (", ");
						generated_file.putint (i);
						generated_file.putstring (");");
						generated_file.new_line;
					elseif para_type.is_reference and not para_type.is_separate then
						generated_file.putstring ("CURPO(");
						expr.print_register;
						generated_file.putstring (", ");
						generated_file.putint (i);
						generated_file.putstring (");");
						generated_file.new_line;
					elseif para_type.is_separate then
						generated_file.putstring ("CURPSO(");
--					  expr.print_register;
						if expr.stored_register.register_name /= Void then
							loc_idx := context.local_index (expr.stored_register.register_name);
						else
							loc_idx := -1;
						end;
						if loc_idx /= -1 then
							generated_file.putstring ("l[");
							generated_file.putint (context.ref_var_used + loc_idx);
							generated_file.putstring ("]");
						else
							-- It'll be the case when the value is "Void"
							expr.print_register;
						end;
						generated_file.putstring (", ");
						generated_file.putint (i);
						generated_file.putstring (");");
						generated_file.new_line;
					end
					i := i + 1;
					parameters.forth;
				end;
			end;
		end
 
		-- generate code for finalizing mode
	generate_access_on_type(reg: REGISTRABLE; typ: CL_TYPE_I) is
		local
			evaluated_type: TYPE_I;
			cl_type: CL_TYPE_I
		do
				-- Feature call on a separate object
			generated_file.putstring ("if (on_local_processor(")
			reg.print_register;
			generated_file.putstring (")) {")
			generated_file.new_line
			generated_file.indent
 
			evaluated_type := Context.real_type (type)
 
			if evaluated_type.is_void then
				-- procedure
			else
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
				elseif cl_type.is_feature_pointer then
					generated_file.putstring("CURPP(")
				elseif cl_type.is_expanded then
					generated_file.putstring("CURPO(")
					-- FIXCONCURRENCY: We should make a clone here.
				elseif cl_type.is_separate then
					generated_file.putstring("CURPSO(")
				else
				--if cl_type.is_reference and not cl_type.is_separate then
					generated_file.putstring("CURPSO(CURLTS(")
				end
			end
 
			old_generate_access_on_type (reg, typ);
 
			generated_file.putchar ('(');
			generated_file.putstring ("CURPROXY_OBJ(");
			reg.print_register;
			generated_file.putstring (")");
 
			if parameters /= Void then
				generate_parameters_list;
			end;
 
			generated_file.putstring (")");
			if cl_type /= Void  then
				if not(cl_type.is_separate or cl_type.is_long or cl_type.is_feature_pointer or cl_type.is_boolean or cl_type.is_char or cl_type.is_double or cl_type.is_float) then
					generated_file.putstring(")")
				end
				generated_file.putstring (", 0);");
			else
				generated_file.putstring (";");
			end
 
			generated_file.new_line
			generated_file.exdent
			generated_file.putstring ("}");
			generated_file.new_line
			generated_file.putstring ("else {");
			generated_file.new_line
			generated_file.indent
			if evaluated_type.is_void then
				generated_file.putstring ("CURSARI(constant_execute_procedure, oid_of_sep_obj(")
			else
				generated_file.putstring ("CURSARI(constant_execute_query, oid_of_sep_obj(")
			end
			reg.print_register;
			if evaluated_type.is_void then
				if attach_loc_to_sep then
					generated_file.putstring ("), constant_procedure_with_ack, %"")
				else
					generated_file.putstring ("), constant_procedure_without_ack, %"")
				end
			else
				generated_file.putstring ("), constant_query, %"")
			end

			generated_file.putstring(typ.base_class.name_in_upper)
			generated_file.putstring("%", %"")
			generated_file.putstring(feature_name)
			generated_file.putstring ("%", ")
			if parameters /= Void then
				generated_file.putint (parameters.count)
			else
				generated_file.putint (0)
			end
			generated_file.putstring (");")
			generated_file.new_line
			put_parameters_into_array;
			generated_file.putstring ("CURSG(");
			reg.print_register;
			generated_file.putstring (");");
			generated_file.new_line
			generated_file.exdent
			generated_file.putstring ("}");
			generated_file.new_line
		end

end

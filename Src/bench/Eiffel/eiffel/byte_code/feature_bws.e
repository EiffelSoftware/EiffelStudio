-- Enlarged node for Eiffel feature call in workbench mode

class FEATURE_BWS 

inherit

	FEATURE_BW
		redefine
			generate_access_on_type
		end

creation

	make

feature -- Concurrent Eiffel

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_I) is
		local
			is_nested: BOOLEAN;
			r_id: ROUTINE_ID;
			rout_info: ROUT_INFO;
			base_class: CLASS_C;
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

			is_nested := not is_first;
			generated_file.putstring ("(");
			real_type (type).c_type.generate_function_cast (generated_file, argument_types);
			base_class := typ.base_class;

			if
				Compilation_modes.is_precompiling or 
				base_class.is_precompiled
			then
				if is_nested and need_invariant then
					generated_file.putstring ("RTVPF(");
				else
					generated_file.putstring ("RTWPF(");
				end;
				r_id := base_class.feature_table.item
					(feature_name).rout_id_set.first;
				rout_info := System.rout_info_table.item (r_id);
				generated_file.putstring (rout_info.origin.generated_id);
				generated_file.putstring (gc_comma);
				generated_file.putint (rout_info.offset);
			else
				if is_nested and need_invariant then
					generated_file.putstring ("RTVF(");
				else
					generated_file.putstring ("RTWF(");
				end;
				generated_file.putint (typ.associated_class_type.id.id - 1);
				generated_file.putstring (gc_comma);
				generated_file.putint (real_feature_id);
			end;
			generated_file.putstring (gc_comma);
			if not is_nested then
				if precursor_type /= Void then
					-- Use dynamic type of parent instead 
					-- of dynamic type of Current.
					if context.workbench_mode then
						generated_file.putstring ("RTUD(");
						generated_file.putstring (
						 precursor_type.associated_class_type.id.generated_id
												 );
						generated_file.putchar (')');
					else
						generated_file.putint (precursor_type.type_id - 1);
					end;
				else
					context.generate_current_dtype;
				end
			elseif need_invariant then
				generated_file.putchar ('"');
				generated_file.putstring (feature_name);
				generated_file.putstring ("%", ");
				generated_file.putstring ("CURPROXY_OBJ(");
				reg.print_register;
				generated_file.putstring (")");
			else
				generated_file.putstring (gc_upper_dtype_lparan);
				generated_file.putstring ("CURPROXY_OBJ(");
				reg.print_register;
				generated_file.putstring ("))");
			end;
			generated_file.putstring ("))");

			generated_file.putchar ('(');
			generated_file.putstring ("CURPROXY_OBJ(");
			reg.print_register;
			generated_file.putstring (")");
	
			if parameters /= Void then
				generate_parameters_list;
			end;
	
			generated_file.putstring (")");
			if cl_type /= Void  then
				if not(cl_type.is_separate or cl_type.is_long or cl_type.is_feature_pointer or cl_type.is_boolean or cl_type.is_char or cl_type.is_double or cl_type.is_float or cl_type.is_expanded) then
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

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
			f: INDENT_FILE
		do
		  	-- Feature call on a separate object
			f := generated_file
			f.putstring ("if (on_local_processor(")
			reg.print_register;
			f.putstring (")) {")
			f.new_line
			f.indent
	
			evaluated_type := Context.real_type (type)
	
			if evaluated_type.is_void then
				-- procedure
			else
				cl_type ?= evaluated_type
				if cl_type.is_boolean then
					f.putstring("CURPB(")
				elseif cl_type.is_char then
					f.putstring("CURPC(")
				elseif cl_type.is_double then
					f.putstring("CURPD(")
				elseif cl_type.is_float then
					f.putstring("CURPR(")
				elseif cl_type.is_long then
					f.putstring("CURPI(")
				elseif cl_type.is_feature_pointer then
					f.putstring("CURPP(")
				elseif cl_type.is_expanded then
					f.putstring("CURPO(")
					-- FIXCONCURRENCY: We should make a clone here.
				elseif cl_type.is_separate then
					f.putstring("CURPSO(")
				else
				--if cl_type.is_reference and not cl_type.is_separate then
					f.putstring("CURPSO(CURLTS(")
				end
			end

			is_nested := not is_first;
			f.putstring ("(");
			real_type (type).c_type.generate_function_cast (f, argument_types);
			base_class := typ.base_class;

			if
				Compilation_modes.is_precompiling or else
				base_class.is_precompiled
			then
				if is_nested and need_invariant then
					f.putstring ("RTVPF(");
				else
					f.putstring ("RTWPF(");
				end;
				r_id := base_class.feature_table.item
					(feature_name).rout_id_set.first;
				rout_info := System.rout_info_table.item (r_id);
				rout_info.origin.generated_id (f)
				f.putstring (gc_comma);
				f.putint (rout_info.offset);
			else
				if is_nested and need_invariant then
					f.putstring ("RTVF(");
				else
					f.putstring ("RTWF(");
				end;
				f.putint (typ.associated_class_type.id.id - 1);
				f.putstring (gc_comma);
				f.putint (real_feature_id);
			end;
			f.putstring (gc_comma);
			if not is_nested then
				if precursor_type /= Void then
					-- Use dynamic type of parent instead 
					-- of dynamic type of Current.
					if context.workbench_mode then
						f.putstring ("RTUD(");
						precursor_type.associated_class_type.id.generated_id (f)
						f.putchar (')');
					else
						f.putint (precursor_type.type_id - 1);
					end;
				else
					context.generate_current_dtype;
				end
			elseif need_invariant then
				f.putchar ('"');
				f.putstring (feature_name);
				f.putstring ("%", ");
				f.putstring ("CURPROXY_OBJ(");
				reg.print_register;
				f.putstring (")");
			else
				f.putstring (gc_upper_dtype_lparan);
				f.putstring ("CURPROXY_OBJ(");
				reg.print_register;
				f.putstring ("))");
			end;
			f.putstring ("))");

			f.putchar ('(');
			f.putstring ("CURPROXY_OBJ(");
			reg.print_register;
			f.putstring (")");
	
			if parameters /= Void then
				generate_parameters_list;
			end;
	
			f.putstring (")");
			if cl_type /= Void  then
				if not(cl_type.is_separate or cl_type.is_long or cl_type.is_feature_pointer or cl_type.is_boolean or cl_type.is_char or cl_type.is_double or cl_type.is_float or cl_type.is_expanded) then
					f.putstring(")")
				end
				f.putstring (", 0);");
			else
				f.putstring (";");
			end
	
			f.new_line
			f.exdent
			f.putstring ("}");
			f.new_line
			f.putstring ("else {");
			f.new_line
			f.indent
			if evaluated_type.is_void then
				f.putstring ("CURSARI(constant_execute_procedure, oid_of_sep_obj(")
			else
			f.putstring ("CURSARI(constant_execute_query, oid_of_sep_obj(")
			end
			reg.print_register;
			if evaluated_type.is_void then
				if attach_loc_to_sep then
					f.putstring ("), constant_procedure_with_ack, %"")
				else
					f.putstring ("), constant_procedure_without_ack, %"")
				end
			else
				f.putstring ("), constant_query, %"")
			end
			f.putstring(typ.base_class.name_in_upper)
			f.putstring("%", %"")
			f.putstring(feature_name)
			f.putstring ("%", ")
			if parameters /= Void then
				f.putint (parameters.count)
			else
				f.putint (0)
			end
			f.putstring (");")
			f.new_line
			put_parameters_into_array;
			f.putstring ("CURSG(");
			reg.print_register;
			f.putstring (");");
			f.new_line
			f.exdent
			f.putstring ("}");
			f.new_line
		end

end

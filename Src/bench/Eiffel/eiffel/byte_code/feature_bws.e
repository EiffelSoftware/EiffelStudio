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
			r_id: INTEGER;
			rout_info: ROUT_INFO;
			base_class: CLASS_C;
			evaluated_type: TYPE_I;
			cl_type: CL_TYPE_I
			buf: GENERATION_BUFFER
		do
		  	-- Feature call on a separate object
			buf := buffer
			buf.putstring ("if (on_local_processor(")
			reg.print_register;
			buf.putstring (")) {")
			buf.new_line
			buf.indent
	
			evaluated_type := Context.real_type (type)
	
			if evaluated_type.is_void then
				-- procedure
			else
				cl_type ?= evaluated_type
				if cl_type.is_boolean then
					buf.putstring("CURPB(")
				elseif cl_type.is_char then
					buf.putstring("CURPC(")
				elseif cl_type.is_double then
					buf.putstring("CURPD(")
				elseif cl_type.is_float then
					buf.putstring("CURPR(")
				elseif cl_type.is_long then
					buf.putstring("CURPI(")
				elseif cl_type.is_feature_pointer then
					buf.putstring("CURPP(")
				elseif cl_type.is_true_expanded then
					buf.putstring("CURPO(")
					-- FIXCONCURRENCY: We should make a clone here.
				elseif cl_type.is_separate then
					buf.putstring("CURPSO(")
				else
				--if cl_type.is_reference and not cl_type.is_separate then
					buf.putstring("CURPSO(CURLTS(")
				end
			end

			is_nested := not is_first;
			buf.putstring ("(");
			real_type (type).c_type.generate_function_cast (buf, argument_types);
			base_class := typ.base_class;

			if
				Compilation_modes.is_precompiling or else
				base_class.is_precompiled
			then
				if is_nested and need_invariant then
					buf.putstring ("RTVPF(");
				else
					buf.putstring ("RTWPF(");
				end;
				r_id := base_class.feature_table.item_id (feature_name_id).rout_id_set.first;
				rout_info := System.rout_info_table.item (r_id);
				buf.generate_class_id (rout_info.origin)
				buf.putstring (gc_comma);
				buf.putint (rout_info.offset);
			else
				if is_nested and need_invariant then
					buf.putstring ("RTVF(");
				else
					buf.putstring ("RTWF(");
				end;
				buf.putint (typ.associated_class_type.static_type_id - 1);
				buf.putstring (gc_comma);
				buf.putint (real_feature_id);
			end;
			buf.putstring (gc_comma);
			if not is_nested then
				if precursor_type /= Void then
					-- Use dynamic type of parent instead 
					-- of dynamic type of Current.
					if context.workbench_mode then
						buf.putstring ("RTUD(");
						buf.generate_type_id (precursor_type.associated_class_type.static_type_id)
						buf.putchar (')');
					else
						buf.putint (precursor_type.type_id - 1);
					end;
				else
					context.generate_current_dtype;
				end
			elseif need_invariant then
				buf.putchar ('"');
				buf.putstring (feature_name);
				buf.putstring ("%", ");
				buf.putstring ("CURPROXY_OBJ(");
				reg.print_register;
				buf.putstring (")");
			else
				buf.putstring (gc_upper_dtype_lparan);
				buf.putstring ("CURPROXY_OBJ(");
				reg.print_register;
				buf.putstring ("))");
			end;
			buf.putstring ("))");

			buf.putchar ('(');
			buf.putstring ("CURPROXY_OBJ(");
			reg.print_register;
			buf.putstring (")");
	
			if parameters /= Void then
				generate_parameters_list;
			end;
	
			buf.putstring (")");
			if cl_type /= Void  then
				if not (cl_type.is_separate or cl_type.is_expanded) then
					buf.putstring(")")
				end
				buf.putstring (", 0);");
			else
				buf.putstring (";");
			end
	
			buf.new_line
			buf.exdent
			buf.putstring ("}");
			buf.new_line
			buf.putstring ("else {");
			buf.new_line
			buf.indent
			if evaluated_type.is_void then
				buf.putstring ("CURSARI(constant_execute_procedure, oid_of_sep_obj(")
			else
			buf.putstring ("CURSARI(constant_execute_query, oid_of_sep_obj(")
			end
			reg.print_register;
			if evaluated_type.is_void then
				if attach_loc_to_sep then
					buf.putstring ("), constant_procedure_with_ack, %"")
				else
					buf.putstring ("), constant_procedure_without_ack, %"")
				end
			else
				buf.putstring ("), constant_query, %"")
			end
			buf.putstring(typ.base_class.name_in_upper)
			buf.putstring("%", %"")
			buf.putstring(feature_name)
			buf.putstring ("%", ")
			if parameters /= Void then
				buf.putint (parameters.count)
			else
				buf.putint (0)
			end
			buf.putstring (");")
			buf.new_line
			put_parameters_into_array;
			buf.putstring ("CURSG(");
			reg.print_register;
			buf.putstring (");");
			buf.new_line
			buf.exdent
			buf.putstring ("}");
			buf.new_line
		end

end

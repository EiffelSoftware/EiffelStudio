-- Enlarged node for Eiffel feature call in workbench mode

class FEATURE_BW 

inherit

	FEATURE_BL
		redefine
			check_dt_current, generate_access_on_type, is_polymorphic,
			need_invariant, set_need_invariant
		end

creation

	make
	
feature 

	is_polymorphic: BOOLEAN is
			-- Is the feature call polymorphic ?
		do
			Result := True;
		end;

	need_invariant: BOOLEAN;
			-- Does the call need an invariant check ?

	set_need_invariant (b: BOOLEAN) is
			-- Assign `b' to `need_invariant'.
		do
			need_invariant := b
		end;

	make is
		do
			need_invariant := True;
		end;

	check_dt_current (reg: REGISTRABLE) is
			-- Check whether we need to compute the dynamic type of current
			-- and call context.add_dt_current accordingly. The parameter
			-- `reg' is the entity on which the access is made.
		local
			class_type: CL_TYPE_I;
			type_i: TYPE_I;
			cond: BOOLEAN;
			access: ACCESS_B;
			void_register: REGISTER;
		do
			type_i := context_type;
			class_type ?= type_i;
			cond := not (type_i.is_basic or else class_type = Void);
			if reg.is_current and cond then
				context.add_dt_current;
			end;
			if not reg.is_predefined and cond then
					-- BEWARE!! The function call is polymorphic hence we'll
					-- need to evaluate `reg' twice: once to get its dynamic
					-- type and once as a parameter for Current. Hence we
					-- must make sure it is not held in a No_register--RAM.
			 	access ?= reg;	  -- Cannot fail
				if access.register = No_register then
					access.set_register (void_register);
					access.get_register;
				end;
			end;
		end;

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_I) is
			-- Generate feature call in a `typ' context
		local
			is_nested: BOOLEAN;
			r_id: ROUTINE_ID;
			rout_info: ROUT_INFO;
			base_class: CLASS_C;
		do
			is_nested := not is_first;
			if typ.is_separate then
			   -- Feature call on a separate object
				generate_for_separate_feature_call(reg, typ);
			else
				generated_file.putchar ('(');
				real_type (type).c_type.generate_function_cast (generated_file);
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
					context.generate_current_dtype;
				elseif need_invariant then
					generated_file.putchar ('"');
					generated_file.putstring (feature_name);
					generated_file.putstring ("%", ");
					reg.print_register;
				else
					generated_file.putstring (gc_upper_dtype_lparan);
					reg.print_register;
					generated_file.putchar (')');
				end;
				generated_file.putstring ("))");
			end

			restore_current;
		end;

feature -- Concurrent Eiffel

	put_parameters_into_array is
		local
			expr: PARAMETER_B;
			para_type: TYPE_I;
			i: INTEGER
		do
			if parameters /= Void then
				from
					parameters.start;
					i := 0;
				until
					parameters.after
				loop
					expr ?= parameters.item;    -- Cannot fail
					para_type := real_type(expr.attachment_type);
					if para_type.is_boolean then
						generated_file.putstring ("CURPB(");
						expr.print_register;
						generated_file.putstring (", ");
						generated_file.putint (i);
						generated_file.putstring (");");
						generated_file.new_line;
					end
					if para_type.is_long then
						generated_file.putstring ("CURPI(");
						expr.print_register;
						generated_file.putstring (", ");
						generated_file.putint (i);
						generated_file.putstring (");");
						generated_file.new_line;
					end
					if para_type.is_char then
						generated_file.putstring ("CURPC(");
						expr.print_register;
						generated_file.putstring (", ");
						generated_file.putint (i);
						generated_file.putstring (");");
						generated_file.new_line;
					end
					if para_type.is_double then
						generated_file.putstring ("CURPD(");
						expr.print_register;
						generated_file.putstring (", ");
						generated_file.putint (i);
						generated_file.putstring (");");
						generated_file.new_line;
					end
					if para_type.is_float then
						generated_file.putstring ("CURPR(");
						expr.print_register;
						generated_file.putstring (", ");
						generated_file.putint (i);
						generated_file.putstring (");");
						generated_file.new_line;
					end
					if para_type.is_reference and not para_type.is_separate then
						generated_file.putstring ("CURPO(");
						expr.print_register;
						generated_file.putstring (", ");
						generated_file.putint (i);
						generated_file.putstring (");");
						generated_file.new_line;
					end
					if para_type.is_separate then
						generated_file.putstring ("CURPSO(");
						expr.print_register;
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

	generate_for_separate_feature_call(reg: REGISTRABLE; typ: CL_TYPE_I) is
		local
			is_nested: BOOLEAN;
			r_id: ROUTINE_ID;
			rout_info: ROUT_INFO;
			base_class: CLASS_C;
			evaluated_type: TYPE_I;
			cl_type: CL_TYPE_I
		do
		  	-- Feature call on a separate object
			is_nested := not is_first;
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

			generated_file.putstring ("(");
			real_type (type).c_type.generate_function_cast (generated_file);
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
				context.generate_current_dtype;
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
				if not(cl_type.is_separate or cl_type.is_long or cl_type.is_boolean or cl_type.is_char or cl_type.is_double or cl_type.is_float) then
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
			generated_file.putstring(typ.base_class.e_class.name_in_upper)
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

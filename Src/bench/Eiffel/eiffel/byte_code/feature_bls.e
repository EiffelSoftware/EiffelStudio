-- Enlarged access to an Eiffel feature

class FEATURE_BLS 

inherit

	FEATURE_BL
		redefine 
			generate_access_on_type 
		end

feature 

	NOput_parameters_into_array is
		local
			expr: PARAMETER_B
			para_type: TYPE_I
			i: INTEGER
			loc_idx: INTEGER
			buf: GENERATION_BUFFER
		do
			if parameters /= Void then
				from
					buf := buffer
					parameters.start
					i := 0
				until
					parameters.after
				loop
					expr ?= parameters.item;	-- Cannot fail
					para_type := real_type(expr.attachment_type)
					if para_type.is_boolean then
						buf.putstring ("CURPB(")
						expr.print_register
						buf.putstring (", ")
						buf.putint (i)
						buf.putstring (");")
						buf.new_line
					elseif para_type.is_long then
						buf.putstring ("CURPI(")
						expr.print_register
						buf.putstring (", ")
						buf.putint (i)
						buf.putstring (");")
						buf.new_line
					elseif para_type.is_feature_pointer then
						buf.putstring ("CURPP(")
						expr.print_register
						buf.putstring (", ")
						buf.putint (i)
						buf.putstring (");")
						buf.new_line
					elseif para_type.is_char then
						buf.putstring ("CURPC(")
						expr.print_register
						buf.putstring (", ")
						buf.putint (i)
						buf.putstring (");")
						buf.new_line
					elseif para_type.is_double then
						buf.putstring ("CURPD(")
						expr.print_register
						buf.putstring (", ")
						buf.putint (i)
						buf.putstring (");")
						buf.new_line
					elseif para_type.is_float then
						buf.putstring ("CURPR(")
						expr.print_register
						buf.putstring (", ")
						buf.putint (i)
						buf.putstring (");")
						buf.new_line
					elseif para_type.is_reference and not para_type.is_separate then
						buf.putstring ("CURPO(")
						expr.print_register
						buf.putstring (", ")
						buf.putint (i)
						buf.putstring (");")
						buf.new_line
					elseif para_type.is_separate then
						buf.putstring ("CURPSO(")
--					  expr.print_register
						if expr.stored_register.register_name /= Void then
							loc_idx := context.local_index (expr.stored_register.register_name)
						else
							loc_idx := -1
						end
						if loc_idx /= -1 then
							buf.put_protected_local_set (context.ref_var_used + loc_idx)
						else
							-- It'll be the case when the value is "Void"
							expr.print_register
						end
						buf.putstring (", ")
						buf.putint (i)
						buf.putstring (");")
						buf.new_line
					end
					i := i + 1
					parameters.forth
				end
			end
		end
 
		-- generate code for finalizing mode
	generate_access_on_type(reg: REGISTRABLE; typ: CL_TYPE_I) is
		local
			evaluated_type: TYPE_I
			cl_type: CL_TYPE_I
			buf: GENERATION_BUFFER
		do
			buf := buffer
				-- Feature call on a separate object
			buf.putstring ("if (on_local_processor(")
			reg.print_register
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
 
			{FEATURE_BL} Precursor (reg, typ)
 
			buf.putchar ('(')
			buf.putstring ("CURPROXY_OBJ(")
			reg.print_register
			buf.putstring (")")
 
			if parameters /= Void then
				generate_parameters_list
			end
 
			buf.putstring (")")
			if cl_type /= Void  then
				if not (cl_type.is_separate or cl_type.is_expanded) then
					buf.putstring(")")
				end
				buf.putstring (", 0);")
			else
				buf.putstring (";")
			end
 
			buf.new_line
			buf.exdent
			buf.putstring ("}")
			buf.new_line
			buf.putstring ("else {")
			buf.new_line
			buf.indent
			if evaluated_type.is_void then
				buf.putstring ("CURSARI(constant_execute_procedure, oid_of_sep_obj(")
			else
				buf.putstring ("CURSARI(constant_execute_query, oid_of_sep_obj(")
			end
			reg.print_register
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
			buf.putstring(escaped_feature_name)
			buf.putstring ("%", ")
			if parameters /= Void then
				buf.putint (parameters.count)
			else
				buf.putint (0)
			end
			buf.putstring (");")
			buf.new_line
			put_parameters_into_array
			buf.putstring ("CURSG(")
			reg.print_register
			buf.putstring (");")
			buf.new_line
			buf.exdent
			buf.putstring ("}")
			buf.new_line
		end

end

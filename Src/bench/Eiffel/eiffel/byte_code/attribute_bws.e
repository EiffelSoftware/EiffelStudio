-- Enlarge node for attribute access in workbench mode

class ATTRIBUTE_BWS

inherit

	ATTRIBUTE_BW
		redefine
			generate_access_on_type
		end

feature

	generate_access_on_type (reg:  REGISTRABLE; typ: CL_TYPE_I) is
			-- generate code for separate attribute call.
		local
            is_nested: BOOLEAN
            type_i: TYPE_i
            type_c: TYPE_C
            r_id: ROUTINE_ID
            rout_info: ROUT_INFO
            base_class: CLASS_C
			cl_type: CL_TYPE_I
			evaluated_type: TYPE_I
			f: INDENT_FILE
        do
			f := generated_file
			f.putstring ("if (on_local_processor(")
			reg.print_register
			f.putstring (")) {")
			f.new_line
			f.indent
	
			evaluated_type := Context.real_type (type)
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
			-- if cl_type.is_reference and not cl_type.is_separate then
				f.putstring("CURPSO(CURLTS(")
			end

            is_nested := not is_first
            type_i := real_type (type)
            type_c := type_i.c_type
            if not type_i.is_expanded and then not type_c.is_bit then
                    -- For dereferencing, we need a star...
                f.putchar ('*')
                    -- ...followed by the appropriate access cast
                type_c.generate_access_cast (f)
            end
            f.putstring ("(CURPROXY_OBJ(")
            reg.print_register
            f.putstring (")")
            if reg.is_predefined or reg.register /= No_register then
                f.putstring (gc_plus)
            else
                f.putstring (" +")
                f.new_line
                f.indent
            end
            base_class := typ.base_class
            if
                Compilation_modes.is_precompiling or else
                base_class.is_precompiled
            then
                if is_nested then
                    f.putstring ("RTVPA(")
                else
                    f.putstring ("RTWPA(")
                end
                r_id := base_class.feature_table.item
                    (attribute_name).rout_id_set.first
                rout_info := System.rout_info_table.item (r_id)
                rout_info.origin.generated_id (f)
                f.putstring (gc_comma)
                f.putint (rout_info.offset)
            else
                if is_nested then
                    f.putstring ("RTVA(")
                else
                    f.putstring ("RTWA(")
                end
                f.putint (typ.associated_class_type.id.id - 1)
                f.putstring (gc_comma)
                f.putint (real_feature_id)
            end
            f.putstring (gc_comma)
            if is_nested then
                f.putchar ('"')
                f.putstring (attribute_name)
                f.putstring ("%", ")
                f.putstring ("CURPROXY_OBJ(")
                reg.print_register
                f.putstring (")")
            else
                context.generate_current_dtype
            end
            f.putstring ("))")
            if not (reg.is_predefined or reg.register /= No_register) then
              f.exdent
            end
	
			if not(cl_type.is_separate or cl_type.is_long or cl_type.is_feature_pointer or cl_type.is_boolean or cl_type.is_char or cl_type.is_double or cl_type.is_float or cl_type.is_expanded) then
                f.putstring(")")
            end
			f.putstring (", 0);")
	
			f.new_line
			f.exdent
			f.putstring ("}")
			f.new_line
			f.putstring ("else {")
			f.new_line
			f.indent
			f.putstring ("CURSARI(constant_execute_query, oid_of_sep_obj(")
			reg.print_register
			f.putstring ("), constant_attribute, %"")
			f.putstring(base_class.name_in_upper)
			f.putstring("%", %"")
			f.putstring(attribute_name)
			f.putstring ("%", 0);")
			f.new_line
			f.putstring ("CURSG(")
			reg.print_register
			f.putstring (");")
			f.new_line
			f.exdent
			f.putstring ("}")
			f.new_line
		end
	
end

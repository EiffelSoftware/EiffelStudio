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
            r_id: INTEGER
            rout_info: ROUT_INFO
            base_class: CLASS_C
			cl_type: CL_TYPE_I
			evaluated_type: TYPE_I
			buf: GENERATION_BUFFER
        do
			buf := buffer
			buf.putstring ("if (on_local_processor(")
			reg.print_register
			buf.putstring (")) {")
			buf.new_line
			buf.indent
	
			evaluated_type := Context.real_type (type)
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
			-- if cl_type.is_reference and not cl_type.is_separate then
				buf.putstring("CURPSO(CURLTS(")
			end

            is_nested := not is_first
            type_i := real_type (type)
            type_c := type_i.c_type
            if not type_i.is_true_expanded and then not type_c.is_bit then
                    -- For dereferencing, we need a star...
                buf.putchar ('*')
                    -- ...followed by the appropriate access cast
                type_c.generate_access_cast (buf)
            end
            buf.putstring ("(CURPROXY_OBJ(")
            reg.print_register
            buf.putstring (")")
            if reg.is_predefined or reg.register /= No_register then
                buf.putstring (gc_plus)
            else
                buf.putstring (" +")
                buf.new_line
                buf.indent
            end
            base_class := typ.base_class
            if
                Compilation_modes.is_precompiling or else
                base_class.is_precompiled
            then
                if is_nested then
                    buf.putstring ("RTVPA(")
                else
                    buf.putstring ("RTWPA(")
                end
                r_id := base_class.feature_table.item
                    (attribute_name).rout_id_set.first
                rout_info := System.rout_info_table.item (r_id)
                buf.generate_class_id (rout_info.origin)
                buf.putstring (gc_comma)
                buf.putint (rout_info.offset)
            else
                if is_nested then
                    buf.putstring ("RTVA(")
                else
                    buf.putstring ("RTWA(")
                end
                buf.putint (typ.associated_class_type.static_type_id - 1)
                buf.putstring (gc_comma)
                buf.putint (real_feature_id)
            end
            buf.putstring (gc_comma)
            if is_nested then
                buf.putchar ('"')
                buf.putstring (attribute_name)
                buf.putstring ("%", ")
                buf.putstring ("CURPROXY_OBJ(")
                reg.print_register
                buf.putstring (")")
            else
                context.generate_current_dtype
            end
            buf.putstring ("))")
            if not (reg.is_predefined or reg.register /= No_register) then
              buf.exdent
            end
	
			if not (cl_type.is_separate or cl_type.is_expanded) then
                buf.putstring(")")
            end
			buf.putstring (", 0);")
	
			buf.new_line
			buf.exdent
			buf.putstring ("}")
			buf.new_line
			buf.putstring ("else {")
			buf.new_line
			buf.indent
			buf.putstring ("CURSARI(constant_execute_query, oid_of_sep_obj(")
			reg.print_register
			buf.putstring ("), constant_attribute, %"")
			buf.putstring(base_class.name_in_upper)
			buf.putstring("%", %"")
			buf.putstring(attribute_name)
			buf.putstring ("%", 0);")
			buf.new_line
			buf.putstring ("CURSG(")
			reg.print_register
			buf.putstring (");")
			buf.new_line
			buf.exdent
			buf.putstring ("}")
			buf.new_line
		end
	
end

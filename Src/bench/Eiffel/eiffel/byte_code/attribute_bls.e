-- Enlarged access to an Eiffel attribute

class ATTRIBUTE_BLS 

inherit

	ATTRIBUTE_BL
		redefine	
			generate_access_on_type 
		end

feature 
	
    generate_access_on_type (reg:  REGISTRABLE; typ: CL_TYPE_I) is
        	-- generate code for separate attribute call.
        local
            cl_type: CL_TYPE_I
            evaluated_type: TYPE_I
        do
            generated_file.putstring ("if (on_local_processor(")
            reg.print_register
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
            elseif cl_type.is_feature_pointer then
                generated_file.putstring("CURPP(")
            elseif cl_type.is_expanded then
                generated_file.putstring("CURPO(")
                -- FIXCONCURRENCY: We should make a clone here.
            elseif cl_type.is_separate then
                generated_file.putstring("CURPSO(")
            else
            -- if cl_type.is_reference and not cl_type.is_separate then
                generated_file.putstring("CURPSO(CURLTS(")
            end
 
			old_generate_access_on_type (reg, typ)

            if not(cl_type.is_separate or cl_type.is_long or cl_type.is_feature_pointer or cl_type.is_boolean or cl_type.is_char or cl_type.is_double or cl_type.is_float or cl_type.is_expanded) then
                generated_file.putstring(")")
            end
            generated_file.putstring (", 0);")
 
            generated_file.new_line
            generated_file.exdent
            generated_file.putstring ("}")
            generated_file.new_line
            generated_file.putstring ("else {")
            generated_file.new_line
            generated_file.indent
            generated_file.putstring ("CURSARI(constant_execute_query, oid_of_sep_obj(")
            reg.print_register
            generated_file.putstring ("), constant_attribute, %"")
            generated_file.putstring(typ.base_class.name_in_upper)
            generated_file.putstring("%", %"")
            generated_file.putstring(attribute_name)
            generated_file.putstring ("%", 0);")
            generated_file.new_line
            generated_file.putstring ("CURSG(")
            reg.print_register
            generated_file.putstring (");")
            generated_file.new_line
            generated_file.exdent
            generated_file.putstring ("}")
            generated_file.new_line
        end

		-- The following is almost the same as the "generate_access_on_type" of ATTRIBUTE_BL,
		-- but only with the difference that we put "CURPROXY_OBJ()" around the "reg".
		-- So, be sure that this feature is modified if "generate_access_on_type" of ATTRIBUTE_BL
		-- is modified.
	old_generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_I) is
			-- Generate attribute in a `typ' context
		local
			entry: POLY_TABLE [ENTRY]
			table_name: STRING
			offset_class_type: CLASS_TYPE
			type_c: TYPE_C
			type_i: TYPE_I
		do
			type_i := real_type (type)
			type_c := type_i.c_type
			entry := Eiffel_table.poly_table (rout_id)
				-- No need to use dereferencing if object is an expanded
				-- or if it is a bit.
			if not type_i.is_expanded and then not type_c.is_bit then
					-- For dereferencing, we need a star...
				generated_file.putchar ('*')
					-- ...followed by the appropriate access cast
				type_c.generate_access_cast (generated_file)
			end
			generated_file.putstring ("(CURPROXY_OBJ(")
			reg.print_register
			generated_file.putstring (")")
--			if reg.is_predefined or reg.register /= No_register then
				generated_file.putstring (gc_plus)
--			else
--				generated_file.putstring (" +")
--				generated_file.new_line
--				generated_file.indent
--			end
			if entry.is_polymorphic (typ.type_id) then
					-- The access is polymorphic, which means the offset
					-- is not a constant and has to be computed.
				table_name := rout_id.table_name
				generated_file.putchar ('(')
				generated_file.putstring (table_name)
				generated_file.putchar ('-')
				generated_file.putint (entry.min_type_id - 1)
				generated_file.putchar (')')
				generated_file.putchar ('[')
				if reg.is_current then
					context.generate_current_dtype
				else
					generated_file.putstring (gc_upper_dtype_lparan)
					generated_file.putstring ("CURPROXY_OBJ(")
					reg.print_register
					generated_file.putstring ("))")
				end
				generated_file.putchar (']')
					-- Mark attribute offset table used.
				Eiffel_table.mark_used (rout_id)
					-- Remember external attribute offset declaration
				Extern_declarations.add_attribute_table (table_name)
			else
					-- Hardwire the offset
				offset_class_type := system.class_type_of_id (typ.type_id)
				offset_class_type.skeleton.generate_offset
					(generated_file, attribute_id)
			end
			generated_file.putchar (')')
--			if not (reg.is_predefined or reg.register /= No_register) then
--				generated_file.exdent
--			end
		end

end

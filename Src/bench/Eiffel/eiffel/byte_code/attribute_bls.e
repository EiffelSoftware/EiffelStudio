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
 
			old_generate_access_on_type (reg, typ)

            if not(cl_type.is_separate or cl_type.is_expanded) then
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
            buf.putstring(typ.base_class.name_in_upper)
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

		-- The following is almost the same as the "generate_access_on_type" of ATTRIBUTE_BL,
		-- but only with the difference that we put "CURPROXY_OBJ()" around the "reg".
		-- So, be sure that this feature is modified if "generate_access_on_type" of ATTRIBUTE_BL
		-- is modified.
	old_generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_I) is
			-- Generate attribute in a `typ' context
		local
			table_name: STRING
			offset_class_type: CLASS_TYPE
			type_c: TYPE_C
			type_i: TYPE_I
			buf: GENERATION_BUFFER
			array_index: INTEGER
		do
			buf := buffer
			type_i := real_type (type)
			type_c := type_i.c_type
				-- No need to use dereferencing if object is an expanded
				-- or if it is a bit.
			if not type_i.is_true_expanded and then not type_c.is_bit then
					-- For dereferencing, we need a star...
				buf.putchar ('*')
					-- ...followed by the appropriate access cast
				type_c.generate_access_cast (buf)
			end
			buf.putstring ("(CURPROXY_OBJ(")
			reg.print_register
			buf.putstring (")")
--			if reg.is_predefined or reg.register /= No_register then
--				buf.putstring (gc_plus)
--			else
--				buf.putstring (" +")
--				buf.new_line
--				buf.indent
--			end
			array_index := Eiffel_table.is_polymorphic (routine_id, typ.type_id, False)
			if array_index >= 0 then
					-- The access is polymorphic, which means the offset
					-- is not a constant and has to be computed.
				table_name := Encoder.table_name (routine_id)
				buf.putstring (" + (")
				buf.putstring (table_name)
				buf.putchar ('-')
				buf.putint (array_index)
				buf.putchar (')')
				buf.putchar ('[')
				if reg.is_current then
					context.generate_current_dtype
				else
					buf.putstring (gc_upper_dtype_lparan)
					buf.putstring ("CURPROXY_OBJ(")
					reg.print_register
					buf.putstring ("))")
				end
				buf.putchar (']')
					-- Mark attribute offset table used.
				Eiffel_table.mark_used (routine_id)
					-- Remember external attribute offset declaration
				Extern_declarations.add_attribute_table (table_name)
			else
					-- Hardwire the offset
				offset_class_type := system.class_type_of_id (typ.type_id)
					--| In this instruction, we put `False' as second
					--| arguments. This means we won't generate anything if there is nothing
					--| to generate. Remember that `True' is used in the generation of attributes
					--| table in Final mode.
				offset_class_type.skeleton.generate_offset (buf, attribute_id, False)
			end
			buf.putchar (')')
--			if not (reg.is_predefined or reg.register /= No_register) then
--				buf.exdent
--			end
		end

end

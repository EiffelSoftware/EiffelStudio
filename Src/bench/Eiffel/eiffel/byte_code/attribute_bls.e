-- Enlarged access to an Eiffel attribute

class ATTRIBUTE_BLS 

inherit

	ATTRIBUTE_BL
		rename
			generate_access_on_type as old_generate_access_on_type
		end

feature 
	
    generate_access_on_type (reg:  REGISTRABLE; typ: CL_TYPE_I) is
        	-- generate code for separate attribute call.
        local
            cl_type: CL_TYPE_I;
            evaluated_type: TYPE_I
        do
            generated_file.putstring ("if (on_local_processor(")
            reg.print_register;
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
 
			old_generate_access_on_type (reg, typ);

            if not(cl_type.is_separate or cl_type.is_long or cl_type.is_feature_pointer or cl_type.is_boolean or cl_type.is_char or cl_type.is_double or cl_type.is_float) then
                generated_file.putstring(")")
            end
            generated_file.putstring (", 0);");
 
            generated_file.new_line
            generated_file.exdent
            generated_file.putstring ("}");
            generated_file.new_line
            generated_file.putstring ("else {");
            generated_file.new_line
            generated_file.indent
            generated_file.putstring ("CURSARI(constant_execute_query, oid_of_sep_obj(")
            reg.print_register;
            generated_file.putstring ("), constant_attribute, %"")
            generated_file.putstring(typ.base_class.name_in_upper)
            generated_file.putstring("%", %"")
            generated_file.putstring(attribute_name)
            generated_file.putstring ("%", 0);")
            generated_file.new_line
            generated_file.putstring ("CURSG(");
            reg.print_register;
            generated_file.putstring (");");
            generated_file.new_line;
            generated_file.exdent
            generated_file.putstring ("}");
            generated_file.new_line
        end

end

-- Enlarge node for attribute access in workbench mode

class ATTRIBUTE_BW 

inherit

	ATTRIBUTE_BL
		redefine
			check_dt_current, is_polymorphic, generate_access_on_type
		end

feature

	check_dt_current (reg: REGISTRABLE) is
			-- Check whether we need to compute the dynamic type of current
			-- and call context.add_dt_current accordingly. The parameter
			-- `reg' is the entity on which the access is made.
		local
			class_type: CL_TYPE_I
		do
				-- Do nothing if `reg' is not the current entity
			if reg.is_current then
				class_type ?= context_type;
				if class_type /= Void then
					context.add_dt_current;
				end;
			end;
		end;

	
	is_polymorphic: BOOLEAN is True;
			-- Is the attribute access polymorphic ?

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_I) is
			-- Generate attribute access in a `typ' context
		local
			is_nested: BOOLEAN;
			type_i: TYPE_i;
			type_c: TYPE_C;
			r_id: INTEGER;
			rout_info: ROUT_INFO;
			base_class: CLASS_C
			buf: GENERATION_BUFFER
		do
			buf := buffer
			is_nested := not is_first;
			type_i := real_type (type);
			type_c := type_i.c_type;
			if not type_i.is_true_expanded and then not type_c.is_bit then
					-- For dereferencing, we need a star...
				buf.putchar ('*');
					-- ...followed by the appropriate access cast
				type_c.generate_access_cast (buf);
			end;
			buf.putchar ('(');
			reg.print_register;
			if reg.is_predefined or reg.register /= No_register then
				buf.putstring (gc_plus);
			else
				buf.putstring (" +");
				buf.new_line;
				buf.indent;
			end;
			base_class := typ.base_class;
			if
				Compilation_modes.is_precompiling or else
				base_class.is_precompiled
			then
				if is_nested then
					buf.putstring ("RTVPA(");
				else
					buf.putstring ("RTWPA(");
				end;
				r_id := base_class.feature_table.item_id (attribute_name_id).rout_id_set.first;
				rout_info := System.rout_info_table.item (r_id);
				buf.generate_class_id (rout_info.origin)
				buf.putstring (gc_comma);
				buf.putint (rout_info.offset)
			else
				if is_nested then
					buf.putstring ("RTVA(");
				else
					buf.putstring ("RTWA(");
				end;
				buf.putint (typ.associated_class_type.static_type_id - 1);
				buf.putstring (gc_comma);
				buf.putint (real_feature_id);
			end;
			buf.putstring (gc_comma);
			if is_nested then
				buf.putchar ('"');
				buf.putstring (attribute_name);
				buf.putstring ("%", ");
				reg.print_register;
			else
				context.generate_current_dtype;
			end;
			buf.putstring ("))");
			if not (reg.is_predefined or reg.register /= No_register) then
			  buf.exdent;
			end;
		end;
	
end

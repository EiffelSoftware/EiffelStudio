-- Byte code for strip expression

class STRIP_BL

inherit

	STRIP_B
		redefine
			analyze, generate, 
			register, set_register,
			unanalyze
		end;

feature 

	register: REGISTRABLE;
			-- Register for array containing the strip

	set_register (r: REGISTRABLE) is
			-- Set `register' to `r
		do
			register := r;
		end;

	unanalyze is
			-- Unanalyze expression
		do
			register := Void
		end;
	
	analyze is
			-- Analyze expression
		do
			get_register
		end;
	
	generate is
			-- Generate expression
		local
			cl_type: CLASS_TYPE
		do
			cl_type := Context.class_type;
			generated_file.putstring ("{");
			generated_file.new_line;
			generated_file.indent;
			generated_file.putstring ("static char *items[");
			generated_file.putstring ("] = { ");
			generate_attribute_names_list;
			generated_file.putstring (" };");
			generated_file.new_line;
			print_register;
			generated_file.putstring (" = ");
			generated_file.putstring ("RTST(");
			Context.Current_register.print_register_by_name;
			generated_file.putstring (", ");
			generated_file.putint (cl_type.type_id - 1);
			generated_file.putstring (", items, ");
			generated_file.putint (feature_ids.count);
			generated_file.putstring ("L);");
			generated_file.new_line;
			generated_file.exdent;
			generated_file.putstring (" }");
			generated_file.new_line;
		end;

	generate_attribute_names_list is
			-- Generate routine ids (from feature ids) as a C list.
		local
			attr_names: LINKED_LIST [STRING];	
		do
			attr_names := attribute_names;
			from
				attr_names.start
			until
				attr_names.after
			loop
				generated_file.putstring ("%"");
				generated_file.putstring (attr_names.item);
				generated_file.putstring ("%"");
				attr_names.forth;
				if not attr_names.after then
					generated_file.putstring (", ")
				end;	
			end;
		end;

	set_feature_ids (ids: like feature_ids) is
			-- Set feature_ids to `ids'
		require
			valid_arg: ids /= Void
		do
			feature_ids := ids
		end;

invariant

	set_exists: feature_ids /= Void

end

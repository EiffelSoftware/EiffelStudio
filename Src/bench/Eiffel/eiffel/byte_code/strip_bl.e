-- Byte code for strip expression

class STRIP_BL

inherit

	STRIP_B
		redefine
			analyze, generate, 
			register, set_register,
			unanalyze, allocates_memory
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

	allocates_memory: BOOLEAN is True;

	generate is
			-- Generate expression
		local
			cl_type: CLASS_TYPE
			buf: GENERATION_BUFFER
		do
			buf := buffer
			cl_type := Context.class_type;
			buf.put_character ('{');
			buf.put_new_line;
			buf.indent;
			generate_attribute_names_list;
			print_register;
			buf.put_string (" = ");
			buf.put_string ("RTST(");
			Context.Current_register.print_register;
			buf.put_string (gc_comma);
			if context.workbench_mode then
				buf.put_string ("RTUD(")
				buf.put_static_type_id (cl_type.static_type_id)
				buf.put_character (')')
			else
				buf.put_type_id (cl_type.type_id)
			end
			buf.put_string (", items, ");
			buf.put_integer (feature_ids.count);
			buf.put_string ("L);");
			buf.put_new_line;
			buf.exdent;
			buf.put_string (" }");
			buf.put_new_line;
		end;

	generate_attribute_names_list is
			-- Generate routine ids (from feature ids) as a C list.
		require
			attribute_names_not_void: attribute_names /= Void
		local
			attr_names: LINKED_LIST [STRING];	
			buf: GENERATION_BUFFER
		do
			buf := buffer
			attr_names := attribute_names;
			if not attr_names.is_empty then
				buf.put_string ("static char *items[");
				buf.put_string ("] = { ");
				from
					attr_names.start
				until
					attr_names.after
				loop
					buf.put_character ('"');
					buf.put_string (attr_names.item);
					buf.put_character ('"');
					attr_names.forth;
					if not attr_names.after then
						buf.put_string (gc_comma);
					end;	
				end;
				buf.put_string (" };");
			else
				buf.put_string ("static char **items = NULL;")
			end
			buf.put_new_line;
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

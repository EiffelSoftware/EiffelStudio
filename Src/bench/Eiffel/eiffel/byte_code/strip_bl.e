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
			buf.putchar ('{');
			buf.new_line;
			buf.indent;
			generate_attribute_names_list;
			print_register;
			buf.putstring (" = ");
			buf.putstring ("RTST(");
			Context.Current_register.print_register;
			buf.putstring (gc_comma);
			buf.putint (cl_type.type_id - 1);
			buf.putstring (", items, ");
			buf.putint (feature_ids.count);
			buf.putstring ("L);");
			buf.new_line;
			buf.exdent;
			buf.putstring (" }");
			buf.new_line;
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
				buf.putstring ("static char *items[");
				buf.putstring ("] = { ");
				from
					attr_names.start
				until
					attr_names.after
				loop
					buf.putchar ('"');
					buf.putstring (attr_names.item);
					buf.putchar ('"');
					attr_names.forth;
					if not attr_names.after then
						buf.putstring (gc_comma);
					end;	
				end;
				buf.putstring (" };");
			else
				buf.putstring ("static char **items = NULL;")
			end
			buf.new_line;
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

class DEBUG_B 

inherit

	INSTR_B
		redefine
			make_byte_code, enlarge_tree, analyze, generate
		end
	
feature 

	compound: BYTE_LIST [BYTE_NODE];
			-- Debug compound {list of INSTR_B]: can be Void

	keys: FIXED_LIST [STRING];
			-- Keys if any

	set_compound (c: like compound) is
			-- Assign `c' to `compound'.
		do
			compound := c;
		end;

	set_keys (k: like keys) is
			-- Assign `k' to `keys'.
		do
			keys := k;
		end;

	enlarge_tree is
			-- Enlarge generation tree
		do
			if compound /= Void then
				compound.enlarge_tree;
			end;
		end;

	analyze is
			-- Analysis of debug compound
		do
			if compound /= Void then
				if context.workbench_mode or else generate_for_final_mode
				then
					compound.analyze;
				end;
			end;
		end;

	generate_for_final_mode: BOOLEAN is
			-- Has the debug compound to be generated in final mode ?
		local
			debug_level: DEBUG_I;
		do
			debug_level := context.current_type.base_class.debug_level;
			if keys = Void then
				Result := debug_level.is_yes;
			else
				from
					keys.start
				until
					keys.offright or else Result
				loop
					Result := debug_level.is_debug (keys.item);
					keys.forth;
				end;
			end;
		end;

	generate is
			-- Generation of debug compound
		local
			static_type: INTEGER;
		do
			if compound /= Void then
				if context.final_mode then
					if generate_for_final_mode then
						compound.generate;
					end;
				else
						-- Generation of the debug compound in workbench
						-- mode
					static_type := context.current_type.type_id - 1;
					generated_file.putstring ("if (");
					generated_file.new_line;
					generated_file.indent;
					if keys = Void then
							-- No keys
						generated_file.putstring ("WDBG(");
						generated_file.putint (static_type);
						generated_file.putstring (", (char *) 0)");
					else
						from
							keys.start
						until
							keys.offright
						loop
							generated_file.putstring ("WDBG(");
							generated_file.putint (static_type);
							generated_file.putstring (",%"");
							generated_file.putstring (keys.item);
							generated_file.putstring ("%")");
							keys.forth;
							if not keys.offright then
								generated_file.putstring (" ||");
								generated_file.new_line;
							end;
						end;
					end;
					generated_file.new_line;
					generated_file.exdent;
					generated_file.putstring (") {");
					generated_file.new_line;
					generated_file.indent;
								
					compound.generate;
	
					generated_file.exdent;
					generated_file.putchar ('}');
					generated_file.new_line;
				end;
			end;
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a debug clause
		local
			nb_keys: INTEGER;
		do
			if compound /= Void then
				ba.append (Bc_debug);
				if keys = Void then
					ba.append_integer (0);
				else
					ba.append_integer (keys.count);
					from
						keys.start
					until
						keys.offright
					loop
						ba.append_raw_string (keys.item);
						keys.forth;
					end;
				end;
				ba.mark_forward;
				compound.make_byte_code (ba);
				ba.write_forward;
			end;
		end;

end

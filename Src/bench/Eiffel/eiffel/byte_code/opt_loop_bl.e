-- Optimized byte code for loops

class
	OPT_LOOP_BL

inherit
	OPT_LOOP_B
		undefine
			analyze, generate
		end;

	LOOP_BL
		undefine
			enlarged, size, pre_inlined_code
		redefine
			fill_from, generate
		end

feature

	fill_from (l: OPT_LOOP_B) is    
		do
			{LOOP_BL} Precursor (l);
			array_desc := l.array_desc
			generated_offsets := l.generated_offsets
			already_generated_offsets := l.already_generated_offsets
		end;

	external_reg_name (id: INTEGER): STRING is
			-- Register name which will be effectively generated at the C level.
		do
			!!Result.make (0);
			if id = 0 then
				Result.append ("tmp_result");
			elseif id < 0 then
					-- local
				Result.append ("loc");
				Result.append_integer (-id);
			else
					-- Argument
				Result.append ("arg");
				Result.append_integer (id);
			end
		end;

	internal_reg_name (id: INTEGER): STRING is
			-- Same as `external_reg_name' except that for a function returning a
			-- result we need to return `Result' and not `tmp_result' because the
			-- hash_code is based on `Result'.
		do
			!!Result.make (0);
			if id = 0 then
				Result.append ("Result");
			elseif id < 0 then
					-- local
				Result.append ("loc");
				Result.append_integer (-id);
			else
					-- Argument
				Result.append ("arg");
				Result.append_integer (id);
			end
		end;

	register_acces (id: INTEGER): STRING is
		do
			if context.byte_code.is_once and then id = 0 then
				Result := "Result"
			else
				!!Result.make (5);
				Result.append ("l[");
				Result.append_integer (context.local_index (internal_reg_name (id)));
				Result.append_character (']');
			end
		end

	generate is
		do
			generate_line_info;
			generate_assertions;
			generate_declarations;
			generate_initializations;
			generate_loop_body;
			generate_free;
		end;

	generate_declarations is
		local
			id: INTEGER;
			r_name: STRING
		do
			if array_desc /= Void then
				generated_file.putchar ('{');
				generated_file.new_line;
				from
					array_desc.start
				until
					array_desc.after
				loop
					generated_file.putstring ("RTAD(");
					id := array_desc.item;
					r_name := external_reg_name (id);
					generated_file.putstring (r_name);
					generated_file.putstring (gc_rparan_comma);
							-- The Dtype has not been declared before
					if
						already_generated_offsets = Void
					or else 
						not already_generated_offsets.has (id)
					then
						generated_file.putstring (" RTADTYPE(");
						generated_file.putstring (r_name);
						generated_file.putstring (gc_rparan_comma);
					end;
					generated_file.new_line;
					array_desc.forth
				end
				generated_file.new_line;
			end
			if generated_offsets /= Void then
				if array_desc = Void then
					generated_file.putchar ('{');
					generated_file.new_line;
				end;
				from
					generated_offsets.start
				until
					generated_offsets.after
				loop
					r_name := external_reg_name (generated_offsets.item);
					generated_file.putstring ("RTADTYPE(");
					generated_file.putstring (r_name);
					generated_file.putstring ("); RTADOFFSETS(");
					generated_file.putstring (r_name);
					generated_file.putstring (gc_rparan_comma);
					generated_file.new_line;
					generated_offsets.forth
				end
				generated_file.new_line;
			end
		end;

	generate_initializations is
		local
			id: INTEGER;
			r_name: STRING
		do
			if array_desc /= Void then
				from
					array_desc.start
				until
					array_desc.after
				loop
					id := array_desc.item;
					if
						already_generated_offsets = Void
					or else
						not already_generated_offsets.has (id)
					then
						generated_file.putstring ("RTAI(");
					else
							-- We can use the offset definitions
						generated_file.putstring ("RTAIOFF(");
					end
					System.remover.array_optimizer.array_item_type (id).
						generate (generated_file);
					generated_file.putstring (gc_comma);
					generated_file.putstring (external_reg_name (id));
					generated_file.putstring (gc_comma);
					generated_file.putstring (register_acces (id));
					generated_file.putstring (gc_rparan_comma);
					generated_file.new_line;

					array_desc.forth
				end
				generated_file.new_line;
			end;
			if generated_offsets /= Void then
				from
					generated_offsets.start
				until
					generated_offsets.after
				loop
					id := generated_offsets.item;
					r_name := external_reg_name (id);
					generated_file.putstring ("RTAIOFFSETS(");
					generated_file.putstring (r_name);
					generated_file.putstring (gc_comma);
					generated_file.putstring (register_acces (id));
					generated_file.putstring (gc_rparan_comma);
					generated_file.new_line;
					generated_offsets.forth
				end
				generated_file.new_line;
			end
		end;

	generate_free is
		local
			id: INTEGER
		do
			if array_desc /= Void then
				from
					array_desc.start
				until
					array_desc.after
				loop
					generated_file.putstring ("RTAF(");
					id := array_desc.item
					generated_file.putstring (external_reg_name (id));
					generated_file.putstring (gc_comma);
					generated_file.putstring (register_acces (id));
					generated_file.putstring (gc_rparan_comma);
					generated_file.new_line;
					array_desc.forth
				end
				generated_file.new_line;
				generated_file.putchar ('}');
				generated_file.new_line;
			elseif generated_offsets /= Void then
				generated_file.putchar ('}');
				generated_file.new_line;
			end
		end;

end

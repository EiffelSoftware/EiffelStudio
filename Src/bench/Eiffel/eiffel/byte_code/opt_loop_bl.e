-- Optimized byte code for loops

class OPT_LOOP_BL

inherit

	OPT_LOOP_B
		undefine
			analyze, generate
		end;
	LOOP_BL
		rename
			fill_from as old_fill_from
		undefine
			enlarged
		redefine
			generate
		end
	LOOP_BL
		undefine
			enlarged
		redefine
			fill_from, generate
		select
			fill_from
		end

feature

	fill_from (l: OPT_LOOP_B) is    
		do
			old_fill_from (l);
			array_desc := l.array_desc
		end;

	generate is
		do
			generate_assertions;
			generated_file.putstring ("{");
			generated_file.new_line;
			generated_file.putstring ("generate access to area[-lower]");
			generated_file.new_line;
			generate_loop_body
			generated_file.putstring ("free access to area[-lower]");
			generated_file.new_line;
		end;

end

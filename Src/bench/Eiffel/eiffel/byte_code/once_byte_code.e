--|-------------------------------------------------------------|--
--|  Copyright (c) 1992 Interactive Software Engineering, Inc.  |--
--|	  270 Storke Road, Suite 7 Goleta, California 93117	  |--
--|					 (805) 685-1006						  |--
--| All rights reserved. Duplication or distribution prohibited |--
--|-------------------------------------------------------------|--

-- Byte code for once feature

class ONCE_BYTE_CODE

inherit

	STD_BYTE_CODE
		redefine
			is_once, generate_once, generate_result_declaration
		end

feature

	is_once: BOOLEAN is True;
			-- Is the current byte code relative to a once feature ?

	generate_once is
			-- Generate test at the head of once routines
		local
			type_i: TYPE_I;
		do
			generated_file.putstring ("if (done)");
			generated_file.new_line;
			generated_file.indent;
				-- Full generation for a once function, but a single
				-- return for procedures.
			generated_file.putstring ("return");
			if result_type /= Void and then not result_type.is_void then
				generated_file.putchar (' ');
				if context.result_used then
					generated_file.putstring ("Result");
				else
					type_i := real_type (result_type);
					type_i.c_type.generate_cast (generated_file);
					generated_file.putchar ('0');
				end;
			end;
			generated_file.putchar (';');
			generated_file.new_line;
			generated_file.exdent;
				-- Detach this block
			generated_file.new_line;
			generated_file.putstring ("done = 1;");
			generated_file.new_line;
			init_dtype;
		end;

	generate_result_declaration is
			-- Generate declaration of the Result entity
		local
			ctype: TYPE_C;
		do
			ctype := real_type (result_type).c_type;
			generated_file.putstring ("static ");
			ctype.generate (generated_file);
			generated_file.putstring ("Result = ");
			ctype.generate_cast (generated_file);
			generated_file.putstring ("0;");
			generated_file.new_line;
		end;

end


class PASS1_C

inherit

	PASS_C;
	SHARED_ERROR_HANDLER;
	SHARED_SERVER

creation

	make

feature

	set_check_suppliers is
			-- Check only the suppliers
		do
		end;

	execute is
			-- Syntax analysis on `associated_class'
		local
			ast: CLASS_AS_B;
			class_id: CLASS_ID;
			temp: STRING;
			comment_reg: COMMENT_REGISTRATION
		do
				-- Verbose
			io.error.putstring ("Degree 5: class ");
				temp := clone (associated_class.class_name)
				temp.to_upper;
			io.error.putstring (temp);
			io.error.new_line;

			class_id := associated_class.id;
			if new_compilation then
				ast := associated_class.build_ast;
				if Compilation_modes.is_precompiling then
						-- Register the comments for precompiled
						-- associated_class.
					!! comment_reg.make (ast, associated_class);
					comment_reg.register
				end
			elseif Tmp_ast_server.has (class_id.id) then
				ast := Tmp_ast_server.item (class_id.id)
			else
				ast := Ast_server.item (class_id.id)
			end;
			check
					-- The ast is either recomputed or retrieved from
					-- a server
				ast_not_void: ast /= Void;
			end;
			associated_class.end_of_pass1 (ast);

				-- No syntax error happened: set the compilation status
				-- of the current changed class.
			check
				No_error: not Error_handler.has_error;
			end;
		end;

end

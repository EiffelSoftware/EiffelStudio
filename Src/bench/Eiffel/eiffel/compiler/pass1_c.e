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
			ast: CLASS_AS;
			class_id: INTEGER;
			temp: STRING
		do
				-- Verbose
			io.putstring ("Degree 5: class ");
				temp := associated_class.class_name.duplicate;
				temp.to_upper;
			io.putstring (temp);
			io.new_line;

			class_id := associated_class.id;
			if new_compilation then
				ast := associated_class.build_ast
			elseif Tmp_ast_server.has (class_id) then
				ast := Tmp_ast_server.item (class_id)
			else
				ast := Ast_server.item (class_id)
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

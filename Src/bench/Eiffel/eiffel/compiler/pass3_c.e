class PASS3_C

inherit

	COMP_PASS_C;
	SHARED_SERVER;
	SHARED_ERROR_HANDLER

creation

	make

feature

	execute (degree_output: DEGREE_OUTPUT; to_go: INTEGER) is
			-- Byte code production and type checking: list `changed_classes'
			-- contains classes marked `changed' and/or changed3. For
			-- the classes marked `changed', produce byte code and type
			-- check the features marked `melted'; if the class is also
			-- marked `changed3' type check also the other features. For
			-- classes marked `changed3' only, type check all the
			-- features.
		do
				-- Type checking and maybe byte code production
				-- for a class
			degree_output.put_degree_3 (associated_class, to_go);
			associated_class.pass3;
			associated_class.set_reverse_engineered (False)

				-- No error happened: set the compilation status
				-- of class `associated_class'
			check
				No_error: not Error_handler.has_error;
			end;
		end;

end

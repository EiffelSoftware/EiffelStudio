indexing

	description:
		"Abstract description of a reverse assignment. %
		%Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class REVERSE_AS_B

inherit
	
	REVERSE_AS
		redefine
			target, source
		end;

	ASSIGN_AS_B
		undefine
			assign_symbol
		redefine
			check_validity, byte_node,
			target, source
		end

feature -- Properties

	source: EXPR_AS_B;

	target: ACCESS_AS_B

feature -- Access

	check_validity is
			-- Check validity of the reverse assignment
		local
			source_type, target_type: TYPE_A;
			vjrv: VJRV;
			vkcn3: VKCN3
		do
				-- Stack managment
			source_type := context.item;
			context.pop (1);
			if source_type.is_void then
				!!vkcn3;
				context.init_error (vkcn3);
				Error_handler.insert_error (vkcn3);
				Error_handler.raise_error;
			end;

			target_type := context.item;
			
			if 	target_type.is_basic
				or else
				target_type.is_formal
				or else
				target_type.is_expanded
			then
				!!vjrv;
				context.init_error (vjrv);
				vjrv.set_target_name (target.access_name);
				vjrv.set_target_type (target_type);
				Error_handler.insert_error (vjrv);
			end;
				-- Update type stack
			context.pop (1);
		end;

	byte_node: REVERSE_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_target (target.byte_node);
			Result.set_source (source.byte_node);
			Result.set_line_number (line_number)
		end;

end -- class REVERSE_AS_B

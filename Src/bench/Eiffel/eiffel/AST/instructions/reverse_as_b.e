-- Abstract description of a reverse assignment

class REVERSE_AS

inherit

	ASSIGN_AS
		redefine
			check_validity, byte_node, assign_symbol
		end

feature

	check_validity is
			-- Check validity of the reverse assignment
		local
			target_type: TYPE_A;
			vjrv: VJRV;
		do
				-- Stack managment
			context.pop (1);
			target_type := context.item;
			
			if 	target_type.is_basic
				or else
				target_type.is_formal
				or else
				target_type.is_expanded
			then
				!!vjrv;
				context.init_error (vjrv);
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
		end;

feature {} -- Formatter
	
	assign_symbol: STRING is 
		once
			Result := " ?= ";
		end;

end

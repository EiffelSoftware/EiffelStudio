indexing

	description:
		"Abstract description of a reverse assignment. %
		%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class REVERSE_AS

inherit
	ASSIGN_AS
		redefine
			check_validity, byte_node, assign_symbol
		end

feature -- Access

	check_validity is
			-- Check validity of the reverse assignment
		local
			target_type: TYPE_A
			vjrv1: VJRV1
			vjrv2: VJRV2
		do
				-- Stack managment
			context.pop (1)
			
			if not System.il_generation then
				target_type := context.item
				if target_type.is_expanded then
					create vjrv1
					context.init_error (vjrv1)
					vjrv1.set_target_name (target.access_name)
					vjrv1.set_target_type (target_type)
					Error_handler.insert_error (vjrv1)
				elseif target_type.is_formal then
					create vjrv2
					context.init_error (vjrv2)
					vjrv2.set_target_name (target.access_name)
					vjrv2.set_target_type (target_type)
					Error_handler.insert_error (vjrv2)
				end
			end
				-- Update type stack
			context.pop (1)
		end

	byte_node: REVERSE_B is
			-- Associated byte code
		do
			!! Result
			Result.set_target (target.byte_node)
			Result.set_source (source.byte_node)
			Result.set_line_number (line_number)
		end

feature {NONE} -- Formatter
	
	assign_symbol: TEXT_ITEM is 
		do
			Result := ti_Reverse_assign
		end

end -- class REVERSE_AS


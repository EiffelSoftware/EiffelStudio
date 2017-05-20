note
	description: "Summary description for {TEMPLATE_SUM_ACTION}."
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_SUM_ACTION

inherit
	TEMPLATE_CUSTOM_ACTION

	SHARED_TEMPLATE_CONTEXT

feature -- Execution

	item (a_text: STRING; a_params: STRING_TABLE [STRING]; a_struct_action: TEMPLATE_STRUCTURE_ACTION): detachable ANY
		local
			i: INTEGER_64
		do
			if attached a_params.item ("left") as e then
				i := i + integer_64_from (e, a_struct_action)
			end
			if attached a_params.item ("right") as e then
				i := i + integer_64_from (e, a_struct_action)
			end
			if attached a_params.item ("name") as n then
				template_context.add_value (i, n)
			elseif not a_text.is_whitespace then
				template_context.add_value (i, a_text)
			end
			Result := ""
		end

	integer_64_from (e: STRING; a_struct_action: TEMPLATE_STRUCTURE_ACTION): INTEGER_64
		do
			if e.is_integer_64 then
				Result := e.to_integer_64
			elseif attached a_struct_action.resolved_expression (e) as v then
				if attached {READABLE_STRING_GENERAL} v as s and then s.is_integer_64 then
					Result := s.to_integer_64
				elseif attached {INTEGER_64} v as i64 then
					Result := i64
				elseif attached {INTEGER_32} v as i32 then
					Result := i32.as_integer_64
				end
			end
		end

end

class INLINED_ATTR_B

inherit
	ATTRIBUTE_BL
		redefine
			enlarged, fill_from, current_register
		end

feature

	fill_from (a: ATTRIBUTE_B) is
		do
			parent := a.parent
			attribute_name_id := a.attribute_name_id;
			attribute_id := a.attribute_id;
			routine_id := a.routine_id
			type := a.type;
		end

	enlarged: INLINED_ATTR_B is
		do
			Result := Current
		end

	Current_register: INLINED_CURRENT_B is
		once
			!!Result
		end

end

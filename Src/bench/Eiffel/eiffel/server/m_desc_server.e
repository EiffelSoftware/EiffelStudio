class M_DESC_SERVER

inherit

	COMPILER_SERVER [MELTED_DESC, CLASS_ID]

creation

	make

feature

	id (t: MELTED_DESC): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	Cache: M_DESC_CACHE is
		once
			!!Result.make;
		end;

	Size_limit: INTEGER is 2;

end

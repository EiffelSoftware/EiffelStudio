note
	description: "Operand Type"
	date: "$Date$"
	revision: "$Revision$"

once class
	OPERAND_TYPE

create
	t_none, t_value, t_int, t_real, t_string, t_label

feature	{NONE} -- Creation

	t_none once  end
	t_value once  end
	t_int once  end
	t_real once  end
	t_string once  end
	t_label once  end

feature -- Access

	instances: ITERABLE [OPERAND_TYPE]
			-- All known operand types.
		do
			Result := <<{OPERAND_TYPE}.t_none, {OPERAND_TYPE}.t_value, {OPERAND_TYPE}.t_int, {OPERAND_TYPE}.t_real, {OPERAND_TYPE}.t_string, {OPERAND_TYPE}.t_label>>
		ensure
			instance_free: class
		end
end

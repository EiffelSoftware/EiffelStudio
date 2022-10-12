note
	description: "Operand Type"
	date: "$Date$"
	revision: "$Revision$"

once class
	CIL_OPERAND_TYPE

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

	instances: ITERABLE [CIL_OPERAND_TYPE]
			-- All known operand types.
		do
			Result := <<{CIL_OPERAND_TYPE}.t_none, {CIL_OPERAND_TYPE}.t_value, {CIL_OPERAND_TYPE}.t_int, {CIL_OPERAND_TYPE}.t_real, {CIL_OPERAND_TYPE}.t_string, {CIL_OPERAND_TYPE}.t_label>>
		ensure
			instance_free: class
		end
end

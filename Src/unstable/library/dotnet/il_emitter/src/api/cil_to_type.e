note
	description: "Summary description for {CIL_TO_TYPE}."
	date: "$Date$"
	revision: "$Revision$"

once class
	CIL_TO_TYPE

create
	ToI1, ToI2, ToI4, ToI8, ToR4, ToR8, ToU1, ToU2, ToU4, ToU8, ToInt, ToUint, ToRun

feature {NONE} -- Creation procedures

	ToI1 once end
	ToI2 once end
	ToI4 once end
	ToI8 once end
	ToR4 once end
	ToR8 once end
	ToU1 once end
	ToU2 once end
	ToU4 once end
	ToU8 once end
	ToInt once end
	ToUint once end
	ToRun once end

feature -- Instances

	instances: ITERABLE [CIL_TO_TYPE]
			-- All known instances CIL to type
		do
			Result := <<{CIL_TO_TYPE}.ToI1,
					{CIL_TO_TYPE}.ToI2,
					{CIL_TO_TYPE}.ToI4,
					{CIL_TO_TYPE}.ToI8,
					{CIL_TO_TYPE}.ToR4,
					{CIL_TO_TYPE}.ToR8,
					{CIL_TO_TYPE}.ToU1,
					{CIL_TO_TYPE}.ToU2,
					{CIL_TO_TYPE}.ToU4,
					{CIL_TO_TYPE}.ToU8,
					{CIL_TO_TYPE}.ToInt,
					{CIL_TO_TYPE}.ToUint,
					{CIL_TO_TYPE}.ToRun>>
		ensure
			instance_free: class
		end

end

note
	description: "Summary description for {CIL_IND_TYPE}."
	date: "$Date$"
	revision: "$Revision$"

once class
	CIL_IND_TYPE

create
	I1, I2, I4, I8, U1, U2, U4, U8, R4, R8, Int, Ref

feature {NONE} -- Creation Procedure

	I1 once end
	I2 once end
	I4 once end
	I8 once end
	U1 once end
	U2 once end
	U4 once end
	U8 once end
	R4 once end
	R8 once end
	Int once end
	Ref once end

feature -- Instances

	instances: ITERABLE [CIL_IND_TYPE]
			-- All knwon instances
		do
			Result := <<{CIL_IND_TYPE}.I1,
					{CIL_IND_TYPE}.I2,
					{CIL_IND_TYPE}.I4,
					{CIL_IND_TYPE}.I8,
					{CIL_IND_TYPE}.U1,
					{CIL_IND_TYPE}.U2,
					{CIL_IND_TYPE}.U4,
					{CIL_IND_TYPE}.U8,
					{CIL_IND_TYPE}.R4,
					{CIL_IND_TYPE}.R8,
					{CIL_IND_TYPE}.Int,
					{CIL_IND_TYPE}.Ref>>
		ensure
			instance_free: class
		end

end

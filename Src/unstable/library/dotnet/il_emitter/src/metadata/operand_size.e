note
	description: "Operand Size"
	date: "$Date$"
	revision: "$Revision$"

once class
	OPERAND_SIZE

create
	any, i8, u8, i16, u16, i32, u32, i64, u64, inative, r4, r8

feature {NONE} -- Creation

	any once end
	i8 once end
	u8 once end
	i16 once end
	u16 once end
	i32 once end
	u32 once end
	i64 once end
	u64 once end
	inative once end
	r4 once end
	r8 once end

feature -- Access

	instances: ITERABLE [OPERAND_SIZE]
		do
			Result := <<{OPERAND_SIZE}.any, {OPERAND_SIZE}.i8, {OPERAND_SIZE}.u8, {OPERAND_SIZE}.i16, {OPERAND_SIZE}.u16, {OPERAND_SIZE}.i32, {OPERAND_SIZE}.u32, {OPERAND_SIZE}.i64, {OPERAND_SIZE}.u64, {OPERAND_SIZE}.inative, {OPERAND_SIZE}.r4, {OPERAND_SIZE}.r8>>
		ensure
			static: class
		end
end

note
	description: "Summary description for {ATTRIBUTES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen expanded class
	ATTRIBUTES

obsolete "This class has been changed to an ENUM type on the C++ side."

feature

	none: NATURAL_32 = 0x0
	zext: NATURAL_32 = 0x1
	sext: NATURAL_32 = 0x2
	no_return: NATURAL_32 = 0x4
	in_reg: NATURAL_32 = 0x8
	struct_ret: NATURAL_32 = 0x10
	no_unwind: NATURAL_32 = 0x20
	no_alias: NATURAL_32 = 0x40
	by_val: NATURAL_32 = 0x80
	nest: NATURAL_32 = 0x100
	read_none: NATURAL_32 = 0x200
	read_only: NATURAL_32 = 0x400
	no_inline: NATURAL_32 = 0x800
	always_inline: NATURAL_32 = 0x1000
	optimize_for_size: NATURAL_32 = 0x2000
	stack_protect: NATURAL_32 = 0x4000
	stack_protect_req: NATURAL_32 = 0x8000
	alignment: NATURAL_32 = 0x1f_0000
	no_capture: NATURAL_32 = 0x20_0000
	no_red_zone: NATURAL_32 = 0x40_0000
	no_implicit_float: NATURAL_32 = 0x80_0000
	naked: NATURAL_32 = 0x100_0000
	inline_hint: NATURAL_32 = 0x200_0000
	stack_alignment: NATURAL_32 = 0x1c00_0000

end

note
	description: "A Cil Instruction"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_INSTRUCTION

inherit

	REFACTORING_HELPER

create
	make,
	make_with_text

feature {NONE} -- Initialization

	make (a_op: CIL_INSTRUCTION_OPCODES; a_operand: detachable CIL_OPERAND)
		do
			create {ARRAYED_LIST [STRING_32]} switches.make (0)
			opcode := a_op
			operand := a_operand
			create text.make_empty
			seh_type := {CIL_SEH}.seh_try
		end

	make_with_text (a_op: CIL_INSTRUCTION_OPCODES; a_text: STRING_32)
		do
			create {ARRAYED_LIST [STRING_32]} switches.make (0)
			opcode := a_op
			create text.make_from_string_general (a_text)
			seh_type := {CIL_SEH}.seh_try
		end

feature -- Access

	live: BOOLEAN assign set_live
			-- is it live?
			-- We are checking for live because sometimes
			-- dead code sequences can confuse the stack checking routine.

		-- The following to fields are
		-- used as a union `operand` and `seh_catch_type`.

	operand: detachable CIL_OPERAND assign set_operand
			-- the `operand` (CIL instructions have either zero or 1 operands)

	seh_catch_type: detachable CIL_TYPE assign set_seh_catch_type
			-- the catch type.

	switches: LIST [STRING_32]
			-- Get the set of case labels.

	opcode: CIL_INSTRUCTION_OPCODES assign set_opcode
			-- Current cil opcode.

	offset: INTEGER assign set_offset
			-- the offset of the instruccion within the method.

	seh_type: CIL_SEH
			-- seh type.

	seh_begin: BOOLEAN
			-- true if it is a begin tag.

	text: STRING_32
			-- text, e.g for a comment.

	label: STRING_32
			-- Label name associated with the instruction.
		do
			Result := "";
			if attached operand as l_operand then
				Result := l_operand.string_value
			end

		end

feature -- Status Report

	is_rel4: BOOLEAN
			-- Is a branch with a 4 byte relative offset
		do
			Result := instructions.at ({CIL_INSTRUCTION_OPCODES}.index_of (opcode) + 1).operand_type = {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel4)
		end

	is_rel1: BOOLEAN
			-- Is a branch with a 1 byte relative offset
		do
				-- TODO check if it's better to use IOPERAND as the type of operand_type instead of NATURAL_8.
			Result := instructions.at ({CIL_INSTRUCTION_OPCODES}.index_of (opcode) + 1).operand_type = {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel1)
		end

	is_branch: BOOLEAN
			-- Is current instruccion any kind of branch
		do
			Result := is_rel1 or else is_rel4
		end

	is_call: BOOLEAN
			-- Is it any kind of call?
		do
			Result := opcode = {CIL_INSTRUCTION_OPCODES}.i_call or else opcode = {CIL_INSTRUCTION_OPCODES}.i_calli or else opcode = {CIL_INSTRUCTION_OPCODES}.i_callvirt
		end

	stack_usage: INTEGER
			-- get stack use for this instruction
			-- positive means it adds to the stack, negative means it subtracts
			-- 0 means it has no effect.
		local
			l_sig: CIL_METHOD_SIGNATURE
			n: INTEGER
		do
			inspect opcode
			when {CIL_INSTRUCTION_OPCODES}.i_SEH then
				if seh_begin and then
					(seh_type = {CIL_SEH}.seh_filter or else
						seh_type = {CIL_SEH}.seh_filter_handler or else
						seh_type = {CIL_SEH}.seh_catch)
				then
					Result := 1 -- for the object.
				else
					Result := 0
				end
			when
				{CIL_INSTRUCTION_OPCODES}.i_leave,
				{CIL_INSTRUCTION_OPCODES}.i_leave_s,
				{CIL_INSTRUCTION_OPCODES}.i_endfinally,
				{CIL_INSTRUCTION_OPCODES}.i_endfault
			then
				Result := 0 -- at this point the eval stack should be empty.
			when {CIL_INSTRUCTION_OPCODES}.i_endfilter then
				Result := -1 -- after this pop the eval stack should be empty.
			when
				{CIL_INSTRUCTION_OPCODES}.i_call,
				{CIL_INSTRUCTION_OPCODES}.i_calli,
				{CIL_INSTRUCTION_OPCODES}.i_callvirt,
				{CIL_INSTRUCTION_OPCODES}.i_newobj
			then
				if attached {CIL_OPERAND} operand as l_operand and then
					attached {CIL_METHOD_NAME} l_operand.value as l_value
				then
					l_sig := l_value.signature
					n := if attached {CIL_TYPE} l_sig.return_type as l_return_type and then
							l_return_type.is_void
						then
							0
						else
							1
						end
					n := n - (l_sig.params.count + l_sig.vararg_params.count)
					if opcode /= {CIL_INSTRUCTION_OPCODES}.i_newobj and then
						(l_sig.flags & {CIL_METHOD_SIGNATURE_ATTRIBUTES}.instance_flag /= 0)
					then
						n := n - 1
					end
				end
				Result := n + instructions.at ({CIL_INSTRUCTION_OPCODES}.index_of (opcode) + 1).stack_usage
			else
				Result := instructions.at ({CIL_INSTRUCTION_OPCODES}.index_of (opcode) + 1).stack_usage
			end
		end

	instruction_size: INTEGER
			-- Calculate length of instruction
		do
			if opcode = {CIL_INSTRUCTION_OPCODES}.i_switch then
				Result := 1 + 4 + if switches.is_empty then 0 else switches.count * 4 end
			else
				Result := instructions.at ({CIL_INSTRUCTION_OPCODES}.index_of (opcode) + 1).bytes
			end
		end

feature -- Element change

	set_live (a_live: like live)
			-- Assign `live' with `a_live'.
			-- We are checking for live because sometimes
			-- dead code sequences can confuse the stack checking routine
		do
			live := a_live
		ensure
			live_assigned: live = a_live
		end

	set_operand (an_operand: like operand)
			-- Assign `operand' with `an_operand'.
		do
			operand := an_operand
		ensure
			operand_assigned: operand = an_operand
		end

	set_seh_catch_type (a_seh_catch_type: like seh_catch_type)
			-- Assign `seh_catch_type' with `a_seh_catch_type'.
		do
			seh_catch_type := a_seh_catch_type
		ensure
			seh_catch_type_assigned: seh_catch_type = a_seh_catch_type
		end

	set_opcode (a_opcode: CIL_INSTRUCTION_OPCODES)
			-- Assign `opcode' with `a_opcode`.
		do
			opcode := a_opcode
		ensure
			opcode_set: opcode = a_opcode
		end

	set_offset (a_val: INTEGER)
			-- Assign `offset` with `a_val`
		do
			offset := a_val
		ensure
			offet_set: offset = a_val
		end

	rel_4_to_1
			-- Convert a 4-byte branch to a 1-byte branch.
		do
				-- TODO double check
			opcode := {CIL_INSTRUCTION_OPCODES}.next (opcode)
		end

	add_case_label (a_label: STRING_32)
			-- Add a label for a SWITCH instruction
			-- Labels MUST be added in order.
		do
			switches.force (a_label)
		end

	null_operand
			-- An `empty` operand.
		do
			operand := {CIL_OPERAND_FACTORY}.default_operand
		end

feature -- Output

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		local
			i: INTEGER
		do
			if opcode = {CIL_INSTRUCTION_OPCODES}.i_SEH then
				if seh_begin then
					inspect seh_type
					when {CIL_SEH}.seh_try then
						a_file.put_string (".try {")
						a_file.put_new_line
						a_file.flush
					when {CIL_SEH}.seh_catch then
						a_file.put_string ("catch ")
						if attached seh_catch_type as l_seh_catch_type then
							Result := l_seh_catch_type.il_src_dump (a_file)
						else
							a_file.put_string ("  [mscorlib]System.Object")
						end
						a_file.put_string (" {")
						a_file.put_new_line
						a_file.flush
					when {CIL_SEH}.seh_filter then
						a_file.put_string ("filter {")
						a_file.put_new_line
						a_file.flush
					when {CIL_SEH}.seh_filter_handler then
						a_file.put_string ("{")
						a_file.put_new_line
						a_file.flush
					when {CIL_SEH}.seh_fault then
						a_file.put_string ("fault {")
						a_file.put_new_line
						a_file.flush
					when {CIL_SEH}.seh_finally then
						a_file.put_string ("finally {")
						a_file.put_new_line
						a_file.flush
					else
							-- Do nothing
					end
				else
					a_file.put_string ("}")
					a_file.put_new_line
					a_file.flush
				end
			elseif opcode = {CIL_INSTRUCTION_OPCODES}.i_label then
				a_file.put_string (label)
				a_file.put_new_line
				a_file.flush
			elseif opcode = {CIL_INSTRUCTION_OPCODES}.i_comment then
				a_file.put_string ("// ")
				a_file.put_string (text)
				a_file.put_new_line
				a_file.flush
			elseif opcode = {CIL_INSTRUCTION_OPCODES}.i_switch then
				a_file.put_string ("%Tswitch (")
				if not switches.is_empty then
					across switches as it loop
						a_file.put_string (it)
						if @ it.cursor_index + 1 /= @ it.last_index then
							a_file.put_string (", ")
							i := i + 1
							if i \\ 8 = 0 then
								a_file.put_string ("%N%T%T")
							end
						end
					end
				end
				a_file.put_string ("%T")
				a_file.put_new_line
				a_file.flush
			else
				if attached operand as l_operand then
					a_file.put_string ("%T")
					a_file.put_string (instructions.at ({CIL_INSTRUCTION_OPCODES}.index_of (opcode) + 1).name) -- TODO check with index starting in 1.
					a_file.put_string ("%T")
					Result := l_operand.il_src_dump (a_file)
					a_file.put_new_line
					a_file.flush
				else
					a_file.put_string ("%T")
					a_file.put_string (instructions.at ({CIL_INSTRUCTION_OPCODES}.index_of (opcode) + 1).name)
					a_file.put_new_line
					a_file.flush
				end
			end
			Result := True
		end

	render (a_stream: FILE_STREAM; a_result: SPECIAL [NATURAL_8]; a_offset: INTEGER; labels: STRING_TABLE [CIL_INSTRUCTION]): NATURAL_32
		local
			l_sz: INTEGER
			l_data: SPECIAL [NATURAL_8]
			l_dis: NATURAL_8
			l_base: INTEGER
			n: INTEGER
			l_branch_label: STRING_32
			l_cur: INTEGER
		do
			l_sz := 0
			if opcode = {CIL_INSTRUCTION_OPCODES}.i_seh and then
				seh_type = {CIL_SEH}.seh_catch
			then
				create l_data.make_empty (4)
				if attached seh_catch_type as l_seh_catch_type then
					l_dis := l_seh_catch_type.render (a_stream, l_data, l_sz + a_offset)
				end
			end
			if opcode /= {CIL_INSTRUCTION_OPCODES}.i_label and then
				opcode /= {CIL_INSTRUCTION_OPCODES}.i_comment and then
				opcode /= {CIL_INSTRUCTION_OPCODES}.i_line
			then
				a_result.force (instructions [{CIL_INSTRUCTION_OPCODES}.index_of (opcode) + 1].op1, l_sz + a_offset)
				l_sz := l_sz + 1
				if instructions [{CIL_INSTRUCTION_OPCODES}.index_of (opcode) + 1].op2 /= 0xff then
					a_result.force (instructions [{CIL_INSTRUCTION_OPCODES}.index_of (opcode) + 1].op2, l_sz + a_offset)
					l_sz := l_sz + 1
				end
				if opcode = {CIL_INSTRUCTION_OPCODES}.i_switch then
					a_result.force (switches.count.to_natural_8, l_sz + a_offset)
						-- Double check if the previous assigment is equivalent to
						-- C++ *(DWord*)(result + sz) = switches_->size();
					l_sz := l_sz + 4
						-- sz += sizeof(DWord) where DWord is defined as 4 bytes.
					l_base := l_sz + offset + switches.count * 4
					across switches as switch loop
						n := if attached labels [switch] as l_ins then l_ins.offset else 0 end
						a_result.force ((n - l_base).to_natural_8, l_sz + a_offset)
						l_sz := l_sz + 4
					end
				elseif is_branch then
					l_branch_label := if attached operand as l_operand then l_operand.string_value else {STRING_32} "" end
					l_cur := offset + 1 + if is_rel4 then 4 else 1 end
						-- calculate source
					n := if attached labels [l_branch_label] as l_ins then l_ins.offset - l_cur else 0 - l_cur end
						-- calculate offset to target
					if is_rel4 then
						a_result.force (n.to_natural_8, l_sz + a_offset)
						l_sz := l_sz + 4
					else
						a_result.force (n.to_natural_8, l_sz + a_offset)
						l_sz := l_sz + 1
					end
				else
					if attached operand as l_operand and then
						instructions [{CIL_INSTRUCTION_OPCODES}.index_of (opcode) + 1].operand_type /= {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single) + 1
						-- TODO double check if this comparision is ok!!!
					then
						l_sz := l_sz + l_operand.render (a_stream, {CIL_INSTRUCTION_OPCODES}.index_of (opcode),
								instructions [{CIL_INSTRUCTION_OPCODES}.index_of (opcode) + 1].operand_type,
								a_result, l_sz + a_offset).to_integer_32
					end
				end
			end
			Result := l_sz.to_natural_32
		end

feature -- Static

	instructions: LIST [CIL_INSTRUCTION_NAME]
		once
			create {ARRAYED_LIST [CIL_INSTRUCTION_NAME]} Result.make (0)
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("<unknown>", 0, 255, 0, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_none), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make (".label", 0, 255, 0, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_none), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make (".comment", 0, 255, 0, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_none), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("line", 0, 255, 0, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_none), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make (".SEH", 0, 255, 0, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_none), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("add", 0x58, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("add.ovf", 0xd6, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("add.ovf.un", 0xd7, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("and", 0x5f, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("arglist", 0xfe, 0, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("beq", 0x3b, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel4), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("beq.s", 0x2e, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel1), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("bge", 0x3c, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel4), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("bge.s", 0x2f, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel1), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("bge.un", 0x41, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel4), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("bge.un.s", 0x34, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel1), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("bgt", 0x3d, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel4), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("bgt.s", 0x30, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel1), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("bgt.un", 0x42, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel4), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("bgt.un.s", 0x35, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel1), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ble", 0x3e, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel4), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ble.s", 0x31, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel1), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ble.un", 0x43, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel4), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ble.un.s", 0x36, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel1), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("blt", 0x3f, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel4), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("blt.s", 0x32, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel1), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("blt.un", 0x44, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel4), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("blt.un.s", 0x37, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel1), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("bne.un", 0x40, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel4), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("bne.un.s", 0x33, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel1), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("box", 0x8c, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("br", 0x38, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel4), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("br.s", 0x2b, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel1), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("break", 0x01, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("brfalse", 0x39, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel4), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("brfalse.s", 0x2c, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel1), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("brinst", 0x3a, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel4), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("brinst.s", 0x2d, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel1), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("brnull", 0x39, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel4), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("brnull.s", 0x2c, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel1), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("brtrue", 0x3a, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel4), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("brtrue.s", 0x2d, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel1), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("brzero", 0x39, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel4), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("brzero.s", 0x2c, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel1), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("call", 0x28, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 0)) -- - args + 1 if rv nonvoid
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("calli", 0x29, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), -1)) -- - args + 1 if rv nonvoid
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("callvirt", 0x6f, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 0)) -- - args + 1 if rv nonvoid
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("castclass", 0x74, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ceq", 0xfe, 1, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("cgt", 0xfe, 2, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("cgt.un", 0xfe, 3, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ckfinite", 0xc3, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("clt", 0xfe, 4, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("clt.un", 0xfe, 5, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("constrained.", 0xfe, 0x16, 6, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.i", 0xd3, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.i1", 0x67, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.i2", 0x68, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.i4", 0x69, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.i8", 0x6a, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.ovf.i", 0xd4, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.ovf.i.un", 0x8a, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.ovf.i1", 0xb3, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.ovf.i1.un", 0x82, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.ovf.i2", 0xb5, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.ovf.i2.un", 0x83, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.ovf.i4", 0xb7, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.ovf.i4.un", 0x84, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.ovf.i8", 0xb9, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.ovf.i8.un", 0x85, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.ovf.u", 0xd5, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.ovf.u.un", 0x8b, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.ovf.u1", 0xb4, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.ovf.u1.un", 0x86, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.ovf.u2", 0xb6, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.ovf.u2.un", 0x87, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.ovf.u4", 0xb8, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.ovf.u4.un", 0x88, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.ovf.u8", 0xba, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.ovf.u8.un", 0x89, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.r.un", 0x76, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.r4", 0x6b, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.r8", 0x6c, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.u", 0xe0, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.u1", 0xd2, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.u2", 0xd1, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.u4", 0x6d, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("conv.u8", 0x6e, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("cpblk", 0xfe, 0x17, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -3))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("cpobj", 0x70, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("div", 0x5b, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("div.un", 0x5c, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("dup", 0x25, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("endfault", 0xdc, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("endfilter", 0xfe, 0x17, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("endfinally", 0xdc, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("initblk", 0xfe, 0x18, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -3))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("initobj", 0xfe, 0x15, 6, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("isinst", 0x75, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("jmp", 0x27, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldarg", 0xfe, 0x09, 4, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index2), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldarg.0", 0x02, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldarg.1", 0x03, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldarg.2", 0x04, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldarg.3", 0x05, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldarg.s", 0xe, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index1), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldarga", 0xfe, 0x0a, 4, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index2), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldarga.s", 0x0f, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index1), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldc.i4", 0x20, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_immed4), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldc.i4.0", 0x16, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldc.i4.1", 0x17, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldc.i4.2", 0x18, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldc.i4.3", 0x19, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldc.i4.4", 0x1a, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldc.i4.5", 0x1b, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldc.i4.6", 0x1c, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldc.i4.7", 0x1d, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldc.i4.8", 0x1e, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldc.i4.m1", 0x15, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldc.i4.M1", 0x15, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldc.i4.s", 0x1f, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_immed1), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldc.i8", 0x21, 255, 9, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_immed8), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldc.r4", 0x22, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_float4), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldc.r8", 0x23, 255, 9, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_float8), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldelem", 0xa3, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldelem.i", 0x97, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldelem.i1", 0x90, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldelem.i2", 0x92, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldelem.i4", 0x94, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldelem.i8", 0x96, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldelem.r4", 0x98, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldelem.r8", 0x99, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldelem.ref", 0x9a, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldelem.u1", 0x91, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldelem.u2", 0x93, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldelem.u4", 0x95, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldelem.u8", 0x96, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldelema", 0x8f, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldfld", 0x7b, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldflda", 0x7c, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldftn", 0xfe, 0x06, 6, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldind.i", 0x4d, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldind.i1", 0x46, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldind.i2", 0x48, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldind.i4", 0x4a, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldind.i8", 0x4c, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldind.r4", 0x4e, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldind.r8", 0x4f, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldind.ref", 0x50, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldind.u1", 0x47, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldind.u2", 0x49, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldind.u4", 0x4b, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldind.u8", 0x4c, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldlen", 0x8e, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldloc", 0xfe, 0x0c, 4, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index2), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldloc.0", 0x06, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldloc.1", 0x07, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldloc.2", 0x08, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldloc.3", 0x09, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldloc.s", 0x11, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index1), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldloca", 0xfe, 0x0d, 4, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index2), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldloca.s", 0x12, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index1), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldnull", 0x14, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldobj", 0x71, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldsfld", 0x7e, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldsflda", 0x7f, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldstr", 0x72, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldtoken", 0xd0, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ldvirtftn", 0xfe, 0x07, 6, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("leave", 0xdd, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel4), 0)) -- empty eval stack,
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("leave.s", 0xde, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_rel1), 0)) -- empty eval stack
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("localloc", 0xfe, 0x0f, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("mkrefany", 0xc6, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("mul", 0x5a, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("mul.ovf", 0xd8, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("mul.ovf.un", 0xd9, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("neg", 0x65, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("newarr", 0x8d, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("newobj", 0x73, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 1)) -- - arg list
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("no.", 0xfe, 0x19, 3, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_immed1), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("nop", 0x00, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("not", 0x66, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("or", 0x60, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("pop", 0x26, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("readonly.", 0xfe, 0x1e, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("refanytype", 0xfe, 0x1d, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("refanyval", 0xc2, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("rem", 0x5d, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("rem.un", 0x5e, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("ret", 0x2a, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("rethrow", 0xfe, 0x1a, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("shl", 0x62, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("shr", 0x63, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("shr.un", 0x64, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("sizeof", 0xfe, 0x1c, 6, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("starg", 0xfe, 0x0b, 4, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index2), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("starg.s", 0x10, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index1), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stelem", 0xa4, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), -3))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stelem.i", 0x9b, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -3))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stelem.i1", 0x9c, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -3))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stelem.i2", 0x9d, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -3))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stelem.i4", 0x9e, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -3))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stelem.i8", 0x9f, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -3))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stelem.r4", 0xa0, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -3))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stelem.r8", 0xa1, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -3))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stelem.ref", 0xa2, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -3))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stfld", 0x7d, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stind.i", 0xdf, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stind.i1", 0x52, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stind.i2", 0x53, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stind.i4", 0x54, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stind.i8", 0x55, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stind.r4", 0x56, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stind.r8", 0x57, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stind.ref", 0x51, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stloc", 0xfe, 0xe, 4, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index2), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stloc.0", 0x0a, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stloc.1", 0x0b, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stloc.2", 0x0c, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stloc.3", 0x0d, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stloc.s", 0x13, 255, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index1), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stobj", 0x81, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), -2))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("stsfld", 0x80, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("sub", 0x59, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("sub.ovf", 0xda, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("sub.ovf.un", 0xdb, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("switch", 0x45, 255, 0, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_switch), -1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("tail.", 0xfe, 0x14, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("throw", 0x7a, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 1))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("unaligned.", 0xfe, 12, 3, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("unbox", 0x79, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("unbox.any", 0xa5, 255, 5, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_index4), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("volatile.", 0xfe, 13, 2, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), 0))
			Result.force (create {CIL_INSTRUCTION_NAME}.make ("xor", 0x61, 255, 1, {CIL_IOPERAND}.index_of ({CIL_IOPERAND}.o_single), -1))
		ensure
			instance_free: class
		end

end

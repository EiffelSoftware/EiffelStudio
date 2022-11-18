note
	description: "[
					Base class that contains instructions / labels
			    	will be further overridden later to make a 'method'
			    	definition
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_CODE_CONTAINER

inherit

	REFACTORING_HELPER

create
	make

feature {NONE} --Initialization

	make (a_flags: CIL_QUALIFIERS)
		do
			flags := a_flags
			create labels.make (0)
			create {ARRAYED_LIST [CIL_INSTRUCTION]} instructions.make (0)
		ensure
			flags_set: flags = a_flags
			labels_empty: labels.is_empty
			instructions_empty: instructions.is_empty
			not_has_seh: not has_seh
			parent_void: parent = Void
		end

feature -- Access

	labels: STRING_TABLE [CIL_INSTRUCTION]
			-- TODO
			-- C++ map is implemented as a red black tree.
			-- https://en.cppreference.com/w/cpp/container/map
			-- Gobo has red black tree implementation.

	instructions: LIST [CIL_INSTRUCTION]
			-- Current list of CIL instructions.

	flags: CIL_QUALIFIERS
			-- flags.

	parent: detachable CIL_DATA_CONTAINER
			-- parent container.

	has_seh: BOOLEAN
			-- has Structured Exception Handling?


feature -- Status Report

	in_assembly_ref: BOOLEAN
		do
			Result := if attached parent as l_parent then l_parent.in_assembly_ref else False end
		end

feature -- Element Change

	set_container (a_item: like parent)
			-- Set `parent` container with `a_item`.
		do
			parent := a_item
		ensure
			parent_set: parent = a_item
		end

	add_instruction (a_ins: CIL_INSTRUCTION)
			-- Add a single CIL instruction `a_ins`.
			--| to the list of instructions.
		do
			instructions.force (a_ins)
		end

	remove_last_instruction: CIL_INSTRUCTION
			-- it is possible to remove the last instruction.
		require
				-- TODO creqte a query
			not_empty_instructions: not instructions.is_empty
		do
			Result := instructions.last
			instructions.prune (Result)
		end

	last_instruction: CIL_INSTRUCTION
			-- Retrieve the last instruction
		require
			not_empty_instructions: not instructions.is_empty
		do
			Result := instructions.last
		end

feature -- Optimization

	optimize_code
		do
			load_labels
				--optimize_ldc
				--optimize_ldloc
				--optimize_ldarg
			optimize_branch
			labels.wipe_out
		end

feature {NONE} -- Implementation

	load_labels
		do
			across instructions as ins loop
				if ins.opcode = {CIL_INSTRUCTION_OPCODES}.i_label then
					if labels.has (ins.label) then
							-- TODO reimplement
						{EXCEPTIONS}.raise (generator + "load_labels Duplicate label at " + ins.label)
					else
						labels.force (ins, ins.label)
					end
				end
			end
		end

	optimize_ldc
			-- Optimize load constants instructions.
		local
			done: BOOLEAN
			n: INTEGER_64
			ops: ARRAY [CIL_INSTRUCTION_OPCODES]
		do
			ops := <<{CIL_INSTRUCTION_OPCODES}.i_ldc_i4_M1_, {CIL_INSTRUCTION_OPCODES}.i_ldc_i4_0, {CIL_INSTRUCTION_OPCODES}.i_ldc_i4_1,
					{CIL_INSTRUCTION_OPCODES}.i_ldc_i4_2, {CIL_INSTRUCTION_OPCODES}.i_ldc_i4_3, {CIL_INSTRUCTION_OPCODES}.i_ldc_i4_4,
					{CIL_INSTRUCTION_OPCODES}.i_ldc_i4_5, {CIL_INSTRUCTION_OPCODES}.i_ldc_i4_6, {CIL_INSTRUCTION_OPCODES}.i_ldc_i4_7,
					{CIL_INSTRUCTION_OPCODES}.i_ldc_i4_8>>

			across instructions as ins loop
				inspect ins.opcode
				when
					{CIL_INSTRUCTION_OPCODES}.i_ldc_i4
				then
					if attached ins.operand as l_op and then l_op.type = {CIL_OPERAND_TYPE}.t_int then
						done := True
						n := l_op.int_value
						inspect n
						when 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 then
							ins.set_opcode (ops [(n + 1).to_integer_32])
						else
							done := False
							if n < 128 and then n >= -128 then
								ins.set_opcode ({CIL_INSTRUCTION_OPCODES}.i_ldc_i4_s)
							end
						end
						if done then
							ins.set_operand ({CIL_OPERAND_FACTORY}.default_operand)
						end
					end
				else
						-- do nothing.
				end
			end
		end

	optimize_ldloc
			-- Optimize load local variable onto the stack.
		local
			l_index: INTEGER
			ldlocs: ARRAY [CIL_INSTRUCTION_OPCODES]
			stlocs: ARRAY [CIL_INSTRUCTION_OPCODES]
		do
				-- TODO double check what's the best way to representt these arrays.
				-- Potential issue: indexes
				-- Memory issue, maybe we can create them iff we need them.

			ldlocs := <<{CIL_INSTRUCTION_OPCODES}.i_ldloc_0, {CIL_INSTRUCTION_OPCODES}.i_ldloc_1,
					{CIL_INSTRUCTION_OPCODES}.i_ldloc_2, {CIL_INSTRUCTION_OPCODES}.i_ldloc_3>>

			stlocs := <<{CIL_INSTRUCTION_OPCODES}.i_stloc_0, {CIL_INSTRUCTION_OPCODES}.i_stloc_1,
					{CIL_INSTRUCTION_OPCODES}.i_stloc_2, {CIL_INSTRUCTION_OPCODES}.i_stloc_3>>

			across instructions as ins loop
				inspect ins.opcode
				when {CIL_INSTRUCTION_OPCODES}.i_ldloc, {CIL_INSTRUCTION_OPCODES}.i_ldloca, {CIL_INSTRUCTION_OPCODES}.i_stloc then
					if attached ins.operand as l_op then
						if attached {CIL_LOCAL} l_op.value as l_loc then
								-- TODO implement
							l_index := l_loc.index
							inspect ins.opcode
							when {CIL_INSTRUCTION_OPCODES}.i_ldloc then
								if l_index < 4 then
										-- TODO check the l_index, since
										-- the C++ code use a 0 based to access ldlocs.

									ins.set_opcode (ldlocs [l_index + 1])
									ins.set_operand ({CIL_OPERAND_FACTORY}.default_operand)
								elseif l_index < 128 and then l_index >= -128 then
									ins.set_opcode ({CIL_INSTRUCTION_OPCODES}.i_ldloc_s)
								end
							when {CIL_INSTRUCTION_OPCODES}.i_ldloca then
								if l_index < 128 and then l_index >= -128 then
									ins.set_opcode ({CIL_INSTRUCTION_OPCODES}.i_ldloca_s)
								end
							when {CIL_INSTRUCTION_OPCODES}.i_stloc then
								if l_index < 4 then
										-- TODO check the l_index, since
										-- the C++ code use a 0 based to access ldlocs.

									ins.set_opcode (stlocs [l_index + 1])
									ins.set_operand ({CIL_OPERAND_FACTORY}.default_operand)
								elseif l_index < 128 and then l_index >= -128 then
									ins.set_opcode ({CIL_INSTRUCTION_OPCODES}.i_stloc_s)
								end
							else
									-- do nothing.
							end
						end
					end
				else
						-- do nothing.
				end
			end
		end

	optimize_ldarg
			-- Optimize load argument on the stack.
		local
			v: CIL_VALUE
			l_index: INTEGER
			ldargs: ARRAY [CIL_INSTRUCTION_OPCODES]
		do
				-- TODO double check what's the best way to represent this array.
				-- Potential issue: indexes
				-- Memory issue, maybe we can create it iff we need it.

			ldargs := <<{CIL_INSTRUCTION_OPCODES}.i_ldarg_0, {CIL_INSTRUCTION_OPCODES}.i_ldarg_1,
					{CIL_INSTRUCTION_OPCODES}.i_ldarg_2, {CIL_INSTRUCTION_OPCODES}.i_ldarg_3>>

			across instructions as ins loop
				inspect ins.opcode
				when {CIL_INSTRUCTION_OPCODES}.i_ldarg, {CIL_INSTRUCTION_OPCODES}.i_ldarga, {CIL_INSTRUCTION_OPCODES}.i_starg then
					if attached ins.operand as l_op then
						if attached {CIL_PARAM} l_op.value as l_param then
								-- TODO implement
							l_index := l_param.index
							inspect ins.opcode
							when {CIL_INSTRUCTION_OPCODES}.i_ldarg then
								if l_index < 4 then
										-- TODO check the l_index, since
										-- the C++ code use a 0 based to access ldlocs.

									ins.set_opcode (ldargs [l_index + 1])
									ins.set_operand ({CIL_OPERAND_FACTORY}.default_operand)
								else
									if l_index < 128 and then l_index >= -128 then
										ins.set_opcode ({CIL_INSTRUCTION_OPCODES}.i_ldarg_s)
									end
									if attached ins.operand as l_operand and then
										l_operand.type = {CIL_OPERAND_TYPE}.t_value and then
										attached l_op.value as l_val and then
										attached l_val.type as l_type and then
										l_type.basic_type = {CIL_BASIC_TYPE}.method_param
									then
										ins.set_operand ({CIL_OPERAND_FACTORY}.integer_operand (l_index, {CIL_OPERAND_SIZE}.i32))
									end
								end
							when {CIL_INSTRUCTION_OPCODES}.i_ldarga then
								if l_index < 128 and then l_index >= -128 then
									ins.set_opcode ({CIL_INSTRUCTION_OPCODES}.i_ldarga_s)
								end
								if attached ins.operand as l_operand and then
									l_operand.type = {CIL_OPERAND_TYPE}.t_value and then
									attached l_op.value as l_val and then
									attached l_val.type as l_type and then
									l_type.basic_type = {CIL_BASIC_TYPE}.method_param
								then
									ins.set_operand ({CIL_OPERAND_FACTORY}.integer_operand (l_index, {CIL_OPERAND_SIZE}.i32))
								end
							when {CIL_INSTRUCTION_OPCODES}.i_starg then
								if l_index < 128 and then l_index >= -128 then
									ins.set_opcode ({CIL_INSTRUCTION_OPCODES}.i_starg_s)
								end
								if attached ins.operand as l_operand and then
									l_operand.type = {CIL_OPERAND_TYPE}.t_value and then
									attached l_op.value as l_val and then
									attached l_val.type as l_type and then
									l_type.basic_type = {CIL_BASIC_TYPE}.method_param
								then
									ins.set_operand ({CIL_OPERAND_FACTORY}.integer_operand (l_index, {CIL_OPERAND_SIZE}.i32))
								end

							else
									-- do nothing.
							end
						end
					end
				else
						-- do nothing.
				end
			end
		end

	optimize_branch
		local
			done: BOOLEAN
		do
			from
				validate_seh
			until
				done
			loop
				calculate_offsets
				done := modify_branches
			end
			validate_instructions
		end

	validate_seh
			-- Validate Structured Exception Handling.
			-- Validate SEH tags, e.g. make sure there are matching begin and end tags and that filters are organized properly.
		local
			l_tags: ARRAYED_LIST [CIL_INSTRUCTION]
			l_res: INTEGER
		do
			create l_tags.make (0)
			across instructions as ins loop
				if ins.opcode = {CIL_INSTRUCTION_OPCODES}.i_SEH then
					l_tags.force (ins)
				end
			end
			if not l_tags.is_empty then
				has_seh := True
				l_res := validate_seh_tags (l_tags, 1)
				validate_seh_filters (l_tags)
				validate_seh_epilogues
			end
		end

	calculate_offsets
		local
			l_ofs: INTEGER
		do
			l_ofs := 0
			across instructions as ins loop
				ins.offset := l_ofs
				l_ofs := l_ofs + ins.instruction_size
			end
		end

	modify_branches: BOOLEAN
		local
			l_offset: INTEGER
			l_loffset: INTEGER
			l_diff: INTEGER
		do
			Result := True
			across instructions as ins loop
				if ins.is_rel4 then
					l_offset := ins.offset
					if attached {CIL_OPERAND} ins.operand as l_operand and then attached {CIL_INSTRUCTION} labels.item (l_operand.string_value) as it then
						l_loffset := it.offset
						l_diff := l_loffset - (l_offset + 5)
						if l_diff < 128 and then l_diff >= -128 then
							Result := False
							ins.rel_4_to_1
						end
					end
				end
			end
		end

	validate_instructions
			-- Validate CIL instructions.
		do
			calculate_offsets
			across instructions as ins loop
				if ins.is_branch then
						-- TODO implement
				else
					inspect ins.opcode
					when {CIL_INSTRUCTION_OPCODES}.i_ldarg, {CIL_INSTRUCTION_OPCODES}.i_ldarga, {CIL_INSTRUCTION_OPCODES}.i_starg then
						if attached ins.operand as l_operand and then
							attached {CIL_PARAM} l_operand.value as l_value and then
							l_value.index > 65534
						then
								-- TODO reimplement.
							{EXCEPTIONS}.raise (generator + "validate_instructions: IndexOutOfRange at" + l_value.name)
						end
					when {CIL_INSTRUCTION_OPCODES}.i_ldloc, {CIL_INSTRUCTION_OPCODES}.i_ldloca, {CIL_INSTRUCTION_OPCODES}.i_stloc then
						if attached ins.operand as l_operand and then
							attached {CIL_LOCAL} l_operand.value as l_value and then
							l_value.index > 65534
						then
								-- TODO reimplement.
							{EXCEPTIONS}.raise (generator + "validate_instructions: IndexOutOfRange at" + l_value.name)
						end
					when {CIL_INSTRUCTION_OPCODES}.i_ldarg_s, {CIL_INSTRUCTION_OPCODES}.i_ldarga_s, {CIL_INSTRUCTION_OPCODES}.i_starg_s then
						if attached ins.operand as l_operand and then
							attached {CIL_PARAM} l_operand.value as l_value and then
							l_value.index > 255
						then
								-- TODO reimplement.
							{EXCEPTIONS}.raise (generator + "validate_instructions: IndexOutOfRange at" + l_value.name)

						end
					when {CIL_INSTRUCTION_OPCODES}.i_ldloc_s, {CIL_INSTRUCTION_OPCODES}.i_ldloca_s, {CIL_INSTRUCTION_OPCODES}.i_stloc_s then
						if attached ins.operand as l_operand and then
							attached {CIL_LOCAL} l_operand.value as l_value and then
							l_value.index > 255
						then
								-- TODO reimplement.
							{EXCEPTIONS}.raise (generator + "validate_instructions: IndexOutOfRange at" + l_value.name)
						end
					else
							-- Do nothing
					end
				end
			end
		end

	validate_seh_tags (tags: LIST [CIL_INSTRUCTION]; a_offset: INTEGER): INTEGER
			-- Validate one level of tags (recursive)
		local
			l_offset_in: INTEGER
			l_offset: INTEGER
			l_start: CIL_INSTRUCTION
			l_type: CIL_SEH
			l_exit: BOOLEAN
		do
				-- TODO test
			l_offset_in := a_offset
			l_offset := a_offset
			l_start := tags [l_offset]
			l_offset := l_offset + 1
			if l_start.seh_type /= {CIL_SEH}.seh_try then
				{EXCEPTIONS}.raise (generator + "validate_seh_tags: Expected SEH Try")
			end
			if not l_start.seh_begin then
				{EXCEPTIONS}.raise (generator + "validate_seh_tags: Expected SEH Try")
			end
			from
			until
				l_offset > tags.count or else not tags [l_offset].seh_begin
			loop
				l_offset := validate_seh_tags (tags, l_offset)
			end
			if l_offset > tags.count then
				{EXCEPTIONS}.raise (generator + "validate_seh_tags: OrphanedSEHTag")
			end
			if tags [l_offset].seh_type /= {CIL_SEH}.seh_try then
				{EXCEPTIONS}.raise (generator + "validate_seh_tags: MismatchedSEHTag")
			end
			if tags [l_offset].seh_begin then
				{EXCEPTIONS}.raise (generator + "validate_seh_tags: MismatchedSEHTag")
			end
			l_offset := l_offset + 1
			if not tags [l_offset].seh_begin or else (tags [l_offset].seh_type = {CIL_SEH}.seh_try) then
				{EXCEPTIONS}.raise (generator + "validate_seh_tags: ExpectedSEHHandler")
			end

			from
			until
				l_offset > tags.count or l_exit
			loop
				if not tags [l_offset].seh_begin then
					l_exit := True
					Result := l_offset
				end
				if not l_exit then
					l_type := tags [l_offset].seh_type
					l_offset := l_offset + 1
					from
					until
						l_offset > tags.count or else not tags [l_offset].seh_begin
					loop
						l_offset := validate_seh_tags (tags, l_offset)
					end
					if l_offset > tags.count then
						{EXCEPTIONS}.raise (generator + "validate_seh_tags: OrphanedSEHTag")
					end
					if tags [l_offset].seh_type /= l_type then
						{EXCEPTIONS}.raise (generator + "validate_seh_tags: MismatchedSEHTag")
					end
					l_offset := l_offset + 1
				end
			end
			Result := l_offset
		end

	validate_seh_filters (tags: LIST [CIL_INSTRUCTION])
			--  Validate that SEH filter expressions are in the proper place.
		local
			l_check: BOOLEAN
		do
				-- TODO test
			across tags as tag loop
				if not tag.seh_begin and then tag.seh_type = {CIL_SEH}.seh_filter then
					l_check := True
				end
				if l_check then
					l_check := False
					if not tag.seh_begin or else tag.seh_type /= {CIL_SEH}.seh_filter_handler then
						{EXCEPTIONS}.raise (generator + "validate_seh_tags: InvalidSEHFilrer")
					end
				end
			end
		end

	validate_seh_epilogues
			--  Validate the epilogue for each SEH section.
		local
			l_old, l_old1: CIL_INSTRUCTION
		do
				-- we aren't checking the 'pop' here as it is up to the user when to handle that
				-- but it will be caught in the normal process of level matching...
			across instructions as ins loop
				if ins.opcode = {CIL_INSTRUCTION_OPCODES}.i_seh then
					if not ins.seh_begin then
						inspect ins.seh_type
						when {CIL_SEH}.seh_try then
							if l_old = Void or else l_old.opcode /= {CIL_INSTRUCTION_OPCODES}.i_leave and then l_old.opcode /= {CIL_INSTRUCTION_OPCODES}.i_leave_s then
								{EXCEPTIONS}.raise (generator + "validate_seh_tags: InvalidSEHEpilogue")
							end
						when {CIL_SEH}.seh_catch, {CIL_SEH}.seh_filter_handler then
							if l_old = Void or else l_old.opcode /= {CIL_INSTRUCTION_OPCODES}.i_leave and then l_old.opcode /= {CIL_INSTRUCTION_OPCODES}.i_leave_s then
								{EXCEPTIONS}.raise (generator + "validate_seh_tags: InvalidSEHEpilogue")
							end
						when {CIL_SEH}.seh_filter then
							if l_old = Void or else l_old.opcode /= {CIL_INSTRUCTION_OPCODES}.i_endfilter then
								{EXCEPTIONS}.raise (generator + "validate_seh_tags: InvalidSEHEpilogue")
							end
						when {CIL_SEH}.seh_fault then
							if l_old = Void or else l_old.opcode /= {CIL_INSTRUCTION_OPCODES}.i_endfault then
								{EXCEPTIONS}.raise (generator + "validate_seh_tags: InvalidSEHEpilogue")
							end
						when {CIL_SEH}.seh_finally then
							if l_old = Void or else l_old.opcode /= {CIL_INSTRUCTION_OPCODES}.i_endfinally then
								{EXCEPTIONS}.raise (generator + "validate_seh_tags: InvalidSEHEpilogue")
							end
						end
					end
				elseif ins.opcode = {CIL_INSTRUCTION_OPCODES}.i_label and then ins.opcode = {CIL_INSTRUCTION_OPCODES}.i_comment then
					l_old1 := l_old
					l_old := ins
				end

			end
		end

feature -- Base types

	base_types (a_types: CELL [INTEGER])
		local
			l_op: CIL_OPERAND
			l_exit: BOOLEAN
		do
			if not (a_types.item & {CIL_DATA_CONTAINER}.base_index_system /= 0) then
				across instructions as ins until l_exit loop
					if attached {CIL_OPERAND} ins.operand as l_operand and then
						l_operand.type = {CIL_OPERAND_TYPE}.t_value and then
						attached {CIL_VALUE} l_operand.value as l_value
					then
						if attached {CIL_BOXED_TYPE} l_value.type then
							a_types.put (a_types.item | {CIL_DATA_CONTAINER}.base_index_system)
							l_exit := True
						end
					end
				end
			end
		end

feature -- Output

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		do
			across instructions as ins loop
				Result := ins.il_src_dump (a_file)
			end
			Result := True
		end

	pe_dump (a_stream: FILE_STREAM): BOOLEAN
		do
			to_implement ("Add Implementation")
			Result := False
		end

	render (a_stream: FILE_STREAM)
		do
			to_implement ("Add Implementation")
		end

feature -- Compile

	compile_cc (a_stream: FILE_STREAM; a_sz: CELL [NATURAL_32]): detachable ARRAY [NATURAL_8]
		local
			l_last: CIL_INSTRUCTION
			l_sz: NATURAL
			l_pos: INTEGER
		do
			l_sz := a_sz.item
			calculate_offsets
			load_labels
			l_last := if instructions.is_empty then Void else instructions.last end

			if attached l_last then
				l_sz := (l_last.offset + l_last.instruction_size).to_natural_32
				if l_sz /= 0 then
					create Result.make_filled (0, 1, l_sz.to_integer_32)
					l_pos := 0
					across instructions as ins loop
						--l_pos := l_pos + ins.render (a_stream, l_pos, labels)
						to_implement ("Work in progress")
					end
				end
			else
				l_sz := 0
			end
			labels.wipe_out
			a_sz.put (l_sz)
		end

	compile (a_stream: FILE_STREAM)
		do
			-- to be redefined
		end

	compile_seh_cc (a_tags: LIST [CIL_INSTRUCTION]; a_offset: INTEGER; a_seh_data: LIST [CIL_SEH_DATA]): INTEGER
		do
			to_implement ("Add implementation C++ [int CompileSEH(std::vector<Instruction *>tags, int offset, std::vector<SEHData> &sehData);]")
		end

	compile_seh (a_seh_data: CIL_SEH_DATA)
		do
			to_implement ("Add implementation C++ [void CompileSEH(std::vector<SEHData> &sehData);]")
		end

end

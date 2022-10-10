note
	description: "[
		Base class that contains instructions / labels
    	will be further overridden later to make a 'method'
    	definition
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_CONTAINER

create
	make

feature {NONE} --Initialization

	make (a_flags: QUALIFIERS)
		do
			flags := a_flags
			create labels.make (0)
			create {ARRAYED_LIST [INSTRUCTION]} instructions.make (0)
		end


feature -- Access

	labels: STRING_TABLE [INSTRUCTION]
		-- TODO
		-- C++ map is implemented as a red black tree.
		-- https://en.cppreference.com/w/cpp/container/map
		-- Gobo has red black tree implementation.

	instructions: LIST[INSTRUCTION]

	flags: QUALIFIERS

	parent: detachable DATA_CONTAINER

	has_seh: BOOLEAN
			-- has Structured Exception Handling?

feature -- Element Change

	set_container (a_item: DATA_CONTAINER)
			-- Set `parent` container with `a_item`.
		do
			parent := a_item
		end


feature -- Optimization

	optimize_code (a_pe: PE_LIB)
		do
			load_labels
			optimize_ldc(a_pe)
			optimize_ldloc(a_pe)
			optimize_ldarg(a_pe)
			optimize_branch(a_pe)
			labels.wipe_out
		end

feature {NONE} -- Implementation

	load_labels
		do
			across instructions as ins loop
				if ins.opcode = {CIL_OPCODES}.i_label then
					if labels.has (ins.label)then
							-- TODO reimplement
						{EXCEPTIONS}.raise (generator + "load_labels Duplicate label at " + ins.label)
					else
						labels.force (ins, ins.label)
					end
				end
			end
		end


	optimize_ldc (a_pe: PE_LIB)
			-- Optimize load constants instructions.
		local
			done: BOOLEAN
			n: INTEGER_64
			ops: ARRAY[CIL_OPCODES]
		do
			ops := <<{CIL_OPCODES}.i_ldc_i4_M1_, {CIL_OPCODES}.i_ldc_i4_0, {CIL_OPCODES}.i_ldc_i4_1,
                     {CIL_OPCODES}.i_ldc_i4_2,  {CIL_OPCODES}.i_ldc_i4_3, {CIL_OPCODES}.i_ldc_i4_4,
                     {CIL_OPCODES}.i_ldc_i4_5,  {CIL_OPCODES}.i_ldc_i4_6, {CIL_OPCODES}.i_ldc_i4_7,
                     {CIL_OPCODES}.i_ldc_i4_8 >>

			across instructions as ins loop
				inspect ins.opcode
				when
					{CIL_OPCODES}.i_ldc_i4
				then
					if attached ins.operand as l_op and then l_op.type = {OPERAND_TYPE}.t_int  then
						done := True
						n := l_op.int_value
						inspect n
						when 0,1,2,3,4,5,6,7,8, 9 then
							ins.set_opcode (ops[(n+1).to_integer_32])
						else
							done := False
							if n < 128 and then n>= -128 then
								ins.set_opcode({CIL_OPCODES}.i_ldc_i4_s)
							end
						end
						if done then
							ins.set_operand({OPERAND_FACTORY}.default_operand)
						end
					end
				else
					-- do nothing.
				end
			end
		end

	optimize_ldloc (a_pe: PE_LIB)
			-- Optimize load local variable onto the stack.
		local
			l_index: INTEGER
			ldlocs: ARRAY [CIL_OPCODES]
			stlocs: ARRAY [CIL_OPCODES]
		do
			-- TODO double check what's the best way to representt these arrays.
			-- Potential issue: indexes
			-- Memory issue, maybe we can create them iff we need them.


			ldlocs := <<{CIL_OPCODES}.i_ldloc_0, {CIL_OPCODES}.i_ldloc_1,
						{CIL_OPCODES}.i_ldloc_2, {CIL_OPCODES}.i_ldloc_3>>


			stlocs := <<{CIL_OPCODES}.i_stloc_0, {CIL_OPCODES}.i_stloc_1,
						{CIL_OPCODES}.i_stloc_2, {CIL_OPCODES}.i_stloc_3>>


			across instructions as  ins loop
				inspect ins.opcode
				when {CIL_OPCODES}.i_ldloc, {CIL_OPCODES}.i_ldloca, {CIL_OPCODES}.i_stloc then
					if attached ins.operand as l_op then
						if attached {CLS_LOCAL} l_op.value as l_loc then
							-- TODO implement
							l_index := l_loc.index
							inspect ins.opcode
							when {CIL_OPCODES}.i_ldloc then
								if l_index < 4 then
										-- TODO check the l_index, since
										-- the C++ code use a 0 based to access ldlocs.

									ins.set_opcode(ldlocs[l_index + 1])
									ins.set_operand({OPERAND_FACTORY}.default_operand)
								elseif l_index < 128 and then l_index >= -128 then
									ins.set_opcode({CIL_OPCODES}.i_ldloc_s)
								end
							when {CIL_OPCODES}.i_ldloca then
								if l_index < 128 and then l_index >= -128 then
									ins.set_opcode({CIL_OPCODES}.i_ldloca_s)
								end
							when {CIL_OPCODES}.i_stloc then
								if l_index < 4 then
										-- TODO check the l_index, since
										-- the C++ code use a 0 based to access ldlocs.	

									ins.set_opcode(stlocs[l_index + 1])
									ins.set_operand({OPERAND_FACTORY}.default_operand)
								elseif l_index < 128 and then l_index >= -128 then
									ins.set_opcode({CIL_OPCODES}.i_stloc_s)
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

	optimize_ldarg (a_pe: PE_LIB)
			-- Optimize load argument on the stack.
		local
			v: VALUE
			l_index: INTEGER
			ldargs: ARRAY [CIL_OPCODES]
		do
				-- TODO double check what's the best way to represent this array.
				-- Potential issue: indexes
				-- Memory issue, maybe we can create it iff we need it.

			ldargs := <<{CIL_OPCODES}.i_ldarg_0, {CIL_OPCODES}.i_ldarg_1,
						{CIL_OPCODES}.i_ldarg_2, {CIL_OPCODES}.i_ldarg_3>>

			across instructions as  ins loop
				inspect ins.opcode
				when {CIL_OPCODES}.i_ldarg, {CIL_OPCODES}.i_ldarga, {CIL_OPCODES}.i_starg then
					if attached ins.operand as l_op then
						if attached {PARAM} l_op.value as l_param then
							-- TODO implement
							l_index := l_param.index
							inspect ins.opcode
							when {CIL_OPCODES}.i_ldarg then
								if l_index < 4 then
										-- TODO check the l_index, since
										-- the C++ code use a 0 based to access ldlocs.

									ins.set_opcode(ldargs[l_index + 1])
									ins.set_operand({OPERAND_FACTORY}.default_operand)
								else
									if l_index < 128 and then l_index >= -128 then
										ins.set_opcode({CIL_OPCODES}.i_ldarg_s)
									end
									if attached ins.operand as l_operand and then
										l_operand.type = {OPERAND_TYPE}.t_value and then
										attached l_op.value as l_val and then
										attached l_val.type as l_type  and then
										l_type.basic_type = {BASIC_TYPE}.method_param
									then
										ins.set_operand({OPERAND_FACTORY}.integer_operand (l_index, {OPERAND_SIZE}.i32))
									end
								end
							when {CIL_OPCODES}.i_ldarga then
								if l_index < 128 and then l_index >= -128 then
									ins.set_opcode({CIL_OPCODES}.i_ldarga_s)
								end
								if attached ins.operand as l_operand and then
									l_operand.type = {OPERAND_TYPE}.t_value and then
									attached l_op.value as l_val and then
									attached l_val.type as l_type  and then
									l_type.basic_type = {BASIC_TYPE}.method_param
								then
									ins.set_operand({OPERAND_FACTORY}.integer_operand (l_index, {OPERAND_SIZE}.i32))
								end
							when {CIL_OPCODES}.i_starg then
								if l_index < 128 and then l_index >= -128 then
									ins.set_opcode({CIL_OPCODES}.i_starg_s)
								end
								if attached ins.operand as l_operand and then
									l_operand.type = {OPERAND_TYPE}.t_value and then
									attached l_op.value as l_val and then
									attached l_val.type as l_type  and then
									l_type.basic_type = {BASIC_TYPE}.method_param
								then
									ins.set_operand({OPERAND_FACTORY}.integer_operand (l_index, {OPERAND_SIZE}.i32))
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

	optimize_branch (a_pe: PE_LIB)
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
			-- validate Structured Exception Handling.
		local
			l_tags: ARRAYED_LIST [INSTRUCTION]
		do
			create l_tags.make (0)
			across instructions as ins loop
				if ins.opcode = {CIL_OPCODES}.i_SEH then
					l_tags.force (ins)
				end
			end
			if not l_tags.is_empty then
				has_seh := True
				validate_seh_tags (l_tags, 0)
				validate_seh_filters(l_tags)
				validate_seh_epilogues
			end
		end

	calculate_offsets
		local
			l_ofs: INTEGER
		do
			l_ofs := 0
			across instructions as  ins loop
				ins.offset := l_ofs
				l_ofs := l_ofs + ins.instruction_size
			end
		end

	modify_branches: BOOLEAN
		local
			l_offset: INTEGER
		do
			Result := True
			across instructions as ins loop
				if ins.is_rel4 then
					l_offset := ins.offset
					-- TODO implement.
				end
			end
		end

	validate_instructions
		do
			calculate_offsets
			across instructions as ins loop
				if ins.is_branch then
					-- TODO implement
				else
					inspect ins.opcode
					when {CIL_OPCODES}.i_ldarg, {CIL_OPCODES}.i_ldarga, {CIL_OPCODES}.i_starg  then
						if attached ins.operand as l_operand and then
						   attached {PARAM} l_operand.value as l_value and then
						   l_value.index > 	65534
						then
								-- TODO reimplement.
							{EXCEPTIONS}.raise (generator + "validate_instructions: IndexOutOfRange at" + l_value.name)
						end
					when {CIL_OPCODES}.i_ldloc, {CIL_OPCODES}.i_ldloca, {CIL_OPCODES}.i_stloc then
						if attached ins.operand as l_operand and then
						   attached {CLS_LOCAL} l_operand.value as l_value and then
						   l_value.index > 	65534
						then
								-- TODO reimplement.
							{EXCEPTIONS}.raise (generator + "validate_instructions: IndexOutOfRange at" + l_value.name)
						end
					when {CIL_OPCODES}.i_ldarg_s, {CIL_OPCODES}.i_ldarga_s, {CIL_OPCODES}.i_starg_s then
						if attached ins.operand as l_operand and then
						   attached {PARAM} l_operand.value as l_value and then
						   l_value.index > 	255
						then
								-- TODO reimplement.
							{EXCEPTIONS}.raise (generator + "validate_instructions: IndexOutOfRange at" + l_value.name)

						end
					when {CIL_OPCODES}.i_ldloc_s, {CIL_OPCODES}.i_ldloca_s, {CIL_OPCODES}.i_stloc_s  then
						if attached ins.operand as l_operand and then
						   attached {CLS_LOCAL} l_operand.value as l_value and then
						   l_value.index > 	255
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

	validate_seh_tags(tags: LIST [INSTRUCTION]; a_offset: INTEGER)
		do
			-- TODO implement
		end

	validate_seh_filters(tags: LIST [INSTRUCTION])
		do
			-- TODO implement
		end

	validate_seh_epilogues
		do
			-- TODO implement
		end


feature -- Output


	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		do
			across instructions as ins loop
				Result := ins.il_src_dump (a_file)
			end
			Result := True
		end
end

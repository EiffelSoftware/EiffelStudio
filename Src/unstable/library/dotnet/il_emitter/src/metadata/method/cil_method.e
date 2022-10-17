note
	description: "[
		Object Representing a method with code
		CIL instructions are added with the 'Add' feature of code container.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_METHOD

inherit

	CIL_CODE_CONTAINER
		rename
			make as make_code
		redefine
			il_src_dump
		end

create
	make

feature {NONE} --Initialization

	make (a_prototype: CIL_METHOD_SIGNATURE; a_flags: CIL_QUALIFIERS; a_entry: BOOLEAN)
		do
			make_code(a_flags)
			prototype := a_prototype
			max_stack := 100
			entry_point := a_entry
			invoke_mode := {CIL_INVOKE_MODE}.CIL
			pinvoke_type := {CIL_INVOKE_TYPE}.Stdcall
			create import_name.make_empty
			create {ARRAYED_LIST [CIL_LOCAL]} var_list.make (0)
			create pinvoke_name.make_empty
			if not (flags.flags & {CIL_QUALIFIERS_ENUM}.Static /= 0) then
				prototype.instance(True)
			end
		ensure
			import_name_set: import_name.is_empty
			pinvoke_name_set: pinvoke_name.is_empty
			invoke_mode_set: invoke_mode = {CIL_INVOKE_MODE}.CIL
			pinvoke_type_set: pinvoke_type = {CIL_INVOKE_TYPE}.Stdcall
			var_list_set: var_list.is_empty
			max_stack_set: max_stack = 100
			entry_point_Set: entry_point = a_entry
			-- prototype set.
		end

feature -- Access

	prototype: CIL_METHOD_SIGNATURE

	var_list: LIST [CIL_LOCAL]

	pinvoke_name: STRING_32

	invoke_mode: CIL_INVOKE_MODE

	pinvoke_type: CIL_INVOKE_TYPE

	max_stack: INTEGER

	entry_point: BOOLEAN

	rendering: detachable PE_METHOD

	import_name: STRING_32

feature -- Change Element

	set_pinvoke(a_name: STRING_32; a_type: CIL_INVOKE_TYPE; a_import_name: STRING_32)
			--  Set Pinvoke DLL name
		do
			invoke_mode := {CIL_INVOKE_MODE}.PInvoke
			pinvoke_name := a_name
			pinvoke_type := a_type
			import_name := a_import_name
		ensure
			invoke_mode_set: invoke_mode = {CIL_INVOKE_MODE}.PInvoke
			pinvoke_name_set: pinvoke_name = a_name
			pinvoke_type_set: pinvoke_type = a_type
			import_name_set: import_name = a_import_name
		end

	add_instruction (a_instruction: CIL_INSTRUCTION)
			-- Add an instruction `a_instruction` to the listo of instructions.
		do
			instructions.force (a_instruction)
		end

	add_local (a_local: CIL_LOCAL)
			-- A a local variable `a_local`.
		do
			a_local.set_index (var_list.count)
			var_list.force (a_local)
		end

feature -- Operations

	--optimize (a_pe: PE_LIB)
	  optimize
		local
			l_rescue: BOOLEAN
		do
			if not l_rescue then
				--calculate_live
				--calculate_max_stack
				--optimize_locals
				optimize_code
			else
				-- do nothing.	
			end
		rescue
			if attached exception_manager.last_exception as e then
				print (if attached e.description as l_description then l_description else "Unkown Exception" end)
				print ("%N")
			end
			l_rescue := True
			retry
		end



feature {NONE} -- Exception Manager


	exception_manager: EXCEPTION_MANAGER
		once
			create Result
		end

feature {NONE} -- Implementation

	calculate_live
		local
			labels_reached: ARRAYED_LIST [STRING_32]
			done, skipping: BOOLEAN
		do
			from
				create labels_reached.make (0)
				labels_reached.compare_objects
				done := False
			until
				done
			loop
				done := True
				across instructions as ic loop
					if ic.opcode = {CIL_INSTRUCTION_OPCODES}.i_SEH and then ic.seh_begin then
						ic.set_live(True)
						skipping := False
					elseif not skipping then
						ic.set_live (True)
						if ic.is_branch then

							if attached {CIL_OPERAND} ic.operand as l_operand and then
								labels_reached.has (l_operand.string_value)
							then
								done := False
								labels_reached.force (l_operand.string_value)
							end
							if ic.opcode = {CIL_INSTRUCTION_OPCODES}.i_br then
								skipping := True
							end
						elseif
							ic.opcode = {CIL_INSTRUCTION_OPCODES}.i_switch
						then
							if not ic.switches.is_empty then
								across  ic.switches as switch loop
									if labels_reached.has (switch) then
										done := False
										labels_reached.force (switch)
									end
								end
							end
						end
					elseif ic.opcode = {CIL_INSTRUCTION_OPCODES}.i_label then
						if labels_reached.has (ic.label) then
							ic.set_live(True)
							skipping := False
						end
					end
				end

			end
		end

	calculate_max_stack
		local
			l_labels: STRING_TABLE [INTEGER]
			n, m: INTEGER
			last_branch: BOOLEAN
			skipping: BOOLEAN

		do
			create l_labels.make (0)
			labels.compare_objects
			max_stack := 0
			across instructions as ins loop

				if ins.live then
					m := ins.stack_usage
					if m = -127 then
						n := 0
					else
						n := n + m;
					end
					if n > max_stack then
						max_stack := n
					end
					if n < 0 then
							-- TODO reimplement.
						{EXCEPTIONS}.raise (generator + "calculate_max_stack  Stack UnderFlow")
					end
					if ins.is_branch then
						last_branch := True
						if attached {CIL_OPERAND }ins.operand as l_operand then
							if attached l_labels.item (l_operand.string_value) as l_val and then
							   l_val /= n
							then
									-- TODO reimplement.
								{EXCEPTIONS}.raise (generator + " MismatchedStack at " + l_operand.string_value)
							else
								l_labels.force (n, l_operand.string_value)
							end
						end
					elseif ins.opcode = {CIL_INSTRUCTION_OPCODES}.i_switch then
						if not ins.switches.is_empty then
							across ins.switches as item loop
								if attached l_labels.item (item) as l_val and then
									l_val /= n
								then
										-- TODO reimplement.
									{EXCEPTIONS}.raise (generator + " MismatchedStack at " + item)
								else
									l_labels.force (n, item)
								end
							end
						end
					elseif ins.opcode = {CIL_INSTRUCTION_OPCODES}.i_label then
						if last_branch then
							if attached l_labels.item (ins.label) as l_val then
								n := l_val
							else
								n := 0
							end
						else
							if attached l_labels.item (ins.label) as l_val and then
								l_val /= n
							then
									-- TODO reimplement.
								{EXCEPTIONS}.raise (generator + " MismatchedStack at " + ins.label)
							else
								l_labels.force (n, ins.label)
							end
						end
					elseif ins.opcode = {CIL_INSTRUCTION_OPCODES}.i_comment then
						-- Placeholder.
					else
						last_branch := False
					end
				end
			end
			if n /= 0 then
				if n /= 1 or else attached prototype.return_type as l_return_type and then l_return_type.is_void then
					-- TODO reimplement.
					{EXCEPTIONS}.raise (generator + "calculate_max_stack Stack Not Empty at the end of function")
				end
			end

		end

	optimize_locals 
		local
			l_sorter: SORTER [CIL_LOCAL]
			comparator: PREDICATE [CIL_LOCAL, CIL_LOCAL]
			l_index: INTEGER
		do

			across instructions as ins loop
				if attached {CIL_OPERAND} ins.operand as l_op then
					if attached {CIL_LOCAL} l_op.value as l_val then
						l_val.increment_uses
					end
				end
			end
				-- sort var_list
			comparator := agent (left, right: CIL_LOCAL): BOOLEAN do Result := left.uses > right.uses end
			create {QUICK_SORTER [CIL_LOCAL]} l_sorter.make ((create {AGENT_EQUALITY_TESTER [CIL_LOCAL]}.make (comparator)))
			l_sorter.sort (var_list)

			l_index := 0
			across var_list as l_var loop
				l_var.index := l_index
				l_index := l_index + 1
			end
		end

feature -- Output

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		do
			a_file.put_string (".method")
			flags.il_src_dump_before_flags (a_file)
			if invoke_mode = {CIL_INVOKE_MODE}.PInvoke then
				a_file.put_string (" pinvokeimpl(%"")
				a_file.put_string (pinvoke_name)
				a_file.put_string ("%" ")
				a_file.put_string (if pinvoke_type = {CIL_INVOKE_TYPE}.Cdecl then "cdecl) " else "stdcall) " end)
			else
				a_file.put_string (" ")
			end

			Result := prototype.il_src_dump (a_file, invoke_mode /= {CIL_INVOKE_MODE}.PInvoke, False,  invoke_mode = {CIL_INVOKE_MODE}.PInvoke)
			flags.il_src_dump_after_flags (a_file)
			if invoke_mode /= {CIL_INVOKE_MODE}.PInvoke then
				a_file.put_string ("{")
				a_file.put_new_line
				a_file.flush
				if (prototype.flags & {CIL_METHOD_SIGNATURE_ATTRIBUTES}.vararg) /= 0 and then
					(prototype.flags & {CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed) /= 0
				then
						-- TODO check why we need to include this references Hardcoded.
						-- Allow C# to use
					a_file.put_string ("%T.param%T[")
					a_file.put_integer (prototype.params.count)
					a_file.put_string ("]")
					a_file.put_new_line
					a_file.flush

					a_file.put_string ("%T.custom instance void [mscorlib]System.ParamArrayAttribute::.ctor() = ( 01 00 00 00 )")
					a_file.put_new_line
					a_file.flush
				end
				if not var_list.is_empty then
					a_file.put_string ("%T.locals (")
					a_file.put_new_line
					a_file.flush
					across var_list as it loop
						a_file.put_string ("%T%T[")
						a_file.put_integer (it.index)
						a_file.put_string ("]%T")
						if attached {CIL_TYPE} it.type as l_type and then
						   l_type.basic_type = {CIL_BASIC_TYPE}.class_ref
						then
							if attached {CIL_DATA_CONTAINER} l_type.type_ref as l_class and then
							(l_class.flags.flags & {CIL_QUALIFIERS_ENUM}.value) /= 0
							then
								a_file.put_string ("valuetype ")
							else
								a_file.put_string ("class ")
							end
						end
						if attached {CIL_TYPE} it.type as l_type then
							Result :=l_type.il_src_dump(a_file)
						end
						a_file.put_string (" ")

						if @ it.cursor_index + 1 /= @ it.last_index then
							a_file.put_string (",")
							a_file.put_new_line
							a_file.flush
						else
							a_file.put_new_line
							a_file.flush
						end
					end
					a_file.put_string ("%T")
					a_file.put_new_line
					a_file.flush
				end
				if entry_point then
					a_file.put_string ("%T.entrypoint")
					a_file.put_new_line
					a_file.flush
				end
				a_file.put_string ("%T.maxstack ")
				a_file.put_integer (max_stack)
				a_file.put_new_line
				a_file.flush
				a_file.put_new_line
				a_file.flush
				Result := Precursor {CIL_CODE_CONTAINER}(a_file)
				a_file.put_string ("}")
				a_file.put_new_line
				a_file.flush
			else
				a_file.put_string ("{}")
				a_file.put_new_line
				a_file.flush
			end
		end


end

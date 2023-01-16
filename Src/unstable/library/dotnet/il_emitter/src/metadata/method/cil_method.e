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
			il_src_dump,
			pe_dump,
			compile
		end

create
	make

feature {NONE} --Initialization

	make (a_prototype: CIL_METHOD_SIGNATURE; a_flags: CIL_QUALIFIERS; a_entry: BOOLEAN)
		do
			make_code (a_flags)
			prototype := a_prototype
			max_stack := 100
			entry_point := a_entry
			invoke_mode := {CIL_INVOKE_MODE}.CIL
			pinvoke_type := {CIL_INVOKE_TYPE}.Stdcall
			create import_name.make_empty
			create {ARRAYED_LIST [CIL_LOCAL]} var_list.make (0)
			create pinvoke_name.make_empty
			if not (flags.flags & {CIL_QUALIFIERS_ENUM}.Static /= 0) then
				prototype.set_instance (True)
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
			-- signature.

	var_list: LIST [CIL_LOCAL]
			-- list of local variables.

	pinvoke_name: STRING_32

	invoke_mode: CIL_INVOKE_MODE

	pinvoke_type: CIL_INVOKE_TYPE

	max_stack: INTEGER

	entry_point: BOOLEAN
			-- has entry point?

	rendering: detachable PE_METHOD

	import_name: STRING_32

	item_local (a_index: INTEGER): CIL_LOCAL
			-- Item at `a_index'-th position
		require
			valid_index: a_index > 0
			valid_index: a_index < var_list.count
		do
			Result := var_list [a_index]
		end

	token: NATURAL_64
			-- redundant from `rendering.method_def` because PE_WRITER deletes all PE_METHODS

feature -- Status Report

	is_pinvoke: BOOLEAN
			-- Is Pinvoke?
		do
			Result := invoke_mode = {CIL_INVOKE_MODE}.pinvoke
		end

	instance: BOOLEAN
		do
				-- TODO check the C++ code
				--  return !!(Flags().Value & Qualifiers::Instance);
			Result := not not (flags.flags & {CIL_QUALIFIERS_ENUM}.instance /= 0)
		end

feature -- Change Element

	set_pinvoke (a_name: STRING_32; a_type: CIL_INVOKE_TYPE; a_import_name: STRING_32)
			--  Set Pinvoke DLL name
			--| default values
			--| type = Stdcall
			--| importName = ""
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

	set_entry_point (a_val: BOOLEAN)
			-- Set `has_entry_point` with `a_val`.
		do
			entry_point := a_val
		ensure
			entry_point_set: entry_point = a_val
		end

	add_local (a_local: CIL_LOCAL)
			-- Add a local variable `a_local`.
		do
			a_local.set_index (var_list.count)
			var_list.force (a_local)
		end

	set_instance (a_instance: BOOLEAN)
		do
			if a_instance then
				flags.set_flags (flags.flags | {CIL_QUALIFIERS_ENUM}.instance)
				flags.set_flags (flags.flags & ⊝ ({CIL_QUALIFIERS_ENUM}.static))
			else
				flags.set_flags (flags.flags & ⊝ {CIL_QUALIFIERS_ENUM}.instance)
				flags.set_flags (flags.flags | ({CIL_QUALIFIERS_ENUM}.static))
			end
				-- TODO double check if at some point
				-- prototype could be Void.
			prototype.set_instance (a_instance)
		end

	set_max_stack (a_stack: INTEGER)
		do
			max_stack := a_stack
		ensure
			max_stack_set: max_stack = a_stack
		end

feature -- Operations

	optimize
		local
			l_rescue: BOOLEAN
		do
			if not l_rescue then
					--calculate_live
					--calculate_max_stack
					--optimize_locals
				optimize_code -- From {CIL_CODE_CONTAINER}
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
						ic.set_live (True)
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
								across ic.switches as switch loop
									if labels_reached.has (switch) then
										done := False
										labels_reached.force (switch)
									end
								end
							end
						end
					elseif ic.opcode = {CIL_INSTRUCTION_OPCODES}.i_label then
						if labels_reached.has (ic.label) then
							ic.set_live (True)
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
						if attached {CIL_OPERAND} ins.operand as l_operand then
							if attached l_labels.item (l_operand.string_value) as l_val and then
								l_val /= n
							then
									-- TODO reimplement.
								{EXCEPTIONS}.raise (generator + " MismatchedStack at " + l_operand.string_value.to_string_8)
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
									{EXCEPTIONS}.raise (generator + " MismatchedStack at " + item.to_string_8)
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
								{EXCEPTIONS}.raise (generator + " MismatchedStack at " + ins.label.to_string_8)
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

			Result := prototype.il_src_dump (a_file, invoke_mode /= {CIL_INVOKE_MODE}.PInvoke, False, invoke_mode = {CIL_INVOKE_MODE}.PInvoke)
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
							Result := l_type.il_src_dump (a_file)
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
				Result := Precursor {CIL_CODE_CONTAINER} (a_file)
				a_file.put_string ("}")
				a_file.put_new_line
				a_file.flush
			else
				a_file.put_string ("{}")
				a_file.put_new_line
				a_file.flush
			end
		end

	pe_dump (a_stream: FILE_STREAM): BOOLEAN
		do
			if is_pinvoke and then in_assembly_ref then
				Result := prototype.pe_dump (a_stream, False)
			else
				if attached rendering then
						-- Log a warning message
						-- "already dumped" << GetContainer()->Name().c_str() << Signature()->Name().c_str();
					Result := True
				else
					Result := pe_dump_imp (a_stream)
				end
			end
		end

	compile (a_stream: FILE_STREAM)
		local
			l_sz: CELL [NATURAL_64]
		do
			if attached {PE_METHOD} rendering as l_rendering then
				create l_sz.put (l_rendering.code_size)
					-- code_ and codeSize_ are zero if no instruction, e.g. in delegate impls; seems a legal outcome
				l_rendering.code := compile_cc (a_stream, l_sz)
				l_rendering.code_size := l_sz.item
				compile_seh (l_rendering.seh_data)
			end
		end

feature {NONE} -- Implementation

	pe_dump_imp (a_stream: FILE_STREAM): BOOLEAN
		local
			l_sz: CELL [NATURAL_64]
			l_method_signature: NATURAL_64
			l_sig: ARRAY [NATURAL_8]
			l_table: PE_TABLE_ENTRY_BASE
			l_res: NATURAL_8
			l_last: CIL_INSTRUCTION
			l_pe_flags: INTEGER
			l_is_runtime: BOOLEAN
			l_rendering: like rendering
			l_impl_flags: INTEGER
			l_mf_flags: INTEGER
			l_name_index: NATURAL_64
			l_import_name_index: NATURAL_64
			l_param_index: NATURAL
			i: INTEGER
			l_last_param_index: NATURAL_64
			l_flags: INTEGER
			l_module_name: NATURAL_64
			l_module_ref: NATURAL_64
			l_method_index: PE_MEMBER_FORWARDED
			l_attribute_type: NATURAL_64
			l_attribute_data: NATURAL_64
			l_ctor_index: NATURAL_64
			l_data: ARRAY [NATURAL_8]
			l_data_sig: NATURAL_64
			l_attribute: PE_CUSTOM_ATTRIBUTE
			l_type: PE_CUSTOM_ATTRIBUTE_TYPE
			l_method_def: NATURAL_64
			l_local_count: INTEGER
			l_signature: NATURAL_64
		do
			create l_sz.put (0)
			if attached {CIL_TYPE} prototype.return_type as l_return_type then
				if l_return_type.basic_type = {CIL_BASIC_TYPE}.class_ref and then
					attached {CIL_DATA_CONTAINER} l_return_type.type_ref as l_class and then
					l_class.in_assembly_ref
				then
					Result := l_class.pe_dump (a_stream)
				end

				if attached {CIL_TYPE} l_return_type.mod_opt as l_opt and then
					l_opt.basic_type = {CIL_BASIC_TYPE}.class_ref and then
					attached {CIL_DATA_CONTAINER} l_opt.type_ref as l_class
				then
					Result := l_class.pe_dump (a_stream)
				end
			end
			if not prototype.params.is_empty then
					-- Assign an index to any params
				across prototype.params as param loop
					if attached {CIL_TYPE} param.type as l_tp and then
						l_tp.basic_type = {CIL_BASIC_TYPE}.class_ref
					then
						if l_tp.pe_index = 0 then
							l_res := l_tp.render (a_stream, create {ARRAY [NATURAL_8]}.make_filled (0, 1, 256),0)
						end
					end
				end
			end
			if not var_list.is_empty then
					-- Assign type indexes to any types that haven't already been defined
				across var_list as l_local loop
					if attached {CIL_TYPE} l_local.type as l_tp and then
						l_tp.basic_type = {CIL_BASIC_TYPE}.class_ref
					then
						if l_tp.pe_index = 0 then
							l_res := l_tp.render (a_stream, create {ARRAY [NATURAL_8]}.make_filled (0, 1, 256),0)
						end
					end
				end
				l_sig := {PE_SIGNATURE_GENERATOR_HELPER}.local_var_sig (Current, l_sz)
				if attached {PE_WRITER} a_stream.pe_writer as l_writer then
					l_method_signature := l_writer.hash_blob (l_sig, l_sz.item.to_natural_8)
					create {PE_STANDALONE_SIG_TABLE_ENTRY} l_table.make_with_data (l_method_signature)
				end
			end
			if not instructions.is_empty then
				l_last := instructions.last
			end
			l_is_runtime := (flags.flags & {CIL_QUALIFIERS_ENUM}.runtime).to_boolean
			if entry_point then
				l_pe_flags := l_pe_flags | {PE_METHOD}.entrypoint
			end
			if invoke_mode = {CIL_INVOKE_MODE}.cil and not l_is_runtime then
				l_pe_flags := l_pe_flags | {PE_METHOD}.cil
			end

			check rendering = Void end

			l_method_def := if attached {PE_WRITER} a_stream.pe_writer as l_writer then l_writer.next_table_index ({PE_TABLES}.tmethoddef.value.to_integer_32) else {NATURAL_32} 0 end
			l_local_count := if attached l_last then (l_last.offset + l_last.instruction_size) else 0 end
			if l_method_signature /= 0 then
				l_signature := l_method_signature | ({PE_TABLES}.tstandalonesig.value |<< 24)
			else
				l_signature := 0
			end

			create l_rendering.make (has_seh, l_pe_flags,
				l_method_def,
				max_stack.to_natural_16, var_list.count,
				l_local_count,
				l_signature)

			token := l_rendering.method_def | ({PE_TABLES}.tmethoddef.value |<< 24)

			if invoke_mode = {CIL_INVOKE_MODE}.cil then
				if l_is_runtime and then not instructions.is_empty or else not l_is_runtime and then instructions.is_empty then
						-- "Invalid method\t" << GetContainer()->getAssembly()->Name().c_str() << GetContainer()->Name().c_str() << Signature()->Name().c_str();
				end
				if attached {PE_WRITER} a_stream.pe_writer as l_writer then
					l_writer.add_method (l_rendering)
				end
				a_stream.add_method (Current)
			end

			if (flags.flags & {CIL_QUALIFIERS_ENUM}.CIL) /= 0 then
				l_impl_flags := l_impl_flags | {PE_METHOD_DEF_TABLE_ENTRY}.il
			elseif (flags.flags & {CIL_QUALIFIERS_ENUM}.Runtime) /= 0 then
				l_impl_flags := l_impl_flags | {PE_METHOD_DEF_TABLE_ENTRY}.runtime
			end
			if (flags.flags & {CIL_QUALIFIERS_ENUM}.Managed) /= 0 then
				l_impl_flags := l_impl_flags | {PE_METHOD_DEF_TABLE_ENTRY}.Managed
			end
			if (flags.flags & {CIL_QUALIFIERS_ENUM}.PreserveSig) /= 0 then
				l_impl_flags := l_impl_flags | {PE_METHOD_DEF_TABLE_ENTRY}.PreserveSig
			end
			if (flags.flags & {CIL_QUALIFIERS_ENUM}.Public) /= 0 then
				l_mf_flags := l_mf_flags | {PE_METHOD_DEF_TABLE_ENTRY}.Public
			elseif (flags.flags & {CIL_QUALIFIERS_ENUM}.Private) /= 0 then
				l_mf_flags := l_mf_flags | {PE_METHOD_DEF_TABLE_ENTRY}.Private
			end
			if (flags.flags & {CIL_QUALIFIERS_ENUM}.Virtual) /= 0 then
				l_mf_flags := l_mf_flags | {PE_METHOD_DEF_TABLE_ENTRY}.Virtual
			end
			if (flags.flags & {CIL_QUALIFIERS_ENUM}.NewSlot) /= 0 then
				l_mf_flags := l_mf_flags | {PE_METHOD_DEF_TABLE_ENTRY}.NewSlot
			end
			if (flags.flags & {CIL_QUALIFIERS_ENUM}.Static) /= 0 then
				l_mf_flags := l_mf_flags | {PE_METHOD_DEF_TABLE_ENTRY}.Static
			end
			if (flags.flags & {CIL_QUALIFIERS_ENUM}.SpecialName) /= 0 then
				l_mf_flags := l_mf_flags | {PE_METHOD_DEF_TABLE_ENTRY}.SpecialName
			end
			if (flags.flags & {CIL_QUALIFIERS_ENUM}.RTSpecialName) /= 0 then
				l_mf_flags := l_mf_flags | {PE_METHOD_DEF_TABLE_ENTRY}.RTSpecialName
			end
			if (flags.flags & {CIL_QUALIFIERS_ENUM}.HideBySig) /= 0 then
				l_mf_flags := l_mf_flags | {PE_METHOD_DEF_TABLE_ENTRY}.HideBySig
			end
			if invoke_mode = {CIL_INVOKE_MODE}.PInvoke then
				l_mf_flags := l_mf_flags | {PE_METHOD_DEF_TABLE_ENTRY}.PinvokeImpl
			end

			if attached {PE_WRITER} a_stream.pe_writer as l_writer then

				l_name_index := l_writer.hash_string (prototype.name)
				l_import_name_index := l_name_index

				if not import_name.is_empty then
					l_import_name_index := l_writer.hash_string (import_name)
				end
				l_param_index := l_writer.next_table_index ({PE_TABLES}.tparam.value.to_integer_32)

				l_sig := {PE_SIGNATURE_GENERATOR_HELPER}.method_def_sig (prototype, l_sz)
				l_method_signature := l_writer.hash_blob (l_sig, l_sz.item.to_natural_8)

				create {PE_METHOD_DEF_TABLE_ENTRY} l_table.make_with_data (l_rendering, l_impl_flags, l_mf_flags, l_name_index, l_method_signature, l_param_index)
				prototype.set_pe_index (l_writer.add_table_entry (l_table))

				i := 1
				l_last_param_index := 0
				across prototype.params as param loop
					l_flags := 0
					l_name_index := l_writer.hash_string (param.name)
					create {PE_PARAM_TABLE_ENTRY} l_table.make_with_data (l_flags, i.to_natural_16, l_name_index)
					i := i + 1
					l_last_param_index := l_writer.add_table_entry (l_table)
				end

				if invoke_mode = {CIL_INVOKE_MODE}.pinvoke then
					l_flags := 0
					if pinvoke_type = {CIL_INVOKE_TYPE}.cdecl then
						l_flags := l_flags | {PE_IMPL_MAP_TABLE_ENTRY}.CallConvCdecl
					else
						l_flags := l_flags | {PE_IMPL_MAP_TABLE_ENTRY}.CallConvStdcall
					end
					l_module_name := l_writer.hash_string (pinvoke_name)
					l_module_ref := a_stream.module_ref [l_module_name]
					if l_module_ref = 0 then
						create {PE_MODULE_REF_TABLE_ENTRY} l_table.make_with_data (l_module_name)
						l_module_ref := l_writer.add_table_entry (l_table)
						a_stream.module_ref.force (l_module_ref, l_module_name)
					end
					create l_method_index.make_with_tag_and_index ({PE_MEMBER_FORWARDED}.methoddef, prototype.pe_index)
					create {PE_IMPL_MAP_TABLE_ENTRY} l_table.make_with_data (l_flags, l_method_index, l_import_name_index, l_module_ref)

					l_res := l_writer.add_table_entry (l_table).to_natural_8
						-- TODO fix this, the returned value is not needed.
				end
				if prototype.flags & {CIL_METHOD_SIGNATURE_ATTRIBUTES}.vararg /= 0 and then
					prototype.flags & {CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed /= 0
				then
					l_attribute_type := l_writer.param_attribute_type
					l_attribute_data := l_writer.param_attribute_data
					if not (l_attribute_type /= 0) and then
						not (l_attribute_data /= 0)
					then
						l_ctor_index := 0
						if attached {CIL_METHOD} a_stream.find ("System.ParamArrayAttribute::.ctor") as l_result then
							Result := l_result.pe_dump (a_stream)
							l_ctor_index := l_result.prototype.pe_index_call_site
						end
						l_data := {ARRAY [NATURAL_8]} <<1, 0, 0, 0>>
						l_data_sig := l_writer.hash_blob (l_data, l_data.count.to_natural_8)
						l_writer.set_param_attribute (l_ctor_index, l_data_sig)
						l_attribute_type := l_writer.param_attribute_type
						l_attribute_data := l_writer.param_attribute_data

						create l_attribute.make_with_tag_and_index ({PE_CUSTOM_ATTRIBUTE}.ParamDef, l_last_param_index)
						create l_type.make_with_tag_and_index ({PE_CUSTOM_ATTRIBUTE_TYPE}.methodref, l_attribute_type)
						create {PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY} l_table.make_with_data (l_attribute, l_type, l_attribute_data)
						l_res := l_writer.add_table_entry (l_table).to_natural_8
					end
				end
				rendering := l_rendering
			end
			Result := True
		end

end

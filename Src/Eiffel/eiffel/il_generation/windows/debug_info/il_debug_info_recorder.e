note
	description: "[
		Objects which are recording IL code info at compilation time
		the concerned information are :
			- class token
			- feature token
			- module filename
			- entry_point token
			- once `_done' and `_result' token
			- line debug info
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_DEBUG_INFO_RECORDER

inherit
	REFACTORING_HELPER

	IL_DEBUG_INFO_HELPERS

	SHARED_IL_DEBUG_INFO
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_IL_CODE_GENERATOR
		export
			{NONE} all
		end

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		end

	SYSTEM_CONSTANTS
		export
			{NONE} all
		end

	INTERNAL_COMPILER_STRING_EXPORTER

create {SHARED_IL_DEBUG_INFO_RECORDER}
	make

feature {NONE} -- Initialization

	make
			-- Create `Current'.
		do
			create dbg_info_modules.make (50)
			create dbg_info_class_types.make (100)
			create internal_requested_class_tokens.make (10)
			reset_debugging_live_data
		end

	reset
			-- Reset value of Current
		do
			dbg_info_modules.wipe_out
			dbg_info_class_types.wipe_out
			internal_reset
		end

	internal_reset
			-- Reset temporary values
		do
			internal_requested_class_tokens.wipe_out
			ignoring_next_debug_info := False
			last_class_type_recorded := Void
			last_info_from_class_type := Void
			last_info_from_module := Void

			last_class_type_info_cleaned := Void
			last_module_info_cleaned := Void

			reset_debugging_live_data
		end

feature {IL_DEBUG_INFO_RECORDER_EXPORTER} -- reset live data

	reset_debugging_live_data
			-- Reset data used during debugging session
		do
			if internal_module_key_table = Void then
				create internal_module_key_table.make (50)
			else
				internal_module_key_table.wipe_out
			end
		end

feature {CIL_CODE_GENERATOR} -- Access

	is_debug_info_enabled: BOOLEAN
			-- Are we generating debug information ?

	is_recording: BOOLEAN
			-- Are we inside a recording session ?

	start_recording_session (debug_mode: BOOLEAN)
			-- Start recording session.
		do
			debug ("debugger_il_info_trace")
				print ("IL_DEBUG_INFO_RECORDER.init_recording_session .. %N")
			end
			is_recording := True
			if load_successful then
					-- Load only if in different mode
				if context.workbench_mode and then not last_loading_is_workbench then
					load_workbench_data
				elseif context.final_mode and then last_loading_is_workbench then
					load_final_data
				end
			else
					-- Load corresponding mode
				if context.workbench_mode then
					load_workbench_data
				else
					load_final_data
				end
			end

				--| Reset internal value to recompute the CLASS_TYPES array
			Il_debug_info.reset
				--| Enable/Disable debug info
			is_debug_info_enabled := debug_mode
				--| Reset Internal attributes used for optimisation
			internal_reset
		ensure
			is_inside_recording_session: is_recording
		end

	end_recording_session
			-- End recording session
		require
			is_inside_recording_session: is_recording
		do
			if context.workbench_mode then
				save (il_info_file_name)
				is_recording := False
			else
				save (final_il_info_file_name)
					--| Switch back current IL debug info to Workbench
					--| since it is more likely ES will use it for debugging
					--| Now we checked the current info are related to workbench
					--| but it is safer to reload workbench version here too.
				is_recording := False
					--| this feature already set is_recording to False
					--| but it is safer/cleaner to set to False before
				load_data_for_debugging
			end
		ensure
			is_outside_recording: not is_recording
		end

feature -- Queries : eStudio data

	implemented_type (a_class_c: CLASS_C; a_class_type: CLASS_TYPE): CLASS_TYPE
			-- Return CLASS_TYPE from `a_class_c' related to the derivation of `a_class_type'
		require
			a_class_c_attached: a_class_c /= Void
			a_class_type_attached: a_class_type /= Void
		do
			if attached a_class_type.type.implemented_type (a_class_c.class_id) as clta then
				Result := clta.associated_class_type (Void)
			else
				Result := a_class_type
			end
		ensure
			Result_attached: Result /= Void
		end

feature -- Queries : eStudio data from debugger data

	has_info_about_module (a_module_filename: READABLE_STRING_32): BOOLEAN
			-- Do we have information for Module identified by `a_module_filename' ?
		require
			module_filename_valid: a_module_filename /= Void
								and then not a_module_filename.is_empty
		do
			Result := info_from_module_if_exists (a_module_filename) /= Void
		end

	has_class_info_about_module_class_token (a_module_filename: READABLE_STRING_32; a_class_token: NATURAL_32): BOOLEAN
			-- Do we have information for Class identified by `a_module_filename' and `a_class_token' ?
		require
			module_filename_valid: a_module_filename /= Void
								and then not a_module_filename.is_empty
			token_not_null: a_class_token /= 0
		local
			l_info_from_module: IL_DEBUG_INFO_FROM_MODULE
		do
			l_info_from_module := info_from_module_if_exists (a_module_filename)
			if l_info_from_module /= Void then
				Result := l_info_from_module.know_class_from_token (a_class_token)
			end
		end

	has_feature_info_about_module_class_token (a_module_filename: READABLE_STRING_32; a_class_token: NATURAL_32; a_feature_token: NATURAL_32): BOOLEAN
			-- Do we have information for feature identified by `a_module_filename' , `a_class_token', and `a_feature_token' ?
		require
			module_filename_valid: a_module_filename /= Void and then not a_module_filename.is_empty
			class_token_not_null: a_class_token > 0
			feat_token_not_null: a_feature_token > 0
		local
			l_info_from_module: IL_DEBUG_INFO_FROM_MODULE
		do
			l_info_from_module := info_from_module_if_exists (a_module_filename)
			if l_info_from_module /= Void then
				Result := l_info_from_module.know_feature_from_token (a_feature_token)
			end
		end

	class_type_for_module_class_token (a_module_filename: READABLE_STRING_32; a_class_token: NATURAL_32): detachable CLASS_TYPE
			-- CLASS_TYPE identified by `a_module_filename' and `a_class_token'
		require
			module_filename_valid: a_module_filename /= Void
								and then not a_module_filename.is_empty
			token_not_null: a_class_token /= 0
		local
			l_info_from_module: IL_DEBUG_INFO_FROM_MODULE
		do
			l_info_from_module := info_from_module_if_exists (a_module_filename)
			if l_info_from_module /= Void then
				Result := l_info_from_module.class_type_for_token (a_class_token)
			end
		end

	compiled_class_for_class_token_and_module (a_class_token: NATURAL_32; a_module_filename: READABLE_STRING_32): CLASS_C
			-- Compiled CLASS_C identified by `class_token' and `a_module_filename'
		require
			class_token_valid: a_class_token > 0
			module_filename_valid: a_module_filename /= Void and then not a_module_filename.is_empty
		local
			l_type: CLASS_TYPE
		do
			l_type:= class_type_for_module_class_token (a_module_filename, a_class_token)
			if l_type /= Void then
				Result := l_type.associated_class
			end
		end

	class_name_for_class_token_and_module (a_class_token: NATURAL_32; a_module_filename: READABLE_STRING_32): STRING
			-- Class name for CLASS_C identified by `class_token' and `a_module_filename'
		require
			class_token_positive: a_class_token > 0
			module_filename_not_empty: a_module_filename /= Void and then not a_module_filename.is_empty
		local
			l_class_c: CLASS_C
		do
			l_class_c := compiled_class_for_class_token_and_module (a_class_token, a_module_filename)
			if l_class_c /= Void then
				Result := l_class_c.name_in_upper
			else
				Result := "BuildInClass [token:0x" + a_class_token.to_hex_string+"]"
			end
		ensure
			class_name_ok: Result /= Void and then not Result.is_empty
		end

	feature_i_by_module_feature_token (a_module_filename: READABLE_STRING_32; a_feature_token: NATURAL_32): FEATURE_I
			-- Feature_i identified by `a_module_filename'  and `a_feature_token'
			--| Nota: class token is useless
			--| since in a ICorDebugModule feature_token are unique
		local
			l_info_from_module: IL_DEBUG_INFO_FROM_MODULE
		do
			l_info_from_module := info_from_module_if_exists (a_module_filename)
			if l_info_from_module /= Void then
				Result := l_info_from_module.feature_i_for_token (a_feature_token)
			end
		end

	entry_point_feature_i: FEATURE_I
			-- System entry point feature
		local
			s: STRING
		do
				--| Update the root class info
			s := System.root_creation_name
			if not s.is_empty then
				Result := System.root_type.base_class.feature_table.item (s)
			end
		end

feature -- Access to module name computing

	module_file_name_for_class (a_class_c: CLASS_C): PATH
			-- Computed module file name for `a_class_c'
		require
			class_c_not_void: a_class_c /= Void
			a_class_c_is_not_external: not a_class_c.is_external
		local
			l_assembly_name: like {ASSEMBLY_INFO}.assembly_name
			l_type_id: INTEGER
			l_is_single_module: BOOLEAN
		do
				--| Please make sure this computing is similar to
				--| the one inside IL_CODE_GENERATOR.il_module
			if a_class_c.is_precompiled then
					--| it is is precompiled, this mean we are using it, not compiling
					--| so no recording process
				l_assembly_name := a_class_c.assembly_info.assembly_name

-- FIXME: when we debug .. we load the W_code\assemblies\...dll
--				if system.msil_use_optimized_precompile then
--					Result := finalized_precompilation_module_filename (l_assembly_name)					
--				else
					Result := workbench_precompilation_module_filename (l_assembly_name)
--				end					
			else
					--| Compute module file name
					--| WARNING : Please make sure this computing is similar to
					--| the one inside IL_CODE_GENERATOR.il_module
				if is_recording then
						-- The context is pertinent only in recording context
					if context.workbench_mode then
						l_is_single_module := False
						Result := workbench_module_directory_path_name
					else
						l_is_single_module := True
						Result := finalized_module_directory_path_name
					end
				else
						--| We assume, we are debugging only Workbench application for now.
					l_is_single_module := False
					Result := workbench_module_directory_path_name
				end
				if l_is_single_module then
					l_type_id := 1
				else
					l_type_id := a_class_c.class_id // System.msil_classes_per_module + 1
				end
					--| There complete creation of module file name
				Result := Result.extended ("module_" + l_type_id.out + ".dll")
			end
		end

	module_file_name_for_class_type (a_class_type: CLASS_TYPE): like module_file_name_for_class
			-- Computed module file name for `a_class_type'
			--| we use CLASS_TYPE for the precompiled case .
		require
			class_type_not_void: a_class_type /= Void
			a_class_type_is_not_external: not a_class_type.is_external
		local
			l_assembly_name: like {ASSEMBLY_INFO}.assembly_name
			l_type_id: INTEGER
			l_is_single_module: BOOLEAN
		do
				--| Please make sure this computing is similar to
				--| the one inside IL_CODE_GENERATOR.il_module
			if a_class_type.is_precompiled then
					--| it is is precompiled, this mean we are using it, not compiling
					--| so no recording process
				l_assembly_name := a_class_type.assembly_info.assembly_name

-- FIXME: when we debug .. we load the W_code\assemblies\...dll
--				if system.msil_use_optimized_precompile then
--					Result := finalized_precompilation_module_filename (l_assembly_name)					
--				else
					Result := workbench_precompilation_module_filename (l_assembly_name)
--				end					
			else
					--| Compute module file name
					--| WARNING : Please make sure this computing is similar to
					--| the one inside IL_CODE_GENERATOR.il_module
				if is_recording then
						-- The context is pertinent only in recording context
					if context.workbench_mode then
						l_is_single_module := False
						Result := workbench_module_directory_path_name
					else
						l_is_single_module := True
						Result := finalized_module_directory_path_name
					end
				else
						--| We assume, we are debugging only Workbench application for now.
					l_is_single_module := False
					Result := workbench_module_directory_path_name
				end
				if l_is_single_module then
					l_type_id := 1
				else
					l_type_id := a_class_type.associated_class.class_id // System.msil_classes_per_module + 1
				end
					--| There complete creation of module file name
				if system.is_il_netcore then
					Result := Result.extended ("assembly_")
					if l_type_id < 10 then
						Result := Result.appended ("0")
					end
					Result := Result.appended (l_type_id.out)
				else
					Result := Result.extended ("module_" + l_type_id.out)
				end
				Result := Result.appended_with_extension ("dll")
			end
		end

feature -- Queries : dotnet data from estudio data

	class_token (a_module_filename: STRING_32; a_class_type: CLASS_TYPE): NATURAL_32
			-- Class token for CLASS_TYPE.
		local
			l_info_from_module: IL_DEBUG_INFO_FROM_MODULE
			l_id: INTEGER
		do
				--| FIXME jfiat [2004/06/07] : in case of recompilation from Finalized
				--| we use to optimize using:
				--|	Result := a_class_type.last_implementation_type_token
				--| but this value may be wrong if recompiled.
			l_id := a_class_type.static_type_id
			Result := internal_requested_class_tokens.item (l_id)
			if Result = 0 then --| Not yet known, no requested yet
				if a_module_filename = Void then
					l_info_from_module := info_from_module_if_exists (module_file_name_for_class_type (a_class_type).name)
				else
					l_info_from_module := info_from_module_if_exists (a_module_filename)
				end
				if l_info_from_module /= Void then --| no module known for it .. (external)

					Result := l_info_from_module.class_token_for_class_type (a_class_type)

						--| Save the result
					internal_requested_class_tokens.put (Result, l_id)
				end
			end
		ensure
			class_token_positive: Result > 0
		end

	feature_token_for_feat_and_class_type (a_feat: FEATURE_I; a_class_type: CLASS_TYPE): NATURAL_32
			-- Feature token identified for `a_feat'
		require
			feat_not_void: a_feat /= Void
			class_not_void: a_class_type /= Void
		local
			l_info_from_class_type: IL_DEBUG_INFO_FROM_CLASS_TYPE
		do
			l_info_from_class_type := info_from_class_type (a_class_type, False)
			if l_info_from_class_type /= Void then
				Result := l_info_from_class_type.feature_token (a_feat)
			end
		end

	feature_token_for_non_generic (a_feat: FEATURE_I): NATURAL_32
			-- Feature token identified for `a_feat'
		require
			feat_not_void: a_feat /= Void
			not_generic: not a_feat.written_class.is_generic
		local
			l_class_type: CLASS_TYPE
		do
			l_class_type := a_feat.written_class.types.first
			Result := feature_token_for_feat_and_class_type (a_feat, l_class_type)
		end

	once_feature_tokens_for_feat_and_class (a_feat: FEATURE_I; a_class_c: CLASS_C): TUPLE [NATURAL_32, NATURAL_32, NATURAL_32, NATURAL_32]
			-- `_done' and `_result' Tokens for the once `a_feat'
		require
			feat_not_void: a_feat /= Void
			feat_is_once: a_feat.is_once
			class_c_not_void: a_class_c /= Void
		local
			l_info_from_class_type: IL_DEBUG_INFO_FROM_CLASS_TYPE
		do
			l_info_from_class_type := first_info_from_class_c (a_class_c)
			if l_info_from_class_type /= Void then
				Result := l_info_from_class_type.once_tokens (a_feat)
			end
		end

feature {IL_DEBUG_INFO_RECORDER_EXPORTER} -- Queries : IL Offset data

	is_il_offset_related_to_eiffel_line (a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_il_offset: INTEGER): BOOLEAN
			-- is a_il_offset related to an Eiffel line index ?
		require
			class_type_not_void: a_class_type /= Void
			feat_not_void: a_feat /= Void
		do
			if attached feature_breakable_il_offsets (a_class_type, a_feat) as l_il_offset_list then
				Result := across l_il_offset_list as o some o.item.il_offset.has (a_il_offset) end
			end
		end

	feature_eiffel_breakable_line_for_il_offset (a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_il_offset: INTEGER): INTEGER
			-- Corresponding Eiffel Line for `a_il_offset' offset
		require
			class_type_not_void: a_class_type /= Void
			feat_not_void: a_feat /= Void
		local
			l_offsets_info: IL_OFFSET_SET
			l_offset_before: INTEGER
			o: INTEGER
			i, upper: INTEGER
		do
			if attached feature_breakable_il_offsets (a_class_type, a_feat) as l_il_offset_list then
				l_offset_before := -1
				across
					l_il_offset_list as l
				loop
					l_offsets_info := l.item.il_offset
					if not l_offsets_info.is_empty then
						from
							i := l_offsets_info.lower
							upper := i + l_offsets_info.count
						until
							i >= upper
						loop
							o := l_offsets_info.item (i)
							if o <= a_il_offset and o > l_offset_before then
								l_offset_before := o
								Result := l.target_index - 1 --| LIST.first.index = 1
							end
							i := i + 1
						end
					end
				end
			end
		end

	approximate_feature_breakable_il_offset_for (a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_il_offset: INTEGER): INTEGER
			-- Approximate IL offset for the il offset `a_current_il_offset'
			-- previous or current offset if on a breakable point
		require
			class_type_not_void: a_class_type /= Void
			feat_not_void: a_feat /= Void
		local
			l_list: SORTED_LIST [INTEGER]
		do
			l_list := feature_breakable_il_offsets_sorted_list (a_class_type, a_feat)
			if l_list /= Void then
				from
					l_list.start
				until
					l_list.after
					or else l_list.item > a_il_offset
				loop
					Result := l_list.item --| LIST.index => 1
					l_list.forth
				end
			end
		end

feature {IL_DEBUG_INFO_RECORDER_EXPORTER} -- Queries : IL Offset data for lines

	feature_breakable_il_line_for (a_class_type: CLASS_TYPE; a_feat: FEATURE_I;
				a_breakable_line_number: INTEGER): IL_OFFSET_SET
			-- IL offset for the bp slot index `a_breakable_line_number'
			-- Return Void if index out of range
		require
			class_type_not_void: a_class_type /= Void
			feat_not_void: a_feat /= Void
		local
			l_index: INTEGER
			l_list: like feature_breakable_il_offsets
		do
			l_index := a_breakable_line_number + 1
			l_list := feature_breakable_il_offsets (a_class_type, a_feat)

			if
				l_list /= Void
				and then l_list.valid_index (l_index)
			then
				Result := l_list.i_th (l_index).il_offset
			else
				Result:= Void
			end
		end

	next_feature_breakable_il_range_for (a_class_type: CLASS_TYPE; a_feat: FEATURE_I;
				a_current_il_offset: INTEGER): ARRAY [TUPLE [left: INTEGER; right: INTEGER]]
			-- IL range offset for the Eiffel line `a_line' in the step next
		require
			class_type_not_void: a_class_type /= Void
			feat_not_void: a_feat /= Void
		local
			l_list: SORTED_LIST [INTEGER]
			l_inf, l_sup: INTEGER
			l_interval: TUPLE [left: INTEGER; right: INTEGER]
			i: INTEGER
		do
			l_list := feature_breakable_il_offsets_sorted_list (a_class_type, a_feat)
			if l_list /= Void then
				from
					l_list.start
					l_inf := l_list.item
					l_list.forth
				until
					l_list.after or (l_interval /= Void)
				loop
					l_sup := l_list.item
					if l_inf <= a_current_il_offset and a_current_il_offset < l_sup then
						l_interval := [l_inf, l_sup]
					end
					l_inf := l_sup
					l_list.forth
				end
				if l_interval /= Void then
					Result := <<l_interval>>
				end
			end

			debug ("debugger_il_info_trace")
				if Result /= Void then
					from
						i := Result.lower
					until
						i > Result.upper
					loop
						print (" - " + i.out + " : [" + (Result.item (i)).left.out + " , " + (Result.item (i)).right.out + "] %N")
						i := i + 1
					end
				end
			end
		end

feature {NONE} -- line debug exploitation

	feature_breakable_il_offsets_sorted_list (a_class_type: CLASS_TYPE; a_feat: FEATURE_I): SORTED_LIST [INTEGER]
			-- List of all sorted breakable IL Offset for `a_feat'
		require
			class_type_not_void: a_class_type /= Void
			feat_not_void: a_feat /= Void
		local
			l_offsets_info: IL_OFFSET_SET
			i, upper: INTEGER
		do
			if attached feature_breakable_il_offsets (a_class_type, a_feat) as l_il_offset_list then
				create {SORTED_TWO_WAY_LIST [INTEGER]} Result.make
					--| +2 : in case we have loop with variant + invariant
				across
					l_il_offset_list as o
				loop
					l_offsets_info := o.item.il_offset
					if not l_offsets_info.is_empty then
						from
							i := l_offsets_info.lower
							upper := i + l_offsets_info.count
						until
							i >= upper
						loop
							Result.force (l_offsets_info.item (i))
							i := i + 1
						end
					end
				end
			end
		end

	feature_breakable_il_offsets (a_class_type: CLASS_TYPE; a_feat: FEATURE_I): ARRAYED_LIST [TUPLE [e_line: INTEGER; il_offset: IL_OFFSET_SET]]
			-- List of breakable IL Offset for `a_feat'
		require
			class_type_not_void: a_class_type /= Void
			feat_not_void: a_feat /= Void
		local
			l_info_from_class_type: IL_DEBUG_INFO_FROM_CLASS_TYPE
		do
			l_info_from_class_type := info_from_class_type (a_class_type, False)
			if l_info_from_class_type /= Void then
				Result := l_info_from_class_type.breakable_il_offsets (a_feat)
			end
		end

feature {NONE} -- Implementation for class token finder

	internal_requested_class_tokens: HASH_TABLE [NATURAL_32, INTEGER]
			-- [Class token] <= [Class type]

feature {CIL_CODE_GENERATOR} -- Recording context

	is_single_class : BOOLEAN
			-- Can current class only be single inherited?

	is_attribute : BOOLEAN
			-- is current generated feature is attribute ?

	is_static : BOOLEAN
			-- is current generated feature is static ?

	in_interface : BOOLEAN
			-- is current generated feature is in_interface ?

	set_record_context (a_is_single_class, a_is_attr, a_is_static, a_in_interface: BOOLEAN)
			-- Save generation context in order to determine what to record.
		do
			is_single_class := a_is_single_class
			is_attribute := a_is_attr
			is_static := a_is_static
			in_interface := a_in_interface
		end

feature {CIL_CODE_GENERATOR} -- line debug recording

	ignore_next_debug_info
			-- Ignore recording of debug info (nop) for next recording
		do
			ignoring_next_debug_info := True
		end

	ignoring_next_debug_info: BOOLEAN
			-- Do we ignore recording of debug info (nop) for next recording ?

	record_ghost_debug_infos (a_class_type: CLASS_TYPE; a_feat: FEATURE_I;
								a_il_line: INTEGER; a_eiffel_line: INTEGER;
								a_nb: INTEGER)
			-- Record potential IL offset stoppable without any IL generation
			-- this is used for non generated debug clauses
			-- for enabling estudio to show correct eiffel line.
		local
			i: INTEGER
			l_info_from_class_type: IL_DEBUG_INFO_FROM_CLASS_TYPE
		do
			if is_debug_info_enabled then
				l_info_from_class_type := info_from_class_type (a_class_type, True)
				from
					i := 1
				until
					i > a_nb
				loop
						--| 0 instead of `a_il_line'
					l_info_from_class_type.record_add_line_info (a_feat, 0, a_eiffel_line + i)
					i := i + 1
				end
			end
		end

	record_line_info (a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_il_line: INTEGER; a_eiffel_line: INTEGER;)
			-- Record IL information regarding breakable line
		require
			class_type_not_void: a_class_type /= Void
			feat_not_void: a_feat /= Void
		local
			l_info_from_class_type: IL_DEBUG_INFO_FROM_CLASS_TYPE
		do
			if is_debug_info_enabled then
				if ignoring_next_debug_info then
					ignoring_next_debug_info := False
				else
					debug ("debugger_il_info_trace")
						print (" - " + a_feat.written_class.name_in_upper
								+ "."
								+ a_feat.feature_name
								+ " -> "
								+ " Il Offset=" + a_il_line.to_hex_string
								+ " Eiffel Line=" + a_eiffel_line.out
								+ "%N"
							)
					end

					l_info_from_class_type := info_from_class_type (a_class_type, True)
					l_info_from_class_type.record_add_line_info (a_feat, a_il_line, a_eiffel_line)
				end
			end
		end

feature {CIL_CODE_GENERATOR} -- Token recording

	record_once_info_for_class (a_data_class_token,
					a_once_done_token, a_once_result_token, a_once_exception_token: INTEGER;
					a_feature: FEATURE_I; a_class_c: CLASS_C)
			--  Record `_done' `_result' and `_exception' tokens for once `a_once_name' from `a_class_type'.
		local
			l_data_class_token,
			l_once_done_token, l_once_result_token, l_once_exception_token: NATURAL_32
		do
			debug ("refactor_fixme")
				fixme ("[
							JFIAT: 2005-09-20 : maybe we should record only once for CLASS_C
							and not for each CLASS_TYPE.
							This would implies a new storage indexed by CLASS_C.
							However, this is optimisation for generic classes
						]")
			end

			l_data_class_token := a_data_class_token.as_natural_32
			l_once_done_token := a_once_done_token.as_natural_32
			l_once_result_token := a_once_result_token.as_natural_32
			l_once_exception_token := a_once_exception_token.as_natural_32

			if is_debug_info_enabled then
				across
					a_class_c.types as c
				loop
					record_once_info_for_class_type	(l_data_class_token,
							l_once_done_token, l_once_result_token, l_once_exception_token,
							a_feature, c.item)
				end
			end
		end

	record_once_info_for_class_type (a_data_class_token: NATURAL_32;
					a_once_done_token, a_once_result_token, a_once_exception_token: NATURAL_32;
					a_feature_i: FEATURE_I; a_class_type: CLASS_TYPE)
		require
			a_feature_i /= Void
		local
			l_info_from_class_type: IL_DEBUG_INFO_FROM_CLASS_TYPE
		do
			if
				is_debug_info_enabled
			then
				debug ("debugger_il_info_trace")
					print ("[>] Recording Once : "
							+ a_class_type.associated_class.name_in_upper
							+ "." + a_feature_i.feature_name
							+ " -> "
							+ "Data=0x" + a_data_class_token.to_hex_string
							+ "::"
							+ "Done=0x" + a_once_done_token.to_hex_string
							+ "::"
							+ "Result=0x" + a_once_result_token.to_hex_string
							+ "::"
							+ "Exception=0x" + a_once_exception_token.to_hex_string
							+ "%N")
				end
				l_info_from_class_type := info_from_class_type (a_class_type, True)
				l_info_from_class_type.record_once_tokens (a_data_class_token,
						a_once_done_token, a_once_result_token, a_once_exception_token,
						a_feature_i)
			end
		end

	record_il_feature_info (a_module: IL_MODULE; a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_class_token, a_feature_token: INTEGER)
			-- Record feature information : class, feature token, and module name throught the other data.
		local
			l_class_token, l_feature_token: NATURAL_32
		do
			if is_debug_info_enabled then
				l_class_token := a_class_token.as_natural_32
				l_feature_token := a_feature_token.as_natural_32
				if is_attribute then
						if not in_interface and is_static then
							process_il_feature_info_recording (a_module, a_class_type, a_feat, l_class_token, l_feature_token)
						elseif a_class_type.associated_class.is_single then
							process_il_feature_info_recording (a_module, a_class_type, a_feat, l_class_token, l_feature_token)
						end
				else -- not is_attribute
					if not in_interface and is_static then
						process_il_feature_info_recording (a_module, a_class_type, a_feat, l_class_token, l_feature_token)
					else
						do_nothing
					end
				end
			end
		end

feature {NONE} -- Record processing

	last_class_type_recorded: CLASS_TYPE
			-- Last recorded class type

	ignore_feature (a_feat: FEATURE_I): BOOLEAN
			-- Ignore non Eiffel feature name
			-- for now, ignore all '^_.*' feature_name
		require
			a_feat_not_void: a_feat /= Void
		do
			Result := a_feat.feature_name.item (1) = '_'
--| NOTA JFIAT: 2004/05/28 : fix invariant cursor in call stack
--| When we'll decide to fix the cursor in call stack on invariant
--| this may be a start ..
				--| and then not a_feat.feature_name.is_equal ("_invariant")
		end

	process_il_feature_info_recording (a_module: IL_MODULE; a_class_type: CLASS_TYPE;
				a_feature: FEATURE_I; a_class_token, a_feature_token: NATURAL_32)
			-- Record feature information regarding token
		require
			module_not_void: a_module /= Void
			class_type_not_void: a_class_type /= Void
			a_feat_not_void: a_feature /= Void
			token_positive: a_class_token > 0 and then a_feature_token > 0
		local
			l_info_from_module: IL_DEBUG_INFO_FROM_MODULE
			l_info_from_class_type: IL_DEBUG_INFO_FROM_CLASS_TYPE
		do
			if ignore_feature (a_feature) then
				debug ("debugger_il_info_trace")
					print ("[!] Ignoring feature : " + a_feature.feature_name + "%N")
				end
			else
					--| Class related
				if a_class_type /= last_class_type_recorded then
					internal_record_class_token (a_module, a_class_type, a_class_token)
					last_class_type_recorded := a_class_type
				end

				debug ("debugger_il_info_trace")
					print ("[>] Recording : "
							+ a_class_type.associated_class.name_in_upper
							+ "." + a_feature.feature_name
							+ " -> "
							+ "0x" + a_class_token.to_hex_string
							+ "::"
							+ "0x" + a_feature_token.to_hex_string
							+ "%N")
				end
					--| Record `feature_i' indexed by `feature_token'
				l_info_from_module := info_from_module_or_create (a_module.module_file_name, a_module.module_name_with_extension)
				l_info_from_module.record_feature_i (a_class_type, a_feature, a_feature_token)

					--| Record `feature_token' indexed by `feature_i'
				l_info_from_class_type := info_from_class_type (a_class_type, True)
				l_info_from_class_type.record_feature_token (a_feature_token, a_feature)
			end
		end

feature {NONE} -- Class Specific info

	internal_record_class_token (a_module: IL_MODULE; a_class_type: CLASS_TYPE; a_class_token: NATURAL_32)
			-- Record class information regarding token
		require
			module_not_void: a_module /= Void
			class_type_not_void: a_class_type /= Void
			class_token_positive: a_class_token > 0
		do
			internal_record_class_type (a_module.module_file_name, a_module.module_name_with_extension, a_class_type, a_class_token)
		end

	internal_record_class_type (a_module_filename: STRING_32; a_module_name: STRING;
			a_class_type: CLASS_TYPE; a_class_token: NATURAL_32)
				--| New mecanism
		require
			module_filename_not_empty: a_module_filename /= Void and then not a_module_filename.is_empty
			class_type_not_void: a_class_type /= Void
			class_token_positive: a_class_token > 0
		local
			l_info: IL_DEBUG_INFO_FROM_MODULE
		do
			debug ("debugger_il_info_trace")
				print ("[>] Recording Class: "
						+ a_class_type.associated_class.name_in_upper
						+ "::" + a_class_type.static_type_id.out
						+ " -> "
						+ "0x" + a_class_token.to_hex_string
						+ "%N")
			end
			l_info := info_from_module_or_create (a_module_filename, a_module_name)
			l_info.record_class_type (a_class_type, a_class_token)
		ensure
			dbg_info_modules.has (direct_module_key (a_module_filename))
		end

feature {CIL_CODE_GENERATOR} -- Cleaning

	last_module_info_cleaned: like module_file_name_for_class
			-- Last cleaned Module

	last_class_type_info_cleaned: CLASS_TYPE
			-- Last cleaned Class Type

	clean_class_type_info_for (a_class_type: CLASS_TYPE)
			-- Clean info related to this `a_class_type'.
		require
			class_type_not_void: a_class_type /= Void
		local
			l_class_type: CLASS_TYPE
			l_module_filename: like module_file_name_for_class_type
			l_info_from_class_type: IL_DEBUG_INFO_FROM_CLASS_TYPE
			l_info_from_module: IL_DEBUG_INFO_FROM_MODULE
		do
			l_class_type := a_class_type

				--| Clean Class Type Info |--
			if last_class_type_info_cleaned /= l_class_type then
				last_class_type_info_cleaned := l_class_type
				debug ("debugger_il_info_trace")
					print ("Cleaning : "+ l_class_type.associated_class.name_in_upper
										+ " ID=" + l_class_type.static_type_id.out
										+ "%N")
				end

				l_info_from_class_type := info_from_class_type (l_class_type, False)
				if l_info_from_class_type /= Void then
					l_info_from_class_type.reset (a_class_type)
				else
					debug ("debugger_il_info_trace")
						print ("  -> nothing to clean (new)%N")
					end
				end
			end

				--| Clean Module Info     |--
			l_module_filename := module_file_name_for_class_type (l_class_type)
			if
				attached last_module_info_cleaned as m implies
				not m.is_equal (l_module_filename)
			 then
				last_module_info_cleaned := l_module_filename
				debug ("debugger_il_info_trace")
					io.put_string_32 ({STRING_32} "Cleaning : " + l_module_filename.name + "%N")
				end

				l_info_from_module := info_from_module_if_exists (l_module_filename.name)
				if l_info_from_module /= Void then
					l_info_from_module.reset (l_info_from_module.module_filename)
				else
					debug ("debugger_il_info_trace")
						print ("  -> nothing to clean (new)%N")
					end
				end
			end
		end

feature {NONE} -- Debugger Info List Access

	last_info_from_class_type: like info_from_class_type
			-- Last IL_DEBUG_INFO_FROM_CLASS_TYPE used

	last_info_from_module: like info_from_module
 			-- Last IL_DEBUG_INFO_FROM_MODULE used

	first_info_from_class_c (a_class_c: CLASS_C): IL_DEBUG_INFO_FROM_CLASS_TYPE
			-- Info from any Class_type	 from `a_class_c'.
		require
			class_c_not_void: a_class_c /= Void
		local
			l_types: TYPE_LIST
		do
			from
				l_types := a_class_c.types
				l_types.start
			until
				l_types.after or Result /= Void
			loop
				Result := info_from_class_type (l_types.item, False)
				l_types.forth
			end
		end

	info_from_class_type (a_class_type: CLASS_TYPE; a_create_if_not_found: BOOLEAN): IL_DEBUG_INFO_FROM_CLASS_TYPE
			-- Info from Class_type
		require
			class_type_not_void: a_class_type /= Void
		local
			l_class_static_type_id: INTEGER
		do
			l_class_static_type_id := a_class_type.static_type_id
			if
				last_info_from_class_type /= Void and then
				last_info_from_class_type.static_type_id = l_class_static_type_id
			then
				Result := last_info_from_class_type
			else
				Result := dbg_info_class_types.item (l_class_static_type_id)
				if a_create_if_not_found and Result = Void then
					create Result.make (l_class_static_type_id)
					dbg_info_class_types.put (Result, l_class_static_type_id)
				end
				last_info_from_class_type := Result
			end
		ensure
			(Result = Void) implies (not a_create_if_not_found)
		end

	info_from_module_or_create (a_module_filename: STRING_32; a_module_name: STRING): IL_DEBUG_INFO_FROM_MODULE
			-- Info from Module_filename
		require
			module_filename_not_empty: a_module_filename /= Void and then not a_module_filename.is_empty
		do
			Result := info_from_module (a_module_filename, True)
			Result.set_module_name (a_module_name.twin)
		ensure
			result_not_void: Result /= Void
		end

	info_from_module_if_exists (a_module_filename: READABLE_STRING_32): IL_DEBUG_INFO_FROM_MODULE
			-- Info from Module_filename
		require
			module_filename_not_empty: a_module_filename /= Void and then not a_module_filename.is_empty
		do
			Result := info_from_module (a_module_filename, False)
		end

	info_from_module (a_module_filename: READABLE_STRING_32; a_create_if_not_found: BOOLEAN): IL_DEBUG_INFO_FROM_MODULE
			-- Info from Module_filename
			--| Should not be called directly anymore,
			--| use `info_from_module_or_create' or `info_from_module_if_exists'
		require
			module_filename_not_empty: a_module_filename /= Void and then not a_module_filename.is_empty
		local
			l_module_key: READABLE_STRING_32
		do
			if a_create_if_not_found then
					--| This means we are recording, so we need to record
					--| the true computed module name
				l_module_key := direct_module_key (a_module_filename)
			else
					--| This means we are query data, not recording
					--| so we need to resolve the module name
					--| in case it comes from the GAC from instance (for precomp)
				l_module_key := resolved_module_key (a_module_filename)
			end
			if
				last_info_from_module /= Void and then
				last_info_from_module.module_filename.same_string (l_module_key)
			then
				Result := last_info_from_module
			else
				Result := dbg_info_modules.item (l_module_key)
				if a_create_if_not_found and Result = Void then
					create Result.make (l_module_key, system.name)
					dbg_info_modules.put (Result, l_module_key)
				end
				last_info_from_module := Result
			end
		ensure
			(Result = Void) implies (not a_create_if_not_found)
		end

feature {NONE} -- Debugger Info List

	dbg_info_modules: STRING_TABLE [IL_DEBUG_INFO_FROM_MODULE]
			-- [module_key] => [IL_DEBUG_INFO_FROM_MODULE]

	dbg_info_class_types: HASH_TABLE [IL_DEBUG_INFO_FROM_CLASS_TYPE, INTEGER]
			-- [CLASS_TYPE.static_type_id] => [IL_DEBUG_INFO_FROM_CLASS_TYPE]

feature {CIL_CODE_GENERATOR, IL_DEBUG_INFO_RECORDER_EXPORTER} -- Persistence

	load_data_for_debugging
			-- Load workbench data (mainly for debugging)
		do
			is_recording := False
			load_workbench_data
		end

	load_workbench_data
			-- Load workbench data (mainly for debugging)
		do
			load (il_info_file_name)
			last_loading_is_workbench := True
		end

	load_final_data
			-- Load final data
		do
			load (final_il_info_file_name)
			last_loading_is_workbench := False
		end

	last_loading_is_workbench: BOOLEAN
			-- Is last loading for workbench mode ?

	load_successful: BOOLEAN
			-- Is last loading successful ?

	loading_errors_message: STRING_32
		do
			create Result.make (50)
			Result.append_string_general (" ERROR while retrieving IL DEBUG INFO data ...%N")
			if attached loading_errors as es then
				Result.append_string_general ("%N")
				across
					es as e
				loop
					Result.append_string_general ("   - ")
					Result.append_string_general (e.item)
					Result.append_string_general ("%N")
				end
			end
			Result.append_string_general ("%N")
			Result.append_string_general ("   Debugging will be disabled.%N")
			Result.append_string_general ("   Please reload, until you do not get this message.%N")
			Result.append_string_general ("%N")
		end

feature {NONE}-- Implementation for save and load task

	save (a_filename_to_save: PATH)
			-- Save info into file.
		local
			l_object_to_save: IL_DEBUG_INFO_STORAGE
			l_project_path: like {PROJECT_DIRECTORY}.path
		do
			if is_debug_info_enabled then
				debug ("debugger_il_info_trace")
					print ("Saving IL debug info %N")
				end

					--| Prepare object to be saved
				create l_object_to_save.make

				l_object_to_save.set_system_name (system.name)
				if context.workbench_mode then
					l_project_path := workbench_module_directory_path_name
				else
					l_project_path := finalized_module_directory_path_name
				end
				l_object_to_save.set_project_path (direct_module_key (l_project_path.name))
				l_object_to_save.set_modules_debugger_info (dbg_info_modules)
				l_object_to_save.set_class_types_debugger_info (dbg_info_class_types)

				save_storable_data (l_object_to_save, a_filename_to_save)
			end
		end

	load (a_il_info_file_name: PATH)
			-- Load info from saved file.
		require
			a_il_info_file_name_not_void: a_il_info_file_name /= Void
		local
			l_succeed: BOOLEAN
			l_remote_project_directory: REMOTE_PROJECT_DIRECTORY
			l_pfn: PATH
		do
			debug ("debugger_il_info_trace")
				print ({STRING_32} "Loading IL Info from [" + a_il_info_file_name.name + "] %N")
			end

			load_successful := True
			create loading_errors.make

			reset
			l_succeed := import_file_data (a_il_info_file_name, System.name, False)

			load_successful := load_successful and l_succeed

			across
				System.precompilation_directories as d
			loop
				l_remote_project_directory := d.item
				l_pfn := l_remote_project_directory.precomp_il_info_file (
					l_remote_project_directory.is_precompile_finalized and system.msil_use_optimized_precompile)
				debug ("debugger_il_info_trace_extra")
					print (l_pfn.name)
					io.put_new_line
				end
				l_succeed := import_file_data (l_pfn, l_remote_project_directory.system_name, True)
				load_successful := load_successful and l_succeed
			end

			debug ("debugger_il_info_trace_extra")
				across
					dbg_info_modules as m
				loop
					m.item.debug_display
				end
			end
		end

	loading_errors: LINKED_LIST [READABLE_STRING_GENERAL]
			-- Loading error messages.

	save_storable_data (d: IL_DEBUG_INFO_STORAGE; a_filename_to_save: PATH)
			-- Save Storable data
		require
			data_valid: d /= Void
			filename_not_empty: a_filename_to_save /= Void
		local
			l_il_info_file: RAW_FILE
		do
				--| Save into file
			create l_il_info_file.make_with_path (a_filename_to_save)
			l_il_info_file.open_write
			l_il_info_file.independent_store (d)
			l_il_info_file.close
		end

	import_file_data (a_fn: PATH; a_system_name: STRING; is_from_precompiled: BOOLEAN): BOOLEAN
			-- Add data contained in `a_fn' into current structure
		local
			retried: BOOLEAN
			l_retrieved: detachable ANY

			l_dbg_system_name: STRING
			l_dbg_info_project_path: like {IL_DEBUG_INFO_STORAGE}.project_path
			l_dbg_info_modules: like dbg_info_modules
			l_patched_dbg_info_modules: like dbg_info_modules
			l_dbg_info_class_types: like dbg_info_class_types
			l_il_info_file: RAW_FILE

			l_current_project_path: like direct_module_key
			l_info_module: IL_DEBUG_INFO_FROM_MODULE
		do
			if not retried then
				debug ("debugger_il_info_trace")
					io.error.put_string_32 ({STRING_32}"Importing IL Info from [" + a_fn.name + "] %N")
				end
				Result := True

				create l_il_info_file.make_with_path (a_fn)
				if l_il_info_file.exists then
					l_il_info_file.open_read
					l_retrieved := l_il_info_file.retrieved
					l_il_info_file.close

						--| Get values
					if attached {IL_DEBUG_INFO_STORAGE} l_retrieved as l_retrieved_object then
						l_dbg_system_name		:= l_retrieved_object.system_name
						l_dbg_info_project_path	:= l_retrieved_object.project_path
						l_dbg_info_modules      := l_retrieved_object.modules_debugger_info
						l_dbg_info_class_types  := l_retrieved_object.class_types_debugger_info

						if not is_from_precompiled then
								--| when we load the project, by default we load as workbench
							if is_recording then
								if context.workbench_mode then
									l_current_project_path := direct_module_key (workbench_module_directory_path_name.name)
								else
									l_current_project_path := direct_module_key (finalized_module_directory_path_name.name)
								end
							else
								l_current_project_path := direct_module_key (workbench_module_directory_path_name.name)
							end

								--| First, we check if the project didn't moved to a new location
							if
								l_dbg_info_project_path /= Void and then
								not l_dbg_info_project_path.is_equal (l_current_project_path)
							then
									--| This is the current project, since it is not a precompilation
									--| We need to update these data, since the location changed
								check
									l_dbg_system_name /= Void
									l_dbg_info_project_path /= Void
								end
								debug ("debugger_il_info_trace")
									io.error.put_string ("Your project's location changed !!!%N")
									io.error.put_string (" [Previous] %N")
									io.error.put_string ("  - System   = " + l_dbg_system_name + "%N")
									io.error.put_string_32 ({STRING_32} "  - Location = " + l_dbg_info_project_path +"%N")
									io.error.put_string (" [Current ] %N")
									io.error.put_string ("  - System   = " + system.name + "%N")
									io.error.put_string_32 ({STRING_32} "  - Location = " + l_current_project_path +"%N")
									io.error.put_string (" => Updating data ... ")
								end
								create l_patched_dbg_info_modules.make (l_dbg_info_modules.count)
								across
									l_dbg_info_modules as m
								loop
									l_info_module := m.item
									update_imported_project_info_module (l_current_project_path, l_info_module)

									check
										item_not_already_inside:
											not l_patched_dbg_info_modules.has (l_info_module.module_filename)
									end
									l_patched_dbg_info_modules.put (l_info_module, l_info_module.module_filename)
									check
										item_inserted: l_patched_dbg_info_modules.inserted
									end
								end
								l_retrieved_object.set_modules_debugger_info (l_patched_dbg_info_modules)
								l_retrieved_object.set_project_path (l_current_project_path)
								debug ("debugger_il_info_trace")
									io.error.put_string (" done.%N")
								end
								save_storable_data (l_retrieved_object, Il_info_file_name)
								debug ("debugger_il_info_trace")
									io.error.put_string (" [!] Updated data saved.%N")
								end

								l_dbg_info_modules := l_retrieved_object.modules_debugger_info
									--| Now the data are patched and ready to be used
							end

							dbg_info_modules.merge (l_dbg_info_modules)
						else
								--| Update and Merge data
								--| regarding about module name
								--| since we move assemblies/precompilation module under
								--| W_code/assemblies/..
							across
								l_dbg_info_modules as m
							loop
								l_info_module := m.item
								update_imported_precompilation_info_module (a_system_name, l_info_module)
								debug ("debugger_il_info_trace")
									io.error.put_string_32 ({STRING_32} " :: Importing Module from [" + l_info_module.module_filename + "] %N")
								end
								if dbg_info_modules.has (l_info_module.module_filename) then
									dbg_info_modules.item (l_info_module.module_filename).merge (l_info_module)
								else
									dbg_info_modules.put (l_info_module, l_info_module.module_filename)
								end
							end
						end
						dbg_info_class_types.merge (l_dbg_info_class_types)
					end
				end
			else
				Result := False
				loading_errors.extend ({STRING_32} "Unable to load [" + a_fn.name + "]")
			end
		rescue
			retried := True
			retry
		end

	update_imported_project_info_module (a_project_path: like direct_module_key; a_info_module: IL_DEBUG_INFO_FROM_MODULE)
			-- Update imported project module name to effective module name.
		local
			l_fn: like module_file_name_for_class
		do
			create l_fn.make_from_string (a_project_path)
			l_fn := l_fn.extended (a_info_module.module_name)
				--| module_name : contains ".dll"
			a_info_module.update_module_filename (direct_module_key (l_fn.name))
		end

	update_imported_precompilation_info_module (a_system_name: STRING; a_info_module: IL_DEBUG_INFO_FROM_MODULE)
			-- Update imported precompilation module name to effective module name.
		local
			l_mod_fn: like module_file_name_for_class
		do
--| FIXME: when we debug we use the W_code\assemblies\....dll one
--			if system.msil_use_optimized_precompile then
--				l_mod_fn := finalized_precompilation_module_filename (a_info_module.system_name)				
--			else
				l_mod_fn := workbench_precompilation_module_filename (a_info_module.system_name)
--			end
			a_info_module.update_module_filename (direct_module_key (l_mod_fn.name))
		end

feature {SHARED_IL_DEBUG_INFO_RECORDER} -- Module indexer implementation

	resolved_module_key (a_mod_filename: READABLE_STRING_32): READABLE_STRING_32
			-- Lowered and resolved Module key for `a_mod_filename' used for indexation
		require
			mod_name_valid: a_mod_filename /= Void and then not a_mod_filename.is_empty
		do
			Result := direct_module_key (a_mod_filename) -- So this is a twin lowered
			Result := internal_module_key (Result)
		ensure
			Result_valid: Result /= Void and then not Result.is_empty
			Result_is_lower_case: Result.as_lower.is_equal (Result)
		end

feature {NONE} -- Module indexer implementation

	direct_module_key (a_mod_filename: READABLE_STRING_32): READABLE_STRING_32
			-- Module key for `a_mod_filename' used for indexation
			-- Nota: Only for recording session features
		require
			mod_name_valid: a_mod_filename /= Void and then not a_mod_filename.is_empty
		do
			Result := a_mod_filename.as_lower
		ensure
			Result_valid: Result /= Void and then not Result.is_empty
			Result_is_lower_case: Result.as_lower.is_equal (Result)
		end

	internal_module_key (a_mod_key: like internal_module_key): READABLE_STRING_32
			-- Module key used in the internal structure.
			-- as opposed to external module key
			-- which comes from dotnet debugger
		require
			a_mod_key_not_void: a_mod_key /= Void
			a_mod_key_is_lower_case: a_mod_key.as_lower.is_equal (a_mod_key)
		local
			l_module_id: STRING_32
			l_pos_dll, l_pos_sep: INTEGER
			l_item: IL_DEBUG_INFO_FROM_MODULE
			l_item_mod_id: STRING
		do
			if dbg_info_modules.has (a_mod_key) then
				Result := a_mod_key
			else
				if internal_module_key_table.has (a_mod_key) then
					Result := internal_module_key_table.item (a_mod_key)
				else
						--| FIXME JFIAT 2004/05/19 : issue if 2 assemblies with same filename.dll
						--|   Then we have an issue, but at worst we will see Eiffel type name
						--|   as dotnet type name
						--|
						--|   How does estudio manage 2 assemblies with the same filename ?
						--|   When it copies them into EIFGEN/W_code/assemblies ??

						--| Get an potential identifier for module						
					l_pos_dll := a_mod_key.substring_index (".dll", 1)
					if l_pos_dll > 0 then
						l_pos_sep := a_mod_key.last_index_of ((create {OPERATING_ENVIRONMENT}).Directory_separator, l_pos_dll)
						if l_pos_sep > 0 then
							l_module_id := a_mod_key.substring (l_pos_sep + 1, l_pos_dll + 3)
						end
					end
					if l_module_id /= Void then
							--| Search in the known module, which one could match `a_mod_key'
						from
							dbg_info_modules.start
						until
							dbg_info_modules.after or Result /= Void
						loop
							l_item := dbg_info_modules.item_for_iteration
							l_item_mod_id := l_item.module_name
							if l_item_mod_id.same_string_general (l_module_id) then
								last_info_from_module := l_item
								Result := last_info_from_module.module_filename --| Should contain .dll
								internal_module_key_table.force (Result, a_mod_key)
							end
							dbg_info_modules.forth
						end
					end
					if Result = Void then
						Result := a_mod_key
						internal_module_key_table.force (Result, a_mod_key)
					end
				end
			end
		ensure
			Result_valid: Result /= Void and then not Result.is_empty
			Result_is_lower_case: Result.as_lower.is_equal (Result)
		end

	internal_module_key_table: HASH_TABLE [like internal_module_key, like internal_module_key];
			-- Table to make relation between external module name,
			-- and internal key for module

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

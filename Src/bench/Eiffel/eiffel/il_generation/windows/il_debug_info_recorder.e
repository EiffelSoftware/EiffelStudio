indexing
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
	author: "$author$"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_DEBUG_INFO_RECORDER

inherit

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

	SYSTEM_CONSTANTS
		export
			{NONE} all
		end

create {SHARED_IL_DEBUG_INFO_RECORDER}
	make

feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		do
			create dbg_info_modules.make (50)
			create dbg_info_class_types.make (100)
			entry_point_token := 0
			create internal_requested_class_tokens.make (10)
			reset_debugging_live_data
		end

	reset is
			-- Reset value of Current
		do
			dbg_info_modules.wipe_out
			dbg_info_class_types.wipe_out
			entry_point_token := 0
			internal_reset
		end

	internal_reset is
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
		
feature {EIFNET_DEBUGGER} -- reset live data

	reset_debugging_live_data is
			-- Reset data used during debugging session
		do
			if internal_module_key_table = Void then
				create internal_module_key_table.make (10)
			else
				internal_module_key_table.wipe_out
			end
		end

feature {IL_CODE_GENERATOR} -- Access

	is_debug_info_enabled: BOOLEAN
			-- Are we generating debug information ?

	init_recording_session (debug_mode: BOOLEAN) is
			-- Initialize recording session.
		do
			debug ("debugger_il_info_trace")
				print ("IL_DEBUG_INFO_RECORDER.init_recording_session .. %N")
			end

			if not load_successful then
					--| Load IL Info, should be already loaded, but in case.
				load
			end

				--| Reset internal value to recompute the CLASS_TYPES array
			Il_debug_info.reset
				--| Enable/Disable debug info
			is_debug_info_enabled := debug_mode

				--| Reset Internal attributes used for optimisation 
			internal_reset
		end

feature -- Queries : eStudio data from debugger data

	has_info_about_module (a_module_filename: STRING): BOOLEAN is
			-- Do we have information for Module identified by `a_module_filename' ?
		require
			module_filename_valid: a_module_filename /= Void
								and then not a_module_filename.is_empty
		do
			Result := info_from_module_if_exists (a_module_filename) /= Void
		end

	has_class_info_about_module_class_token (a_module_filename: STRING; a_class_token: INTEGER): BOOLEAN is
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

	has_feature_info_about_module_class_token (a_module_filename: STRING; a_class_token: INTEGER; a_feature_token: INTEGER): BOOLEAN is
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

	class_type_for_module_class_token (a_module_filename: STRING; a_class_token: INTEGER): CLASS_TYPE is
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

	compiled_class_for_class_token_and_module (a_class_token: INTEGER; a_module_filename: STRING): CLASS_C is
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

	class_name_for_class_token_and_module (a_class_token: INTEGER; a_module_filename: STRING): STRING is
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

	feature_i_by_module_feature_token (a_module_filename: STRING; a_feature_token: INTEGER): FEATURE_I is
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

	entry_point_feature_i: FEATURE_I is
			-- System entry point feature
		local
			l_class: CLASS_C
		do
			--| Update the root class info
			l_class := System.root_class.compiled_class
			Result := l_class.feature_table.item (System.creation_name)
		end

feature -- Queries : dotnet data from estudio data

	class_token (a_module_filename: STRING; a_class_type: CLASS_TYPE): INTEGER is
			-- Class token for CLASS_TYPE.
		local
			l_info_from_module: IL_DEBUG_INFO_FROM_MODULE
			l_id: INTEGER
		do
			Result := a_class_type.last_implementation_type_token
			if Result = 0 then --| Precompilated class_type for instance
				l_id := a_class_type.static_type_id

				Result := internal_requested_class_tokens.item (l_id)
				if Result = 0 then --| Not yet known, no requested yet
					if a_module_filename = Void then
						l_info_from_module := info_from_module_if_exists (module_file_name_for_class (a_class_type))
					else
						l_info_from_module := info_from_module_if_exists (a_module_filename)
					end
					if l_info_from_module /= Void then --| no module known for it .. (external)

						Result := l_info_from_module.class_token_for_class_type (a_class_type)

							--| Save the result
						internal_requested_class_tokens.put (Result, l_id)
					end
				end
			end
		ensure
			class_token_positive: Result /= 0
		end

	entry_point_token: INTEGER
			-- Token of the system entry point feature
			-- Useful for stepping at the beginning of the execution

	feature_token_for_feat_and_class_type (a_feat: FEATURE_I; a_class_type: CLASS_TYPE): INTEGER is
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

	feature_token_for_non_generic (a_feat: FEATURE_I): INTEGER is
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

	once_feature_tokens_for_feat_and_class_type (a_feat: FEATURE_I; a_class_type: CLASS_TYPE): TUPLE [INTEGER, INTEGER] is
			-- `_done' and `_result' Tokens for the once `a_feat'
		require
			feat_not_void: a_feat /= Void
			feat_is_once: a_feat.is_once
			class_type_not_void: a_class_type /= Void
		local
			l_info_from_class_type: IL_DEBUG_INFO_FROM_CLASS_TYPE
		do
			l_info_from_class_type := info_from_class_type (a_class_type, False)
			if l_info_from_class_type /= Void then
				Result := l_info_from_class_type.once_tokens (a_feat)
			end
		end

feature {EIFFEL_CALL_STACK_DOTNET, 
		APPLICATION_STATUS_DOTNET, 
		APPLICATION_EXECUTION_DOTNET,
		ICOR_DEBUG_MANAGED_CALLBACK} -- Queries : IL Offset data

	is_il_offset_related_to_eiffel_line (a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_il_offset: INTEGER): BOOLEAN is
			-- is a_il_offset related to an Eiffel line index ?
		require
			class_type_not_void: a_class_type /= Void
			feat_not_void: a_feat /= Void
		local
			l_il_offset_list: ARRAYED_LIST [TUPLE [INTEGER, LIST [INTEGER]]]
			l_offsets_info: LIST [INTEGER]
		do
			l_il_offset_list := feature_breakable_il_offsets (a_class_type, a_feat)
			if l_il_offset_list /= Void then
				from
					l_il_offset_list.start
				until
					l_il_offset_list.after or Result
				loop
					l_offsets_info ?= l_il_offset_list.item.item (2)
					Result := l_offsets_info.has (a_il_offset)
					l_il_offset_list.forth
				end
			end
		end

	feature_eiffel_breakable_line_for_il_offset (a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_il_offset: INTEGER): INTEGER is
			-- Corresponding Eiffel Line for `a_il_offset' offset
		require
			class_type_not_void: a_class_type /= Void
			feat_not_void: a_feat /= Void
		local
			l_il_offset_list: ARRAYED_LIST [TUPLE [INTEGER, LIST [INTEGER]]]
			l_offsets_info: LIST [INTEGER]
			l_offset_before: INTEGER
			l_breakable_line: INTEGER
			o: INTEGER
		do
			l_il_offset_list := feature_breakable_il_offsets (a_class_type, a_feat)
			if l_il_offset_list /= Void then
				from
					l_breakable_line := 0
					l_offset_before := -1
					l_il_offset_list.start
				until
					l_il_offset_list.after
				loop
					l_offsets_info ?= l_il_offset_list.item.item (2)
					from
						l_offsets_info.start
					until
						l_offsets_info.after
					loop
						o := l_offsets_info.item
						if o <= a_il_offset and o > l_offset_before then
							l_offset_before := o
							l_breakable_line := l_il_offset_list.index - 1 --| LIST.first.index = 1
						end
						l_offsets_info.forth
					end
					l_il_offset_list.forth
				end
			end
			Result := l_breakable_line
		end

	approximate_feature_breakable_il_offset_for (a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_il_offset: INTEGER): INTEGER is
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

feature {APPLICATION_EXECUTION_DOTNET} -- Queries : IL Offset data

	feature_breakable_il_line_for (a_class_type: CLASS_TYPE; a_feat: FEATURE_I; 
				a_breakable_line_number: INTEGER): LIST [INTEGER] is
			-- IL offset for the bp slot index `a_breakable_line_number'
			-- Return Void if index out of range
		require
			class_type_not_void: a_class_type /= Void
			feat_not_void: a_feat /= Void
		local
			l_index: INTEGER
			l_list: ARRAYED_LIST [TUPLE [INTEGER, LIST [INTEGER]]]
		do
			l_index := a_breakable_line_number + 1
			l_list := feature_breakable_il_offsets (a_class_type, a_feat)

			if 
				l_list /= Void 
				and then l_list.valid_index (l_index) 
			then
				Result ?= l_list.i_th (l_index).item (2)
			else
				Result:= Void
			end
		end

	next_feature_breakable_il_range_for (a_class_type: CLASS_TYPE; a_feat: FEATURE_I; 
				a_current_il_offset: INTEGER): ARRAY [TUPLE [INTEGER, INTEGER]] is
			-- IL range offset for the Eiffel line `a_line' in the step next
		require
			class_type_not_void: a_class_type /= Void
			feat_not_void: a_feat /= Void
		local
			l_list: SORTED_LIST [INTEGER]
			l_inf, l_sup: INTEGER
			l_interval: TUPLE [INTEGER, INTEGER]
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
						print (" - " + i.out + " : [" + (Result.item (i)).integer_item (1).out + " , " + (Result.item (i)).integer_item (2).out + "] %N")
						i := i + 1
					end
				end
			end
		end

feature {NONE} -- line debug exploitation

	feature_breakable_il_offsets_sorted_list (a_class_type: CLASS_TYPE; a_feat: FEATURE_I): SORTED_LIST [INTEGER] is
			-- List of all sorted breakable IL Offset for `a_feat'
		require
			class_type_not_void: a_class_type /= Void
			feat_not_void: a_feat /= Void
		local
			l_il_offset_list: ARRAYED_LIST [ TUPLE [INTEGER, LIST [INTEGER]]]
			l_offsets_info: LIST [INTEGER]
		do
			l_il_offset_list := feature_breakable_il_offsets (a_class_type, a_feat)
			if l_il_offset_list /= Void then
				from
					create {SORTED_TWO_WAY_LIST [INTEGER]} Result.make 
						--| +2 : in case we have loop with variant + invariant
					l_il_offset_list.start
				until
					l_il_offset_list.after
				loop
					l_offsets_info ?= l_il_offset_list.item.item (2)
					Result.append (l_offsets_info)
					l_il_offset_list.forth
				end
			end
		end

	feature_breakable_il_offsets (a_class_type: CLASS_TYPE; a_feat: FEATURE_I): ARRAYED_LIST [TUPLE [INTEGER, LIST [INTEGER]]] is
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

	internal_requested_class_tokens: HASH_TABLE [INTEGER, INTEGER]
			-- [Class token] <= [Class type]

feature {IL_CODE_GENERATOR} -- Recording context

	is_single_class : BOOLEAN
			-- Can current class only be single inherited?

	is_attribute : BOOLEAN
			-- is current generated feature is attribute ?

	is_static : BOOLEAN
			-- is current generated feature is static ?

	in_interface : BOOLEAN
			-- is current generated feature is in_interface ?

	set_record_context (a_is_single_class, a_is_attr, a_is_static, a_in_interface: BOOLEAN) is
			-- Save generation context in order to determine what to record.
		do
			is_single_class := a_is_single_class
			is_attribute := a_is_attr
			is_static := a_is_static
			in_interface := a_in_interface
		end

feature {IL_CODE_GENERATOR} -- line debug recording

	ignore_next_debug_info is
			-- Ignore recording of debug info (nop) for next recording
		do
			ignoring_next_debug_info := True
		end

	ignoring_next_debug_info: BOOLEAN
			-- Do we ignore recording of debug info (nop) for next recording ?

	record_ghost_debug_infos (a_class_type: CLASS_TYPE; a_feat: FEATURE_I; 
								a_il_line: INTEGER; a_eiffel_line: INTEGER; 
								a_nb: INTEGER) is
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

	record_line_info (a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_il_line: INTEGER; a_eiffel_line: INTEGER;) is
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

feature {IL_CODE_GENERATOR} -- Token recording

	record_entry_point_token (a_module: STRING; a_class_token, a_feature_token: INTEGER) is
			-- Record the entry_point_token of the system.
		do
			if is_debug_info_enabled then
				debug ("debugger_il_info_trace")
					print ("EntryPointToken_Recorded " + a_feature_token.to_hex_string + "%N")
				end
				entry_point_token := a_feature_token
			end
		end

	record_once_info (a_class_type: CLASS_TYPE; a_feature: FEATURE_I; a_once_name: STRING; a_once_done_token, a_once_result_token: INTEGER;) is
			--  Record `_done' and `_result' tokens for once `a_once_name' from `a_class_type'.
		local
			l_info_from_class_type: IL_DEBUG_INFO_FROM_CLASS_TYPE
		do
			if 
				is_debug_info_enabled 
--				and then a_feature /= Void
			then
				debug ("debugger_il_info_trace")
					print ("[>] Recording Once : "  + a_once_name + " = "
							+ a_class_type.associated_class.name_in_upper 
							+ "." + a_feature.feature_name 
							+ " -> "
							+ "Done=0x" + a_once_done_token.to_hex_string
							+ "::"
							+ "Result=0x" + a_once_result_token.to_hex_string
							+ "%N")
				end
				l_info_from_class_type := info_from_class_type (a_class_type, True)
				l_info_from_class_type.record_once_tokens (a_once_done_token, a_once_result_token, a_feature)
			end
		end

	record_il_feature_info (a_module: IL_MODULE; a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_class_token, a_feature_token: INTEGER) is
			-- Record feature information : class, feature token, and module name throught the other data.
		do
			if is_debug_info_enabled then
				if is_attribute then
						if not in_interface and is_static then
							process_il_feature_info_recording (a_module, a_class_type, a_feat, a_class_token, a_feature_token)
						elseif a_class_type.associated_class.is_single then
							process_il_feature_info_recording (a_module, a_class_type, a_feat, a_class_token, a_feature_token)
						end
				else -- not is_attribute
					if not in_interface and is_static then
						process_il_feature_info_recording (a_module, a_class_type, a_feat, a_class_token, a_feature_token)
						if is_entry_point (a_feat) then
							record_entry_point_token (
									module_key (a_module.module_file_name)
									, a_class_token
									, a_feature_token
								)
						end
					else
						do_nothing
					end
				end
			end
		end

feature {NONE} -- Record processing

	last_class_type_recorded: CLASS_TYPE
			-- Last recorded class type

	ignore_feature (a_feat: FEATURE_I): BOOLEAN is
			-- Ignore non Eiffel feature name 
			-- for now, ignore all '^_.*' feature_name
		require
			a_feat_not_void: a_feat /= Void
		do
			Result := a_feat.feature_name.item(1).is_equal ('_')
--| NOTA JFIAT: 2004/05/28 : fix invariant cursor in call stack
--| When we'll decide to fix the cursor in call stack on invariant
--| this may be a start ..
				--| and then not a_feat.feature_name.is_equal ("_invariant")
		end

	process_il_feature_info_recording (a_module: IL_MODULE; a_class_type: CLASS_TYPE; a_feature: FEATURE_I; a_class_token, a_feature_token: INTEGER) is
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
				l_info_from_module := info_from_module_or_create (a_module.module_file_name, a_module.module_name)
				l_info_from_module.record_feature_i (a_class_type, a_feature, a_feature_token)

					--| Record `feature_token' indexed by `feature_i'
				l_info_from_class_type := info_from_class_type (a_class_type, True)
				l_info_from_class_type.record_feature_token (a_feature_token, a_feature)
			end
		end

feature {NONE} -- Class Specific info

	internal_record_class_token (a_module: IL_MODULE; a_class_type: CLASS_TYPE; a_class_token: INTEGER) is
			-- Record class information regarding token
		require
			module_not_void: a_module /= Void
			class_type_not_void: a_class_type /= Void
			class_token_positive: a_class_token > 0
		do
			internal_record_class_type (a_module.module_file_name, a_module.module_name, a_class_type, a_class_token)
		end

	internal_record_class_type (a_module_filename: STRING; a_module_name: STRING; a_class_type: CLASS_TYPE; a_class_token: INTEGER) is
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
			dbg_info_modules.has (module_key (a_module_filename))
		end

feature {IL_CODE_GENERATOR} -- Cleaning

	last_module_info_cleaned: STRING
			-- Last cleaned Module

	last_class_type_info_cleaned: CLASS_TYPE
			-- Last cleaned Class Type

	clean_class_type_info_for (a_class_type: CLASS_TYPE) is
			-- Clean info related to this `a_class_type'.
		require
			class_type_not_void: a_class_type /= Void
		local
			l_class_type: CLASS_TYPE
			l_module_filename: STRING
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
			l_module_filename := module_file_name_for_class (l_class_type)
			if 
				(last_module_info_cleaned = Void) or else
				not (last_module_info_cleaned.is_equal (l_module_filename))
			 then
				last_module_info_cleaned := l_module_filename
				debug ("debugger_il_info_trace")
					print ("Cleaning : " + l_module_filename + "%N")
				end

				l_info_from_module := info_from_module_if_exists (l_module_filename)
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

	info_from_class_type (a_class_type: CLASS_TYPE; a_create_if_not_found: BOOLEAN): IL_DEBUG_INFO_FROM_CLASS_TYPE is
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

	info_from_module_or_create (a_module_filename: STRING; a_module_name: STRING): IL_DEBUG_INFO_FROM_MODULE is
			-- Info from Module_filename
		require
			module_filename_not_empty: a_module_filename /= Void and then not a_module_filename.is_empty
		do
			Result := info_from_module (a_module_filename, True)
			Result.set_module_name (a_module_name.twin)
		ensure
			result_not_void: Result /= Void
		end

	info_from_module_if_exists (a_module_filename: STRING): IL_DEBUG_INFO_FROM_MODULE is
			-- Info from Module_filename
		require
			module_filename_not_empty: a_module_filename /= Void and then not a_module_filename.is_empty
		do
			Result := info_from_module (a_module_filename, False)
		end

	info_from_module (a_module_filename: STRING; a_create_if_not_found: BOOLEAN): IL_DEBUG_INFO_FROM_MODULE is
			-- Info from Module_filename
			--| Should not be called directly anymore, 
			--| use `info_from_module_or_create' or `info_from_module_if_exists'
		require
			module_filename_not_empty: a_module_filename /= Void and then not a_module_filename.is_empty
		local
			l_module_key: STRING
			l_internal_mod_key: STRING
		do
			l_module_key := module_key (a_module_filename)

			if not a_create_if_not_found then
					--| This means we are query data, not recording
				l_internal_mod_key := internal_module_key (l_module_key)
				if l_internal_mod_key /= Void then
					l_module_key := l_internal_mod_key					
				end
			end
			if 
				last_info_from_module /= Void and then
				last_info_from_module.module_filename.is_equal (l_module_key)
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

	dbg_info_modules: HASH_TABLE [IL_DEBUG_INFO_FROM_MODULE, STRING]
			-- [module_key] => [IL_DEBUG_INFO_FROM_MODULE]

	dbg_info_class_types: HASH_TABLE [IL_DEBUG_INFO_FROM_CLASS_TYPE, INTEGER]
			-- [CLASS_TYPE.static_type_id] => [IL_DEBUG_INFO_FROM_CLASS_TYPE]

feature {IL_CODE_GENERATOR, APPLICATION_EXECUTION_DOTNET} -- {SHARED_IL_DEBUG_INFO_RECORDER} -- Persistence

	save is
			-- Save info into file.
		local
			l_object_to_save: IL_DEBUG_INFO_STORAGE
		do
			if is_debug_info_enabled then
				debug ("debugger_il_info_trace")
					print ("Saving IL debug info %N")
				end

					--| Prepare object to be saved
				create l_object_to_save.make

				l_object_to_save.set_system_name (system.name)
				l_object_to_save.set_project_path (module_key (module_directory_name))
				l_object_to_save.set_modules_debugger_info (dbg_info_modules)
				l_object_to_save.set_class_types_debugger_info (dbg_info_class_types)
				l_object_to_save.set_entry_point_token (entry_point_token)

				save_storable_data (l_object_to_save)
			end
		end

	load is
			-- Load info from saved file.
		local
			l_succeed: BOOLEAN
			l_precomp_dirs: HASH_TABLE [REMOTE_PROJECT_DIRECTORY, INTEGER]
			l_remote_project_directory: REMOTE_PROJECT_DIRECTORY
			l_pfn: FILE_NAME
		do
			debug ("debugger_il_info_trace")
				print ("Loading IL Info  %N")
			end

			load_successful := True
			create loading_errors.make

			reset
			l_succeed := import_file_data (Il_info_file_name, System.name, False)

			load_successful := load_successful and l_succeed

			l_precomp_dirs := System.precompilation_directories
			if not l_precomp_dirs.is_empty then
				from
					l_precomp_dirs.start
				until
					l_precomp_dirs.after
				loop
					l_remote_project_directory := l_precomp_dirs.item_for_iteration
					l_pfn := l_remote_project_directory.precomp_il_info_file (
						l_remote_project_directory.is_precompile_finalized and system.msil_use_optimized_precompile)
					debug ("debugger_il_info_trace_extra")
						print (l_pfn)
						io.put_new_line
					end
					l_succeed := import_file_data (l_pfn, l_remote_project_directory.system_name, True)
					load_successful := load_successful and l_succeed
					l_precomp_dirs.forth
				end
			end

			debug ("debugger_il_info_trace_extra")
				from
					dbg_info_modules.start
				until
					dbg_info_modules.after
				loop
					dbg_info_modules.item_for_iteration.debug_display
					dbg_info_modules.forth
				end
			end
		end

	load_successful: BOOLEAN
			-- Is last loading successful ?

	loading_errors_message: STRING is
		do
			create Result.make (50)
			Result.append_string (" ERROR while retrieving IL DEBUG INFO data ...%N")
			if loading_errors /= Void then
				Result.append_string ("%N")
				from
					loading_errors.start
				until
					loading_errors.after
				loop
					Result.append_string ("   - " + loading_errors.item + "%N")
					loading_errors.forth
				end
			end
			Result.append_string ("%N")
			Result.append_string ("   Debugging will be disabled.%N")
			Result.append_string ("   Please reload, until you do not get this message.%N")
			Result.append_string ("%N")
		end

feature {NONE}-- Implementation for save and load task

	loading_errors: LINKED_LIST [STRING]
			-- Loading error messages.

	save_storable_data (d: IL_DEBUG_INFO_STORAGE) is
			-- Save Storable data
		require
			data_valid: d /= Void
		local
			l_il_info_file: RAW_FILE
		do
				--| Save into file
			create l_il_info_file.make (Il_info_file_name)

			l_il_info_file.open_write
			l_il_info_file.independent_store (d)
			l_il_info_file.close
		end

	import_file_data (a_fn: STRING; a_system_name: STRING; is_from_precompiled: BOOLEAN): BOOLEAN is
			-- Add data contained in `a_fn' into current structure
		local
			retried: BOOLEAN
			l_retrieved: ANY
			l_retrieved_object: IL_DEBUG_INFO_STORAGE

			l_dbg_system_name: STRING
			l_dbg_info_project_path: STRING
			l_dbg_info_modules: like dbg_info_modules
			l_patched_dbg_info_modules: like dbg_info_modules
			l_dbg_info_class_types: like dbg_info_class_types
			l_entry_point_token: like entry_point_token
			l_il_info_file: RAW_FILE

			l_current_project_path: STRING
			l_info_module: IL_DEBUG_INFO_FROM_MODULE
		do
			if not retried then
				debug ("debugger_il_info_trace")
					print ("Importing IL Info from [" + a_fn + "] %N")
				end
				Result := True

				create l_il_info_file.make (a_fn)
				if not l_il_info_file.exists then
						--| File does not exists !
				else
					l_il_info_file.open_read
					l_retrieved := l_il_info_file.retrieved
					l_il_info_file.close

						--| Get values
					l_retrieved_object ?= l_retrieved
					if l_retrieved_object /= Void then
						l_dbg_system_name		:= l_retrieved_object.system_name
						l_dbg_info_project_path	:= l_retrieved_object.project_path
						l_dbg_info_modules      := l_retrieved_object.modules_debugger_info
						l_dbg_info_class_types  := l_retrieved_object.class_types_debugger_info
						l_entry_point_token     := l_retrieved_object.entry_point_token

							--| Assign values
						l_current_project_path := module_key (module_directory_name)
						if not is_from_precompiled then
								--| First, we check if the project didn't moved to a new location
							if 
								l_dbg_info_project_path /= Void and then 
								not l_dbg_info_project_path.same_string (l_current_project_path)
							then
									--| This is the current project, since it is not a precompilation
									--| We need to update these data, since the location changed
								check 
									l_dbg_system_name /= Void
									l_dbg_info_project_path /= Void
								end
								io.error.put_string ("Your project's location changed !!!%N")
								io.error.put_string (" [Previous] %N")
								io.error.put_string ("  - System   = " + l_dbg_system_name + "%N")
								io.error.put_string ("  - Location = " + l_dbg_info_project_path +"%N")
								io.error.put_string (" [Current ] %N")
								io.error.put_string ("  - System   = " + system.name + "%N")
								io.error.put_string ("  - Location = " + l_current_project_path +"%N")
								io.error.put_string (" => Updating data ... ")
								from
									create l_patched_dbg_info_modules.make (l_dbg_info_modules.count)
									l_dbg_info_modules.start
								until
									l_dbg_info_modules.after
								loop
									l_info_module := l_dbg_info_modules.item_for_iteration
									update_imported_project_info_module (l_current_project_path, l_info_module)

									check
										item_not_already_inside: not l_patched_dbg_info_modules.has (l_info_module.module_filename)
									end
									l_patched_dbg_info_modules.put (l_info_module, l_info_module.module_filename)
									check 
										item_inserted: l_patched_dbg_info_modules.inserted
									end

									l_dbg_info_modules.forth
								end
								l_retrieved_object.set_modules_debugger_info (l_patched_dbg_info_modules)
								l_retrieved_object.set_project_path (l_current_project_path)
								io.error.put_string (" done.%N")
								save_storable_data (l_retrieved_object)
								io.error.put_string (" [!] Updated data saved.%N")

								l_dbg_info_modules := l_retrieved_object.modules_debugger_info
								l_dbg_info_project_path	:= l_retrieved_object.project_path
									--| Now the data are patched and ready to be used
							end

							dbg_info_modules.merge (l_dbg_info_modules)
							entry_point_token := l_entry_point_token
						else
								--| Update and Merge data
								--| regarding about module name
								--| since we move assemblies/precompilation module under
								--| W_code/assemblies/..
							from
								l_dbg_info_modules.start
							until
								l_dbg_info_modules.after
							loop
								l_info_module := l_dbg_info_modules.item_for_iteration
								update_imported_precompilation_info_module (a_system_name, l_info_module)
								debug ("debugger_il_info_trace")
									print (" :: Importing Module from [" + l_info_module.module_filename + "] %N")
								end
								if dbg_info_modules.has (l_info_module.module_filename) then
									dbg_info_modules.item (l_info_module.module_filename).merge (l_info_module)
								else
									dbg_info_modules.put (l_info_module, l_info_module.module_filename)
								end
								l_dbg_info_modules.forth
							end
						end
						dbg_info_class_types.merge (l_dbg_info_class_types)
					end
				end
			else
				Result := False
				loading_errors.extend ("Unable to load [" + a_fn + "]")
			end
		rescue
			retried := True
			retry
		end

	update_imported_project_info_module (a_project_path: STRING; a_info_module: IL_DEBUG_INFO_FROM_MODULE) is
			-- Update imported project module name to effective module name.
		local
			l_fn: FILE_NAME
		do
			create l_fn.make_from_string (a_project_path)
			l_fn.set_file_name (a_info_module.module_name)
				--| module_name : contains ".dll"
			a_info_module.update_module_filename (module_key (l_fn))
		end

	update_imported_precompilation_info_module (a_system_name: STRING; a_info_module: IL_DEBUG_INFO_FROM_MODULE) is
			-- Update imported precompilation module name to effective module name.
		do
			a_info_module.update_module_filename (module_key (precompilation_module_filename (a_info_module.system_name)))
		end

feature {NONE} -- Module indexer implementation

	module_key (a_mod_filename: STRING): STRING is
			-- Module key for `a_mod_filename' used for indexation
		require
			mod_name_valid: a_mod_filename /= Void and then not a_mod_filename.is_empty
		do
			Result := a_mod_filename.as_lower -- So this is a twin lowered
		ensure
			Result_valid: Result /= Void and then not Result.is_empty
		end

	internal_module_key (a_mod_key: STRING): STRING is
			-- Module key used in the internal structure.
			-- as opposed to external module key
			-- which comes from dotnet debugger
		require
			a_mod_key_not_void: a_mod_key /= Void
			a_mod_key_is_lower_case: a_mod_key.as_lower.is_equal (a_mod_key)
		local
			l_module_id: STRING
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
							l_item_mod_id.to_lower
							if l_item_mod_id.is_equal (l_module_id) then
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
			result_not_void: Result /= Void
		end
		
	internal_module_key_table: HASH_TABLE [STRING, STRING]
			-- Table to make relation between external module name, 
			-- and internal key for module

end -- class IL_DEBUG_INFO_RECORDER

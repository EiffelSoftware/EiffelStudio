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

	PROJECT_CONTEXT
		export
			{NONE} all 
		end
		
	SHARED_WORKBENCH
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
	
create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			create class_type_impl_id_by_token_and_module.make (100)
			create feature_id_by_token.make (100)
			create feature_token_by_id.make (100)
			create once_feature_tokens_by_id.make (100)
			create feature_breakable_il_line_by_id.make (100)
		end

--| Unused |--

--	reset is
--			-- Reset data.
--		do
--			class_type_impl_id_by_token_and_module.wipe_out
--			feature_id_by_token.wipe_out
--			feature_token_by_id.wipe_out
--			once_feature_tokens_by_id.wipe_out
--			feature_breakable_il_line_by_id.wipe_out
--			entry_point_token := 0
--		end
		
feature -- Access

	init_recording_session is
			-- 
		do
			last_class_type_recorded := Void
			last_module_key := Void
			last_table_cls_type_impl_id_by_token := Void
		end
		
feature -- Access

	class_type_for_module_class_token (a_module_name: STRING; a_class_token: INTEGER): CLASS_TYPE is
			-- CLASS_TYPE identified by `a_module_name' and `a_class_token'
		require
			module_name_valid: a_module_name /= Void 
								and then not a_module_name.is_empty
			token_not_null: a_class_token > 0
		local
			l_impl_id: INTEGER
		do
			l_impl_id := cls_type_implementation_id_for_module_token (a_module_name, a_class_token)
			Result := class_types @ l_impl_id
		end

	feature_token_for_feat_and_class_type (a_feat: FEATURE_I; a_class_type: CLASS_TYPE): INTEGER is
			-- Feature token identified for `a_feat'
		require
			feat_not_void: a_feat /= Void
			class_not_void: a_class_type /= Void
		do
			Result := feature_token_by_id.item (feature_token_by_id_key (a_feat, a_class_type))
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

	feature_i_by_module_class_token (a_module_name: STRING; a_class_token: INTEGER; a_feature_token: INTEGER): FEATURE_I is -- class_id, feature_id
			-- Feature_i identified by `a_module_name' , `a_class_token', and `a_feature_token'
		local
			l_class_id, l_rout_id: INTEGER
			l_feature_info: TUPLE [INTEGER, INTEGER]
			l_class_c: CLASS_C
		do
			l_feature_info := feature_id_by_token.item (feature_id_by_token_key (a_module_name, a_class_token, a_feature_token))

			if l_feature_info /= Void then
				l_class_id := l_feature_info.integer_item (1)
				l_rout_id := l_feature_info.integer_item (2)
				l_class_c := System.class_of_id (l_class_id)
				Result := l_class_c.feature_of_rout_id (l_rout_id)
			end
		end

feature -- queries

	has_class_info_about_module_class_token (a_module_name: STRING; a_class_token: INTEGER): BOOLEAN is
		require
			module_name_valid: a_module_name /= Void
								and then not a_module_name.is_empty
			token_not_null: a_class_token > 0	
		local
			l_hash_impl_id_by_token: HASH_TABLE [INTEGER, INTEGER]	
		do
			l_hash_impl_id_by_token := table_cls_type_impl_id_by_token_from_module (a_module_name)
			if l_hash_impl_id_by_token = Void then
				Result := False
			else
				Result := l_hash_impl_id_by_token.has (a_class_token)
			end
		end

	has_feature_info_about_module_class_token (a_module_name: STRING; a_class_token: INTEGER; a_feature_token: INTEGER): BOOLEAN is
			-- Do we have information for feature identified by `a_module_name' , `a_class_token', and `a_feature_token' ?
		require
			module_name_valid: a_module_name /= Void and then not a_module_name.is_empty
			class_token_not_null: a_class_token > 0
			feat_token_not_null: a_feature_token > 0
		do		
			Result := feature_id_by_token.has (feature_id_by_token_key (a_module_name, a_class_token, a_feature_token))
		end

feature -- From compiler world

	module_file_name_for_class (a_class_type: CLASS_TYPE): STRING is
			-- Computed module name for `a_class_type'
			--| we use CLASS_TYPE for the precompiled case .
		require
			class_type_not_void: a_class_type /= Void
		local
			l_type_id: INTEGER
			l_location_path: STRING
			l_assembly_name: STRING
			l_output: FILE_NAME
			l_module_name: STRING

			l_is_single_module: BOOLEAN
		do
				--| Please make sure this computing is similar to 
				--| the one inside IL_CODE_GENERATOR.il_module

--			l_is_single_module := System.in_final_mode or else Compilation_modes.is_precompiling
-- We assume, we are debugging only Workbench application for now.
			l_is_single_module := a_class_type.is_precompiled  --System.in_final_mode or else Compilation_modes.is_precompiling
			
			
			l_assembly_name := System.name
-- MEGA BIG FIX HERE !!!! how can one know if we are in wb or final ?
-- FOR NOW WE ASSUME WE DEBUG ONLY WORKBENCH PROGR
			l_location_path := Workbench_generation_path

			if l_is_single_module then
				l_type_id := 1
			else
				l_type_id :=
					a_class_type.associated_class.class_id // System.msil_classes_per_module + 1
			end

			create l_output.make_from_string (l_location_path)
			l_module_name := l_assembly_name + "_module_" + l_type_id.out + ".dll"
			l_output.set_file_name (l_module_name)
			Result := l_output
		end
		
	class_tokens_for_class (a_class: CLASS_C): LIST [INTEGER] is
			-- Return tokens related to `a_class'
			-- this computing is not related to the IL Token recording
		require
			arg_not_void: a_class /= Void
		local
			l_types: TYPE_LIST
			l_class_type: CLASS_TYPE
			l_types_cursor: CURSOR
		do
			create {LINKED_LIST [INTEGER]} Result.make
			l_types := a_class.types

			l_types_cursor := l_types.cursor
			from
				l_types.start
			until
				l_types.after
			loop
				l_class_type := l_types.item
				Result.extend (class_token_for (l_class_type))
				l_types.forth
			end
			l_types.go_to (l_types_cursor)
		ensure
			at_least_one_token: Result /= Void and then not Result.is_empty
		end		

	class_token_for (a_class_type: CLASS_TYPE): INTEGER is
			-- Class token for class type `a_class_type'
		require
			arg_class_type_not_void: a_class_type /= Void
		do
			Result := a_class_type.last_implementation_type_token
		end

feature -- To compiler world

	compiled_class_for_class_token_and_module (a_class_token: INTEGER; a_module_name: STRING): CLASS_C is
			-- Compiled CLASS_C identified by `class_token' and `a_module_name'
		require
			class_token_valid: a_class_token > 0
			module_name_valid: a_module_name /= Void and then not a_module_name.is_empty 
		local
			l_type: CLASS_TYPE
		do
			l_type:= class_type_for_module_class_token (a_module_name, a_class_token)
			if l_type /= Void then
				Result := l_type.associated_class
--			else
--				Result := Void
			end
		end
		
	class_name_for_class_token_and_module (a_class_token: INTEGER; a_module_name: STRING): STRING is
			-- Class name for CLASS_C identified by `class_token' and `a_module_name'
		require
			class_token_valid: a_class_token > 0
			module_name_valid: a_module_name /= Void and then not a_module_name.is_empty 
		local
			l_class_c: CLASS_C
		do
			l_class_c := compiled_class_for_class_token_and_module (a_class_token, a_module_name)
			if l_class_c /= Void then
				Result := l_class_c.name_in_upper
			else
				Result := "BuildInClass [token:0x" + a_class_token.to_hex_string+"]"
			end
		ensure
			class_name_ok: Result /= Void and then not Result.is_empty
		end

feature {NONE} -- Table key

	feature_id_by_token_key (a_module_name: STRING; a_class_token, a_feature_token: INTEGER): HASHABLE is
			-- Key used to index `feature_id_by_token'.
		do
			Result := module_key (a_module_name) + ":" + a_class_token.out + ":" + a_feature_token.out
--			Result := [module_key (a_module_name), a_feature_token]
		end

	feature_token_by_id_specialized_key (a_class_id: INTEGER; a_static_type_id: INTEGER; a_rout_id: INTEGER): HASHABLE is
			-- Key used to index `feature_token_by_id'.
		do
			Result := a_class_id.out + ":" + a_static_type_id.out + ":" + a_rout_id.out
--			Result := [a_class_id, a_static_type_id, a_rout_id]
		end
		
	feature_token_by_id_key (a_feat: FEATURE_I; a_class_type: CLASS_TYPE): like feature_token_by_id_specialized_key is
			-- Feature token identified for `a_feat'
		require
			feat_not_void: a_feat /= Void
			class_not_void: a_class_type /= Void
		local
			l_rout_id: INTEGER
			l_class_id: INTEGER
			l_static_type_id: INTEGER
		do
			l_rout_id := a_feat.rout_id_set.first  --FIXME: check
			l_class_id := a_class_type.associated_class.class_id
			l_static_type_id := a_class_type.static_type_id

			Result := feature_token_by_id_specialized_key (l_class_id, l_static_type_id, l_rout_id)
		end

	feature_breakable_il_line_by_id_specialized_key (a_class_id: INTEGER; a_rout_id: INTEGER): HASHABLE is
			-- Key used to index `feature_breakable_il_line_by_id'.
		do
			Result := a_class_id.out + ":" + a_rout_id.out
		end

	feature_breakable_il_line_by_id_key (a_feat_i: FEATURE_I): HASHABLE is
			-- Key used to index `feature_breakable_il_line_by_id'.
		require
			a_feat_i /= Void
		do
			Result := feature_breakable_il_line_by_id_specialized_key (a_feat_i.generation_class_id, a_feat_i.rout_id_set.first)
		ensure
			Result /= Void
		end

	once_feature_tokens_by_id_specialized_key (a_static_type_id: INTEGER; a_once_name: STRING): HASHABLE is
			-- Key used to index `once_feature_tokens_by_id'.
		local
			l_result: STRING
		do
			l_result := a_static_type_id.out + ":" + a_once_name
			l_result.to_lower
			Result := l_result
		end

	once_feature_tokens_by_id_key (a_class_type: CLASS_TYPE; a_once_name: STRING): HASHABLE is
			-- Key used to index `once_feature_tokens_by_id'.
		local
			l_static_type_id: INTEGER
		do
			l_static_type_id := a_class_type.static_type_id
			Result := once_feature_tokens_by_id_specialized_key (l_static_type_id, a_once_name)
		end

feature -- entry point token

	entry_point_token: INTEGER
			-- Token of the system entry point feature
			-- Usefull for stepping at the beginning of the execution
	
	entry_point_feature_i: FEATURE_I is
			-- System entry point feature
		local
			l_class: CLASS_C
		do
			--| Update the root class info
			l_class := System.root_class.compiled_class
			Result := l_class.feature_table.item (System.creation_name)	
		end	

feature {NONE} -- entry point token

	record_entry_point_token (a_module: STRING; a_class_token, a_feature_token: INTEGER) is
			-- Record the entry_point_token of the system.
		do
			debug ("debugger_il_info_trace")
				print ("ENTRYPOINTTOKEN_RECORDED " + a_feature_token.to_hex_string + "%N")
			end
			entry_point_token := a_feature_token
		end

	is_entry_point (a_feat: FEATURE_I): BOOLEAN is
			-- Is `a_feat' the entry point ?
		do
			Result := a_feat.feature_name.is_equal (System.creation_name) 
					and then a_feat.written_class.is_equal (System.root_class.compiled_class)
		end

feature -- line debug recording

	ignore_next_debug_info is
			-- Ignore recording of debug info (nop) for next recording
		do
			ignoring_next_debug_info := True
		end
		
	ignoring_next_debug_info: BOOLEAN
			-- Do we ignore recording of debug info (nop) for next recording ?

	last_key_for_recording_line_info: HASHABLE
			-- cache of last key for recording line info

	record_line_info (a_feat: FEATURE_I; a_il_line: INTEGER; a_eiffel_line: INTEGER;) is
			-- Record IL information regarding breakable line
		local
			l_key: HASHABLE
			l_lines_table: ARRAYED_LIST [INTEGER]
		do
			if ignoring_next_debug_info then
				ignoring_next_debug_info := False
				debug ("debugger_il_info_trace")
					print ("Ignoring line_info for " + a_feat.feature_name + " @ [IL:" + a_il_line.to_hex_string + "] [EIFFEL:" + a_eiffel_line.out + "]%N")
				end
			else
				if a_feat /= Void then
					debug ("debugger_il_info_trace")
						print (" - " + a_feat.written_class.name_in_upper + " :: NOP :: ")
						print (	a_feat.feature_name 						
								+ " Il_Line=" + a_il_line.to_hex_string
								+ " Eiffel_Line=" + a_eiffel_line.out
								+ "%N"
							)	
					end
					l_key := feature_breakable_il_line_by_id_key (a_feat)
					if 
						last_key_for_recording_line_info /= Void 
						and l_key.is_equal (last_key_for_recording_line_info) 
					then
							--| we assumes we are generating all the line info regarding a feature
							--| in the same atomic time (no other feature are processed during this time)
						check
							feature_breakable_il_line_by_id.has (l_key)
						end
					else
						last_key_for_recording_line_info := l_key
						if feature_breakable_il_line_by_id.has (l_key) then
								--| this means we are overwriting existing data...
								--| recompilation ...
							debug ("debugger_il_info_trace")
								print ("?! Clean line_info for " + a_feat.feature_name + " %N")
							end
							feature_breakable_il_line_by_id.remove (l_key)
						end
						create l_lines_table.make (a_feat.number_of_breakpoint_slots)
						feature_breakable_il_line_by_id.force (l_lines_table, l_key)							
					end
					
--					if feature_breakable_il_line_by_id.has (l_key) then
						l_lines_table := feature_breakable_il_line_by_id.item (l_key)
--					else
--						create l_lines_table.make (a_feat.number_of_breakpoint_slots)
--						feature_breakable_il_line_by_id.force (l_lines_table, l_key)
--					end
					l_lines_table.extend (a_il_line)
				end
			end
		end

feature -- line debug exploitation

	feature_eiffel_breakable_line_for_il_offset (a_feat: FEATURE_I; a_il_offset: INTEGER): INTEGER is
			-- Corresponding Eiffel Line for `a_il_offset' offset
		require
			feat_not_void: a_feat /= Void
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			l_list := feature_breakable_il_line_by_id.item (feature_breakable_il_line_by_id_key (a_feat))
			from
				l_list.start
			until
				l_list.after
				or else l_list.item > a_il_offset
			loop
				Result := l_list.index - 1 --| ARRAYED_LIST.index => 1
				l_list.forth
			end
		end

	feature_breakable_il_line_for (a_feat: FEATURE_I; a_line: INTEGER): INTEGER is
			-- IL offset for the Eiffel line number `a_line'
			-- Return -1 if index out of range
		require
			feat_not_void: a_feat /= Void
		local
			l_index: INTEGER
			l_list: ARRAYED_LIST [INTEGER]
		do
			l_index := a_line + 1
			l_list := feature_breakable_il_line_by_id.item (feature_breakable_il_line_by_id_key (a_feat))
			if l_list.valid_index (l_index) then
				Result := l_list.i_th (l_index)
			else
				Result:= -1
			end
		end

	is_il_offset_related_to_eiffel_line (a_feat: FEATURE_I; a_il_offset: INTEGER): BOOLEAN is
			-- is a_il_offset related to an Eiffel line index ?
		require
			feat_not_void: a_feat /= Void
		local
			l_list: LIST [INTEGER]
		do
			l_list := feature_breakable_il_line_by_id.item (feature_breakable_il_line_by_id_key (a_feat))
			Result := l_list.has (a_il_offset)
		end
		
	next_feature_breakable_il_offset_for (a_feat: FEATURE_I; a_il_offset: INTEGER): INTEGER is
			-- Next IL offset for the il offset `a_current_il_offset'
		require
			feat_not_void: a_feat /= Void
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			l_list := feature_breakable_il_line_by_id.item (feature_breakable_il_line_by_id_key (a_feat))
			from
				l_list.start
			until
				l_list.after
				or else Result > a_il_offset
			loop
				Result := l_list.item --| ARRAYED_LIST.index => 1
				l_list.forth
			end
		end

	next_feature_breakable_il_range_for (a_feat: FEATURE_I; a_current_il_offset: INTEGER): ARRAY [TUPLE [INTEGER, INTEGER]] is
			-- IL range offset for the Eiffel line `a_line' in the step next
		local
			l_list: ARRAYED_LIST [INTEGER]			
			l_inf, l_sup: INTEGER		
			l_interval: TUPLE[INTEGER, INTEGER]			
			i: INTEGER
		do
			l_list := feature_breakable_il_line_by_id.item (feature_breakable_il_line_by_id_key (a_feat))	
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

			debug ("DEBUGGER_EIFNET_DATA")
				if Result /= Void then
					from 
						i := Result.lower
					until
						i > Result.upper
					loop
						print (" - " + i.out + " : [" + (Result.item (i)).integer_64_item (1).out + " , " + (Result.item (i)).integer_64_item (2).out + "] %N")
						i := i + 1
					end		
				end
			end
		end
		

feature -- Recorder Once

	once_feature_tokens_for_feat_and_class_type (a_feat: FEATURE_I; a_class_type: CLASS_TYPE): TUPLE [INTEGER, INTEGER] is
			-- `_done' and `_result' Tokens for the once `a_feat'
		require
			feat_not_void: a_feat /= Void
			feat_is_once: a_feat.is_once
			class_type_not_void: a_class_type /= Void
		local
			l_once_name: STRING
		do
			l_once_name := a_feat.feature_name
			Result := once_feature_tokens_by_id.item (once_feature_tokens_by_id_key (a_class_type, l_once_name))

			if Result = Void then
				Result := [0,0]
				print ("[!] ERROR : IL_DEBUG_INFO_RECORDER.once_feature_tokens_for %N")			
			end
		ensure
			Result /= Void
		end

	record_once_info (a_class_type: CLASS_TYPE; a_once_name: STRING; a_once_done_token, a_once_result_token: INTEGER;) is
			--  Record `_done' and `_result' tokens for once `a_once_name' from `a_class_type'.
		local
			l_info_done_result: TUPLE [INTEGER, INTEGER]
			l_key: HASHABLE
		do
			l_key := once_feature_tokens_by_id_key (a_class_type, a_once_name)
			l_info_done_result := once_feature_tokens_by_id.item (l_key)
			if l_info_done_result = Void then
				l_info_done_result := [a_once_done_token, a_once_result_token]
				once_feature_tokens_by_id.put (l_info_done_result, l_key)
				if not once_feature_tokens_by_id.inserted then
					print ("CONFLICT -> "+a_class_type.associated_class.name_in_upper
							+"["+a_class_type.static_type_id.out
							+"]."+a_once_name
							+"%N"
						)
					once_feature_tokens_by_id.force (l_info_done_result, l_key)
				end
			else
				if a_once_done_token /= 0 then
					l_info_done_result.put_integer (a_once_done_token, 1)
				end
				if a_once_result_token /= 0 then
					l_info_done_result.put_integer (a_once_result_token, 2)
				end
			end
			debug ("debugger_il_info_trace")
				print ("ONCE::Record -> "
								+a_class_type.associated_class.name_in_upper
								+"["+a_class_type.static_type_id.out
								+"]."+a_once_name
								+ "%N")
			end
		end

feature -- Recorder feature and attribute

	set_record_context (a_is_attr, a_is_static, a_in_interface: BOOLEAN) is
			-- Save generation context in order to determine what to record.
		do
			is_attribute := a_is_attr
			is_static := a_is_static
			in_interface := a_in_interface
		end

	is_attribute : BOOLEAN
			-- is current generated feature is attribute ?

	is_static : BOOLEAN
			-- is current generated feature is static ?

	in_interface : BOOLEAN
			-- is current generated feature is in_interface ?

	record_il_feature_info (a_module: IL_MODULE; a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_class_token, a_feature_token: INTEGER) is
			-- Record feature information : class, feature token, and module name throught the other data.
		do
			if not in_interface then		
				if is_attribute and then is_static then
					process_il_feature_info_recording (a_module, a_class_type, a_feat, a_class_token, a_feature_token)
				elseif not is_attribute then
					if is_static then
						process_il_feature_info_recording (a_module, a_class_type, a_feat, a_class_token, a_feature_token)
						if is_entry_point (a_feat) then
							record_entry_point_token (
									module_key (a_module.module_file_name)
									, a_class_token
									, a_feature_token
								)
						end
					end
				end
			end
		end
		
feature {NONE} -- Record processing

	last_class_type_recorded: CLASS_TYPE

	process_il_feature_info_recording (a_module: IL_MODULE; a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_class_token, a_feature_token: INTEGER) is
			-- Record feature information regarding token
		require
			module_not_void: a_module /= Void
			class_type_not_void: a_class_type /= Void
			a_feat_not_void: a_feat /= Void
			token_positive: a_class_token > 0 and then a_feature_token > 0
		local
			l_feat_token, l_class_token: INTEGER
			l_module_key_name: STRING

			l_rout_id: INTEGER
			l_class_id: INTEGER

			l_key_for_feature_id_by_token: HASHABLE
			l_key_for_feature_token_by_id: HASHABLE

			l_static_type_id: INTEGER
			l_item_overwrited: BOOLEAN
			l_feat_token_to_clean: INTEGER
		do
			if ignore_feature (a_feat) then
				debug ("debugger_il_info_trace")
					print ("[!] Ignoring feature : " + a_feat.feature_name + "%N")
				end
			else
				if 
					last_class_type_recorded = Void
					or else (
						a_class_type.associated_class /= last_class_type_recorded.associated_class 
						)
				then
						-- We are going to record info for the class a_class_type.associated_class
						-- so let's clean it up first.
					clean_info_for (a_class_type.associated_class)
				end

				--| Class related
				if a_class_type /= last_class_type_recorded then
					internal_record_class_token (a_module, a_class_type, a_class_token)
					last_class_type_recorded := a_class_type
				end

--FIXME jfiat [26/06/2003]
-- We take the first one ... maybe wrong ?

				l_rout_id := a_feat.rout_id_set.first 
				l_class_id := a_class_type.associated_class.class_id
				l_static_type_id := a_class_type.static_type_id

				l_feat_token := a_feature_token
				l_class_token := a_class_token
				l_module_key_name := module_key (a_module.module_file_name)


					--=======================--
					--| feature_token_by_id |--
					--=======================--
					--|
					--| 	class_id        |
					--|  	static_type_id  |=>  feature_token
					--|  	rout_id         |

				l_key_for_feature_token_by_id := feature_token_by_id_specialized_key (l_class_id, l_static_type_id,  l_rout_id)
				l_item_overwrited := feature_token_by_id.has (l_key_for_feature_token_by_id)
				if l_item_overwrited then
						--| must be due to incremental recompilation                |--
						--| so we must remove the previous information now obsolete |--
					l_feat_token_to_clean := feature_token_by_id.item (l_key_for_feature_token_by_id)

					debug ("DEBUGGER_IL_INFO_TRACE")
						print ("!? Clean feature_id_by_token :: "+a_feat.feature_name+"%N")
					end
					l_key_for_feature_id_by_token := feature_id_by_token_key (l_module_key_name, l_class_token, l_feat_token_to_clean)
					feature_id_by_token.remove (l_key_for_feature_id_by_token)
				end
				feature_token_by_id.force (a_feature_token, l_key_for_feature_token_by_id)
				debug ("DEBUGGER_IL_INFO_TRACE")
					if l_item_overwrited then
						print ("Check feature_token_by_id :: CONFLICT <"+l_static_type_id.out+">["+a_class_type.associated_class.name_in_upper + "." + a_feat.feature_name+"] %N")
						print ("%T - ATTR="+is_attribute.out+" %T IS_STATIC="+is_static.out+" %T IN_INTERFACE="+in_interface.out+" %N")
						print ("%T - key     = " + l_key_for_feature_token_by_id.out + "%N")
						print ("%T - Already = 0x"+feature_token_by_id.item (l_key_for_feature_token_by_id).to_hex_string +" %N")				
						print ("%T - Cancel  = 0x"+a_feature_token.to_hex_string +" %N")				
					else
						print ("Check feature_token_by_id :: INSERTED <"+l_static_type_id.out+">["+a_class_type.associated_class.name_in_upper + "." + a_feat.feature_name+"] %N")
						print ("%T - ATTR="+is_attribute.out+" %T IS_STATIC="+is_static.out+" %T IN_INTERFACE="+in_interface.out+" %N")
						print ("%T - key     = " + l_key_for_feature_token_by_id.out + "%N")
						print ("%T - Insert  = 0x"+a_feature_token.to_hex_string +" %N")				
					end
				end

					--=======================--
					--| feature_id_by_token |--
					--=======================--
					--|
					--| 	module         |
					--|  	class_token	   |=>  class_id :: rout_id
					--|  	feature_token  |
				
				l_key_for_feature_id_by_token := feature_id_by_token_key (l_module_key_name, l_class_token, l_feat_token)
				l_item_overwrited := feature_id_by_token.has (l_key_for_feature_id_by_token)
				feature_id_by_token.force ([l_class_id, l_rout_id], l_key_for_feature_id_by_token )

				debug ("DEBUGGER_IL_INFO_TRACE")
					if l_item_overwrited then
						print ("Check feature_id_by_token :: CONFLICT <"+l_static_type_id.out+">["+a_class_type.associated_class.name_in_upper + "." + a_feat.feature_name+"] %N")
						print ("%T - ATTR="+is_attribute.out+" %T IS_STATIC="+is_static.out+" %T IN_INTERFACE="+in_interface.out+" %N")
						print ("%T - key     = " + l_key_for_feature_id_by_token.out + "%N")
						print ("%T - Already = " + feature_id_by_token.item (l_key_for_feature_id_by_token).out + "N")
						print ("%T - Cancel  = class_id=0x"+l_class_id.out + "%T rout_id=0x" + l_rout_id.out +" %N")				
					else
						print ("Check feature_id_by_token :: INSERTED <"+l_static_type_id.out+">["+a_class_type.associated_class.name_in_upper + "." + a_feat.feature_name+"] %N")
						print ("%T - ATTR="+is_attribute.out+" %T IS_STATIC="+is_static.out+" %T IN_INTERFACE="+in_interface.out+" %N")
						print ("%T - key     = " + l_key_for_feature_id_by_token.out + "%N")
						print ("%T - Cancel  = class_id=0x"+l_class_id.out + "%T rout_id=0x" + l_rout_id.out +" %N")				
					end
				end
			end
		end

feature -- Ignore feature 

	ignore_feature (a_feat: FEATURE_I): BOOLEAN is
			-- Ignore non Eiffel feature name 
			-- for now, ignore all '^_.*' feature_name
		do
			Result := a_feat.feature_name.item(1).is_equal ('_')
		end

feature {SHARED_IL_DEBUG_INFO_RECORDER} -- Persistence

	save is
			-- Save info into file.
		local
			l_il_info_file: RAW_FILE	
			l_data_to_save: TUPLE[ANY,ANY,ANY,ANY,ANY, INTEGER]
		do
			debug ("debugger_il_info_trace")
				print ("Saving IL Tokens %N")
			end
			
				--| class_token : feature_token -- classname : feature_name
			create l_il_info_file.make_create_read_write (Il_info_file_name)
			l_data_to_save := [
								class_type_impl_id_by_token_and_module, 
								feature_id_by_token, 
								feature_token_by_id,
								once_feature_tokens_by_id,
								feature_breakable_il_line_by_id,
								entry_point_token
							]
			l_il_info_file.independent_store (l_data_to_save)
			l_il_info_file.close
		end

	load is
			-- Load info from saved file.
		local
			l_il_info_file: RAW_FILE
			l_data_to_save: TUPLE[ANY,ANY,ANY,ANY,ANY, INTEGER]
			retried: BOOLEAN
		do
			debug ("debugger_il_info_trace")
				print ("Loading IL Tokens (retry:" + retried.out + ") %N")
			end
			if not retried then
				create l_il_info_file.make (Il_info_file_name)
				if not l_il_info_file.exists then
						-- Create new arguments file.
					l_il_info_file.create_read_write
					l_il_info_file.close					
				else
					l_il_info_file.open_read
					l_data_to_save ?= l_il_info_file.retrieved
					l_il_info_file.close					
					
					class_type_impl_id_by_token_and_module ?= l_data_to_save.item (1)
					feature_id_by_token ?= l_data_to_save.item (2)
					feature_token_by_id ?= l_data_to_save.item (3)			
					once_feature_tokens_by_id ?= l_data_to_save.item (4)			
					feature_breakable_il_line_by_id ?= l_data_to_save.item (5)			
					entry_point_token := l_data_to_save.integer_item (6)			
				end
				
			else
				io.put_string ("ERROR: Unable to load IL INFO data from file [" + Il_info_file_name + "]%N")
			end
		rescue
			retried := True
			retry
		end

	Il_info_file_name: FILE_NAME is
			-- Filename for IL info storage
		once
			create Result.make_from_string (Workbench_generation_path)
			Result.set_file_name ("il_info.eid");
		end	

feature {NONE} -- Specific info

	class_types: ARRAY [CLASS_TYPE] is
			-- List all class types in system indexed using both `implementation_id' and
			-- `static_type_id'.
		local
			i, nb: INTEGER
			l_class_type: CLASS_TYPE
			l_class_types: ARRAY [CLASS_TYPE]
		do
			Result := internal_class_types
			if Result = Void then
					-- Collect all class types in system and initialize `internal_class_types'.
				from
					l_class_types := System.class_types
					i := l_class_types.lower
					nb := l_class_types.upper
					create Result.make (0, System.Static_type_id_counter.count)
				until
					i > nb
				loop
					l_class_type := l_class_types.item (i)
					if l_class_type /= Void then
						Result.put (l_class_type, l_class_type.static_type_id)
						Result.put (l_class_type, l_class_type.implementation_id)
					end
					i := i + 1
				end
				internal_class_types := Result
			end
		ensure
			class_types_not_void: Result /= Void
			class_types_not_empty: Result.count > 0
		end

	internal_class_types: ARRAY [CLASS_TYPE]
			-- Array of CLASS_TYPE in system indexed by `implementation_id' and
			-- `static_type_id' of CLASS_TYPE.

feature {NONE} -- Class Specific info

	internal_record_class_token (a_module: IL_MODULE; a_class_type: CLASS_TYPE; a_class_token: INTEGER) is
			-- Record class information regarding token
		require
			module_not_void: a_module /= Void
			class_type_not_void: a_class_type /= Void
			class_token_positive: a_class_token > 0
		local
			l_module_filename: STRING
		do
			l_module_filename := a_module.module_file_name
			internal_record_class_token_with_module_filename (l_module_filename, a_class_type, a_class_token)
		end
		
	internal_record_class_token_with_module_filename (a_module_file_name: STRING; a_class_type: CLASS_TYPE; a_class_token: INTEGER) is
			-- Record class information regarding token and module_file_name
		require
			module_file_name_valid: a_module_file_name /= Void 
									and then not a_module_file_name.is_empty
			class_type_not_void: a_class_type /= Void
			class_token_positive: a_class_token > 0
		local
			l_class_id_by_token: HASH_TABLE [INTEGER, INTEGER]
			l_cl_type_impl_id: INTEGER
		do
			l_class_id_by_token := table_cls_type_impl_id_by_token_from_module (a_module_file_name)
			l_cl_type_impl_id := a_class_type.implementation_id

			if not l_class_id_by_token.has (a_class_token) then
					--| New entry
				l_class_id_by_token.put (l_cl_type_impl_id, a_class_token)
			else
				if l_class_id_by_token.item (a_class_token) /= l_cl_type_impl_id then
						--| What the hell ? same id .. but not same content ?
						--| the last one is the good one
					print ("ERROR : class type_id/token CONFLICT : " + a_class_token.out +" => "+ l_cl_type_impl_id.out + " ? " + l_class_id_by_token.item (a_class_token).out+ "%N")
					l_class_id_by_token.force (l_cl_type_impl_id, a_class_token)
				end
			end

			debug ("DEBUGGER_IL_INFO_TRACE")
				print ("INSERTED ClassToken " + a_class_token.to_hex_string + " <=> " + a_class_type.associated_class.name_in_upper + "%N")
--				print ("%T - ATTR="+is_attribute.out+" %T IS_STATIC="+is_static.out+" %T IN_INTERFACE="+in_interface.out+" %N")
				print ("%T - MODULE = ["+a_module_file_name+"]%N")
			end

		end		

feature {NONE} -- Internal access

	module_key (a_mod_name: STRING): STRING is
			-- Module key for `a_mod_name' used for indexation
		require
			mod_name_valid: a_mod_name /= Void and then not a_mod_name.is_empty
		do
			Result := clone (a_mod_name)
			Result.to_lower
		ensure
			Result_valid: Result /= Void and then not Result.is_empty
		end

	last_module_key: STRING
			-- Last computed module_key

	last_table_cls_type_impl_id_by_token: HASH_TABLE [INTEGER, INTEGER]
			-- Last table of class_type_impl_id_by_token used

	table_cls_type_impl_id_by_token_from_module (a_module_name: STRING): like last_table_cls_type_impl_id_by_token is
			-- Hash Table containing the class_type_id indexed by token 
			-- for module `a_module_name'.
		require
			module_name_valid: a_module_name /= Void and then not a_module_name.is_empty
		local
			l_key: STRING
		do
			l_key := module_key (a_module_name)
			if last_module_key /= Void and then last_module_key.is_equal (l_key) then
				Result := last_table_cls_type_impl_id_by_token
			else
				last_module_key := l_key
				if class_type_impl_id_by_token_and_module.has (l_key) then
					Result := class_type_impl_id_by_token_and_module.item (l_key)
				else
					create Result.make (1)
					class_type_impl_id_by_token_and_module.put (Result, l_key)
				end
				last_table_cls_type_impl_id_by_token := Result
			end
		end

	cls_type_implementation_id_for_module_token (a_module_name: STRING; a_class_token: INTEGER): INTEGER is
			-- Class type id for class_token `inside' module `a_module_name'
		require
			module_name_valid: a_module_name /= Void 
								and then not a_module_name.is_empty
			token_not_null: a_class_token > 0
		local
			l_hash_impl_id_by_token: HASH_TABLE [INTEGER, INTEGER]
		do
			l_hash_impl_id_by_token := table_cls_type_impl_id_by_token_from_module (a_module_name)
			if l_hash_impl_id_by_token.has (a_class_token) then
				Result := l_hash_impl_id_by_token.item (a_class_token)
			end
--		ensure
--			class_type_impl_id_not_null: Result /= 0
		end

feature {NONE} -- Cleaning

	clean_info_for (a_class_c: CLASS_C) is
			-- Clean stored info about `a_class_c'
		require
			class_c_not_void: a_class_c /= Void
		local
			f_table: FEATURE_TABLE
			l_feat_i: FEATURE_I
			l_class_token: INTEGER
			l_feat_token: INTEGER
			l_class_types: TYPE_LIST
			l_class_type: CLASS_TYPE
			l_feat_cursor: CURSOR
			l_class_cursor: CURSOR

			l_module_name: STRING
			l_feature_id_by_token_key: HASHABLE
			l_feature_token_by_id_key: HASHABLE
			l_once_feature_tokens_by_id_key: HASHABLE
			l_feature_breakable_il_line_by_id_key: HASHABLE
			l_static_type_id, l_class_id: INTEGER
			l_root_id: INTEGER
			l_feature_info: TUPLE [INTEGER, INTEGER]
		do
			f_table := a_class_c.feature_table
			l_class_types := a_class_c.types

			l_feat_cursor := f_table.cursor
			from
				f_table.start
			until
				f_table.after
			loop
				l_feat_i := f_table.item_for_iteration
				if l_feat_i.written_class = a_class_c then
					debug ("debugger_il_info_trace")
						print ("Cleaning for " + a_class_c.name_in_upper + "." + l_feat_i.feature_name + "%N")
					end

					l_class_cursor := l_class_types.cursor
					from
						l_class_types.start
					until
						l_class_types.after
					loop
						l_class_type := l_class_types.item
						l_feat_token := feature_token_for_feat_and_class_type (l_feat_i, l_class_type)
						if l_feat_token > 0 then
								--| Otherwise this means this is a new feature

							l_static_type_id := l_class_type.static_type_id
							l_class_token := class_token_for (l_class_type)
							l_module_name := module_file_name_for_class (l_class_type)

							debug ("debugger_il_info_trace")
								print ("  " + l_class_type.full_il_type_name + " => " + l_feat_token.to_hex_string + "%N")
							end

								--| CLEAN class_type_impl_id_by_token_and_module
								--|		HashTable[class_type_id, class_token ] <= module_name

								-- No Need to clean this

								--| CLEAN feature_id_by_token
								--|		[class_id, root_id] <= [module_name, feature_token]
							l_feature_id_by_token_key := feature_id_by_token_key (l_module_name, l_class_token, l_feat_token)
							if feature_id_by_token.has (l_feature_id_by_token_key) then
								l_feature_info := feature_id_by_token.item (l_feature_id_by_token_key)
								l_class_id := l_feature_info.integer_item (1)
								l_root_id := l_feature_info.integer_item (2)
								feature_id_by_token.remove (l_feature_id_by_token_key)
								debug ("debugger_il_info_trace")
									if not feature_id_by_token.removed then
										print ("[WARNING] feature " + l_feat_i.feature_name + " was not removed from <feature_id_by_token> !%N")
									end
								end
							end

								--| CLEAN feature_token_by_id
								--|		[feature_token] <= [class_id, rout_id]

							l_feature_token_by_id_key := feature_token_by_id_specialized_key (l_class_id, l_static_type_id, l_root_id)

							if feature_token_by_id.has (l_feature_token_by_id_key) then
								feature_token_by_id.remove (l_feature_token_by_id_key)
								debug ("debugger_il_info_trace")
									if not feature_token_by_id.removed then
										print ("[WARNING] feature " + l_feat_i.feature_name + " was not removed from <feature_token_by_id> !%N")
									end
								end
							end

								--| CLEAN once_feature_tokens_by_id
								--|		feature_tokens[_done|_result] <= [class_id, rout_id]

							if l_feat_i.is_once then
								l_once_feature_tokens_by_id_key := once_feature_tokens_by_id_specialized_key (l_static_type_id, l_feat_i.feature_name)
								if once_feature_tokens_by_id.has (l_once_feature_tokens_by_id_key) then
									once_feature_tokens_by_id.remove (l_once_feature_tokens_by_id_key)
									debug ("debugger_il_info_trace")
										if not once_feature_tokens_by_id.removed then
											print ("[WARNING] once feature " + l_feat_i.feature_name + " was not removed from <once_feature_tokens_by_id> !%N")
										end
									end
								end
							end

								--| CLEAN feature_breakable_il_line_by_id
								--|		[List [Line IL] ] <= [class_id, rout_id]

							l_feature_breakable_il_line_by_id_key := feature_breakable_il_line_by_id_key (l_feat_i)
							if feature_breakable_il_line_by_id.has (l_feature_breakable_il_line_by_id_key) then
								feature_breakable_il_line_by_id.remove (l_feature_breakable_il_line_by_id_key)
								debug ("debugger_il_info_trace")
									if not feature_breakable_il_line_by_id.removed then
										print ("[WARNING] feature " + l_feat_i.feature_name + " was not removed from <feature_breakable_il_line_by_id> !%N")
									end
								end
							end
						end
						l_class_types.forth
					end
					l_class_types.go_to (l_class_cursor)

				end
				f_table.forth
			end
			f_table.go_to (l_feat_cursor)
		end

feature {NONE} -- Debugger Info List

	class_type_impl_id_by_token_and_module: HASH_TABLE [HASH_TABLE [INTEGER, INTEGER], STRING] 
			-- HashTable[class_type_id, class_token ] <= module_name

	feature_id_by_token: HASH_TABLE [TUPLE [INTEGER,INTEGER] , HASHABLE] 
			-- [class_id, root_id] <= [module_name, feature_token]

feature {NONE} -- eStudio Info List

	feature_token_by_id: HASH_TABLE [INTEGER, HASHABLE] 
			-- [feature_token] <= [class_id, static_type_id, rout_id]

	once_feature_tokens_by_id: HASH_TABLE [TUPLE [INTEGER, INTEGER], HASHABLE] 
			-- feature_tokens[_done|_result] <= [static_type_id, rout_id]

	feature_breakable_il_line_by_id: HASH_TABLE [ARRAYED_LIST[INTEGER], HASHABLE] 
			-- [List [Line IL] ] <= [class_id, rout_id]

end -- class IL_DEBUG_INFO_RECORDER



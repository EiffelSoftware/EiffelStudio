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

	SHARED_IL_DEBUG_INFO
		export
			{NONE} all
		end

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
			create modules_debugger_info.make (50)
			create class_types_debugger_info.make (100)
		end

feature -- Access

	is_debug_info_enabled: BOOLEAN
			-- Are we generating debug information?

	init_recording_session is
			-- 
		do
			Il_debug_info.reset
			is_debug_info_enabled := True
			last_class_type_recorded := Void

			last_info_from_class_type := Void
			last_info_from_module := Void
		end
		
feature -- Access from debugger

	has_class_info_about_module_class_token (a_module_name: STRING; a_class_token: INTEGER): BOOLEAN is
		require
			module_name_valid: a_module_name /= Void
								and then not a_module_name.is_empty
			token_not_null: a_class_token /= 0	
		local
			l_info_from_module: IL_DEBUG_INFO_FROM_MODULE
		do
			l_info_from_module := info_from_module (a_module_name, False)
			if l_info_from_module /= Void then
				Result := l_info_from_module.know_class_from_token (a_class_token)
			end
		end

	class_type_for_module_class_token (a_module_name: STRING; a_class_token: INTEGER): CLASS_TYPE is
			-- CLASS_TYPE identified by `a_module_name' and `a_class_token'
		require
			module_name_valid: a_module_name /= Void 
								and then not a_module_name.is_empty
			token_not_null: a_class_token /= 0
		local
			l_info_from_module: IL_DEBUG_INFO_FROM_MODULE
		do
			l_info_from_module := info_from_module (a_module_name, False)
			if l_info_from_module /= Void then
				Result := l_info_from_module.class_type_for_token (a_class_token)
			end
		end


	has_feature_info_about_module_class_token (a_module_name: STRING; a_class_token: INTEGER; a_feature_token: INTEGER): BOOLEAN is
			-- Do we have information for feature identified by `a_module_name' , `a_class_token', and `a_feature_token' ?
		require
			module_name_valid: a_module_name /= Void and then not a_module_name.is_empty
			class_token_not_null: a_class_token > 0
			feat_token_not_null: a_feature_token > 0
		local
			l_info_from_module: IL_DEBUG_INFO_FROM_MODULE
		do		
			l_info_from_module := info_from_module (a_module_name, False)
			if l_info_from_module /= Void then
				Result := l_info_from_module.know_feature_from_token (a_feature_token)
			end
		end

	feature_i_by_module_class_token (a_module_name: STRING; a_class_token: INTEGER; a_feature_token: INTEGER): FEATURE_I is -- class_id, feature_id
			-- Feature_i identified by `a_module_name' , `a_class_token', and `a_feature_token'
			--| FIXME jfiat [2003/10/13 - 14:16]: a_class_token is useless
			--| since in a ICorDebugModule feature_token are unique
		local
			l_info_from_module: IL_DEBUG_INFO_FROM_MODULE
		do
			l_info_from_module := info_from_module (a_module_name, False)
			if l_info_from_module /= Void then
				Result := l_info_from_module.feature_i_for_token (a_feature_token)
			end
		end

feature -- Access from eStudio

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
				l_type_id := a_class_type.associated_class.class_id // System.msil_classes_per_module + 1
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
			if is_debug_info_enabled then
				debug ("debugger_il_info_trace")
					print ("EntryPointToken_Recorded " + a_feature_token.to_hex_string + "%N")
				end
				entry_point_token := a_feature_token
			end
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

	record_line_info (a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_il_line: INTEGER; a_eiffel_line: INTEGER;) is
			-- Record IL information regarding breakable line
		require
			feat_not_void: a_feat /= Void
		local
			l_info_from_class_type: IL_DEBUG_INFO_FROM_CLASS_TYPE
		do
			if is_debug_info_enabled then			
				if ignoring_next_debug_info then
					ignoring_next_debug_info := False
--				elseif a_feat /= Void then --FIXME: JFIAT
				else
					
					debug ("debugger_il_info_trace")
						print (" - " + a_feat.written_class.name_in_upper + " :: NOP :: ")
						print (	a_feat.feature_name 						
								+ " Il_Line=" + a_il_line.to_hex_string
								+ " Eiffel_Line=" + a_eiffel_line.out
								+ "%N"
							)
					end

					l_info_from_class_type := info_from_class_type (a_class_type, True)
					l_info_from_class_type.record_add_line_info (a_feat, a_il_line, a_eiffel_line)
				end
			end
		end

feature {NONE} -- line debug recording Implementation
		
	ignoring_next_debug_info: BOOLEAN
			-- Do we ignore recording of debug info (nop) for next recording ?

feature -- line debug exploitation

	feature_breakable_il_offsets (a_class_type: CLASS_TYPE; a_feat: FEATURE_I): ARRAYED_LIST [INTEGER] is
			-- List of breakable IL Offset for `a_feat'
		require
			feat_not_void: a_feat /= Void
		local
			l_info_from_class_type: IL_DEBUG_INFO_FROM_CLASS_TYPE
		do
			l_info_from_class_type := info_from_class_type (a_class_type, False)
			if l_info_from_class_type /= Void then
				Result := l_info_from_class_type.breakable_il_offsets (a_feat)
			end
		end
		
	feature_eiffel_breakable_line_for_il_offset (a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_il_offset: INTEGER): INTEGER is
			-- Corresponding Eiffel Line for `a_il_offset' offset
		require
			feat_not_void: a_feat /= Void
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			l_list := feature_breakable_il_offsets (a_class_type, a_feat)
			if l_list /= Void then
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
		end

	feature_breakable_il_line_for (a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_line: INTEGER): INTEGER is
			-- IL offset for the Eiffel line number `a_line'
			-- Return -1 if index out of range
		require
			feat_not_void: a_feat /= Void
		local
			l_index: INTEGER
			l_list: ARRAYED_LIST [INTEGER]
		do
			l_index := a_line + 1
			l_list := feature_breakable_il_offsets (a_class_type, a_feat)
			
			if l_list.valid_index (l_index) then
				Result := l_list.i_th (l_index)
			else
				Result:= -1
			end
		end

	is_il_offset_related_to_eiffel_line (a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_il_offset: INTEGER): BOOLEAN is
			-- is a_il_offset related to an Eiffel line index ?
		require
			feat_not_void: a_feat /= Void
		local
			l_list: LIST [INTEGER]
		do
			l_list := feature_breakable_il_offsets (a_class_type, a_feat)
			Result := l_list.has (a_il_offset)
		end
		
	next_feature_breakable_il_offset_for (a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_il_offset: INTEGER): INTEGER is
			-- Next IL offset for the il offset `a_current_il_offset'
		require
			feat_not_void: a_feat /= Void
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			l_list := feature_breakable_il_offsets (a_class_type, a_feat)			
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

	next_feature_breakable_il_range_for (a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_current_il_offset: INTEGER): ARRAY [TUPLE [INTEGER, INTEGER]] is
			-- IL range offset for the Eiffel line `a_line' in the step next
		local
			l_list: ARRAYED_LIST [INTEGER]			
			l_inf, l_sup: INTEGER		
			l_interval: TUPLE[INTEGER, INTEGER]			
			i: INTEGER
		do
			l_list := feature_breakable_il_offsets (a_class_type, a_feat)			
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
						print (" - " + i.out + " : [" + (Result.item (i)).integer_item (1).out + " , " + (Result.item (i)).integer_item (2).out + "] %N")
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
			l_info_from_class_type: IL_DEBUG_INFO_FROM_CLASS_TYPE
		do

			l_info_from_class_type := info_from_class_type (a_class_type, False)
			if l_info_from_class_type /= Void then
				Result := l_info_from_class_type.once_tokens (a_feat)
			end
--			if Result = Void then
--				Result := [0,0]
--				print ("[!] ERROR : IL_DEBUG_INFO_RECORDER.once_feature_tokens_for %N")			
--			end
--		ensure
--			Result /= Void
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
				l_info_from_class_type := info_from_class_type (a_class_type, True)
				l_info_from_class_type.record_once_tokens (a_once_done_token, a_once_result_token, a_feature)
			end
		end

feature {NONE} -- Record context

	is_attribute : BOOLEAN
			-- is current generated feature is attribute ?

	is_static : BOOLEAN
			-- is current generated feature is static ?

	in_interface : BOOLEAN
			-- is current generated feature is in_interface ?

feature -- Recorder feature and attribute

	set_record_context (a_is_attr, a_is_static, a_in_interface: BOOLEAN) is
			-- Save generation context in order to determine what to record.
		do
			is_attribute := a_is_attr
			is_static := a_is_static
			in_interface := a_in_interface
		end
		
	record_il_feature_info (a_module: IL_MODULE; a_class_type: CLASS_TYPE; a_feat: FEATURE_I; a_class_token, a_feature_token: INTEGER) is
			-- Record feature information : class, feature token, and module name throught the other data.
		do
			if is_debug_info_enabled then
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
		end
		
feature {NONE} -- Record processing

	last_class_type_recorded: CLASS_TYPE

	ignore_feature (a_feat: FEATURE_I): BOOLEAN is
			-- Ignore non Eiffel feature name 
			-- for now, ignore all '^_.*' feature_name
		do
			Result := a_feat.feature_name.item(1).is_equal ('_')
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

					--| Record `feature_i' indexed by `feature_token'
				l_info_from_module := info_from_module (a_module.module_file_name, True)
				l_info_from_module.record_feature_i (a_class_type, a_feature, a_feature_token)

					--| Record `feature_token' indexed by `feature_i'
				l_info_from_class_type := info_from_class_type (a_class_type, True)
				l_info_from_class_type.record_feature_token (a_feature_token, a_feature)
			end
		end

feature {SHARED_IL_DEBUG_INFO_RECORDER} -- Persistence

	save is
			-- Save info into file.
		local
			l_il_info_file: RAW_FILE	
			l_data_to_save: TUPLE[ANY,ANY,INTEGER]
		do
			if is_debug_info_enabled then
				debug ("debugger_il_info_trace")
					print ("Saving IL Tokens %N")
				end
				
					--| class_token : feature_token -- classname : feature_name
				create l_il_info_file.make_create_read_write (Il_info_file_name)
				l_data_to_save := [
									modules_debugger_info, 
									class_types_debugger_info,
									entry_point_token
								]
				l_il_info_file.independent_store (l_data_to_save)
				l_il_info_file.close
			end
		end

	load is
			-- Load info from saved file.
		local
			l_il_info_file: RAW_FILE
			l_data_to_save: TUPLE[ANY,ANY,INTEGER]
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
					
					modules_debugger_info ?= l_data_to_save.item (1)
					class_types_debugger_info ?= l_data_to_save.item (2)
					entry_point_token := l_data_to_save.integer_item (3)			
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

feature {NONE} -- Class Specific info

	internal_record_class_token (a_module: IL_MODULE; a_class_type: CLASS_TYPE; a_class_token: INTEGER) is
			-- Record class information regarding token
		require
			module_not_void: a_module /= Void
			class_type_not_void: a_class_type /= Void
			class_token_positive: a_class_token > 0
		do
			internal_record_class_type (a_module.module_file_name, a_class_type, a_class_token)
		end
		
	internal_record_class_type (a_module_name: STRING; a_class_type: CLASS_TYPE; a_class_token: INTEGER) is
				--| New mecanism
		local
			l_info: IL_DEBUG_INFO_FROM_MODULE
		do
			l_info := info_from_module (a_module_name, True)
			l_info.record_class_type (a_class_type, a_class_token)
		ensure
			modules_debugger_info.has (module_key (a_module_name))
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

feature {IL_CODE_GENERATOR} -- Cleaning

	clean_class_type_info_for (a_class_type: CLASS_TYPE) is
		local
			l_class_type: CLASS_TYPE
			l_class_c: CLASS_C
			l_info_from_class_type: IL_DEBUG_INFO_FROM_CLASS_TYPE
			l_info_from_module: IL_DEBUG_INFO_FROM_MODULE
			l_feat_token: INTEGER
			l_feat_table: FEATURE_TABLE
			l_feat_cursor: CURSOR
			l_feat_i: FEATURE_I
		do
			l_class_type := a_class_type
			l_class_c := l_class_type.associated_class

			l_feat_table := l_class_type.associated_class.feature_table
			l_feat_cursor := l_feat_table.cursor
			from
				l_feat_table.start
			until
				l_feat_table.after
			loop
				l_feat_i := l_feat_table.item_for_iteration

				if l_feat_i.written_class = l_class_c then
					debug ("debugger_il_info_trace")
						print ("Cleaning for " + l_class_c.name_in_upper + "." + l_feat_i.feature_name + "%N")
					end
			
					l_feat_token := feature_token_for_feat_and_class_type (l_feat_i, l_class_type)
					if l_feat_token > 0 then
							--| Otherwise this means this is a new feature

						l_info_from_module := info_from_module (module_file_name_for_class (l_class_type), False)
						if l_info_from_module /= Void then

								--| CLEAN class_type_impl_id_by_token_and_module
								--|		HashTable[class_type_id, class_token ] <= module_name
								-- No Need to clean the CLASS info

								--| CLEAN feature_id_by_token
								--|		[class_id, root_id] <= [module_name, feature_token]

							if l_info_from_module.know_feature_from_token (l_feat_token) then
								l_info_from_module.clean_feature_token (l_feat_token)
							end
						end

						l_info_from_class_type := info_from_class_type (l_class_type, False)
						if l_info_from_class_type /= Void then
								--| CLEAN feature_token_by_id
								--|		[feature_token] <= [class_id, rout_id]
							if l_info_from_class_type.know_feature_token_from_feature (l_feat_i) then
								l_info_from_class_type.clean_feature_token (l_feat_i)
							end


								--| CLEAN once_feature_tokens_by_id
								--|		feature_tokens[_done|_result] <= [class_id, rout_id]
							if l_info_from_class_type.know_once_tokens_from_feature (l_feat_i) then
								l_info_from_class_type.clean_once_tokens (l_feat_i)
							end

								--| CLEAN feature_breakable_il_line_by_id
								--|		[List [Line IL] ] <= [class_id, rout_id]
							if l_info_from_class_type.know_il_offset_from_feature (l_feat_i) then
								l_info_from_class_type.clean_breakable_il_offset (l_feat_i)
							end
						end
					end
				end
				l_feat_table.forth
			end
			l_feat_table.go_to (l_feat_cursor)
		end

	clean_info_for (a_class_c: CLASS_C) is
			-- Clean stored info about `a_class_c'
		require
			class_c_not_void: a_class_c /= Void
		local
			l_class_types: TYPE_LIST
			l_class_type: CLASS_TYPE
			l_class_cursor: CURSOR
		do
			l_class_types := a_class_c.types
			l_class_cursor := l_class_types.cursor
			from
				l_class_types.start
			until
				l_class_types.after
			loop
				l_class_type := l_class_types.item
				clean_class_type_info_for (l_class_type)
				l_class_types.forth
			end
			l_class_types.go_to (l_class_cursor)
		end

feature {NONE} -- Debugger Info List Access

	last_info_from_class_type: like info_from_class_type
			-- Last IL_DEBUG_INFO_FROM_CLASS_TYPE used
	
	info_from_class_type (a_class_type: CLASS_TYPE; a_create_if_not_found: BOOLEAN): IL_DEBUG_INFO_FROM_CLASS_TYPE is
			-- Info from Class_type
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
				Result := class_types_debugger_info.item (l_class_static_type_id)
				if a_create_if_not_found and Result = Void then
					create Result.make (l_class_static_type_id)
					class_types_debugger_info.put (Result, l_class_static_type_id)
				end
				last_info_from_class_type := Result
			end
		ensure
			(Result = Void) implies (not a_create_if_not_found)
		end

	last_info_from_module: like info_from_module
 			-- Last IL_DEBUG_INFO_FROM_MODULE used

	info_from_module (a_module_name: STRING; a_create_if_not_found: BOOLEAN): IL_DEBUG_INFO_FROM_MODULE is
			-- Info from Module_name
		local
			l_module_key: STRING
		do
			l_module_key := module_key (a_module_name)
			if 
				last_info_from_module /= Void and then
				last_info_from_module.module_name.is_equal (l_module_key)
			then
				Result := last_info_from_module
			else			
				Result := modules_debugger_info.item (l_module_key)
				if a_create_if_not_found and Result = Void then
					create Result.make (l_module_key)
					modules_debugger_info.put (Result, l_module_key)
				end
				last_info_from_module := Result
			end
		ensure
			(Result = Void) implies (not a_create_if_not_found)
		end

feature {NONE} -- Debugger Info List

	modules_debugger_info: HASH_TABLE [IL_DEBUG_INFO_FROM_MODULE, STRING]
			-- [module_key] => [IL_DEBUG_INFO_FROM_MODULE]

	class_types_debugger_info: HASH_TABLE [IL_DEBUG_INFO_FROM_CLASS_TYPE, INTEGER]
			-- [CLASS_TYPE.static_type_id] => [IL_DEBUG_INFO_FROM_CLASS_TYPE]

end -- class IL_DEBUG_INFO_RECORDER


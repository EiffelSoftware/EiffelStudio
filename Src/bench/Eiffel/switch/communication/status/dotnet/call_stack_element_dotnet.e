indexing
	description	: "Information about a call in the calling stack."
	date		: "$Date$"
	revision	: "$Revision $"

class CALL_STACK_ELEMENT_DOTNET

inherit
	
	CALL_STACK_ELEMENT

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	DEBUG_VALUE_EXPORTER
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end
		
	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end	

	SHARED_EIFNET_DEBUG_VALUE_FACTORY
		export
			{NONE} all
		end
		
	ICOR_EXPORTER -- debug trace purpose
		export
			{NONE} all
		end		

create {EIFFEL_CALL_STACK}
	make
--create {APPLICATION_EXECUTION_DOTNET}
--	dummy_make

feature {NONE} -- Initialization

	make (level: INTEGER) is
		do
			level_in_stack := level
			private_body_index := -1
		end

feature -- Filling

	set_routine (a_chain: ICOR_DEBUG_CHAIN; a_frame_il: ICOR_DEBUG_IL_FRAME; melted: BOOLEAN; a_address: STRING; 
			a_dyn_type: CLASS_TYPE; a_org_class: CLASS_C; 
			a_feature: FEATURE_I; a_line_number: INTEGER) is
		do
			icd_chain := a_chain
			icd_chain.add_ref
			
			icd_il_frame := a_frame_il
			icd_il_frame.add_ref
			
			il_offset := icd_il_frame.get_ip
			
			dynamic_type := a_dyn_type
			if dynamic_type /= Void then
				dynamic_class := dynamic_type.associated_class	
			end
			if a_org_class /= Void then
				origin_class := a_org_class
			else
				origin_class := dynamic_class
			end
			break_index := a_line_number

			object_address := a_address
			display_object_address := object_address
			if display_object_address.is_equal ("0x00000000") then
				display_object_address := "Unavailable"
			end

			is_melted := melted
			routine_name := a_feature.feature_name
			routine := a_feature.e_feature
			private_body_index := -1
		end
		
feature -- Cleaning

	clean is
			-- Clean stored data
		do
-- FIXME jfiat 2004-07-07 : seems to cause issue regarding ref
-- so for now we remove it, but please check deeper how to better handle ICorDebugFrame and so on
--			if icd_il_frame /= Void then
--					--| FIXME JFIAT: please check if it is safe ...
--				icd_il_frame.clean_on_dispose
				icd_il_frame := Void

--				icd_chain.clean_on_dispose
				icd_chain := Void
--			end
		end

feature -- Dotnet Properties

	icd_il_frame: ICOR_DEBUG_IL_FRAME
	
	icd_chain: ICOR_DEBUG_CHAIN
	
	il_offset: INTEGER

feature -- Properties

	routine: E_FEATURE
			-- Routine being called
			-- Note from Arnaud: Computation has been deferred for optimisation purpose

	object_address: STRING
			-- Hector address of associated object 
			--| Because the debugger is already in communication with
			--| the application (retrieving information such as locals ...)
			--| it doesn't ask an hector address for that object until
			--| the "line" between the two processes is free.
			--| Initialially it is the physical address but is then
			--| protected in the `set_hector_addr_for_current_object' routine.

feature -- Current object

	current_object: ABSTRACT_DEBUG_VALUE is
			-- Current object value
		do
			Result := private_current_object
			if Result = Void and then not initialized then
				initialize_stack
				Result := private_current_object				
			end
		end
	
	set_private_current_object (c: like private_current_object) is
			-- Set current object value
			-- without initializing the full stack...
		do
			private_current_object := c
		end
		
feature -- Dotnet Properties

	dotnet_class_token: INTEGER is
			-- 
		do
			if not dotnet_initialized then
				initialize_dotnet_info
			end
			Result := private_dotnet_class_token
		end
		
	dotnet_feature_token: INTEGER is
			-- 
		do
			if not dotnet_initialized then
				initialize_dotnet_info
			end
			Result := private_dotnet_feature_token
		end

	dotnet_module_name: STRING is
			-- 
		do
			if not dotnet_initialized then
				initialize_dotnet_info
			end
			Result := private_dotnet_module_name
		end

	dotnet_module_filename: STRING is
			-- 
		do
			if not dotnet_initialized then
				initialize_dotnet_info
			end
			Result := private_dotnet_module_filename
		end		

feature {NONE} -- Implementation Dotnet Properties

	dotnet_initialized: BOOLEAN
			-- Is the stack initialized
			
	private_dotnet_class_token: INTEGER
	
	private_dotnet_feature_token: INTEGER
	
	private_dotnet_module_name: STRING

	private_dotnet_module_filename: STRING

feature {NONE} -- Implementation Properties

	private_current_object: ABSTRACT_DEBUG_VALUE
			-- Current object value

	display_object_address:like object_address

feature {NONE} -- Implementation

	initialize_dotnet_info is
			-- 
		local
			l_function: ICOR_DEBUG_FUNCTION
			l_class: ICOR_DEBUG_CLASS
			l_module: ICOR_DEBUG_MODULE
		do
-- FIXME jfiat 2004-07-08: maybe optimize by calling directly external on pointer
			l_function := icd_il_frame.get_function

			private_dotnet_feature_token := l_function.get_token		
			l_class := l_function.get_class
			l_module := l_function.get_module
			
			private_dotnet_class_token := l_class.get_token
			private_dotnet_module_name := l_module.module_name
			private_dotnet_module_filename := l_module.get_name

			l_function.clean_on_dispose
			l_class.clean_on_dispose
			l_module.clean_on_dispose

			dotnet_initialized := True
		ensure
			dotnet_initialized
		end
		
	initialize_stack is
		local
			local_decl_grps	: EIFFEL_LIST [TYPE_DEC_AS]
			id_list			: ARRAYED_LIST [INTEGER]
			l_index			: INTEGER
			l_count			: INTEGER
			value			: ABSTRACT_DEBUG_VALUE
			locals_list		: like private_locals
			args_list		: like private_arguments
			arg_names		: LIST [STRING]
			rout			: like routine
			counter			: INTEGER
			l_names_heap: like Names_heap

			l_list: LIST [ABSTRACT_DEBUG_VALUE]
			l_dotnet_ref_value: EIFNET_DEBUG_REFERENCE_VALUE
			
		do
			if application.imp_dotnet.exit_process_occurred then
				debug ("DEBUGGER_TRACE_CALLSTACK_DATA") 
					print ("EXIT_PROCESS OCCURRED !!!%N")
				end
				initialized := True
			else
				debug ("DEBUGGER_TRACE_CALLSTACK_DATA") 
					io.put_string ("  @-> Initializing stack (CALL_STACK_ELEMENT_DOTNET): " + routine_name
									+ " from: " + dynamic_class.name + "%N")
				end
				rout := routine
				if rout /= Void then
	
					--| ARGUMENTS |--
					l_list := internal_arg_list
	
					--| Get Current Object
					l_list.start
					
					set_private_current_object (l_list.first)				
					private_current_object.set_name ("Current")
	
					object_address := private_current_object.address
					display_object_address := object_address
	
					l_list.remove
	
					l_count := rout.argument_count
	--				check
	--					l_list.count = l_count
	--				end
					if l_count > 0 then
						create args_list.make_filled (l_count)	
						arg_names := rout.argument_names
						from
							arg_names.start
							args_list.start
							l_list.start
						until
							args_list.after
						loop
							value := l_list.item
							value.set_name (arg_names.item)
							args_list.replace (value)
							args_list.forth
							arg_names.forth
							l_list.forth
						end
					end
	
					--| LOCAL |--
	
					-- First Local is the Result value, so we take it first
					l_list := internal_local_list
					if 
						rout.is_function 
					then
						if not rout.is_once then
							--| In IL generated code .. for once function 
							--| no local variable to store the Result
							--| using directly  "ret value"
							l_list.start
							private_result := l_list.first
							l_list.remove
							private_result.set_name ("Result")
						else
							--| at this stæge, the private_current_object is known
							l_dotnet_ref_value ?= private_current_object
							if l_dotnet_ref_value /= Void then
								private_result := l_dotnet_ref_value.once_function_value (rout)
								if private_result /= Void then
									private_result.set_name ("Result")
								end
							else
								private_result := Void
							end
						end
					end
	
					--| Then real Local variables |--
					local_decl_grps := rout.locals
					if local_decl_grps /= Void then
						l_count := l_list.count
						create locals_list.make (l_count)
						from
							l_index := 0
							local_decl_grps.start
							l_names_heap := Names_heap
							l_list.start
						until
							local_decl_grps.after 
							or l_index > l_count
						loop 
							from
								id_list := local_decl_grps.item.id_list
								id_list.start
							until
								id_list.after or
								l_index > l_count
							loop
								value := l_list.item
								value.set_name (l_names_heap.item (id_list.item))
								locals_list.extend (value)
								id_list.forth
								l_list.forth
								l_index := l_index + 1
							end
							local_decl_grps.forth
						end
					end
				end
				
					--| initialize item numbers for arguments
				if args_list /= Void then
					from
						args_list.start
						counter := 1
					until
						args_list.after
					loop
						args_list.item.set_item_number(counter)
						args_list.forth
						counter := counter + 1
					end
				end
	
					--| initialize item numbers for locals
				if locals_list /= Void then
					from
						locals_list.start
						counter := 1
					until
						locals_list.after
					loop
						locals_list.item.set_item_number(counter)
						locals_list.forth
						counter := counter + 1
					end
				end
	
					--| Associate to private list |--
				private_arguments := args_list
				private_locals := locals_list
				initialized := True
				
				debug ("DEBUGGER_TRACE_CALLSTACK_DATA"); 
					io.put_string ("  @-> Finished initializating stack: "+routine_name+"%N"); 
					io.put_string ("%N-------------------------------------------------%N"); 
				end
--			else
--				debug ("DEBUGGER_TRACE_CALLSTACK_DATA") 
--					io.put_string ("  Error occurred during CALL_STACK_ELEMENT_DOTNET Initialisation : "+routine_name+" from: "+dynamic_class.name+"%N")
--				end
--				initialized := True
			end
		end

	internal_arg_list: LIST [ABSTRACT_DEBUG_VALUE]  is
		require
			icd_il_frame /= Void
		local
			l_il_frame: ICOR_DEBUG_IL_FRAME
			l_enum_args: ICOR_DEBUG_VALUE_ENUM
		do
			l_il_frame := icd_il_frame
			l_il_frame.add_ref
			l_enum_args := l_il_frame.enumerate_arguments
			if l_enum_args /= Void then
--				l_enum_args.skip (1)  -- Ignore first element which is Current Object
				Result := debug_value_list_from_enum (l_enum_args)
				l_enum_args.clean_on_dispose
			end
		ensure
			arg_list_not_void: Result /= Void
			arg_list_not_empty: not Result.is_empty -- At list the current object -- FIXME: check this !
		end

	internal_local_list: LIST [ABSTRACT_DEBUG_VALUE]  is
			-- Return list of Value for local var, 
			-- including the Result if there is one, in this case
			-- this will be the first value
		require
			icd_il_frame /= Void
		local
			l_il_frame: ICOR_DEBUG_IL_FRAME
			l_enum_locals: ICOR_DEBUG_VALUE_ENUM
		do
			l_il_frame := icd_il_frame
			l_il_frame.add_ref
			l_enum_locals := l_il_frame.enumerate_local_variables
			if l_enum_locals /= Void then
				Result := debug_value_list_from_enum (l_enum_locals)
				l_enum_locals.clean_on_dispose
			else
				create {LINKED_LIST[ABSTRACT_DEBUG_VALUE]} Result.make
			end
--		ensure
--			local_list_not_void: Result /= Void
		end

	debug_value_list_from_enum (a_enum: ICOR_DEBUG_VALUE_ENUM): LIST [ABSTRACT_DEBUG_VALUE] is
		require
			a_enum /= Void
		local
			l_objects_count: INTEGER
			l_array_objects: ARRAY [ICOR_DEBUG_VALUE]
			l_object_index: INTEGER
			l_icd_val: ICOR_DEBUG_VALUE
			l_abstract_debug_value: ABSTRACT_DEBUG_VALUE
		do
			l_objects_count := a_enum.get_count
			if l_objects_count > 0 then
				create {LINKED_LIST[ABSTRACT_DEBUG_VALUE]} Result.make
				l_array_objects := a_enum.next (l_objects_count)
				if a_enum.last_call_succeed then
					from
						l_object_index := l_array_objects.lower
					until
						l_object_index > l_array_objects.upper --| or else l_object_index > nb_object -- FIXME: JFIAT
					loop
						l_icd_val := l_array_objects @ l_object_index
						if l_icd_val /= Void then
							l_abstract_debug_value := debug_value_from_icdv (l_icd_val)
							Result.extend (l_abstract_debug_value)
						end
						l_object_index := l_object_index + 1
					end
				end
			end
			--| NOTA: JFIAT : maybe return Empty List .. not Void ...
		end

invariant

--	non_empty_args_if_exists: private_arguments /= Void implies 
--				not private_arguments.is_empty
--	non_empty_locs_if_exists: private_locals /= Void implies 
--				not private_locals.is_empty
--	valid_level: level_in_stack >= 1

end -- class CALL_STACK_ELEMENT_DOTNET

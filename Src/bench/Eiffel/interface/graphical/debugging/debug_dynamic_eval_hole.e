indexing
	description: "Dynamicaly evaluate a feature during a debugging session"
	date: "$Date$"
	revision: "$Revision$"

class DEBUG_DYNAMIC_EVAL_HOLE

inherit
	HOLE_COMMAND
		redefine
			compatible, process_object, process_feature
		end
	DEBUG_EXT
	IPC_SHARED
	SHARED_APPLICATION_EXECUTION
	BEURK_HEXER
	SHARED_SERVER
	SK_CONST
	SHARED_INST_CONTEXT
	STRING_CONVERTER
	RECV_VALUE
		export
			{NONE} all
		end
	EB_SHARED_INTERFACE_TOOLS

creation
	make

feature -- Properties

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Debug_dynamic_eval
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Debug_dynamic_eval
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	symbol: PIXMAP is 
			-- Pixmap for the button.
		do 
			Result := Pixmaps.bm_Debug_dynamic_eval
		end

	stone_type: INTEGER is
		do
		end

feature -- Access

	compatible (dropped: STONE): BOOLEAN is
			-- Can `Current' accept `dropped' ?
		do
			Result := (dropped /= Void) and then 
					  ((dropped.stone_type = Object_type) or 
					  (dropped.stone_type = Routine_type))
		end

feature -- Update

	process_object (object_stone: OBJECT_STONE) is
			-- Process object stone.
		local
			curr_parameter: DUMP_VALUE
		do
			if Application.is_running and then Application.is_stopped then
				inspect state
				when Waiting_for_all then
					curr_target := object_stone
					io.putstring("Now waiting for a feature...%N")
					state := Waiting_for_feature

				when Waiting_for_object then
					curr_target := object_stone
					io.putstring("Now processing...%N")
					state := Waiting_for_all
					dynamic_eval

				when Waiting_for_feature then
					io.putstring("Error: feature expected...%N")

				when Waiting_for_parameter_object then
					create curr_parameter.make_object(object_stone.object_address)
					parameters.put(curr_parameter, parameter_nb)
					parameter_nb := parameter_nb + 1
					retrieve_and_send_parameters
				end
			end
		end

	process_feature (feature_stone: FEATURE_STONE) is
			-- Process feature stone.
		do
			if Application.is_running and then Application.is_stopped then
				inspect state
				when Waiting_for_all then
					curr_routine := feature_stone
					io.putstring("Now waiting for an object...%N")
					state := Waiting_for_object
	
				when Waiting_for_feature then
					curr_routine := feature_stone
					io.putstring("Now processing...%N")
					state := Waiting_for_all
					dynamic_eval
				else
					io.putstring("Error: Object expected...%N")
				end
			end
		end

feature -- Execution

	work (argument: ANY) is
			-- edit an object or a local variable
		do
			-- do nothing.
			if Application.is_running and then Application.is_stopped then
				io.putstring("please, drop here a feature and an object%N")
			end
		end

feature {NONE} -- Implementation

	dynamic_eval is
			-- Collect the information needed by the run-time and
			-- then send the "dynmamic eval" request to the run-time.
		require
			valid_target: curr_target /= Void
			valid_routine: curr_routine /= Void
		local
			e_feature: E_FEATURE
			e_class: CLASS_C
		do
			e_feature := curr_routine.e_feature
			e_class := curr_target.dynamic_class
			if e_feature /= Void and then e_class /= Void then
				if not (e_class.types.count > 1) then
					feature_id := e_feature.feature_id
					if e_feature.is_external then
						is_external := 1
					end
					is_precompiled := e_class.is_precompiled
					static_type := e_class.types.first.static_type_id - 1
					
						-- initilize parameters retrieval
					parameters := initialize_parameters(curr_target.object_address)

						-- retrieve parameters and send them to application if finished 
					retrieve_and_send_parameters
				else
					io.putstring("ERROR: generic parameters are not yet implemented%N")
				end
			end
		end

	send_request is
			-- we send the parameters in reverse order since they are pushed
			-- on a stack on their arrival into the application
		local
			i: INTEGER
			dump_item: DUMP_VALUE
		do
				-- first check that all arguments are valid
			from
				i := 1
				dump_item := parameters.item(0)
			variant
				i
			until
				i > nb_param or else dump_item = Void
			loop
				dump_item := parameters.item(i)
				i := i + 1
			end

			if dump_item /= Void then
				-- everything seems ok, so start sending the arguments to
				-- the application.

					-- send the arguments (Arg_1...Arg_n)
				from
					i := 1
				variant
					i
				until
					i > nb_param
				loop
					dump_item := parameters.item(i)
					dump_item.send_value
					i := i + 1
				end

					-- then send "Current"
				parameters.item(0).send_value

					-- finally, send the information about the feature.
				send_rqst_3(Rqst_dynamic_eval, feature_id, static_type, is_external)
			else
				display_error_message(Error_void_parameter)
			end
		end

	initialize_parameters(target_addr: STRING): ARRAY[DUMP_VALUE] is
		local
			e_feature: E_FEATURE
			feature_as: FEATURE_AS
			body_as: BODY_AS
			curr_parameter: DUMP_VALUE
		do
			e_feature := curr_routine.e_feature
			feature_as := Body_server.item(e_feature.body_index)
			body_as := feature_as.body

			feature_arguments := body_as.arguments
			if feature_arguments /= Void then
				nb_param := feature_arguments.count
			else
				nb_param := 0
			end
				-- create the list.		
			create Result.make(0,nb_param)
			
				-- create the "target" and put it as parameter number zero
			create curr_parameter.make_object(target_addr)
			Result.put(curr_parameter, 0)

				-- now waiting for the first parameter (if any)
			parameter_nb := 1
		ensure
			Result /= Void
		end

	retrieve_parameters is
		local
			curr_parameter: DUMP_VALUE
		do
				-- retrieve each parameter and add it to the list of all parameters
			from
				state := Waiting_for_nothing
			until
				(parameter_nb > nb_param) or else (state = Waiting_for_parameter_object)
			loop
					-- state if modified by get_compatible_parameter
				curr_parameter := get_compatible_parameter(feature_arguments.i_th(parameter_nb).type)

				if (state = Waiting_for_nothing) then
					parameters.put(curr_parameter, parameter_nb)
					parameter_nb := parameter_nb + 1
				end
			end
		end

	retrieve_and_send_parameters is
		local
			st: STRUCTURED_TEXT
		do
				-- go on retrieving parameters
			retrieve_parameters
			
				-- are we finished ?
			if (parameter_nb > nb_param) then

					-- prepare to receive result from the application
				init_recv_c

					-- send all parameters (including "target") and the request
				send_request

					-- receive the Result
				c_recv_value(Current)
				if item /= Void then
					item.set_hector_addr
				end
	
					-- display success message
				display_success_message

					-- update call stack & object tools
				update_display

				io.putstring("The feature returned: ")
				if item /= Void then
					create st.make
					item.append_type_and_value(st)
					io.putstring(st.image)
				else
					io.putstring("NONE Void")
				end

					-- now we reset the current state
				state := Waiting_for_all
			end
		end

	get_compatible_parameter(base_type: TYPE): DUMP_VALUE is
		local
			actual_type: TYPE_A
			sk_value: INTEGER
			sk_value_double: DOUBLE
			associated_class: CLASS_C
			old_cluster: CLUSTER_I
			temp_string: STRING
		do
			old_cluster := Inst_context.cluster
			Inst_context.set_cluster (Universe.clusters.first)
			actual_type := base_type.actual_type
			Inst_context.set_cluster (old_cluster)

			associated_class := actual_type.associated_class
			sk_value := actual_type.type_i.sk_value

				-- mask the 6 low bytes (i.e: sk_value &= SK_HEAD)
				-- FIXME ARNAUD
				-- rewrite the following lines as soon as bit operations are available for INTEGER
			if sk_value < 0 then
				sk_value_double := (sk_value * 1.0)
				sk_value_double := sk_value_double + 4294967296
				sk_value_double := (sk_value_double / 16777216)
				sk_value := sk_value_double.floor
				sk_value_double := sk_value * 1.0
				sk_value_double := (sk_value_double * 16777216)
				sk_value_double := sk_value_double - 4294967296
				sk_value := sk_value_double.rounded
			else
				sk_value_double := (sk_value / 16777216)
				sk_value := sk_value_double.floor
				sk_value_double := sk_value * 1.0
				sk_value_double := (sk_value_double * 16777216)
				sk_value := sk_value_double.rounded
			end

			io.putstring("Retrieving parameter "+parameter_nb.out);
			if associated_class /= Void then
				io.putstring("[ "+associated_class.name_in_upper+" ]")
			end
			io.new_line

			inspect sk_value
			when Sk_int then
				io.putstring("Enter an INTEGER value: ")
				io.readline
				create Result.make_integer(io.last_string.to_integer)

			when Sk_char then
				io.putstring("Enter a CHARACTER value: ")
				io.readline
				create Result.make_character(io.last_string @ 1)

			when Sk_float then
				io.putstring("Enter a REAL value: ")
				io.readline
				create Result.make_real(io.last_string.to_real)

			when Sk_double then
				io.putstring("Enter a DOUBLE value: ")
				io.readline
				create Result.make_double(io.last_string.to_double)

			when Sk_pointer then
				io.putstring("Enter an hexadecimal POINTER value: ")
				io.readline
				create Result.make_pointer(default_pointer + hex_to_integer(io.last_string))

			when Sk_ref then
				if associated_class /= Void and then associated_class.name_in_upper.is_equal("STRING") then
					io.putstring ("Do you want to enter a manifest string rather than using an existant string ? (y/n)%N")
					io.readline
					if (io.last_string @ 1)='y' then
						-- this is a String
						io.putstring("Enter a STRING: ")
						io.readline
						create temp_string.make(10)
						escape_string(temp_string, io.last_string)
						create Result.make_manifest_string(temp_string)
					else
						-- act as if was another kind of object
						io.putstring("Drop an object into the 'dynamic feature' hole%N")
						state := Waiting_for_parameter_object
					end
				else
					-- this is another kind of object
					io.putstring("Drop an object into the 'dynamic feature' hole%N")
					state := Waiting_for_parameter_object
				end
			end
		end

	display_error_message(error_code: INTEGER) is
			-- Display a message according to the error code `error_code'
		do
			inspect error_code
				when Error_acknowledgement_failed then
					io.putstring("Error while evaluating the feature%N")
				when Error_void_parameter then
					io.putstring("Error while checking parameter integrity. At least one parameter was Void%N")
				when Error_getting_callstack then
					io.putstring("Error while getting Application callstack. Application will be terminated%N")
			end
		end

	display_success_message is
			-- Display a message telling the evaluation was successful.
		do
			io.putstring("Evaluation successfully completed%N")
		end

	update_display is
			-- Update all object tools displaying the content of the modified object.
		local
			call_stack_elem: CALL_STACK_ELEMENT
			retry_clause: BOOLEAN
			status: APPLICATION_STATUS		
		do
			if not retry_clause then
					-- update the object tool form of the Project tool
				project_tool.update_object_tool

					-- update all the other object tools
				project_tool.window_manager.object_win_mgr.update

				status := Application.status
				status.reload_call_stack
				call_stack_elem := status.current_stack_element
				if call_stack_elem /= Void then
					Project_tool.display_exception_stack
				end
			else -- retry_clause, something went wrong
				if Application.is_running then
					Application.process_termination;
				end
			end
		rescue
			display_error_message(Error_getting_callstack)
			retry_clause := True
			retry
		end

feature {NONE} -- Current state

	state				: INTEGER		-- current state (what are we waiting for ?) - Possible values are Waiting_XXXX
	curr_target			: OBJECT_STONE	-- target of the feature
	curr_routine		: FEATURE_STONE	-- feature to evaluate

		-- variables used retrieving the parameters
	parameter_nb		: INTEGER 			-- last parameter entered
	nb_param			: INTEGER 			-- number of parameters expected
	parameters			: ARRAY[DUMP_VALUE] -- parameters we will pass to the function
	feature_arguments	: LIST[TYPE_DEC_AS] -- expected type for each argument

		-- things usefull for the application (helps application finding & calling the feature)
	feature_id		: INTEGER
	static_type		: INTEGER
	is_external		: INTEGER
	is_precompiled	: BOOLEAN

feature {NONE} -- Private Constants

	Waiting_for_all				: INTEGER is 0 -- We are waiting for an object or a feature (default)
	Waiting_for_object			: INTEGER is 1 -- A feature has been processed, waiting for an object to start evaluation
	Waiting_for_feature			: INTEGER is 2 -- An object has been processed, waiting for a feature to start evaluation
	Waiting_for_parameter_object: INTEGER is 3 -- We are waiting for a parameter
	Waiting_for_nothing			: INTEGER is 4 -- We are not expecting anything.

feature {NONE} -- Private Constants

	Error_acknowledgement_failed : INTEGER is 1 -- Acknowledgement returned False.
	Error_void_parameter		 : INTEGER is 2	-- A void parameter was detected.
	Error_getting_callstack		 : INTEGER is 3 -- Error while getting application call stack.

end -- class DEBUG_DYNAMIC_EVAL_HOLE

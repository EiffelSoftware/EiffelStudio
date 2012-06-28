indexing

	description:

		"Objects that represent an XSLT evaluation context"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XSLT_EVALUATION_CONTEXT

inherit

	XM_XPATH_CONTEXT
		redefine
			current_date_time, new_context, set_local_variable, is_uri_written
		end

	XM_XPATH_ERROR_TYPES

create

	make, make_restricted, make_minor

feature {NONE} -- Initialization

	make (a_transformer: XM_XSLT_TRANSFORMER) is
			-- Establish invariant for major context.
		require
			transformer_not_void: a_transformer /= Void
		do
			make_minor (a_transformer)
			is_minor := False
			create internal_local_parameters.make_empty
			create internal_local_variable_frame.make_empty
		ensure
			transformer_set: transformer = a_transformer
			not_restricted: not is_restricted
			not_pattern: not is_pattern
		end

	make_minor (a_transformer: XM_XSLT_TRANSFORMER) is
			-- Establish invariant for minor context.
		require
			transformer_not_void: a_transformer /= Void
		do
			transformer := a_transformer
			clear_last_cache
			collation_map := transformer.executable.collation_map
			is_minor := True
			configuration := transformer.configuration
		ensure
			transformer_set: transformer = a_transformer
			not_restricted: not is_restricted
			not_pattern: not is_pattern
		end

	make_restricted (a_static_context: like static_context; a_collation_map: like collation_map; a_configuration: like configuration) is
			-- Create a restricted context for [xsl:]use-when.
		require
			static_context_not_void: a_static_context /= Void
			configuration_not_void: a_configuration /= Void
		local
			a_date_time: DT_DATE_TIME
			a_time_zone: DT_FIXED_OFFSET_TIME_ZONE
		do
			configuration := a_configuration
			is_restricted := True
			clear_last_cache
			static_context := a_static_context
			collation_map := a_collation_map
			create internal_implicit_timezone.make (system_clock.time_now.canonical_duration (utc_system_clock.time_now))
			create a_date_time.make_from_epoch (0)
			utc_system_clock.set_date_time_to_now (a_date_time)
			create a_time_zone.make (internal_implicit_timezone.fixed_offset)
			create internal_date_time.make (a_date_time, a_time_zone)
			create internal_local_variable_frame.make_empty
			create internal_local_parameters.make_empty
		ensure
			restricted: is_restricted
			static_context_set: static_context = a_static_context
			collation_map_set: collation_map = a_collation_map
			not_pattern: not is_pattern
		end

feature -- Access

	configuration: XM_XSLT_CONFIGURATION
			-- System configuration

	caller: like Current
			-- Calling context

	transformer: XM_XSLT_TRANSFORMER
			-- Transformer

	local_variable_frame: XM_XPATH_STACK_FRAME is
			-- Local variables in scope
		do
			if is_minor then
				Result := caller.local_variable_frame
			else
				Result := internal_local_variable_frame
			end
		end

	current_mode: XM_XSLT_MODE is
			-- Current mode
		do
			if is_minor then
				Result := caller.current_mode
			else
				Result := internal_current_mode
			end
		end

	current_template: XM_XSLT_RULE is
			-- Rule for current template
		do
			if is_minor then
				Result := caller.current_template
			else
				Result := internal_current_template
			end
		end

	current_group_iterator:  XM_XSLT_GROUP_ITERATOR [XM_XPATH_ITEM] is
			-- Current group iterator
		do
			if is_minor then
				Result := caller.current_group_iterator
			else
				Result := internal_current_group_iterator
			end
		end

	current_regexp_iterator:  XM_XSLT_REGEXP_ITERATOR is
			-- Current regexp iterator
		do
			if is_pattern then
				Result := Void
			elseif is_minor then
				Result := caller.current_regexp_iterator
			else
				Result := internal_current_regexp_iterator
			end
		ensure then
			current_regexp_iterator_void_for_patterns: is_pattern implies Result = Void
		end
	
	tunnel_parameters:  XM_XSLT_PARAMETER_SET is
			-- Tunnel parameters
		do
			if is_minor then
				Result := caller.tunnel_parameters
			else
				Result := internal_tunnel_parameters
			end
		end

	local_parameters:  XM_XSLT_PARAMETER_SET is
			-- Tunnel parameters
		do
			if is_minor then
				Result := caller.local_parameters
			else
				Result := internal_local_parameters
			end
		ensure
			result_not_void: Result /= Void
		end
	
	is_local_parameter_supplied (a_fingerprint: INTEGER; is_tunnel: BOOLEAN): BOOLEAN is
			-- Does `a_fingerprint' represent a supplied local parameter?
		local
			a_parameter_set: XM_XSLT_PARAMETER_SET
		do
			if is_tunnel then
				a_parameter_set := tunnel_parameters
			else
				a_parameter_set := local_parameters
			end
			if a_parameter_set /= Void then
				Result := a_parameter_set.has (a_fingerprint)
			end
		end

	static_context: XM_XPATH_STATIC_CONTEXT
			-- Static context

	last_parsed_document: XM_XPATH_DOCUMENT
			-- Result from last call to `build_document'

	last_parsed_media_type: UT_MEDIA_TYPE
			-- Auxiliary result from last call to `build_document'
	
	available_functions: XM_XPATH_FUNCTION_LIBRARY is
			-- Available functions
		do
			if is_restricted then
				Result := static_context.available_functions
			else
				Result := transformer.executable.function_library
			end
		end

	available_documents: XM_XPATH_DOCUMENT_POOL is
			-- Available documents
		do
			if not is_restricted then
				Result := transformer.document_pool
			end
		end

	implicit_timezone: DT_FIXED_OFFSET_TIME_ZONE is
			-- Implicit time zone for comparing unzoned times and dates
		do
			if is_restricted then
				Result := internal_implicit_timezone
			else
				Result := transformer.implicit_timezone
			end
		end

	security_manager: XM_XPATH_SECURITY_MANAGER is
			-- Security manager
		do
			Result := transformer.configuration.output_resolver.security_manager
		end

	current_date_time: DT_FIXED_OFFSET_ZONED_DATE_TIME is
			-- Current date-time
		do
			if not is_restricted then
				Result := transformer.current_date_time
			else
				Result := internal_date_time
			end
		end

	is_current_item_available: BOOLEAN is
			-- May `current()' be called without error?
		do
			if not is_restricted then
				Result := current_iterator /= Void and then not current_iterator.is_error and then not current_iterator.off
			end
		end

	tail_call_function: XM_XSLT_COMPILED_USER_FUNCTION
			-- Next tail call

feature -- Status report

	last_build_error: STRING
			-- Error message from last call to `build_document'

	is_minor: BOOLEAN
			-- Is `Current' limited in what it may change?

	is_pattern: BOOLEAN
			-- Is `Current' used for pattern evaluation?

	has_push_processing: BOOLEAN is
			-- Is push-processing to a receiver implemented?
		do
			Result := True
		end

	is_process_error: BOOLEAN is
			-- Has a processing error occurred?
		do
			Result := transformer.is_error
		end

	is_uri_written (a_uri: STRING): BOOLEAN is
			-- Has `a_uri' been written to yet?
		do
			Result := STRING_.same_string (a_uri, transformer.principal_result_uri) or else Precursor (a_uri)
		end

feature -- Status setting

	set_pattern is
			-- Set `is_pattern' to `Trye'.
		do
			is_pattern := True
		ensure
			pattern_set: is_pattern
		end

feature -- Creation

	new_context: like Current is
			-- Create a copy of `Current'
		do
			if is_minor then
				Result := new_major_context (Current)
			else
				Result := Precursor
				--Result.set_caller (Current)
			end
		end
	
	new_major_context (a_minor_context: XM_XSLT_EVALUATION_CONTEXT): like Current is
			-- Create a copy of `Current'
		require
			minor_context_not_void: a_minor_context /= Void and then a_minor_context.is_minor
		do
			create Result.make (a_minor_context.transformer)
			Result.set_current_iterator (a_minor_context.current_iterator)
			Result.set_local_parameters (a_minor_context.local_parameters)
			Result.set_stack_frame (a_minor_context.local_variable_frame)
			Result.set_last (a_minor_context.cached_last)
			Result.set_current_receiver (a_minor_context.current_receiver)
			Result.set_temporary_destination (a_minor_context.is_temporary_destination)
			Result.set_caller (a_minor_context)
			if a_minor_context.tunnel_parameters /= Void then
				Result.set_tunnel_parameters (a_minor_context.tunnel_parameters)
			end
			Result.set_current_mode (a_minor_context.current_mode)
			Result.set_current_template (a_minor_context.current_template)
			Result.set_current_group_iterator (a_minor_context.current_group_iterator)
			Result.set_current_regexp_iterator (a_minor_context.current_regexp_iterator)
		ensure
			major_context: Result /= Void and then not Result.is_minor
		end

	new_minor_context: like Current is
			-- Create a minor copy of `Current'
		do
			create Result.make_minor (transformer)
			Result.set_caller (Current)
			Result.set_current_iterator (current_iterator)
			Result.set_current_receiver (current_receiver)
			Result.set_temporary_destination (is_temporary_destination)
			Result.set_last (cached_last)
			if is_pattern then
				Result.set_pattern
			end
		ensure then
			pattern_status_preserved: Result.is_pattern = is_pattern
		end

	new_pattern_context: XM_XSLT_EVALUATION_CONTEXT is
			-- Create a minor copy of `Current'
		do
			Result := new_minor_context
			Result.set_pattern
		ensure
			new_pattern_context_not_void: Result /= Void
			pattern_context: Result.is_pattern
		end

	new_clean_context: like Current is
			-- Created clean context (for XSLT function calls)
		do
			create Result.make (transformer)
		end

feature -- Element change

	
	set_stack_frame (a_local_variable_frame: like local_variable_frame) is
			-- Set stack frame.
		do
			internal_local_variable_frame := a_local_variable_frame
		end

	reset_stack_frame_map (a_slot_manager: XM_XPATH_SLOT_MANAGER; a_parameter_count: INTEGER) is
			-- Reset `local_variable_frame.slot_manager' and conditionally resize `local_variable_frame.variables'.
		require
			a_slot_manager_not_void: a_slot_manager /= Void
			non_negative_parameter_count: a_parameter_count >= 0
			a_parameter_count_small_enough: a_parameter_count <= a_slot_manager.number_of_variables
			major_context: not is_minor
		do
			local_variable_frame.set_slot_manager (a_slot_manager, a_parameter_count)
		ensure
			slot_manager_set: local_variable_frame.slot_manager = a_slot_manager
			correct_size: local_variable_frame.variables.count = a_slot_manager.number_of_variables
		end

	set_tail_call (a_function: XM_XSLT_COMPILED_USER_FUNCTION; a_variables: ARRAY [XM_XPATH_VALUE]) is
			-- Set `a_function' as the next tail call, with `a_variables' on stack frame.
		require
			a_function_not_void: a_function /= Void
			a_variables_not_void: a_variables /= Void
		local
			i: INTEGER
			l_variables: like a_variables
		do
			tail_call_function := a_function
			if a_variables.count /= local_variable_frame.variables.count then
				create l_variables.make (1, a_function.slot_manager.number_of_variables)
				from
					i := 1
				until
					i > a_variables.count
				loop
					l_variables.put (a_variables.item (i), i)
					i := i + 1
				end
				local_variable_frame.set_variables (l_variables)
			else
				from
					i := 1
				until
					i > a_variables.count
				loop
					local_variable_frame.variables.put (a_variables.item (i), i)
					i := i + 1
				end
			end
		ensure
			tail_call_function_set: tail_call_function = a_function
			minimum_variables_count: local_variable_frame.variables.count >= a_variables.count
		end

	clear_tail_call_function is
			-- Set `tail_call_function' to `Void'.
		do
			tail_call_function := Void
		ensure
			tail_call_function = Void
		end

	open_stack_frame (a_slot_manager: XM_XPATH_SLOT_MANAGER) is
			-- Set stack frame.
		local
			an_array: ARRAY [XM_XPATH_VALUE]
		do
			create an_array.make (1, a_slot_manager.number_of_variables)
			create internal_local_variable_frame.make (a_slot_manager, an_array)
		end


	open_sized_stack_frame (a_slot_count: INTEGER) is
			-- Set stack frame.
		local
			an_array: ARRAY [XM_XPATH_VALUE]
			a_slot_manager: XM_XPATH_SLOT_MANAGER
		do
			create an_array.make (1, a_slot_count)
			create a_slot_manager.make
			a_slot_manager.set_number_of_variables (a_slot_count)
			create internal_local_variable_frame.make (a_slot_manager, an_array)
		end

	set_caller (a_caller: like Current) is
			-- Set calling context.
		require
			caller_not_void: a_caller /= Void
		do
			caller := a_caller
		ensure
			set: caller = a_caller
		end

	set_last (a_last_value: INTEGER) is
			-- Set result of XPath last() function.
		do
			cached_last := a_last_value
		ensure
			set: cached_last = a_last_value
		end
			
	set_local_variable (a_value: XM_XPATH_VALUE; a_slot_number: INTEGER) is
			-- Set the value of a local variable.
		do
			if is_minor then
				caller.set_local_variable (a_value, a_slot_number)
			else
				Precursor (a_value, a_slot_number)
			end
		end

	ensure_local_parameter_set (a_fingerprint: INTEGER; is_tunnel: BOOLEAN; a_slot_number: INTEGER) is
			-- Ensure local parameter is bound to local variable in slot `a_slot_number'.
		require
			local_variables_frame_not_void: local_variable_frame /= Void
			valid_local_variable: is_valid_local_variable (a_slot_number)
			is_local_parameter_supplied (a_fingerprint, is_tunnel)
		local
			a_parameter_set: XM_XSLT_PARAMETER_SET
			a_value: XM_XPATH_VALUE
		do
			if is_minor then
				caller.ensure_local_parameter_set (a_fingerprint, is_tunnel, a_slot_number)
			else
				if is_tunnel then
					a_parameter_set := tunnel_parameters
				else
					a_parameter_set := local_parameters
				end
				check
					a_parameter_set /= Void
					-- because of pre-condition label `is_local_parameter_supplied'
				end
				a_value := a_parameter_set.value (a_fingerprint)
				if a_value /= Void then
					local_variable_frame.variables.put (a_value, a_slot_number)
				end
			end
		end

	set_local_parameters (a_parameter_set: like internal_local_parameters) is
			-- Set `local_parameters'.
		require
			parameter_set_not_void: a_parameter_set /= Void
			major_context: not is_minor
		do
			internal_local_parameters := a_parameter_set
		ensure
			set: local_parameters = a_parameter_set
		end
					 
	set_tunnel_parameters (a_parameter_set: like internal_local_parameters) is
			-- Set `tunnel_parameters'.
		require
			parameter_set_not_void: a_parameter_set /= Void
			major_context: not is_minor
		do
			internal_tunnel_parameters := a_parameter_set
		ensure
			set: tunnel_parameters = a_parameter_set
		end

	set_current_group_iterator (an_iterator: like current_group_iterator) is
			-- Set `current_iterator'.
		do
			internal_current_group_iterator := an_iterator
		ensure
			set: current_group_iterator = an_iterator
		end

	set_current_regexp_iterator (an_iterator: like current_regexp_iterator) is
			-- Set `current_regexp_iterator'.
		do
			internal_current_regexp_iterator := an_iterator
		ensure
			set: current_regexp_iterator = an_iterator
		end

	set_current_mode (a_mode: like current_mode) is
			-- Set `current_mode'.
		require
			major_context: not is_minor
		do
			if (a_mode /= Void and then not a_mode.is_default_mode) or else  internal_current_mode /= Void then
				internal_current_mode := a_mode
			end
		end

	set_current_template (a_template: like current_template) is
			-- Set `current_template'.
		require
			major_context: not is_minor
		do
			internal_current_template := a_template
		ensure
			template_set: current_template = a_template
		end
	
	build_document (a_uri_reference: STRING) is
			-- Build a document.
		local
			l_uri_resolver: XM_URI_REFERENCE_RESOLVER
			l_parser: XM_PARSER
			l_builder: XM_XPATH_BUILDER
			l_source: XM_XSLT_URI_SOURCE
			l_executable: XM_XSLT_EXECUTABLE
			l_uri: UT_URI
		do
			if transformer.timer /= Void then
				transformer.timer.time_document_building
			end
			is_build_document_error := False
			last_parsed_document := Void
			last_parsed_media_type := Void
			create l_uri.make (a_uri_reference)
			l_uri_resolver := transformer.configuration.uri_resolver
			l_uri_resolver.resolve_uri (a_uri_reference)
			if l_uri_resolver.has_uri_reference_error then
				set_build_error (l_uri_resolver.last_uri_reference_error)
			else
				if l_uri_resolver.has_media_type then
					last_parsed_media_type := l_uri_resolver.last_media_type
				end
				l_parser := transformer.new_parser
				l_builder := transformer.new_builder (l_parser, l_uri_resolver.last_system_id.full_uri, l_uri)
				create l_source.make (l_uri_resolver.last_system_id.full_uri)
				l_source.send_from_stream (l_uri_resolver.last_uri_reference_stream, l_uri_resolver.last_system_id, l_parser, l_builder, False)
				if l_builder.has_error then
					set_build_error (l_builder.last_error)
				else
					last_parsed_document	?= l_builder.current_root
					if last_parsed_document /= Void then
						l_executable := transformer.executable
					end
				end
			end
			if transformer.timer /= Void then
				transformer.timer.mark_document_built
				transformer.configuration.error_reporter.report_error_message ("Time to build " + a_uri_reference + " was " + transformer.timer.document_build_time.precise_out + " seconds")
			end
			transformer.configuration.reset_entity_resolver
		end

	change_to_sequence_output_destination (a_receiver: XM_XPATH_SEQUENCE_RECEIVER) is
			-- Change to a temporary destination
		do
			set_receiver (a_receiver)
			is_temporary_destination := True
			if not a_receiver.is_open then a_receiver.open end
		end

	change_output_destination (properties: XM_XSLT_OUTPUT_PROPERTIES; a_result: XM_XSLT_TRANSFORMATION_RESULT
										is_final: BOOLEAN; validation: INTEGER; a_schema_type: XM_XPATH_SCHEMA_TYPE) is
			-- Set a new output destination, supplying the output format details.
		require
			result_not_void: a_result /= void
			schema_type_not_yet_supported: a_schema_type = Void
		local
			a_complex_outputter: XM_XSLT_COMPLEX_CONTENT_OUTPUTTER
			some_properties: XM_XSLT_OUTPUT_PROPERTIES
			a_receiver: XM_XPATH_RECEIVER
			a_namespace_reducer: XM_XSLT_NAMESPACE_REDUCER
			an_error: XM_XPATH_ERROR_VALUE
		do
			if is_final and then is_temporary_destination then
				create an_error.make_from_string ("Cannot switch to a final result destination while writing a temporary tree",
															 Xpath_errors_uri, "XTDE1480", Dynamic_error)
				transformer.report_fatal_error (an_error)
			else
				if properties = Void then
					create some_properties.make (0)
				else
					some_properties := properties
				end
				a_receiver := transformer.selected_receiver (a_result, some_properties)
				a_result.set_principal_receiver (a_receiver)
				if not transformer.is_error and not a_receiver.is_open then
					-- TODO: add a validator to the pipeline if required
					
					-- Add a filter to remove duplicate namespaces
					
					create a_namespace_reducer.make (a_receiver)
					create a_complex_outputter.make (a_namespace_reducer)
					a_complex_outputter.open
					current_receiver := a_complex_outputter
				end
			end
		ensure
			current_receiver_opened: not transformer.is_error implies current_receiver /= Void
				and then current_receiver.is_open		
		end

	report_fatal_error (an_error: XM_XPATH_ERROR_VALUE) is
			-- Report a fatal error.
		do
			transformer.report_fatal_error (an_error)
		end

feature {NONE} -- Implementation

	saved_receiver: like current_receiver
			-- Previous value for `current_receiver'

	set_build_error (a_message: STRING) is
			-- Set `last_build_error'.
		require
			message_not_void: a_message /= Void
		do
			last_build_error := a_message
			is_build_document_error := True
		ensure
			error_set: last_build_error = a_message
			is_build_document_error: is_build_document_error
		end

	internal_local_variable_frame: XM_XPATH_STACK_FRAME
			-- Local variables for major context

	internal_local_parameters:  XM_XSLT_PARAMETER_SET
			--	 Local parameters for major context

	internal_current_group_iterator: XM_XSLT_GROUP_ITERATOR [XM_XPATH_ITEM]
			-- Current group iterator

	internal_current_mode: XM_XSLT_MODE
			-- Current mode

	internal_current_template: XM_XSLT_RULE
			-- Rule for current template

	internal_current_regexp_iterator: XM_XSLT_REGEXP_ITERATOR
			-- Current regexp iterator

	internal_tunnel_parameters: XM_XSLT_PARAMETER_SET
			-- Tunnel parameters

	internal_implicit_timezone: DT_FIXED_OFFSET_TIME_ZONE
			-- Implicit timezone for restricted contexts

invariant

	transformer_conditioanlly_not_void: not is_restricted implies transformer /= Void
	static_context_void: not is_restricted implies static_context = Void
	static_context_not_void: is_restricted implies static_context /= Void
	local_variables: is_minor implies internal_local_variable_frame = Void
	local_variables_not_void: not is_minor implies internal_local_variable_frame /= Void
	local_parameters: is_minor implies internal_local_parameters = Void
	local_parameters_not_void: not is_minor implies internal_local_parameters /= Void	
	tunnel_parameters: is_minor implies internal_tunnel_parameters = Void
	group_iterator: is_minor implies internal_current_group_iterator = Void
	mode: is_minor implies internal_current_mode = Void
	template: is_minor implies internal_current_template = Void
	regexp: is_minor implies internal_current_regexp_iterator = Void
	pattern_context_implies_minor: is_pattern implies is_minor
	configuration_not_void: configuration /= Void
	
end
	

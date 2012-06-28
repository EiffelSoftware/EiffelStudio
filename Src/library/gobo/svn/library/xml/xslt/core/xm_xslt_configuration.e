indexing

	description:

		"Objects that hold user-selected configuration options"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XSLT_CONFIGURATION

inherit

	XM_XPATH_CONFIGURATION
		redefine
			is_tracing, trace, is_uri_written
		end

	XM_STRING_MODE

	XM_RESOLVER_FACTORY
		export {NONE} all end

	XM_XPATH_SHARED_NAME_POOL
		export {NONE} all end

	XM_XSLT_CONFIGURATION_CONSTANTS

	XM_XSLT_VALIDATION


create

	make, make_with_defaults

feature {NONE} -- Initialization

	make (an_entity_resolver: like entity_resolver;
			a_uri_resolver: like uri_resolver;
			an_output_resolver: like output_resolver;
			an_error_listener: like error_listener;
			an_encoder_factory: like encoder_factory) is
			-- Establish invariant.
		require
			entity_resolver_not_void: an_entity_resolver /= Void
			uri_resolver_not_void: a_uri_resolver /= Void
			output_resolver_not_void: an_output_resolver /= Void
			error_listener_not_void: an_error_listener /= Void
			encoder_factory_not_void: 	an_encoder_factory /= Void
		do
			create message_emitter_factory
			if error_reporter = Void then create error_reporter.make_null end
			make_configuration
			encoder_factory := an_encoder_factory
			set_string_mode_mixed
			entity_resolver := an_entity_resolver
			uri_resolver := a_uri_resolver
			output_resolver := an_output_resolver
			set_error_listener (an_error_listener)
			saved_base_uri := entity_resolver.uri
			create extension_functions.make_default
			create media_type_map.make
			assume_html_is_xhtml := True
		ensure
			entity_resolver_set: entity_resolver = an_entity_resolver
			uri_resolver_set: uri_resolver = a_uri_resolver
			output_resolver_set: output_resolver = an_output_resolver
			error_listener_set: error_listener = an_error_listener
			encoder_factory_set: encoder_factory = an_encoder_factory
		end

	make_with_defaults is
			-- Establish invariant using defaults.
		local
			an_error_listener: XM_XSLT_DEFAULT_ERROR_LISTENER
			an_encoder_factory: XM_XSLT_ENCODER_FACTORY
			a_catalog_resolver: XM_CATALOG_RESOLVER
			an_output_resolver: XM_XSLT_DEFAULT_OUTPUT_URI_RESOLVER
			a_security_manager: XM_XSLT_DEFAULT_SECURITY_MANAGER
		do
			a_catalog_resolver := new_catalog_resolver
			create an_encoder_factory
			create error_reporter.make_standard
			create an_error_listener.make (Recover_with_warnings, error_reporter)
			create a_security_manager.make
			create an_output_resolver.make (a_security_manager)
			make (a_catalog_resolver, a_catalog_resolver, an_output_resolver, an_error_listener, an_encoder_factory)
		end

feature -- Access

	trace_listener: XM_XSLT_TRACE_LISTENER
			-- Trace listener

	error_reporter: UT_ERROR_HANDLER
			-- Error reporter for standard error and trace listeners

	entity_resolver: XM_URI_EXTERNAL_RESOLVER
			-- Entity resolver

	uri_resolver: XM_URI_REFERENCE_RESOLVER
			-- URI resolver

	output_resolver: XM_XSLT_OUTPUT_URI_RESOLVER
			-- Output URI resolver

	encoder_factory: XM_XSLT_ENCODER_FACTORY
			-- Encoder factory

	is_line_numbering: BOOLEAN
			-- Is line-numbering turned on?

	is_tiny_tree_model: BOOLEAN
			-- Should the tiny tree model be used for XML source?

	is_reporting_tiny_tree_statistics: BOOLEAN
			-- Do we report statistics on tiny-tree source documents?
	
	is_timing: BOOLEAN
			-- Should timings be written to standard error cstream?

	recovery_policy: INTEGER is
			-- Recovery policy when warnings or errors are encountered
		do
			Result := error_listener.recovery_policy
		ensure
			recovery_policy_in_range: Result >= Recover_silently and Result <= Do_not_recover
		end
		
	extension_functions: DS_ARRAYED_LIST [XM_XPATH_FUNCTION_LIBRARY]
			-- Libraries of extension functions
	
	media_type_map: XM_XSLT_MEDIA_TYPE_MAP
			-- URI to media-type mapping rules

	assume_html_is_xhtml: BOOLEAN
			-- Do we treat text/html as application/xhtml+xml (on the assumption that the HTTP server is lying for MSIE)?

	is_tracing: BOOLEAN is
			-- Is tracing enabled?
		do
			Result := trace_listener /= Void
		end

	error_listener: XM_XSLT_ERROR_LISTENER
			-- Error listener

	warns_on_default_action: BOOLEAN
			-- Are warning messages issued when a default template is invoked?

	default_action_suppressed: BOOLEAN
			-- Are default templates suppressed?
			-- (If `True', then non-compliant)
	
	default_media_type (a_uri: STRING): UT_MEDIA_TYPE is
			-- Media-type associated with `a_uri' (only used when resolver returns no information)
		require
			uri_not_empty: a_uri /= Void and then a_uri.count > 0
		once

			-- This implementation always returns application/xml - sub-class and redefine if this is not satisfactory

			create Result.make ("application", "xml")
		end

	final_execution_phase: INTEGER
			-- Last phase to be executed

	estimated_nodes, estimated_attributes, estimated_namespaces, estimated_characters: INTEGER
		-- Estimates for tiny-tree parameters

	message_emitter_factory: XM_XSLT_MESSAGE_EMITTER_FACTORY
			-- Message-emitter factory

	is_explaining: BOOLEAN
			-- Is gexslt:explain="all" forced on?

	is_dtd_suppressed: BOOLEAN
			-- Is the xml parser supposed to read the DTD or not?

feature -- Status report

	is_uri_written (a_uri: STRING): BOOLEAN is
			-- Has `a_uri' been written to yet?
		do

			-- Note that this call really only determines if the
			--  output destination has been allocated. But this is sufficient
			--  for the purposes of XTRE1500 - a clash is involved.

			Result := output_resolver.output_destinations.has (a_uri)
		end

feature -- Creation

	new_message_emitter (a_transformer: XM_XSLT_TRANSFORMER; a_properties: XM_XSLT_OUTPUT_PROPERTIES): XM_XPATH_RECEIVER is
			-- New destination for xsl:message
		do
			Result := message_emitter_factory.new_message_emitter (a_transformer, a_properties)
		ensure
			new_message_emitter_not_void: Result /= Void
		end

feature -- Element change

	force_explaining is
			-- Force gexslt:explain="all" on.
		do
			is_explaining := True
		ensure
			explaining_forced_on: is_explaining
		end

	set_warns_on_default_action (a_status: BOOLEAN) is
			-- Set whether warning messages are issued when a default template is invoked.
		do
			warns_on_default_action := a_status
			if a_status then set_default_action_suppressed (False) end
		ensure
			status_set: warns_on_default_action = a_status
		end

	set_default_action_suppressed (a_status: BOOLEAN) is
			-- Set whther default templates are suppressed.
		do
			default_action_suppressed := a_status
			if a_status then set_warns_on_default_action (False) end
		ensure
			status_set: default_action_suppressed = a_status
		end

	add_extension_function_library (a_function_library: XM_XPATH_FUNCTION_LIBRARY) is
			-- Add an extension-function library.
		require
			function_library_not_void: a_function_library /= Void
		do
			extension_functions.force_last (a_function_library)
		ensure
			library_added: extension_functions.last = a_function_library
		end

	reset_entity_resolver is
			-- Reset `entity_resolver' stack to initial condition.
		do
			entity_resolver.reset_uri_stack (saved_base_uri)
		end

			
	set_line_numbering (on_or_off: BOOLEAN) is
			-- Turn line numbering `on_or_off'.
		do
			is_line_numbering := on_or_off
		ensure
			set: is_line_numbering = on_or_off
		end

	set_trace_listener (a_trace_listener: XM_XSLT_TRACE_LISTENER) is
			-- Set `trace_listener'.
		require
			trace_listener_may_be_void: True
		do
			trace_listener := a_trace_listener
		ensure
			trace_listener_set: trace_listener = a_trace_listener
		end

	set_message_emitter_factory (a_message_emitter_factory: like message_emitter_factory) is
			-- Set `message_emitter_factory' to `a_message_emitter_factory'.
		require
			a_message_emitter_factory_not_void: a_message_emitter_factory /= Void
		do
			message_emitter_factory := a_message_emitter_factory
		ensure
			message_emitter_factory_set: message_emitter_factory = a_message_emitter_factory
		end

	set_entity_resolver (an_entity_resolver: like entity_resolver) is
			-- Set `entity_resolver'.
		require
			entity_resolver_not_void: an_entity_resolver /= Void
		do
			entity_resolver := an_entity_resolver
		ensure
			entity_resolver_set: entity_resolver = an_entity_resolver
		end

	set_uri_resolver (a_uri_resolver: like uri_resolver) is
			-- Set `uri_resolver'.
		require
			uri_resolver_not_void: a_uri_resolver /= Void
		do
			uri_resolver := a_uri_resolver
		ensure
			uri_resolver_set: uri_resolver = a_uri_resolver
		end

	set_output_resolver (an_output_resolver: like output_resolver) is
			-- Set `output_resolver'.
		require
			output_resolver_not_void: an_output_resolver /= Void
		do
			output_resolver := an_output_resolver
		ensure
			output_resolver_set: output_resolver = an_output_resolver
		end

	set_recovery_policy (a_recovery_policy: INTEGER) is
			-- Set recovery policy.
		require
			valid_recovery_policy: a_recovery_policy >= Recover_silently and then a_recovery_policy <= Do_not_recover
		do
			error_listener.set_recovery_policy (a_recovery_policy)
		ensure
			recovery_policy_set: recovery_policy = a_recovery_policy
		end

	set_error_listener (an_error_listener: like error_listener) is
			-- Set error listener.
		require
			error_listener_not_void: an_error_listener /= Void
		do
			error_listener := an_error_listener
		end

	use_tiny_tree_model (true_or_false: BOOLEAN) is
			-- Switch on/off use of tiny tree model for source XML.
		do
			is_tiny_tree_model := true_or_false
		ensure
			set: is_tiny_tree_model = true_or_false
		end

	report_tiny_tree_statistics (true_or_false: BOOLEAN) is
			-- Switch on/off reporting of tiny tree statistics for source XML.
		do
			is_reporting_tiny_tree_statistics := true_or_false
		ensure
			set: is_reporting_tiny_tree_statistics = true_or_false
		end

	do_not_assume_xhtml is
			-- Do not assume that text/html is really application/xhtml+xml.
		do
			assume_html_is_xhtml := False
		ensure
			really_html: not assume_html_is_xhtml
		end

	trace (a_label, a_value: STRING) is
			-- Create trace entry.
		do
			if trace_listener.is_tracing then
				trace_listener.trace_user_entry (a_label, a_value)
			end
		end

	set_final_execution_phase (a_phase: INTEGER) is
			-- Set last phase to be executed.
		require
			final_execution_phase_in_range: a_phase <= Run_to_completion and then a_phase >= Stop_after_principal_source
		do
			final_execution_phase := a_phase
		ensure
			phase_set: final_execution_phase = a_phase
		end

	set_tiny_tree_estimates (some_estimated_nodes, some_estimated_attributes, some_estimated_namespaces, some_estimated_characters: INTEGER) is
			-- Set size parameters for tiny-tree source documents.
		require
			positive_nodes: some_estimated_nodes >= 0
			positive_attributes: some_estimated_attributes >= 0
			positive_namespaces: some_estimated_namespaces >= 0
			positive_characters: some_estimated_characters >= 0
		do
			estimated_nodes := some_estimated_nodes
			estimated_attributes := some_estimated_attributes
			estimated_namespaces := some_estimated_namespaces
			estimated_characters := some_estimated_characters
		ensure
			estimated_nodes_set: estimated_nodes = some_estimated_nodes
			estimated_attributes_set: estimated_attributes = some_estimated_attributes
			estimated_namespaces_set: estimated_namespaces = some_estimated_namespaces
			estimated_characters_set: estimated_characters = some_estimated_characters
		end


	suppress_dtd is
			-- Suppress reading of external DTDs by XML parser.
		do
			is_dtd_suppressed := True
		ensure
			dtd_suppressed: is_dtd_suppressed
		end
	
	set_timing (a_status: BOOLEAN) is
			-- Set `is_timing' to `a_status'.
		do
			is_timing := a_status
		ensure
			is_timing_set: is_timing = a_status
		end

feature {XM_XSLT_TRANSFORMER, XM_XSLT_INSTRUCTION} -- Transformation

	element_validator (a_receiver: XM_XPATH_RECEIVER; a_name_code: INTEGER; a_schema_type: XM_XPATH_SCHEMA_TYPE;
							 a_validation_action: INTEGER): XM_XPATH_RECEIVER is
			-- A receiver that can be used to validate an element,
			--  and that passes the validated element on to a target receiver.
			-- If validation is not supported, the returned receiver
			--  will be the target receiver.
		require
			current_receiver_not_void: a_receiver /= Void
			validation_action: a_validation_action >= Validation_strict  and then Validation_strip <= a_validation_action
			-- Not sure about the others - anyway, they are not used yet
		do

			-- Basic XSLT processor version

			Result := a_receiver
		ensure
			element_validator_not_void: Result /= Void
		end

	document_validator (a_receiver: XM_XPATH_RECEIVER; a_system_id: STRING; a_validation_action: INTEGER): XM_XPATH_RECEIVER is
		-- A receiver that can be used to validate a document,
			--  and that passes the validated element on to a target receiver.
			-- If validation is not supported, the returned receiver
			--  will be the target receiver.
		require
			current_receiver_not_void: a_receiver /= Void
			validation_action: a_validation_action >= Validation_strict  and then Validation_strip <= a_validation_action
			system_id_not_void: a_system_id /= Void
		do
			Result := a_receiver
		ensure
			document_validator_not_void: Result /= Void
		end
	
feature {NONE} -- Implementation

	saved_base_uri: UT_URI
			-- Bodge - saved base URI from `entity_resolver'`

invariant

	entity_resolver_not_void: initialized implies entity_resolver /= Void
	output_resolver_not_void: initialized implies output_resolver /= Void
	error_listener_not_void: initialized implies error_listener /= Void
	error_reporter_not_void: initialized implies error_reporter /= Void
	encoder_factory_not_void: initialized implies encoder_factory /= Void
	extension_functions_not_void: initialized implies extension_functions /= Void
	final_execution_phase_in_range: initialized implies final_execution_phase <= Run_to_completion and then final_execution_phase >= Stop_after_principal_source
	media_type_map_not_void: initialized implies media_type_map /= Void
	default_action: initialized implies not (default_action_suppressed and then warns_on_default_action)
	message_emitter_factory_not_void: initialized implies message_emitter_factory /= Void

end

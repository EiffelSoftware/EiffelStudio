indexing

	description:

		"Objects that encapsulate an application of a template"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XSLT_APPLY_TEMPLATES_PACKAGE

inherit

	XM_XPATH_TAIL_CALL

	XM_XSLT_TEMPLATE_ROUTINES

create

	make

feature {NONE} -- Initialization

	make (a_value: XM_XPATH_VALUE; a_mode: XM_XSLT_MODE; some_parameters, some_tunnel_parameters: XM_XSLT_PARAMETER_SET; a_context: XM_XSLT_EVALUATION_CONTEXT) is
			-- Establish invariant.
 		require
			selected_nodes_not_void: a_value /= Void
			major_context_not_void: a_context /= Void and then not a_context.is_minor
			some_parameters_not_void: some_parameters /= Void
			some_tunnel_parameters_not_void: some_tunnel_parameters /= Void
		do
			selected_nodes := a_value
			mode := a_mode
			actual_parameters := some_parameters
			tunnel_parameters := some_tunnel_parameters
			execution_context := a_context
		ensure
			mode_set: mode = a_mode
			selected_nodes_set: selected_nodes = a_value
			actual_parameters_set: actual_parameters = some_parameters
			tunnel_parameters_set: tunnel_parameters = some_tunnel_parameters
			execution_context_saved: execution_context = a_context
		end

feature -- Evaluation

	generate_tail_call (a_tail: DS_CELL [XM_XPATH_TAIL_CALL]; a_context: XM_XSLT_EVALUATION_CONTEXT) is
			-- Execute `Current', writing results to the current `XM_XPATH_RECEIVER'.
		do
			selected_nodes.create_iterator (Void)
			if selected_nodes.last_iterator.is_error then
				a_context.transformer.report_fatal_error (selected_nodes.last_iterator.error_value)
			else
				apply_templates (a_tail, selected_nodes.last_iterator,
									  mode,
									  actual_parameters,
									  tunnel_parameters,
									  execution_context
									  )
			end
		end

feature {NONE} -- Implementation

	selected_nodes: XM_XPATH_VALUE
			-- Sequence of nodes to be evaluated.

	mode: XM_XSLT_MODE
			-- mode

	actual_parameters: XM_XSLT_PARAMETER_SET
			-- Non-tunnel parameters

	tunnel_parameters: XM_XSLT_PARAMETER_SET
			-- Tunnel parameters

	execution_context: XM_XSLT_EVALUATION_CONTEXT
			-- Saved execution context

invariant

	selected_nodes_not_void: selected_nodes /= Void
	saved_context_not_void: execution_context /= Void
	parameters_not_void: actual_parameters /= Void
	tunnel_parameters_not_void: tunnel_parameters /= Void
	
end
	

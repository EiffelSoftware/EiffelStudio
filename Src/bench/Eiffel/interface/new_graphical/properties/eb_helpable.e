indexing
	description	: "Windows that contain contextual help"
	date			: "$Date$"
	revision		: "$Revision$"

deferred class
	EB_HELPABLE

inherit
	EB_HELP_CONTEXTS_BASES
		export
			{NONE} all;
			{ANY} is_valid_base_id, is_valid_url
		end

feature --Access

	window: EV_TITLED_WINDOW is
			-- Window to add contextual help to
		deferred
		end

	help_base_id: INTEGER is
			-- Identifier of base URL for help files
		deferred
		end

feature -- Basic Operations

	add_help_context (a_help_context_builder: FUNCTION [ANY, TUPLE, EB_HELP_CONTEXT]; a_widget: EV_WIDGET) is
			-- Add help context builder `a_help_context' to widget `a_widget'.
		require
			non_void_help_context: a_help_context_builder /= Void
			non_void_widget: a_widget /= Void
			widget_in_window: window.has_recursive (a_widget)
		do
			a_widget.set_help_context (a_help_context_builder)
		end

	build_interface is
			-- Connect default help context.
		do
			window.set_help_context (~default_help_context (help_base_id, Root_index))
		end

feature 

	default_help_context (a_base_id: INTEGER; a_url: STRING): EB_HELP_CONTEXT is
			-- Default help context builder
		require
			valid_base_id: is_valid_base_id (a_base_id)
			valid_url: is_valid_url (a_url)
		do
			create Result.make (a_base_id, a_url)
		end

end -- class EB_HELPABLE


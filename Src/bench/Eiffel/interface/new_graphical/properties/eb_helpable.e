indexing
	description	: "Windows that contain contextual help"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			window.set_help_context (agent default_help_context (help_base_id, Root_index))
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_HELPABLE


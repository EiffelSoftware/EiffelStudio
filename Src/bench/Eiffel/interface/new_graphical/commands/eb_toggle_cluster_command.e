indexing
	description: "Objects that is a command to show/hide cluster figures in diagram"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TOGGLE_CLUSTER_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_toolbar_item,
			description,
			initialize
		end

	EB_CONTEXT_DIAGRAM_TOGGLE_COMMAND

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize default values.
		do
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_m),
				True, False, False)
			accelerator.actions.extend (agent execute)
		end

feature -- Basic operations

	execute is
			-- Perform operation.
		do
			if is_sensitive then
				if tool.world.is_cluster_shown then
					tool.world.hide_clusters
					tool.projector.full_project
				else
					tool.world.show_clusters
					tool.projector.full_project
				end
				if tool.world.is_cluster_shown then
					enable_select
				else
					disable_select
				end
			end
		end

	new_toolbar_item (display_text: BOOLEAN): EB_COMMAND_TOGGLE_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		do
			create Result.make (Current)
			current_button := Result
			if tool.world.is_cluster_shown then
				Result.toggle
			end
			initialize_toolbar_item (Result, display_text)
			Result.select_actions.extend (agent execute)
		end

feature -- Access

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			if current_button.is_selected then
				Result := Interface_names.f_diagram_hide_clusters
			else
				Result := Interface_names.f_diagram_show_clusters
			end
		end

feature {NONE} -- Implementation

	pixmap: EV_PIXMAP is
			-- Pixmap representing the command.
		do
			Result := Pixmaps.icon_display_clusters
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.l_diagram_clusters_visibility
		end

	name: STRING is "Clusters_visibility"
			-- Name of the command. Used to store the command in the
			-- preferences.

feature {EB_CONTEXT_EDITOR} -- Implementation

	current_button: EB_COMMAND_TOGGLE_TOOL_BAR_BUTTON;
			-- Current toggle button.

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

end -- class EB_TOGGLE_CLUSTER_COMMAND

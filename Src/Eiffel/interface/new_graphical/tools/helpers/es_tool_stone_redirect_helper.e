indexing
	description: "[
		A helper class for tools to redirect a dropped stone to a well known stone tool.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ES_TOOL_STONE_REDIRECT_HELPER

inherit
	EB_RECYCLABLE

create
	make

feature {NONE} -- Initialization

	make (a_window: like development_window)
			-- Initialze the redirect helper for a development window
			--
			-- `a_window': The development window to redirect drop actions to
		require
			a_window_attached: a_window /= Void
			not_a_window_is_recycled: not a_window.is_recycled
		do
			development_window := a_window
		ensure
			development_window_set: development_window = a_window
		end

feature {NONE} -- Clean up

	internal_recycle is
			-- To be called when the button has became useless.
		do
			development_window := Void
		ensure then
			development_window_detached: development_window = Void
		end

feature {NONE} -- Access

	development_window: EB_DEVELOPMENT_WINDOW
			-- Development window to redirect actions to

feature -- Basic operations

	bind (a_widget: EV_WIDGET)
			-- Bind drop actions to a widget.
			--
			-- `a_widget': Widget to bind common drop actions to.
		require
			a_widget_attached: a_widget /= Void
			not_a_widget_is_destroyed: not a_widget.is_destroyed
		do
			register_action (a_widget.drop_actions, agent drop_breakable)
			register_action (a_widget.drop_actions, agent drop_class)
			register_action (a_widget.drop_actions, agent drop_feature)
			register_action (a_widget.drop_actions, agent drop_cluster)
		end

	unbind (a_widget: EV_WIDGET)
			-- Unbinds drop actions to a widget.
			--
			-- `a_widget': Widget to unbind common drop actions to.
		require
			a_widget_attached: a_widget /= Void
		do
			a_widget.drop_actions.compare_objects
			a_widget.drop_actions.prune (agent drop_breakable)
			a_widget.drop_actions.prune (agent drop_class)
			a_widget.drop_actions.prune (agent drop_feature)
			a_widget.drop_actions.prune (agent drop_cluster)
		end

feature {NONE} -- Redirects

	drop_breakable (a_stone: BREAKABLE_STONE) is
			-- Redirects a breakpoint stone.
			--
			-- `a_stone': Stone to redirect the drop actions to.
		require
			not_is_recycled: not is_recycled
			a_stone_attached: a_stone /= Void
		local
			bpm: BREAKPOINTS_MANAGER
		do
			bpm := development_window.debugger_manager.breakpoints_manager
			if bpm.is_breakpoint_enabled (a_stone.routine, a_stone.index) then
				bpm.remove_breakpoint (a_stone.routine, a_stone.index)
			else
				bpm.set_breakpoint (a_stone.routine, a_stone.index)
			end
			bpm.notify_breakpoints_changes
		end

	drop_class (a_stone: CLASSI_STONE) is
			-- Redirects a class stone.
			--
			-- `a_stone': Stone to redirect the drop actions to.
		require
			not_is_recycled: not is_recycled
			a_stone_attached: a_stone /= Void
		local
			l_class_tool: ES_CLASS_TOOL_PANEL
			l_feature_tool: ES_FEATURES_RELATION_TOOL_PANEL
			l_feature_stone: FEATURE_STONE
		do
			l_feature_stone ?= a_stone
			if l_feature_stone /= Void then
				l_feature_tool := development_window.tools.features_relation_tool
				l_feature_tool.set_stone (a_stone)
				l_feature_tool.content.show
				l_feature_tool.content.set_focus
				l_feature_tool.set_focus
			else
				l_class_tool := development_window.tools.class_tool
				l_class_tool.set_stone (a_stone)
				l_class_tool.content.show
				l_class_tool.content.set_focus
				l_class_tool.set_focus
			end
		end

	drop_feature (a_stone: FEATURE_STONE) is
			-- Redirects a feature stone.
			--
			-- `a_stone': Stone to redirect the drop actions to.
		require
			not_is_recycled: not is_recycled
			a_stone_attached: a_stone /= Void
		local
			l_feature_tool: ES_FEATURES_RELATION_TOOL_PANEL
		do
			l_feature_tool := development_window.tools.features_relation_tool
			l_feature_tool.set_stone (a_stone)
			l_feature_tool.content.show
			l_feature_tool.content.set_focus
			l_feature_tool.set_focus
		end

	drop_cluster (a_stone: CLUSTER_STONE) is
			-- Redirects a cluster stone.
			--
			-- `a_stone': Stone to redirect the drop actions to.
		require
			not_is_recycled: not is_recycled
			a_stone_attached: a_stone /= Void
		do
			development_window.tools.launch_stone (a_stone)
		end

invariant
	development_window_attached: not is_recycled implies development_window /= Void
	not_development_window_is_recycled: not is_recycled implies not development_window.is_recycled

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end

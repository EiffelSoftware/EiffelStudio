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
		redefine
			internal_detach_entities
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: ?like development_window)
			-- Initialze the redirect helper for a development window
			--
			-- `a_window': The development window to redirect drop actions to
		require
			a_window_attached: a_window /= Void
			a_window_is_interface_usable: a_window.is_interface_usable
		do
			development_window := a_window
		ensure
			development_window_set: development_window = a_window
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do

		end

	internal_detach_entities
			-- <Precusor>
		do
			development_window := Void
			Precursor
		ensure then
			development_window_detached: development_window = Void
		end

feature {NONE} -- Access

	development_window: ?EB_DEVELOPMENT_WINDOW
			-- Development window to redirect actions to

feature -- Basic operations

	bind (a_widget: ?EV_WIDGET; a_recycler: ?EB_RECYCLABLE)
			-- Bind drop actions to a widget.
			--
			-- `a_widget': Widget to bind common drop actions to.
			-- `a_recycler': The recycler to use to register and clean up the drop actions.
		require
			a_widget_attached: a_widget /= Void
			not_a_widget_is_destroyed: not a_widget.is_destroyed
		do
			a_recycler.register_action (a_widget.drop_actions, agent on_drop)
		end

	unbind (a_widget: EV_WIDGET; a_recycler: ?EB_RECYCLABLE)
			-- Unbinds drop actions to a widget.
			-- Note: This doesn't have to be called because binding with a recycler will unregister
			--       any bound actions automatically. Only use this when explicit unbinding is required.
			--
			-- `a_widget': Widget to unbind common drop actions to.
			-- `a_recycler': The recycler to use to clean up the drop actions.
		require
			a_widget_attached: a_widget /= Void
		do
			a_recycler.unregister_action (a_widget.drop_actions, agent on_drop)
		end

feature {NONE} -- Action handlers

	on_drop (a_stone: ?STONE)
			-- Drops the stone.
			--
			-- `a_stone': The dropped stone.
		require
			a_stone_attached: a_stone /= Void
		do
			if a_stone.is_valid then
				if {l_cluster: CLUSTER_STONE} a_stone then
					drop_cluster (l_cluster)
				elseif {l_feature: FEATURE_STONE} a_stone then
					drop_feature (l_feature)
				elseif {l_class: CLASSI_STONE} a_stone then
					drop_class (l_class)
				end
			end
		end

feature {NONE} -- Redirects

	drop_class (a_stone: !CLASSI_STONE)
			-- Redirects a class stone.
			--
			-- `a_stone': Stone to redirect the drop actions to.
		require
			is_interface_usable: is_interface_usable
			a_stone_is_valid: a_stone.is_valid
		local
			l_class_tool: ES_CLASS_TOOL
		do
			l_class_tool ?= development_window.shell_tools.tool ({ES_CLASS_TOOL})
			if l_class_tool /= Void and then l_class_tool.is_interface_usable then
				if {l_stonable: ES_STONABLE_I} l_class_tool then
					check
						refactored: False -- Remove check and remove OT else condition.
					end
					if l_stonable.is_stone_usable (a_stone) then
						l_stonable.set_stone_with_query (a_stone)
						l_class_tool.show (True)
					end
				else
						-- Tool has not been converted yet!
					l_class_tool.panel.set_stone (a_stone)
					l_class_tool.show (True)
				end
			end
		end

	drop_feature (a_stone: !FEATURE_STONE)
			-- Redirects a feature stone.
			--
			-- `a_stone': Stone to redirect the drop actions to.
		require
			is_interface_usable: is_interface_usable
			a_stone_is_valid: a_stone.is_valid
		local
			l_feature_tool: ES_FEATURE_RELATION_TOOL
		do
			l_feature_tool ?= development_window.shell_tools.tool ({ES_FEATURE_RELATION_TOOL})
			if l_feature_tool /= Void and then l_feature_tool.is_interface_usable then
				if {l_stonable: ES_STONABLE_I} l_feature_tool then
					check
						refactored: False -- Remove check and remove OT else condition.
					end
					if l_stonable.is_stone_usable (a_stone) then
						l_stonable.set_stone_with_query (a_stone)
						l_feature_tool.show (True)
					end
				else
						-- Tool has not been converted yet!
					l_feature_tool.panel.set_stone (a_stone)
					l_feature_tool.show (True)
				end
			end
		end

	drop_cluster (a_stone: !CLUSTER_STONE)
			-- Redirects a cluster stone.
			--
			-- `a_stone': Stone to redirect the drop actions to.
		require
			is_interface_usable: is_interface_usable
			a_stone_is_valid: a_stone.is_valid
		do
			development_window.tools.launch_stone (a_stone)
		end

invariant
	development_window_attached: is_interface_usable implies development_window /= Void
	not_development_window_is_recycled: is_interface_usable implies development_window.is_interface_usable

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

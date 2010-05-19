note
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

	make (a_window: detachable like development_window)
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

	development_window: detachable EB_DEVELOPMENT_WINDOW
			-- Development window to redirect actions to

feature -- Basic operations

	bind (a_widget: detachable EV_PICK_AND_DROPABLE_ACTION_SEQUENCES; a_recycler: detachable EB_RECYCLABLE)
			-- Bind drop actions to a widget.
			--
			-- `a_widget': Widget to bind common drop actions to.
			-- `a_recycler': The recycler to use to register and clean up the drop actions.
		require
			is_interface_usable: is_interface_usable
			a_widget_attached: a_widget /= Void
		do
			a_recycler.register_action (a_widget.drop_actions, agent on_drop)
			a_widget.drop_actions.set_veto_pebble_function (agent tool_veto_pebble_function)
		end

	unbind (a_widget: detachable EV_PICK_AND_DROPABLE_ACTION_SEQUENCES; a_recycler: detachable EB_RECYCLABLE)
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
			a_widget.drop_actions.set_veto_pebble_function (Void)
		end

feature -- Veto function

	tool_veto_pebble_function (a_stone: ANY): BOOLEAN
			-- Veto pebble function for the tool.
		do
			Result := attached {STONE} a_stone as st and then
						st.is_storable and then
						not attached {TARGET_STONE} a_stone
		end

feature {NONE} -- Action handlers

	on_drop (a_stone: STONE)
			-- Drops the stone.
			--
			-- `a_stone': The dropped stone.
		require
			a_stone_attached: a_stone /= Void
		do
			if a_stone.is_valid then
				if attached {CLUSTER_STONE} a_stone as l_cluster then
					drop_cluster (l_cluster)
				elseif attached {FEATURE_STONE} a_stone as l_feature then
					drop_feature (l_feature)
				elseif attached {CLASSI_STONE} a_stone as l_class then
					drop_class (l_class)
				end
			end
		end

feature {NONE} -- Redirects

	drop_class (a_stone: CLASSI_STONE)
			-- Redirects a class stone.
			--
			-- `a_stone': Stone to redirect the drop actions to.
		require
			is_interface_usable: is_interface_usable
			a_stone_is_valid: a_stone /= Void and then a_stone.is_valid
		local
			l_result: BOOLEAN
		do
			-- Note: need adding codes for new tools here
			-- Or we can adding features like `try_find_es_tool_under_pointer', but have to loop all tools to find
			-- out the ES_TOOL which is not efficient
			l_result := try_drop_class (a_stone, development_window.shell_tools.tool ({ES_CLASS_TOOL}))
			if not l_result then
				l_result := try_drop_class (a_stone, development_window.shell_tools.tool ({ES_DEPENDENCY_TOOL}))
			end
		end

	try_drop_class (a_stone: CLASSI_STONE; a_tool: ES_TOOL [EB_TOOL]): BOOLEAN
			-- Try drop `a_stone' onto `a_tool' if possible
			-- Result True means dropping stone succeeded
		require
			not_void: a_stone /= Void
			is_interface_usable: is_interface_usable
			a_stone_is_valid: a_stone.is_valid
		local
			l_screen: EV_SCREEN
			l_tool_widget: EV_WIDGET
		do
			if a_tool /= Void and then a_tool.is_interface_usable then
				create l_screen

				if
					a_tool.is_tool_instantiated and
					attached l_screen.widget_at_mouse_pointer as l_widget
				then
					-- Now we check if `a_tool' is under mouse pointer now
					l_tool_widget := a_tool.panel.widget
					if
						(l_tool_widget = l_widget) or else
						(	-- Cannot use {EV_CONTAINER}.has_recursive here because of ES_EDITOR_TOKEN_GRID
							-- Details please check bug#16737
							attached {EV_CONTAINER} l_tool_widget as l_container and then
							is_parent_recursive (l_widget, l_container)
						)
					then

						if attached {ES_STONABLE_I} a_tool as l_stonable then
							check
								refactored: False -- Remove check and remove OT else condition.
							end
							if l_stonable.is_stone_usable (a_stone) then
								l_stonable.set_stone_with_query (a_stone)
								a_tool.show (True)
								Result := True
							end
						else
								-- Tool has not been converted yet!
							if attached {EB_STONABLE_TOOL} a_tool.panel as l_stonable_tool then
								l_stonable_tool.set_stone (a_stone)
								a_tool.show (True)
								Result := True
							end
						end
					end
				else
					-- Drop action without a mouse? You are debugging workbench EiffelStudio, or...?
				end
			end
		end

	drop_feature (a_stone: FEATURE_STONE)
			-- Redirects a feature stone.
			--
			-- `a_stone': Stone to redirect the drop actions to.
		require
			is_interface_usable: is_interface_usable
			a_stone_is_valid: a_stone /= Void and then a_stone.is_valid
		do
			if
				attached {ES_FEATURE_RELATION_TOOL} development_window.shell_tools.tool ({ES_FEATURE_RELATION_TOOL}) as l_feature_tool and then
				l_feature_tool.is_interface_usable
			then
				if attached {ES_STONABLE_I} l_feature_tool as l_stonable then
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

	drop_cluster (a_stone: CLUSTER_STONE)
			-- Redirects a cluster stone.
			--
			-- `a_stone': Stone to redirect the drop actions to.
		require
			is_interface_usable: is_interface_usable
			a_stone_is_valid: a_stone /= Void and then a_stone.is_valid
		do
			development_window.tools.launch_stone (a_stone)
		end

	is_parent_recursive (a_child: EV_WIDGET; a_parent: EV_CONTAINER): BOOLEAN
			-- Sometimes cannot using {EV_CONTAINER}.has_recursive because of SD_MIDDLE_CONTAINER
			-- So query it reversely
			-- This feature is checking if `a_parent' is parent of (parent of...) `a_child'
		require
			a_child_attached: a_child /= Void
			a_parent_attached: a_parent /= Void
		do
			if attached a_child.parent as l_child_parent then
				if l_child_parent = a_parent then
					Result := True
				else
					Result := is_parent_recursive (l_child_parent, a_parent)
				end
			end
		end

invariant
	development_window_attached: is_interface_usable implies development_window /= Void
	not_development_window_is_recycled: is_interface_usable implies development_window.is_interface_usable

;note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

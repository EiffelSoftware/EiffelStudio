indexing
	description: "[
		Tool for viewing the active editor's list of feature clauses and features.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_FEATURES_TOOL_PANEL

inherit
	ES_DOCKABLE_STONABLE_TOOL_PANEL [EB_FEATURES_TREE]
		rename
			user_widget as features_tree
		redefine
			on_after_initialized,
			internal_recycle,
			create_mini_tool_bar_items
		end

	ES_FEATURES_TOOL_COMMANDER_I
		export
			{ES_TOOL} all
		end

create {ES_FEATURES_TOOL}
	make

feature {NONE} -- User interface initialization

    build_tool_interface (a_widget: EB_FEATURES_TREE) is
            -- Builds the tools user interface elements.
            -- Note: This function is called prior to showing the tool for the first time.
            --
            -- `a_widget': A widget to build the tool interface using.
		do

		end

    on_after_initialized
            -- Use to perform additional creation initializations, after the UI has been created.
        local
        	l_session: like session_data
		do
			Precursor {ES_DOCKABLE_STONABLE_TOOL_PANEL}

			if session_manager.is_service_available then
					-- Hook up events
				l_session := session_data
				l_session.value_changed_event.subscribe (agent on_session_value_changed)

					-- Retrieve session data and set button states
				if {l_toggle1: !BOOLEAN_REF} l_session.value_or_default (show_alias_session_id, False) then
					if l_toggle1.item then
						show_alias_button.enable_select
					else
						show_alias_button.disable_select
					end
				end
				if {l_toggle2: !BOOLEAN_REF} l_session.value_or_default (show_assigners_session_id, False) then
					if l_toggle2.item then
						show_assigners_button.enable_select
					else
						show_assigners_button.disable_select
					end
				end
				if {l_toggle3: !BOOLEAN_REF} l_session.value_or_default (show_signatures_session_id, False) then
					if l_toggle3.item then
						show_signatures_button.enable_select
					else
						show_signatures_button.disable_select
					end
				end
			end
		end

feature {NONE} -- Clean up

	internal_recycle is
			-- Recycle tool.
		do
			if is_initialized then
				if session_manager.is_service_available then
					session_data.value_changed_event.unsubscribe (agent on_session_value_changed)
				end
			end
			Precursor {ES_DOCKABLE_STONABLE_TOOL_PANEL}
		end

feature {NONE} -- User interface elements

	show_alias_button: SD_TOOL_BAR_TOGGLE_BUTTON
			-- Are alias' to be shown in the feature tree?

	show_assigners_button: SD_TOOL_BAR_TOGGLE_BUTTON
			-- Are assigners to be shown in the features tree?

	show_signatures_button: SD_TOOL_BAR_TOGGLE_BUTTON
			-- Are signatures to be shown in the features tree?	

feature {NONE} -- Access

	current_compiled_class: CLASS_C
			-- Last synchonrized class

feature {EB_FEATURES_TREE} -- Status report

	is_showing_alias: BOOLEAN
			-- Are alias' to be shown in the feature tree?
		do
			if is_initialized then
				Result := show_alias_button.is_selected
			end
		end

	is_showing_assigners: BOOLEAN
			-- Are assigners to be shown in the features tree?
		do
			if is_initialized then
				Result := show_assigners_button.is_selected
			end
		end

	is_showing_signatures: BOOLEAN
			-- Are signatures to be shown in the features tree?
		do
			if is_initialized then
				Result := show_signatures_button.is_selected
			end
		end

feature {ES_TOOL} -- Basic operations

	select_feature_item (a_feature: ?E_FEATURE)
			-- Selects a feature in the feature tree
			--
			-- `a_feature': The feature to select an assocated node in the feature tree.
		do
			if is_initialized then
				select_feature_item_by_data (a_feature, True)
			end
		end

	select_feature_item_by_name (a_feature: !STRING_GENERAL)
			-- Selects a feature in the feature tree, using a string name
			--
			-- `a_feature': The name of a feature to select an assocated node in the feature tree.
		do
			if is_initialized then
				select_feature_item_by_Data (a_feature, True)
			end
		end

feature {NONE} -- Basic operations

	select_feature_item_by_Data (a_data: ?ANY; a_compare_object: BOOLEAN)
			-- Selects a feature in the feature tree
			--
			-- `a_feature': The feature to select an assocated node in the feature tree.
			-- `a_compare_object': Indicates if an object comparison should be peform for tree-node matching.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_tree: like features_tree
		do
			l_tree := features_tree
			if a_data /= Void and then {l_node: !EV_TREE_NODE} l_tree.retrieve_item_recursively_by_data (a_data, a_compare_object) then
				l_node.enable_select
				if l_tree.is_displayed then
					l_tree.ensure_item_visible (l_node)
				end
			elseif {l_selected_node: !EV_TREE_NODE} l_tree.selected_item then
					-- No node located so deselect any selected node.
				l_selected_node.disable_select
			end
		end

feature {NONE} -- Event handlers

	on_session_value_changed (a_session: SESSION; a_id: STRING_8) is
			-- Called when the session changes
			--
			-- `a_session': Session object which the change occured in.
			-- `a_id': The identifier of the changed session value.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_session_attached: a_session /= Void
			a_session_is_interface_usable: a_session.is_interface_usable
		local
			l_button: SD_TOOL_BAR_TOGGLE_BUTTON
		do
			if a_id.is_equal (show_alias_session_id) then
				l_button := show_alias_button
			elseif a_id.is_equal (show_assigners_session_id) then
				l_button := show_assigners_button
			elseif a_id.is_equal (show_signatures_session_id) then
				l_button := show_signatures_button
			end

			if l_button /= Void then
				if {l_toggle: !BOOLEAN_REF} a_session.value_or_default (a_id, False) then
					if l_toggle.item then
						l_button.enable_select
					else
						l_button.disable_select
					end
					l_button.select_actions.call ([])
				end
			end
		end

feature {NONE} -- Action handlers

	on_show_alias_toggled
			-- Called when the show alias mini tool bar button is toggled
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
				-- Set session data
			if session_manager.is_service_available then
				session_data.set_value (show_alias_button.is_selected, show_alias_session_id)
			end
			features_tree.update_all
		end

	on_show_assigner_toggled
			-- Called when the show assigner mini tool bar button is toggled
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
				-- Set session data
			if session_manager.is_service_available then
				session_data.set_value (show_assigners_button.is_selected, show_assigners_session_id)
			end
			features_tree.update_all
		end

	on_show_signature_toggled
			-- Called when the show signature mini tool bar button is toggled
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
				-- Set session data
			if session_manager.is_service_available then
				session_data.set_value (show_signatures_button.is_selected, show_signatures_session_id)
			end
			features_tree.update_all
		end

	on_stone_changed
			-- Called when the set stone changes.
			-- Note: This routine can be called when `stone' is Void, to indicate a stone has been cleared.
			--       Be sure to check `is_in_stone_synchronization' to determine if a stone has change through an explicit
			--       setting or through compile synchronization.
		local
			l_class: CLASS_C
			l_tree: like features_tree
			l_class_ast: CLASS_AS
			l_container: EV_CONTAINER
		do
			l_tree := features_tree

			if {l_class_stone: !CLASSC_STONE} stone then
				l_class := l_class_stone.e_class

				if l_class /= current_compiled_class or is_in_stone_synchronization then
						-- Removes the tree from the parent to perform off-screen drawing.
					l_container := l_tree.parent
					l_container.prune (l_tree)

					l_tree.wipe_out
					if not l_class.is_external and then l_class.has_ast then
						current_compiled_class := l_class

						if l_class.is_precompiled then
							l_class_ast := l_class.ast
						elseif l_class.eiffel_class_c.file_is_readable then
							l_class_ast := l_class.eiffel_class_c.parsed_ast (False)
						end

						if l_class_ast /= Void then
							if l_tree.selected_item /= Void then
								l_tree.selected_item.disable_select
							end

							if {l_clauses: !EIFFEL_LIST [FEATURE_CLAUSE_AS]} l_class_ast.features then
									-- Build tree from AST nodes
								l_tree.build_tree (l_clauses, l_class)
							else
									-- No items
								l_tree.extend (create {EV_TREE_ITEM}.make_with_text (warning_messages.w_no_feature_to_display))
							end
						end
					elseif {l_external_classc: !EXTERNAL_CLASS_C} l_class then
							-- Special processing for a .NET type since has no 'ast' in the normal
							-- sense.
						current_compiled_class := l_class

						if l_tree.selected_item /= Void then
							l_tree.selected_item.disable_select
						end
						l_tree.wipe_out
						l_tree.build_tree_for_external (l_external_classc)
					end

						-- Add tree back to the container
					l_container.extend (l_tree)

					if not l_tree.is_empty and then l_tree.is_displayed then
						l_tree.ensure_item_visible (l_tree.first)
					end
				end
			else
				l_tree.wipe_out
				current_compiled_class := Void
			end
		end

feature {NONE} -- Factory

    create_widget: EB_FEATURES_TREE
            -- Create a new container widget upon request.
            -- Note: You may build the tool elements here or in `build_tool_interface'
		do
			create Result.make (Current, True)
		end

    create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- Retrieves a list of tool bar items to display at the top of the tool.
		do
			--| No tool bar
		end

    create_mini_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- Retrieves a list of tool bar items to display on the window title
		local
			l_window: like develop_window
			l_button: SD_TOOL_BAR_TOGGLE_BUTTON
        do
        	l_window := develop_window

        	create Result.make (4)

        	Result.put_last (l_window.commands.new_feature_cmd.new_mini_sd_toolbar_item)

        	create l_button.make
        	l_button.set_pixel_buffer (stock_mini_pixmaps.completion_show_alias_icon_buffer)
        	l_button.set_pixmap (stock_mini_pixmaps.completion_show_alias_icon)
        	l_button.set_tooltip (interface_names.f_show_alias)
        	register_action (l_button.select_actions, agent on_show_alias_toggled)
        	Result.put_last (l_button)
        	show_alias_button := l_button

        	create l_button.make
        	l_button.set_pixel_buffer (stock_mini_pixmaps.completion_show_assigner_icon_buffer)
        	l_button.set_pixmap (stock_mini_pixmaps.completion_show_assigner_icon)
        	l_button.set_tooltip (interface_names.f_show_assigner)
        	register_action (l_button.select_actions, agent on_show_assigner_toggled)
        	Result.put_last (l_button)
        	show_assigners_button := l_button

        	create l_button.make
        	l_button.set_pixel_buffer (stock_mini_pixmaps.completion_show_signature_icon_buffer)
        	l_button.set_pixmap (stock_mini_pixmaps.completion_show_signature_icon)
        	l_button.set_tooltip (interface_names.f_show_signature)
        	register_action (l_button.select_actions, agent on_show_signature_toggled)
        	Result.put_last (l_button)
        	show_signatures_button := l_button
        end

feature {NONE} -- Constants

	show_alias_session_id: STRING_8 = "com.eiffel.features_tool.show_alias"
	show_assigners_session_id: STRING_8 = "com.eiffel.features_tool.show_assigners"
	show_signatures_session_id: STRING_8 = "com.eiffel.features_tool.show_signature"
			-- Session IDs

invariant
	show_assigners_button_attached: is_initialized and is_interface_usable implies
		show_assigners_button /= Void
	show_alias_button_attached: is_initialized and is_interface_usable implies
		show_alias_button /= Void
	show_signatures_button_attached: is_initialized and is_interface_usable implies
		show_signatures_button /= Void

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

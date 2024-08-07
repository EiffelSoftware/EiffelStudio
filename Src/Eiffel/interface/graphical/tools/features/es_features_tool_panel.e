﻿note
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
	ES_DOCKABLE_STONABLE_TOOL_PANEL [ES_FEATURES_GRID]
		rename
			user_widget as features_tree
		redefine
			on_after_initialized,
			internal_recycle,
			is_stone_sychronization_required,
			create_mini_tool_bar_items
		end

	ES_HELP_CONTEXT
		export
			{NONE} all
		end

	ES_FEATURES_TOOL_COMMANDER_I
		export
			{ES_FEATURES_TOOL_COMMANDER_I} all
		end

	SESSION_EVENT_OBSERVER
		export
			{NONE} all
		redefine
			on_session_value_changed
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

create {ES_FEATURES_TOOL}
	make

feature {NONE} -- User interface initialization

    build_tool_interface (a_widget: ES_FEATURES_GRID)
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

			if attached session_manager.service then
					-- Hook up events
				l_session := session_data

					-- Retrieve session data and set button states
				if attached {BOOLEAN_REF} l_session.value_or_default (show_alias_session_id, False) as l_toggle1 then
					if l_toggle1.item then
						show_alias_button.enable_select
					else
						show_alias_button.disable_select
					end
				end
				if attached {BOOLEAN_REF} l_session.value_or_default (show_assigners_session_id, False) as l_toggle2 then
					if l_toggle2.item then
						show_assigners_button.enable_select
					else
						show_assigners_button.disable_select
					end
				end
				if attached {BOOLEAN_REF} l_session.value_or_default (show_signatures_session_id, False) as l_toggle3 then
					if l_toggle3.item then
						show_signatures_button.enable_select
					else
						show_signatures_button.disable_select
					end
				end

				l_session.session_connection.connect_events (Current)
			end
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			if
				is_initialized and then
				attached session_manager.service as s and then
				session_data.session_connection.is_connected (Current)
			then
				session_data.session_connection.disconnect_events (Current)
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

feature -- Access: Help

	help_context_id: STRING_32
			-- <Precursor>
		once
			Result := {STRING_32} "BC9B2EF1-B4C4-773A-9BA8-97143FB2727A"
		end

feature {ES_FEATURES_GRID} -- Status report

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

feature {NONE} -- Status report

	is_stone_sychronization_required (a_old_stone: detachable STONE; a_new_stone: detachable STONE): BOOLEAN
			-- <Precursor>
		do
				-- Always update the view.
			Result := True
		end

feature {ES_TOOL} -- Basic operations

	select_feature_item (a_feature: detachable E_FEATURE)
			-- Selects a feature in the feature tree
			--
			-- `a_feature': The feature to select an assocated node in the feature tree.
		do
			if is_initialized then
				select_feature_item_by_data (a_feature, True)
			end
		end

	select_feature_item_by_name (a_feature: attached STRING_GENERAL)
			-- Selects a feature in the feature tree, using a string name
			--
			-- `a_feature': The name of a feature to select an assocated node in the feature tree.
		do
			if is_initialized then
				select_feature_item_by_Data (a_feature, True)
			end
		end

feature {NONE} -- Basic operations

	select_feature_item_by_Data (a_data: detachable ANY; a_compare_object: BOOLEAN)
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
			if a_data /= Void and then attached l_tree.retrieve_row_recursively_by_data (a_data, a_compare_object) as l_row then
				l_row.enable_select
				if l_row.is_displayed then
					l_row.ensure_visible
				end
			elseif attached l_tree.selected_row as l_selected_row then
					-- No node located so deselect any selected node.
				l_selected_row.disable_select
			end
		end

feature {NONE} -- Event handlers

	on_session_value_changed (a_session: SESSION; a_id: READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			l_button: SD_TOOL_BAR_TOGGLE_BUTTON
		do
			if a_id.same_string (show_alias_session_id) then
				l_button := show_alias_button
			elseif a_id.same_string (show_assigners_session_id) then
				l_button := show_assigners_button
			elseif a_id.same_string (show_signatures_session_id) then
				l_button := show_signatures_button
			end

			if l_button /= Void then
				if attached {BOOLEAN_REF} a_session.value_or_default (a_id, False) as l_toggle then
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
			if attached session_manager.service then
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
			if attached session_manager.service then
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
			if attached session_manager.service then
				session_data.set_value (show_signatures_button.is_selected, show_signatures_session_id)
			end
			features_tree.update_all
		end

	on_stone_changed (a_old_stone: detachable like stone)
			-- Called when the set stone changes.
			-- Note: This routine can be called when `stone' is Void, to indicate a stone has been cleared.
			--       Be sure to check `is_in_stone_synchronization' to determine if a stone has change through an explicit
			--       setting or through compile synchronization.
		local
			l_class: detachable CLASS_C
			l_tree: like features_tree
			l_class_ast: CLASS_AS
			l_container: EV_CONTAINER
		do
			l_tree := features_tree

			if attached {CLASSC_STONE} stone as l_classc_stone then
				l_class := l_classc_stone.e_class
			elseif attached {CLASSI_STONE} stone as l_classi_stone then
				if attached l_classi_stone.class_i as l_classi then
					if l_classi.is_compiled then
						l_class := l_classi.compiled_class
					end
				end
			end
			if l_class /= Void then
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
								-- Note that this code will perform a parsing if the file
								-- has been modified and saved in EiffelStudio and not yet
								-- recompiled by the compiler.
							l_class_ast := l_class.eiffel_class_c.parsed_ast (False)
								-- Clear error handler, as per-note in parsed_ast
							error_handler.wipe_out
						end

						if l_class_ast /= Void then
							if attached l_tree.selected_row as l_row then
								l_row.disable_select
							end
							if attached l_class_ast.features as l_clauses then
									-- Build tree from AST nodes
								l_tree.build_tree (l_clauses, l_class, l_class_ast)
							else
									-- No items
								l_tree.extend_item (create {EV_GRID_LABEL_ITEM}.make_with_text (warning_messages.w_no_feature_to_display))
							end
						end
					elseif attached {EXTERNAL_CLASS_C} l_class as l_external_classc then
							-- Special processing for a .NET type since has no 'ast' in the normal
							-- sense.
						current_compiled_class := l_class

						if attached l_tree.selected_row as l_row2 then
							l_row2.disable_select
						end
						l_tree.wipe_out
						l_tree.build_tree_for_external (l_external_classc)
					end

						-- Add tree back to the container
					l_container.extend (l_tree)

					if not l_tree.is_empty and then l_tree.is_displayed then
						l_tree.ensure_first_row_visible
					end
				end
			else
				l_tree.wipe_out
				current_compiled_class := Void
			end
		end

feature {NONE} -- Factory

    create_widget: ES_FEATURES_GRID
            -- Create a new container widget upon request.
            -- Note: You may build the tool elements here or in `build_tool_interface'
		do
			create Result.make (Current, True)
		end

    create_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- Retrieves a list of tool bar items to display at the top of the tool.
		do
			--| No tool bar
		end

    create_mini_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- Retrieves a list of tool bar items to display on the window title
		local
			l_window: like develop_window
			l_button: SD_TOOL_BAR_TOGGLE_BUTTON
        do
        	l_window := develop_window

        	create Result.make (4)

        	Result.extend (l_window.commands.new_feature_cmd.new_mini_sd_toolbar_item)

        	create l_button.make
        	l_button.set_pixel_buffer (stock_mini_pixmaps.completion_show_alias_icon_buffer)
        	l_button.set_pixmap (stock_mini_pixmaps.completion_show_alias_icon)
        	l_button.set_tooltip (interface_names.f_show_alias)
        	register_action (l_button.select_actions, agent on_show_alias_toggled)
        	Result.extend (l_button)
        	show_alias_button := l_button

        	create l_button.make
        	l_button.set_pixel_buffer (stock_mini_pixmaps.completion_show_assigner_icon_buffer)
        	l_button.set_pixmap (stock_mini_pixmaps.completion_show_assigner_icon)
        	l_button.set_tooltip (interface_names.f_show_assigner)
        	register_action (l_button.select_actions, agent on_show_assigner_toggled)
        	Result.extend (l_button)
        	show_assigners_button := l_button

        	create l_button.make
        	l_button.set_pixel_buffer (stock_mini_pixmaps.completion_show_signature_icon_buffer)
        	l_button.set_pixmap (stock_mini_pixmaps.completion_show_signature_icon)
        	l_button.set_tooltip (interface_names.f_show_signature)
        	register_action (l_button.select_actions, agent on_show_signature_toggled)
        	Result.extend (l_button)
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

;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

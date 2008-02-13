indexing
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_CONTRACT_TOOL_PANEL

inherit
	ES_DOCKABLE_STONABLE_TOOL_PANEL [EV_HORIZONTAL_BOX]
		redefine
			internal_recycle,
			create_mini_tool_bar_items,
			create_right_tool_bar_items
		end

	ES_MODIFIABLE
		undefine
			internal_detach_entities
		redefine
			internal_recycle
		end

create {ES_CONTRACT_TOOL}
	make

feature {NONE} -- Initialization

    build_tool_interface (a_widget: EV_HORIZONTAL_BOX)
            -- Builds the tools user interface elements.
            -- Note: This function is called prior to showing the tool for the first time.
            --
            -- `a_widget': A widget to build the tool interface using.
		local
--			l_button: EV_BUTTON
		do
			create contract_view
			a_widget.extend (contract_view)

			--create contract_editor.make
			--a_widget.extend (contract_editor.widget)
		end

feature {NONE} -- Clean up

	internal_recycle
			-- To be called when the button has became useless.
			-- Note: It's recommended that you do not detach objects here.
		do
			Precursor {ES_MODIFIABLE}
			Precursor {ES_DOCKABLE_STONABLE_TOOL_PANEL}
		end

feature -- Access

	context_feature: ?E_ROUTINE
			-- Current feature being edited.
			-- Note: It's called `context_feature' because



feature {NONE} -- User interface elements

	contract_view: ?EV_TEXT
			-- Test

	add_contract_button: ?SD_TOOL_BAR_BUTTON
			-- Button to add a new contract to the current feature

	remove_contract_button: ?SD_TOOL_BAR_BUTTON
			-- Button to remove a selected contract

	show_callers_button: ?SD_TOOL_BAR_BUTTON
			-- Button to show the callers of the edited feature

	contract_editor: ?ES_CONTRACT_EDITOR_WIDGET
			-- The editor used to edit the contracts

feature {NONE} -- Basic operations

	update
			-- Updates the view with a compiled feature
		local
			l_text: STRING_32
			l_feature: FEATURE_I
			l_class: CLASS_C
			l_class_as: CLASS_AS
			l_feature_as: FEATURE_AS
			l_routine_as: ROUTINE_AS
			l_require_as: REQUIRE_AS
			l_assertions: EIFFEL_LIST [TAGGED_AS]
			l_assertion: TAGGED_AS
			l_yank: YANK_STRING_WINDOW
			l_class_text: STRING_8
			l_assert_server: ASSERTION_SERVER
			l_cassert: CHAINED_ASSERTIONS
			l_decorator: FEAT_TEXT_FORMATTER_DECORATOR
		do
			create l_text.make_empty
			if {l_routine: !like context_feature} context_feature then
				l_text.append (l_routine.feature_signature + "%N")
				l_feature := l_routine.associated_class.feature_of_feature_id (l_routine.feature_id)
				if l_feature /= Void then
					l_class := context_feature.written_class
					if l_class /= Void then
						l_class_text := l_class.text
						l_class_as := l_class.ast
						if l_class_as /= Void and {l_name: !STRING_GENERAL} l_routine.name then
							l_feature_as := l_class_as.feature_of_name (l_name, False)

							create l_assert_server.make_for_feature (l_feature, l_feature_as)
							l_cassert := l_assert_server.current_assertion

							create l_yank.make
							create l_decorator.make (l_class, l_yank)
							--l_decorator.set_context_group (l_class.group)
							l_decorator.init_feature_context (l_feature, l_feature, l_feature_as)
							l_cassert.format_precondition (l_decorator)

							l_text.append (l_yank.stored_output)

--							l_routine_as ?= l_feature_as.body.content
--							if l_routine_as /= Void then
--								l_require_as := l_routine_as.precondition
--								if l_require_as /= Void then
--									l_assertions := l_require_as.assertions
--									if l_assertions /= Void and then not l_assertions.is_empty then

--										from l_assertions.start until l_assertions.after loop
--											l_assertion := l_assertions.item
--											if l_assertion /= Void then
--												l_yank.put_string (l_class_text.substring (l_assertion.start_position, l_assertion.end_position))
--												l_yank.put_new_line
--												l_yank.put_new_line
--											end
--											l_assertions.forth
--										end

--									end
--									l_text.append (l_yank.stored_output)
--								end
--							end
						end
					end
					if l_routine.has_precondition then
						l_text.append ("PRECONDITIONS: %N")
					end
				else
					check False end
				end
			end
			contract_view.set_text (l_text)
		end



feature {NONE} -- Action handlers

	on_stone_changed
			-- Called when the set stone changes.
			-- Note: This routine can be called when `stone' is Void, to indicate a stone has been cleared.
			--       Be sure to check `is_in_stone_synchronization' to determine if a stone has change through an explicit
			--       setting or through compile synchronization.
		do
			if {l_stone: !FEATURE_STONE} stone then
				context_feature ?= l_stone.e_feature
				add_contract_button.enable_sensitive
				remove_contract_button.enable_sensitive
				show_callers_button.enable_sensitive
			else
				context_feature := Void
				add_contract_button.disable_sensitive
				remove_contract_button.disable_sensitive
				show_callers_button.disable_sensitive
			end
			update
		end

	on_show_callers
			-- Called when the user chooses to show the callers of the edited contracts
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			context_feature_attached: context_feature /= Void
		do
			if {l_feature: !E_FEATURE} context_feature then
				if {l_tool: !ES_FEATURE_RELATION_TOOL} develop_window.shell_tools.tool ({ES_FEATURE_RELATION_TOOL}) then
						-- Display feature relation tool using callers mode.
					l_tool.set_mode_with_stone ({ES_FEATURE_RELATION_TOOL_VIEW_MODES}.callers, create {!FEATURE_STONE}.make (l_feature))
					l_tool.show (True)
				end
			end
		end

	on_add_contract
			-- Called when the user chooses to add a new contract to the existing feature.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			context_feature_attached: context_feature /= Void
		do

		end

	on_remove_contract
			-- Called when the user chooses to remove a contract from the existing feature.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			context_feature_attached: context_feature /= Void
		do

		end

feature {NONE} -- Factory

    create_widget: EV_HORIZONTAL_BOX
            -- Create a new container widget upon request.
            -- Note: You may build the tool elements here or in `build_tool_interface'
		do
			create Result
		end

	create_mini_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items to display on the window title
		do
--			create Result.make (1)
--			Result.put_last (create {SD_TOOL_BAR_WIDGET_ITEM}.make (address_manager.header_info))
--			register_action (address_manager.label_changed_actions, agent
--					-- Register actions to automatically resize the toolbar
--				do
--					if is_interface_usable and is_initialized then
--						develop_window.docking_manager.update_mini_tool_bar_size (content)
--					end
--				end)
--			Result.put_last (history_toolbar)
		end

    create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- Retrieves a list of tool bar items to display at the top of the tool.
		local
			l_button: SD_TOOL_BAR_BUTTON
		do
			create Result.make (2)

				-- Add contract button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.general_add_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.general_add_icon)
			l_button.set_tooltip ("Adds a new contract.")
			l_button.disable_sensitive
			register_action (l_button.select_actions, agent on_add_contract)
			add_contract_button := l_button
			Result.put_last (l_button)

				-- Remove contract button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.general_remove_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.general_remove_icon)
			l_button.set_tooltip ("Removes the selected contract(s).")
			l_button.disable_sensitive
			register_action (l_button.select_actions, agent on_remove_contract)
			remove_contract_button := l_button
			Result.put_last (l_button)
		end

	create_right_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items that should be displayed at the top, but right aligned.
			-- Note: Redefine to add a right tool bar.
		local
			l_button: SD_TOOL_BAR_BUTTON
		do
			create Result.make (1)

				-- Show callers button
			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.feature_callees_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.feature_callees_icon)
			l_button.set_tooltip ("Show the callers of the currently edited feature.")
			l_button.disable_sensitive
			register_action (l_button.select_actions, agent on_show_callers)
			show_callers_button := l_button
			Result.put_last (l_button)
		end

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

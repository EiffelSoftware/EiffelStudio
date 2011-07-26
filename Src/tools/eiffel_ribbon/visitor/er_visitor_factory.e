note
	description: "[
					Factory for visitors
																	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_VISITOR_FACTORY

feature -- Factory methods

	visitors: ARRAYED_LIST [ER_VISITOR]
			-- Visitors base on if using application mode or DLL for multi window support
		local
			l_misc_constants: ER_MISC_CONSTANTS
		do
			create l_misc_constants
			if l_misc_constants.is_using_application_mode.item then
				Result := visitors_for_application_modes
			else
				Result := visitors_for_dll
			end
		end

feature {NONE} -- Implementation

	visitors_for_application_modes: ARRAYED_LIST [ER_VISITOR]
			--
		local
			l_vision2_visitor: ER_LOAD_VISION_TREE_AM_VISITOR
			l_command_updater: ER_UPDATE_COMMAND_AM_VISITOR
			l_separate_tab_visitor: ER_SEPARATE_WINDOW_TAB_AM_VISITOR
			l_drop_down_gallery_visitor: ER_DROP_DOWN_GALLERY_INFO_AM_VISITOR
			l_update_application_menu: ER_UPDATE_APPLICATION_MENU_INFO_AM_VISITOR
			l_split_button_gallery_visitor: ER_SPLIT_BUTTON_GALLERY_INFO_AM_VISITOR
			l_update_context_popups_visitor: ER_UPDATE_CONTEXT_POPUP_AM_VISITOR
			l_load_help_button_visitor: ER_LOAD_HELP_BUTTON_AM_VISITOR
			l_load_quick_access_toolbar_visitor: ER_LOAD_QUICK_ACCESS_TOOLBAR_AM_VISITOR
			l_size_definition_visitor: ER_SIZE_DEFINITION_AM_VISITOR
		do
			create Result.make (10)

			create l_vision2_visitor
			Result.extend (l_vision2_visitor)

			create l_separate_tab_visitor.make
			Result.extend (l_separate_tab_visitor)

			create l_drop_down_gallery_visitor
			Result.extend (l_drop_down_gallery_visitor)

			create l_split_button_gallery_visitor
			Result.extend (l_split_button_gallery_visitor)

			create l_update_application_menu
			Result.extend (l_update_application_menu)

			create l_update_context_popups_visitor
			Result.extend (l_update_context_popups_visitor)

			create l_load_help_button_visitor
			Result.extend (l_load_help_button_visitor)

			create l_load_quick_access_toolbar_visitor
			Result.extend (l_load_quick_access_toolbar_visitor)

			create l_command_updater
			Result.extend (l_command_updater)

			create l_size_definition_visitor
			Result.extend (l_size_definition_visitor)
		end

	visitors_for_dll: ARRAYED_LIST [ER_VISITOR]
			--
		local
			l_vision2_visitor: ER_LOAD_VISION_TREE_VISITOR
			l_command_updater: ER_UPDATE_COMMAND_VISITOR
			l_separate_tab_visitor: ER_SEPARATE_WINDOW_TAB_VISITOR
			l_drop_down_gallery_visitor: ER_DROP_DOWN_GALLERY_INFO_VISITOR
			l_update_application_menu: ER_UPDATE_APPLICATION_MENU_INFO_VISITOR
			l_split_button_gallery_visitor: ER_SPLIT_BUTTON_GALLERY_INFO_VISITOR
			l_update_context_popups_visitor: ER_UPDATE_CONTEXT_POPUP_VISITOR
			l_load_help_button_visitor: ER_LOAD_HELP_BUTTON_VISITOR
			l_load_quick_access_toolbar_visitor: ER_LOAD_QUICK_ACCESS_TOOLBAR_VISITOR
			l_size_definition_visitor: ER_SIZE_DEFINITION_VISITOR
			l_contextual_tabs_visitor: ER_CONTEXTUAL_TABS_VISITOR
		do
			create Result.make (10)

			create l_vision2_visitor
			Result.extend (l_vision2_visitor)

			create l_separate_tab_visitor.make
			Result.extend (l_separate_tab_visitor)

			create l_drop_down_gallery_visitor
			Result.extend (l_drop_down_gallery_visitor)

			create l_split_button_gallery_visitor
			Result.extend (l_split_button_gallery_visitor)

			create l_update_application_menu
			Result.extend (l_update_application_menu)

			create l_update_context_popups_visitor
			Result.extend (l_update_context_popups_visitor)

			create l_load_help_button_visitor
			Result.extend (l_load_help_button_visitor)

			create l_load_quick_access_toolbar_visitor
			Result.extend (l_load_quick_access_toolbar_visitor)

			create l_contextual_tabs_visitor
			Result.extend (l_contextual_tabs_visitor)

			create l_command_updater
			Result.extend (l_command_updater)

			create l_size_definition_visitor
			Result.extend (l_size_definition_visitor)

		end

end

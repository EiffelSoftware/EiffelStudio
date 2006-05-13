indexing
	description: "Objects that represents a quick search tool binded to an {EVS_SEARCHABLE_COMPONENT} object"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRID_QUICK_SEARCH_TOOL

inherit
	EVS_GRID_SEARCH_TOOL
		undefine
			copy,
			is_equal,
			default_create
		end

	QUICK_SEARCH_BAR
		rename
			make as make_search_bar
		redefine
			user_initialization
		end

	EVS_UTILITY
		undefine
			copy,
			is_equal,
			default_create
		end

	EB_CLASS_BROWSER_UTILITY
		undefine
			copy,
			is_equal,
			default_create
		end

	REFACTORING_HELPER
		undefine
			copy,
			is_equal,
			default_create
		end

create
	make

feature{NONE} -- Initialization

	make (a_dev_window: EB_DEVELOPMENT_WINDOW) is
			-- Initialization
		require
			a_dev_window_attached: a_dev_window /= Void
		do
			make_search_bar (a_dev_window.search_tool)
		end

	user_initialization is
			-- Called by `initialize'.
		do
			Precursor
			advanced_button.disable_sensitive
			previous_button.select_actions.extend (agent search_previous (False))
			next_button.select_actions.extend (agent search_next (False))
			close_button.select_actions.extend (agent hide_tool)
			set_key_press_action (agent on_key_pressed_on_search_tool)
			keyword_field.change_actions.extend (agent on_keyword_field_text_change)
		end

feature -- Registration/Implementation

	internal_attach is
			-- Attach current to `a_component'.
		do
			put_tool
			set_activate_accelerator (accelerator_from_preference ("show_quick_search_bar"))
			set_deactivate_accelerator (accelerator_from_preference ("hide_quick_search_bar"))
			set_search_next_accelerator (accelerator_from_preference ("search_selection"))
			set_search_previous_accelerator (accelerator_from_preference ("search_backward"))
			set_store_keyword_accelerator (accelerator_from_preference ("store_search_keyword"))
			safe_register_agent (on_key_pressed_agent, searchable_component.grid.key_press_actions)
			hide
		end

	internal_detach is
			-- Detach current to `a_componet'.
		do
			remove_tool
			safe_remove_agent (on_key_pressed_agent, searchable_component.grid.key_press_actions)
			hide
		end

feature -- Display

	show_tool is
			-- Display current search tool.
		do
			show
		end

	hide_tool is
			-- Hide current search tool.
		do
			hide
		end

	ensure_tool_on_top is
			-- Ensure current quick search bar be displayed on top of grid.
		do
			is_tool_on_top := True
			put_tool
		ensure
			tool_on_top: is_tool_on_top
		end

	ensure_tool_on_bottom is
			-- Ensure current quick search bar be displayed on bottom of grid.
		do
			is_tool_on_top:= False
			put_tool
		ensure
			tool_on_bottom: is_tool_on_bottom
		end

feature -- Setting

	set_activate_accelerator (a_accelerator: like activate_accelerator) is
			-- Set `activate_accelerator' with `a_accelerator'.
		do
			activate_accelerator := a_accelerator
		ensure
			activate_accelerator_set: activate_accelerator = a_accelerator
		end

	set_deactivate_accelerator (a_accelerator: like deactivate_accelerator) is
			-- Set `active_accelerator' with `a_accelerator'.
		do
			deactivate_accelerator := a_accelerator
		ensure
			deactivate_accelerator_set: deactivate_accelerator = a_accelerator
		end

	set_search_previous_accelerator (a_accelerator: like search_previous_accelerator) is
			-- Set `search_previous_accelerator' with `a_accelerator'.
		do
			search_previous_accelerator := a_accelerator
		ensure
			search_previous_accelerator_set: search_previous_accelerator = a_accelerator
		end

	set_search_next_accelerator (a_accelerator: like search_next_accelerator) is
			-- Set `search_next_accelerator' with `a_accelerator'.
		do
			search_next_accelerator := a_accelerator
		ensure
			search_next_accelerator_set: search_next_accelerator = a_accelerator
		end

	set_store_keyword_accelerator (a_accelerator: like store_keyword_accelerator) is
			-- Set `store_keyword_accelerator' with `a_accelerator'.
		do
			store_keyword_accelerator := a_accelerator
		ensure
			store_keyword_accelerator_set: store_keyword_accelerator = a_accelerator
		end

feature -- Status report

	is_tool_displayed: BOOLEAN is
			-- Is current search tool displayed?
		do
			Result := is_displayed
		end

	is_tool_on_top: BOOLEAN
			-- Is current quick search bar on top of grid?

	is_tool_on_bottom: BOOLEAN is
			-- Is current quick search bar on bottom of grid?
		do
			Result := not is_tool_on_top
		ensure
			good_result: Result implies not is_tool_on_top
		end

feature -- Accelerator

	activate_accelerator: EV_ACCELERATOR
			-- Accelerator to show current quick search tool
			-- This accelerator will be registered in `searchable_component'.`grid'.

	deactivate_accelerator: EV_ACCELERATOR
			-- Key accelerator to deactivate current quick search tool

	search_previous_accelerator: EV_ACCELERATOR
			-- Accelerator to search previous

	search_next_accelerator: EV_ACCELERATOR
			-- Accelerator to search next

	store_keyword_accelerator: EV_ACCELERATOR
			-- Key accelerator to store current search keyword in search bar
			-- and do a search next

feature{NONE} -- Actions

	on_key_pressed_agent: PROCEDURE [ANY, TUPLE [EV_KEY]] is
			-- Agent wrapper of `on_key_pressed'
		do
			if on_key_pressed_agent_internal = Void then
				on_key_pressed_agent_internal := agent on_key_pressed
			end
			Result := on_key_pressed_agent_internal
		ensure
			result_attached: Result /= Void
		end

	on_key_pressed_agent_internal: like on_key_pressed_agent
			-- Internal `on_key_pressed_agent'

	on_key_pressed (a_key: EV_KEY) is
			-- Action performed when key pressed in `searchable_component'.`grid'
		require
			attached: is_tool_attached
			a_key_attached: a_key /= Void
		local
			l_component: like searchable_component
			l_acc: EV_ACCELERATOR
		do
			l_component := searchable_component
			if l_component.is_search_enabled then
					-- Key accelerator to show quick search bar
				l_acc := activate_accelerator
				if l_acc = Void then
					l_acc := ctrl_f_accelerator
				end
				if is_accelerator_matched (a_key, l_acc) then
					if not is_displayed and then l_component.is_search_enabled then
						show_tool
					end
				end
					-- Key accelerator to search previous
				l_acc := search_previous_accelerator
				if l_acc /= Void and then is_accelerator_matched (a_key, l_acc) then
					search_previous (False)
				end
					-- Key accelerator to search next
				l_acc := search_next_accelerator
				if l_acc /= Void and then is_accelerator_matched (a_key, l_acc) then
					search_next (False)
				end
			end
		end

	on_key_pressed_on_search_tool (a_key: EV_KEY) is
			-- On key pressed on any widget of search bar.
		local
			l_acc: EV_ACCELERATOR
		do
			l_acc := accelerator_from_preference ("hide_quick_search_bar")
			if l_acc = Void then
				l_acc := escape_accelerator
			end
			if is_accelerator_matched (a_key, l_acc) then
				hide_tool
			end
			l_acc := accelerator_from_preference ("store_search_keyword")
			if l_acc = Void then
				l_acc := enter_accelerator
			end
			if is_accelerator_matched (a_key, l_acc) then
				record_current_searched
				search_next (False)
			end
			l_acc := search_next_accelerator
			if l_acc /= Void and then is_accelerator_matched (a_key, l_acc) then
				search_next (False)
			end
			l_acc := search_previous_accelerator
			if l_acc /= Void and then is_accelerator_matched (a_key, l_acc) then
				search_previous (False)
			end
		end

	on_keyword_field_text_change is
			-- Action to be performed when text in keyword field changes
		do
			if keyword_field.text.count > 0 then
				search_next (True)
			end
		end

	enter_accelerator: EV_ACCELERATOR is
			-- Enter accelerator key
		once
			create Result.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_enter), False, False, False)
		ensure
			result_attached: Result /= Void
		end

	escape_accelerator: EV_ACCELERATOR is
			-- Escape accelerator key
		once
			create Result.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_escape), False, False, False)
		ensure
			result_attached: Result /= Void
		end

	Ctrl_f_accelerator: EV_ACCELERATOR is
			-- Ctrl + F accelerator key
		once
			create Result.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_f5), True, False, False)
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implementation/Search

	search_previous (a_start_from_current: BOOLEAN) is
			-- Search previous according to current first selected item in `searchable_component'.`grid'.
			-- If `a_start_from_current' is True, search will start from current selected item, if any,
			-- otherwise, it will start from next item of current selected item.			
		require
			attached: is_tool_attached
			search_enabled: searchable_component.is_search_enabled
		do
			search_with_direction (True, a_start_from_current)
		end

	search_next (a_start_from_current: BOOLEAN) is
			-- Search next according to current first selected item in `searchable_component'.`grid'.
			-- If `a_start_from_current' is True, search will start from current selected item, if any,
			-- otherwise, it will start from next item of current selected item.			
		require
			attached: is_tool_attached
			search_enabled: searchable_component.is_search_enabled
		do
			search_with_direction (False, a_start_from_current)
		end

	prepare_search_engine (a_engine: like search_engine) is
			-- Prepare `a_engine' for search,
			-- e.g. setup search conditions.
		require
			a_engine_attached: a_engine /= Void
		local
			l_search_engine: like search_engine
		do
			a_engine.enable_wrap_search
			a_engine.set_keyword (current_keyword)
			if is_case_sensitive then
				a_engine.enable_case_sensitive_match
			else
				a_engine.disable_case_sensitive_match
			end
			if is_regex then
				a_engine.enable_regular_expression_match
			else
				a_engine.disable_regular_expression_match
			end
			a_engine.enable_wrap_search
			-- Fixme: match whole word and match whole cell should be implemented.
			to_implement ("Implement code here to test if `match whole word' is selected.")
		end

feature{NONE} -- Implementation/Layout

	put_tool is
			-- Put current quick search bar into `searchable_component'.
		require
			attached: is_tool_attached
		local
			l_source_container: EV_BOX
			l_target_container: EV_BOX
		do
			if is_tool_on_top then
				l_source_container := searchable_component.grid_bottom_container
				l_target_container := searchable_component.grid_top_container
			else
				l_source_container := searchable_component.grid_top_container
				l_target_container := searchable_component.grid_bottom_container
			end
			remove_tool_from_container (l_source_container)
			put_tool_into_container (l_target_container)
		ensure
			tool_in_container:
				(is_tool_on_top implies searchable_component.grid_top_container.has (Current) and
				is_tool_on_bottom implies searchable_component.grid_bottom_container.has (Current))
		end

	remove_tool is
			-- Remove current quick search bar from `searchable_component'.
		require
			attached: is_tool_attached
		do
			if is_tool_on_top then
				remove_tool_from_container (searchable_component.grid_top_container)
			else
				remove_tool_from_container (searchable_component.grid_bottom_container)
			end
		ensure
			tool_removed:
				(not searchable_component.grid_top_container.has (Current) and
				 not searchable_component.grid_bottom_container.has (Current))
		end

	put_tool_into_container (a_container: EV_BOX) is
			-- Put current quick search bar into `a_container'.
		require
			attached: is_tool_attached
			a_container_attached: a_container /= Void
		do
			if not a_container.has (Current) then
				a_container.extend (Current)
				a_container.disable_item_expand (Current)
			end
		ensure
			tool_in_container: a_container.has (Current)
		end

	remove_tool_from_container (a_container: EV_BOX) is
			-- Remove current quick search bar from `a_container'.			
		require
			attached: is_tool_attached
			a_container_attached: a_container /= Void
		do
			a_container.search (Current)
			if not a_container.exhausted then
				a_container.remove
			end
		ensure
			tool_removed: not a_container.has (Current)
		end

feature{NONE} -- Implementation

	current_keyword: STRING is
			-- Current keyword
		do
			Result := keyword_field.text
		ensure
			result_attached: Result /= Void
		end

	search_engine: EB_CLASS_BROWSER_QUICK_SEARCH_ENGINE is
			-- Search engine
		do
			if search_engine_internal = Void then
				create search_engine_internal
				search_engine_internal.ensure_search_by_row
			end
			Result := search_engine_internal
		ensure
			result_attached: Result /= Void
		end

	search_engine_internal: like search_engine
			-- Internal `search_engine'

	search_with_direction (a_previous: BOOLEAN; a_start_from_current: BOOLEAN) is
			-- If `a_previsou' is True, search forward, otherwise backward.
			-- If `a_start_from_current' is True, search will start from current selected item, if any,
			-- otherwise, it will start from next item of current selected item.			
		require
			attached: is_tool_attached
			search_enabled: searchable_component.is_search_enabled
		local
			l_engine: like search_engine
		do
			if not current_keyword.is_empty then
				l_engine := search_engine
				if a_previous then
					l_engine.ensure_search_backward
				else
					l_engine.ensure_search_foreward
				end
				prepare_search_engine (l_engine)
				l_engine.search (searchable_component, a_start_from_current)
				if not l_engine.last_result.is_empty then
					searchable_component.ensure_visible (l_engine.last_result.first, True)
					keyword_field.set_background_color (normal_bgcolor)
				else
					keyword_field.set_background_color (no_result_bgcolor)
				end
			end
		end

	no_result_bgcolor: EV_COLOR is
			-- Background color when no result for incremental search.
		do
			Result := preferences.search_tool_data.none_result_keyword_field_background_color
		end

	normal_bgcolor: EV_COLOR is
			-- Normal background color.
		local
			l_comb: EV_COMBO_BOX
		once
			create l_comb
			Result := l_comb.background_color
		end

invariant
	search_bar_position_correct:
		(is_tool_on_top implies not is_tool_on_bottom) and (not is_tool_on_top implies is_tool_on_bottom)

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


end

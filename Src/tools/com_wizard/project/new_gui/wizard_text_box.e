indexing
	description: "Common parents to all text boxes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_TEXT_BOX

inherit
	WIZARD_SAVED_SETTINGS
		export
			{NONE} all;
			{ANY} max_count, set_max_count
		end

	WIZARD_CONSTANTS
		export
			{NONE} all
		end

	WIZARD_SHARED_PROFILE_MANAGER
		export
			{NONE} all
		end

	ANY

feature -- Initialization

	setup (a_label: STRING; a_key: like key; a_text_processor: like text_processor; a_enter_processor: like enter_processor; a_select_processor: like select_processor) is
			-- Set `text_processor' with `a_text_processor'.
			-- Set `key' with `a_key'.
			-- Set `label' with `a_label'.
			-- Must be called right after object creation.
		require
			non_void_path_processor: a_text_processor /= Void
			non_void_key: a_key /= Void
			non_void_label: a_label /= Void
		local
			l_default: EV_LIST_ITEM
		do
			text_processor := a_text_processor
			enter_processor := a_enter_processor
			select_processor := a_select_processor
			key := a_key
			text_label.set_text (a_label)
			initialize_combo (text_combo, key)
			-- Trigger validity checking
			if text_combo.text.is_empty then
				create l_default.make_with_text (default_text)
				text_combo.extend (l_default)
				l_default.enable_select
			end
			on_select
			if not excluded then
				Profile_manager.active_profile_change_actions.extend (agent on_profile_change)
				Profile_manager.active_profile_save_actions.extend (agent profile_item)
			end
		ensure
			path_processor_set: text_processor = a_text_processor
			key_set: key = a_key
			label_set: text_label.text.is_equal (a_label)
		end

	user_initialization is
			-- Feature for custom initialization, called at end of `initialize'.
		do
			-- Initialize background color
			on_mouse_leave
		end

feature -- Access

	value: STRING is
			-- Combo box selected entry
		do
			Result := text_combo.text
		end

	profile_item: WIZARD_PROFILE_ITEM is
			-- Corresponding profile item
		do
			create Result.make (key, text_combo.text)
		end

	default_text: STRING is
			-- Default text when combo is empty
		do
			if internal_default_text /= Void then
				Result := internal_default_text
			else
				Result := "(none)"
			end
		end

	save_on_return: BOOLEAN is
			-- Should items be saved when `return' is hit?
			-- True by default.
		do
			if internal_save_on_return = Void then
				Result := True
			else
				Result := internal_save_on_return.item
			end
		end

feature -- Status Report

	excluded: BOOLEAN
			-- Is widget excluded from profile?

	is_default_selected: BOOLEAN is
			-- Is default item selected?
		do
			Result := text_combo.text.is_equal (default_text)
		end

feature -- Basic Operations

	save_combo_text is
			-- Save content to combo text as new combo entry.
		local
			l_text: STRING
		do
			l_text := text_combo.text
			if not l_text.is_empty then
				add_combo_item (l_text, text_combo)
			end
		end

	exclude_from_profile is
			-- Do not save settings in profile
		do
			excluded := True
		end

	remove_active_item is
			-- Remove selected item from list.
		do
			text_combo.start
			text_combo.remove
			text_combo.set_text (text_combo.first.text)
		end

	initialize_focus is
			-- Give focus to combo.
		do
			text_combo.set_focus
		end

feature -- Element Change

	set_default_text (a_text: like default_text) is
			-- Set `default_text' with `a_text'.
		require
			non_void_default_text: a_text /= Void
		do
			internal_default_text := a_text
		ensure
			default_text_set: default_text = a_text
		end

	set_save_on_return (a_value: like save_on_return) is
			-- Set `save_on_return' with `a_value'.
		do
			if internal_save_on_return = Void then
				create internal_save_on_return
			end
			internal_save_on_return.set_item (a_value)
		ensure
			save_on_return_set: save_on_return = a_value
		end

feature {NONE} -- Events Handling

	on_change is
			-- Called by `change_actions' of `path_combo'.
		local
			l_status: WIZARD_VALIDITY_STATUS
			l_text: STRING
		do
			if not excluded then
				Profile_manager.save_active_profile
			end
			l_text := text_combo.text
			if text_processor /= Void then
				l_status := text_processor.item ([l_text])
				if l_status.is_error then
					text_combo.set_foreground_color (Invalid_value_color)
					text_combo.set_tooltip (l_status.error_message)
				else
					text_combo.remove_tooltip
					text_combo.set_foreground_color (Valid_value_color)
					if auto_save then
						save_combo_text
					end
				end
			end
		end

	on_return is
			-- Called by `return_actions' of `path_combo'.
			-- Save text
		do
			if save_on_return then
				save_combo_text
			end
			if enter_processor /= Void then
				enter_processor.call (Void)
			end
		end

	on_select is
			-- Called by `select_actions' of `path_combo'.
		do
			if select_processor /= Void then
				select_processor.call (Void)
			end
		end

	on_mouse_enter is
			-- Called by `pointer_enter_actions' of `text_combo'.
			-- Change background color to active background color.
		do
			text_combo.set_background_color (Active_background)
		end

	on_mouse_leave is
			-- Called by `pointer_enter_actions' of `text_combo'.
			-- Change background color to inactive background color.
		do
			text_combo.set_background_color (Inactive_background)
		end

	on_profile_change is
			-- Active profile changed, update values accordingly.
		do
			Profile_manager.search_active_profile (key)
			if Profile_manager.found then
				text_combo.set_text (Profile_manager.found_item.value)
			else
				text_combo.set_text (default_text)
			end
		end

feature {NONE} -- Private Access

	text_processor: FUNCTION [ANY, TUPLE [STRING], WIZARD_VALIDITY_STATUS]
			-- Process combo text upon changes
			-- Return validity status

	enter_processor: PROCEDURE [ANY, TUPLE []]
			-- Process `enter' key press

	select_processor: PROCEDURE [ANY, TUPLE []]
			-- Process `enter' key press

	key: STRING
			-- Key used to store and retrieve combo box items

	text_combo: EV_COMBO_BOX is
			-- Text combo
		deferred
		end

	text_label: EV_LABEL is
			-- Caption label
		deferred
		end

	auto_save: BOOLEAN
			-- If `True' then text of combo is persisted after each change that
			-- yield to a valid content

	internal_default_text: STRING
			-- Default text internal cache

	internal_save_on_return: BOOLEAN_REF;
			-- Cell for `save_on_return'

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
end -- class WIZARD_TEXT_BOX



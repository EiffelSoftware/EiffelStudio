indexing
	description: "Common parents to all text boxes"
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

feature -- Initialization

	setup (a_label: STRING; a_key: like key; a_text_processor: like text_processor; a_enter_processor: like enter_processor) is
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
			key := a_key
			text_label.set_text (a_label)
			initialize_combo (text_combo, key)
			if text_combo.text.is_empty then
				-- Trigger validity checking
				create l_default.make_with_text (default_text)
				text_combo.extend (l_default)
				l_default.enable_select
			end
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
			text_combo.first.enable_select
		end
		
feature -- Element Change

	set_default_text (a_text: STRING) is
			-- Set `default_text' with `a_text'.
		require
			non_void_default_text: a_text /= Void
		do
			internal_default_text := a_text
		ensure
			default_text_set: default_text = a_text
		end
	
feature {NONE} -- Events Handling

	on_change is
			-- Called by `change_actions' of `path_combo'.
		local
			l_valid: BOOLEAN
			l_text: STRING
		do
			if not excluded then
				Profile_manager.save_active_profile
			end
			l_text := text_combo.text
			if l_text.is_empty then
				text_combo.change_actions.block
				text_combo.set_text (default_text)
				text_combo.change_actions.resume
				l_text := default_text
			end
			if text_processor /= Void then
				l_valid := text_processor.item ([l_text])
				if l_valid then
					text_combo.set_foreground_color (Valid_value_color)
					if auto_save then
						save_combo_text
					end
				else
					text_combo.set_foreground_color (Invalid_value_color)
				end
			end
		end

	on_return is
			-- Called by `return_actions' of `path_combo'.
			-- Save text
		do
			save_combo_text
			if enter_processor /= Void then
				enter_processor.call (Void)
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

	text_processor: FUNCTION [ANY, TUPLE [STRING], BOOLEAN]
			-- Process combo text upon changes

	enter_processor: PROCEDURE [ANY, TUPLE []]
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

end -- class WIZARD_TEXT_BOX


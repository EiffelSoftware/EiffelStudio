indexing
	description: "Common parents to all text boxes"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_TEXT_BOX

inherit
	WIZARD_SAVED_SETTINGS
		export
			{NONE} all
		end

	WIZARD_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	setup (a_label: STRING; a_key: like key; a_text_processor: like text_processor) is
			-- Set `text_processor' with `a_text_processor'.
			-- Set `key' with `a_key'.
			-- Set `label' with `a_label'.
			-- Must be called right after object creation.
		require
			non_void_path_processor: a_text_processor /= Void
			non_void_key: a_key /= Void
			non_void_label: a_label /= Void
		do
			text_processor := a_text_processor
			key := a_key
			text_label.set_text (a_label)
			initialize_combo (text_combo, key)
			if text_combo.text.is_empty then
				-- This is to trigger validity checking
				text_combo.set_text ("(none)")
			end
		ensure
			path_processor_set: text_processor = a_text_processor
			key_set: key = a_key
			label_set: text_label.text.is_equal (a_label)
		end

	user_initialization is
			-- Setup combo entries from values in registry if any.
		do
		end

feature -- Access

	value: STRING is
			-- Combo box selected entry
		do
			Result := text_combo.text
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

feature {NONE} -- Events Handling

	on_change is
			-- Called by `change_actions' of `path_combo'.
		local
			l_valid: BOOLEAN
		do
			if text_processor /= Void then
				l_valid := text_processor.item ([text_combo.text])
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

feature {NONE} -- Private Access

	text_processor: FUNCTION [ANY, TUPLE [STRING], BOOLEAN]
			-- Process combo text upon changes

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

end -- class WIZARD_TEXT_BOX


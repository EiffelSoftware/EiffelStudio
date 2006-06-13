indexing
	description: "Represent a tab page for a file rule."
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_RULE_TAB

inherit
	EV_VERTICAL_BOX
		redefine
			data
		end

	PROPERTY_GRID_LAYOUT
		undefine
			default_create,
			copy,
			is_equal
		end

	CONF_ACCESS
		undefine
			default_create,
			copy,
			is_equal
		end

	EB_LAYOUT_CONSTANTS
		undefine
			default_create,
			copy,
			is_equal
		end

	CONF_INTERFACE_NAMES
		undefine
			default_create,
			copy,
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_file_rule: CONF_FILE_RULE) is
			-- Create with `a_file_rule'.
		require
			a_file_rule_not_void: a_file_rule /= Void
		local
			l_frame: EV_FRAME
			l_btn: EV_BUTTON
			vb: EV_VERTICAL_BOX
			hb_main, hb: EV_HORIZONTAL_BOX
			l_label: EV_LABEL
		do
			default_create
			data := a_file_rule

			create hb_main
			extend (hb_main)

			append_small_margin (hb_main)

			create l_frame.make_with_text (dialog_file_rule_excludes)
			hb_main.extend (l_frame)
			hb_main.disable_item_expand (l_frame)
			create vb
			l_frame.extend (vb)
			vb.set_border_width (default_border_size)
			vb.set_padding (default_padding_size)

			if data.exclude /= Void then
				create exclude_pattern.make_with_strings (data.exclude)
			else
				create exclude_pattern
			end
			exclude_pattern.set_minimum_width (200)
			vb.extend (exclude_pattern)
			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			create new_exclude
			hb.extend (new_exclude)
			create l_btn.make_with_text_and_action (plus_button_text, agent add_exclude)
			l_btn.set_minimum_width (small_button_width)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			create l_btn.make_with_text_and_action (minus_button_text, agent remove_exclude)
			l_btn.set_minimum_width (small_button_width)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)

			append_small_margin (hb_main)


			create l_frame.make_with_text (dialog_file_rule_includes)
			hb_main.extend (l_frame)
			hb_main.disable_item_expand (l_frame)
			create vb
			l_frame.extend (vb)
			vb.set_padding (default_padding_size)
			vb.set_border_width (default_border_size)

			if data.include /= Void then
				create include_pattern.make_with_strings (data.include)
			else
				create include_pattern
			end
			include_pattern.set_minimum_width (200)
			vb.extend (include_pattern)
			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			create new_include
			hb.extend (new_include)
			create l_btn.make_with_text_and_action (plus_button_text, agent add_include)
			l_btn.set_minimum_width (small_button_width)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			create l_btn.make_with_text_and_action (minus_button_text, agent remove_include)
			l_btn.set_minimum_width (small_button_width)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)

			append_small_margin (hb_main)

			append_small_margin (Current)
			create l_label.make_with_text (dialog_file_rule_description)
			extend (l_label)
			disable_item_expand (l_label)
			l_label.align_text_left

			create description
			if data.description /= Void then
				description.set_text (data.description)
			end
			description.set_minimum_height (50)
			description.change_actions.extend (agent update_description)
			extend (description)
			disable_item_expand (description)

			append_small_margin (Current)
			create l_label.make_with_text (dialog_file_rule_condition)
			extend (l_label)
			disable_item_expand (l_label)
			l_label.align_text_left

			create hb
			extend (hb)
			disable_item_expand (hb)
			create condition
			hb.extend (condition)
			condition.disable_edit
			if data.internal_conditions /= Void then
				condition.set_text (data.internal_conditions.out)
			end

			create l_btn.make_with_text_and_action (dialog_file_rule_edit_condition, agent edit_condition)
			l_btn.set_minimum_width (default_button_width)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)

			append_small_margin (Current)
		ensure
			file_rule_set: data = a_file_rule
		end

feature -- Access

	data: CONF_FILE_RULE
			-- File rule this page represents.

feature {NONE} -- GUI elements

	exclude_pattern: EV_LIST
			-- List of exclude patterns.

	new_exclude: EV_TEXT_FIELD
			-- New exclude pattern to add.	

	include_pattern: EV_LIST
			-- List of include patterns.

	new_include: EV_TEXT_FIELD
			-- New include pattern to add.

	description: EV_TEXT
			-- Description field.

	condition: EV_TEXT_FIELD
			-- Display of conditions.

feature {NONE} -- Actions

	add_exclude is
			-- Add a new exclude pattern.
		local
			l_pattern: STRING
		do
			l_pattern := new_exclude.text.to_string_8
			if not l_pattern.is_empty and (data.exclude = Void or else not data.exclude.has (l_pattern)) then
				data.add_exclude (l_pattern)
				exclude_pattern.force (create {EV_LIST_ITEM}.make_with_text (l_pattern))
			end
		end

	add_include is
			-- Add a new include pattern.
		local
			l_pattern: STRING
		do
			l_pattern := new_include.text.to_string_8
			if not l_pattern.is_empty and (data.include = Void or else not data.include.has (l_pattern)) then
				data.add_include (l_pattern)
				include_pattern.force (create {EV_LIST_ITEM}.make_with_text (l_pattern))
			end
		end

	remove_exclude is
			-- Remove current selected exclude pattern.
		do
			if exclude_pattern.selected_item /= Void then
				data.exclude.start
				data.exclude.search (exclude_pattern.selected_item.text.to_string_8)
				data.exclude.remove
				exclude_pattern.start
				exclude_pattern.search (exclude_pattern.selected_item)
				exclude_pattern.remove
			end
		end

	remove_include is
			-- Remove current selected include pattern.
		do
			if include_pattern.selected_item /= Void then
				data.include.start
				data.include.search (include_pattern.selected_item.text.to_string_8)
				data.include.remove
				include_pattern.start
				include_pattern.search (include_pattern.selected_item)
				include_pattern.remove
			end
		end

	update_description is
			-- Update description.
		do
			data.set_description (description.text.to_string_8)
		end

	edit_condition is
			-- Edit conditions.
		local
			l_dial: CONDITION_DIALOG
		do
			create l_dial
			l_dial.set_value (data.internal_conditions)
			l_dial.show_modal_to_window (parent_window)
			if l_dial.is_ok then
				data.set_conditions (l_dial.value)
			end
			if data.internal_conditions /= Void then
				condition.set_text (data.internal_conditions.out)
			else
				condition.set_text ("")
			end
		end

	parent_window: EV_WINDOW is
			-- Return the parent window (if any).
		local
			l_parent: EV_CONTAINER
		do
			from
				l_parent := parent
			until
				Result /= Void or l_parent = Void
			loop
				Result ?= l_parent
				l_parent := l_parent.parent
			end
		end

invariant
	data_set: data /= Void
	gui_elements_created: is_initialized implies exclude_pattern /= Void and new_exclude /= Void and include_pattern /= Void and new_include /= Void

end

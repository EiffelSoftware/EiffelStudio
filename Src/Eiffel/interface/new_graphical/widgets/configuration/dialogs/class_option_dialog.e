indexing
	description: "Dialog for class options."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_OPTION_DIALOG

inherit
	PROPERTY_DIALOG [HASH_TABLE [CONF_OPTION, STRING]]
		redefine
			initialize,
			on_ok
		end

	OPTION_PROPERTIES
		undefine
			default_create, copy
		redefine
			refresh
		end

	EB_LAYOUT_CONSTANTS
		undefine
			default_create,
			copy
		end

	CONF_INTERFACE_NAMES
		undefine
			default_create,
			copy
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialization
		local
			hb, hb2: EV_HORIZONTAL_BOX
			vb, vb2: EV_VERTICAL_BOX
			l_btn: EV_BUTTON
			l_label: EV_LABEL
			l_frame: EV_FRAME
		do
			Precursor {PROPERTY_DIALOG}

			create hb
			element_container.extend (hb)

			create vb
			hb.extend (vb)
			hb.disable_item_expand (vb)
			vb.set_minimum_width (200)
			vb.set_padding (default_padding_size)
			vb.set_border_width (default_border_size)

			create class_list
			vb.extend (class_list)

			create l_label.make_with_text (dialog_class_option_class_name)
			l_label.align_text_left
			vb.extend (l_label)
			vb.disable_item_expand (l_label)

			create new_class
			vb.extend (new_class)
			vb.disable_item_expand (new_class)

			create hb2
			vb.extend (hb2)
			vb.disable_item_expand (hb2)

			hb2.extend (create {EV_CELL})
			create l_btn.make_with_text_and_action (plus_button_text, agent add_class)
			l_btn.set_minimum_width (small_button_width)
			hb2.extend (l_btn)
			hb2.disable_item_expand (l_btn)

			create l_btn.make_with_text_and_action (minus_button_text, agent remove_class)
			l_btn.set_minimum_width (small_button_width)
			hb2.extend (l_btn)
			hb2.disable_item_expand (l_btn)

			create vb2
			hb.extend (vb2)
			vb2.set_padding (default_padding_size)
			vb2.set_border_width (default_border_size)

			create properties
			vb2.extend (properties)

			create l_label
			properties.set_description_field (l_label)
			l_label.align_text_left
			create vb
			vb.set_minimum_height (50)
			vb.extend (l_label)
			vb.disable_item_expand (l_label)
			vb.extend (create {EV_CELL})
			create l_frame
			l_frame.set_style ({EV_FRAME_CONSTANTS}.ev_frame_lowered)
			l_frame.extend (vb)
			vb2.extend (l_frame)
			vb2.disable_item_expand (l_frame)

			set_size (500, 600)
			show_actions.extend (agent on_show)
		end

feature -- Update

	set_group_options (an_option: like group_options) is
			-- Set `group_options' to `an_option'.
		require
			an_option_not_void: an_option /= Void
		do
			group_options := an_option
		ensure
			group_options_set: group_options = an_option
		end

feature {NONE} -- Gui elements

	class_list: EV_LIST
			-- List of classes with special options.

	new_class: EV_TEXT_FIELD
			-- Text field to enter name of new class to add.

feature {NONE} -- Agents

	on_show is
			-- Called if the dialog is shown.
		require
			initialized: is_initialized
		do
			refresh
		end

	on_ok is
			-- Ok was pressed.
		local
			wd: EV_WARNING_DIALOG
		do
			if wd = Void then
				Precursor {PROPERTY_DIALOG}
			else
				wd.show_modal_to_window (Current)
			end
		end

	add_class is
			-- Add a new class.
		local
			l_name: STRING
		do
			l_name := new_class.text.as_upper
			if not (l_name.is_empty or (value /= Void and then value.has (l_name))) then
				if value = Void then
					create value.make (1)
				end
				value.force (create {CONF_OPTION}, l_name)
				current_class := l_name
				refresh
			end
		end

	remove_class is
			-- Remove a class.
		do
			if current_class /= Void then
				value.remove (current_class)
				current_class := Void
				refresh
			end
		end

	show_options (a_class: STRING) is
			-- Show options for `a_class'
		require
			properties_set: properties /= Void
			a_class_ok: value /= Void and then a_class /= Void and then value.has (a_class)
		do
			current_class := a_class

			properties.reset
			add_misc_option_properties (value.item (a_class), group_options, True)
			add_assertion_option_properties (value.item (a_class), group_options, True)
			add_warning_option_properties (value.item (a_class), group_options, True)
			add_debug_option_properties (value.item (a_class), group_options, True)
		ensure
			current_class_set: current_class = a_class
		end

feature {NONE} -- Implementation

	group_options: CONF_OPTION
			-- Options of the group this classes belong to.

	current_class: STRING
			-- Currently selected class.

	refresh is
			-- Refresh the displayed values.
		local
			l_sort: DS_ARRAYED_LIST [STRING]
			l_item: EV_LIST_ITEM
		do
			if value /= Void then
					-- sort class names alphabetically
				from
					create l_sort.make (value.count)
					value.start
				until
					value.after
				loop
					l_sort.put_last (value.key_for_iteration)
					value.forth
				end
				l_sort.sort (create {DS_QUICK_SORTER [STRING]}.make (create {KL_COMPARABLE_COMPARATOR [STRING]}.make))

				from
					class_list.wipe_out
					l_sort.start
				until
					l_sort.after
				loop
					create l_item.make_with_text (l_sort.item_for_iteration)
					l_item.select_actions.extend (agent show_options (l_sort.item_for_iteration))
					class_list.extend (l_item)
					if current_class /= Void and then current_class.is_equal (l_sort.item_for_iteration) then
						l_item.enable_select
					end
					l_sort.forth
				end
			end
		end

invariant
	elements: is_initialized implies class_list /= Void and new_class /= Void

end

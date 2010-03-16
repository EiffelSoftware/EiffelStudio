note

	description:
		"EiffelVision combo box, Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COMBO_BOX_IMP

inherit
	EV_COMBO_BOX_I
		undefine
			wipe_out,
			call_pebble_function
		redefine
			interface
		end

	EV_TEXT_FIELD_IMP
		undefine
			create_focus_in_actions,
			create_focus_out_actions,
			pre_pick_steps,
			call_pebble_function,
			enable_transport,
			hide_border
		redefine
			initialize,
			make,
			interface,
			has_focus,
			on_focus_changed,
			dispose,
			minimum_height,
			minimum_width,
			set_text,
			prepend_text,
			append_text
		end

	EV_LIST_ITEM_LIST_IMP
		undefine
			set_default_colors,
			destroy,
			on_key_event,
			default_key_processing_blocked,
			on_focus_changed,
			has_focus,
			set_focus,
			dispose,
			minimum_height,
			minimum_width,
			on_event
		redefine
			initialize,
			make,
			interface,
			insert_i_th,
			remove_i_th
		end

	EV_COMBO_BOX_ACTION_SEQUENCES_IMP

	EV_KEY_CONSTANTS

	HIVIEW_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a combo-box.
			-- How can we do this in carbon? We probably need a normal textfield alongside with an disclosure button control and ..?
		local
			rect: CGRECT_STRUCT
			size: CGSIZE_STRUCT
			point: CGPOINT_STRUCT
			cfs: CONTROL_FONT_STYLE_REC_STRUCT
			ret: INTEGER
			ptr: POINTER
		do
			-- Get initial positions right
			create rect.make_new_unshared
			create size.make_shared ( rect.size )
			create point.make_shared ( rect.origin )
			create cfs.make_new_unshared

			base_make (an_interface)
			ret := hicombo_box_create_external ( rect.item, null, null, null, {HIVIEW_ANON_ENUMS}.kHIComboBoxStandardAttributes, $ptr )
			set_c_object ( ptr )
			entry_widget := ptr

			show

			event_id := app_implementation.get_id ( current )
		end

	minimum_height: INTEGER
			--
		do
			Result := Precursor {EV_TEXT_FIELD_IMP}
		end


	minimum_width: INTEGER
			-- Strangely GetOptimalBounds doesn't seem to work here
		do
			Result := 30
		end

feature {NONE} -- Initialization

	call_selection_action_sequences
			-- Call the appropriate selection action sequences
		do

		end

	previous_selected_item_imp: EV_LIST_ITEM_IMP
		-- Item that was selected previously.

	initialize
			-- Connect action sequences to signals.
		do
			Precursor {EV_LIST_ITEM_LIST_IMP}
		end

	insert_i_th (v: like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			ret: INTEGER
			cfstring: EV_CARBON_CF_STRING
		do
			Precursor {EV_LIST_ITEM_LIST_IMP} (v, i)
			create cfstring.make_unshared_with_eiffel_string ( v.text )
			ret := hicombo_box_append_text_item_external ( c_object, cfstring.item, null )
		end

	remove_i_th (an_index: INTEGER)
		local
			ret: INTEGER
		do
			Precursor {EV_LIST_ITEM_LIST_IMP} (an_index)
			ret := hicombo_box_remove_item_at_index_external (c_object, (an_index -1))
		end




feature -- Status report

	has_focus: BOOLEAN
			-- Does widget have the keyboard focus?
		do

		end

	selected_item: EV_LIST_ITEM
			-- Item which is currently selected, for a multiple
			-- selection.
		local
			ptr: POINTER
			str: EV_CARBON_CF_STRING
		do
			create str.make_unshared (hiview_copy_text_external (c_object))
			from
				start
			until
				off
			loop
				if item.text.is_equal (str.string) then
					Result := item
				end
				forth
			end
		end

	selected_items: ARRAYED_LIST [EV_LIST_ITEM]
			-- List of all the selected items. Used for list_item.is_selected implementation.
		do

		end

	select_item (an_index: INTEGER)
			-- Select an item at the one-based `index' of the list.
		do

		end

	deselect_item (an_index: INTEGER)
			-- Unselect the item at the one-based `index'.
		do

		end

	clear_selection
			-- Clear the item selection of `Current'.
		do

		end

feature -- Status setting

	set_maximum_text_length (len: INTEGER)
			-- Set the length of the longest text size in characters that `Current' can display.
		do

		end

	set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to `text'.
		local
			str: EV_CARBON_CF_STRING
			ret: INTEGER
		do
			create str.make_unshared_with_eiffel_string (a_text)
			ret := hiview_set_text_external (c_object, str.item)
		end

	append_text (a_text: STRING_GENERAL)
			-- Append `a_text' to the end of the text.
		local
			ptr: POINTER
			str: EV_CARBON_CF_STRING
			total_text:STRING_GENERAL
			ret: INTEGER
		do
			ptr := hiview_copy_text_external (c_object)
			create str.make_unshared (ptr)
			total_text := str.string + a_text

			set_text (total_text)

		end

	prepend_text (a_text: STRING_GENERAL)
			-- Prepend `a_text' to the end of the text.
		local
			ptr: POINTER
			str: EV_CARBON_CF_STRING
			total_text:STRING_GENERAL
			ret: INTEGER
		do
			ptr := hiview_copy_text_external (c_object)
			create str.make_unshared (ptr)
			total_text := a_text + str.string

			set_text (total_text)

		end

feature {NONE} -- Implementation

	on_focus_changed (a_has_focus: BOOLEAN)
			-- Focus for `Current' has changed'.
		do
		end

	is_list_shown: BOOLEAN
		-- Is combo list current shown?

	retrieve_toggle_button_signal_connection_id: INTEGER
		-- Signal connection id used when finding the toggle button of `Current'.

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Event handling

	retrieve_toggle_button
			-- Retrieve the toggle button from the GtkComboBox structure.
		do

		end

	toggle_button_toggled
			-- The toggle button has been toggled.
		do
		end

feature {NONE} -- Externals


feature {EV_LIST_ITEM_IMP, EV_INTERMEDIARY_ROUTINES} -- Implementation

	container_widget: POINTER

feature {NONE} -- Implementation
	dispose
			do
				precursor {EV_LIST_ITEM_LIST_IMP}
				precursor {EV_TEXT_FIELD_IMP}
			end

	pixmaps_size_changed
			-- The size of the displayed pixmaps has just
			-- changed.
		do
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_COMBO_BOX;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_COMBO_BOX_IMP


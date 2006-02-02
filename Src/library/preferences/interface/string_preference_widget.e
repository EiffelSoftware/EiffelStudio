indexing
	description	: "[
		Default widget for viewing and editing preferences represented in string
		format (i.e. STRING, INTEGER and ARRAY preferences).
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	STRING_PREFERENCE_WIDGET

inherit
	PREFERENCE_WIDGET
		redefine
			set_preference,
			change_item_widget,
			update_changes,
			refresh
		end

create
	make,
	make_with_preference

feature -- Access

	change_item_widget: EV_GRID_EDITABLE_ITEM
			-- Widget to change the value of this preference.

	graphical_type: STRING is
			-- Graphical type identfier
		do
			Result := "TEXT"
		end

feature -- Status Setting

	set_preference (new_preference: like preference) is
			-- Set the preference.
		do
			Precursor (new_preference)
			check
				change_item_widget_created: change_item_widget /= Void
			end
		end

	show is
			-- Show the widget in its editable state
		do
			activate
		end

feature {NONE} -- Command

	update_changes is
			-- Update the changes made in `change_item_widget' to `preference'.
		do
			preference.set_value_from_string (change_item_widget.text)
			Precursor {PREFERENCE_WIDGET}
		end

	update_preference is
			-- Updates preference.
		local
			int: INTEGER_PREFERENCE
			str: STRING_PREFERENCE
			list: ARRAY_PREFERENCE
		do
			int ?= preference
			str ?= preference
			list ?= preference
			if int /= Void then
				if not change_item_widget.text.is_empty and then change_item_widget.text.is_integer then
					int.set_value (change_item_widget.text.to_integer)
				else
					int.set_value (0)
				end
			elseif str /= Void then
				str.set_value (change_item_widget.text)
			elseif list /= Void then
				list.set_value_from_string (change_item_widget.text)
			end
		end

	refresh is
			-- Refresh
		do
			change_item_widget.set_text (preference.string_value)
		end

feature {NONE} -- Implementation

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		do
			create change_item_widget
			change_item_widget.deactivate_actions.extend (agent update_changes)
			change_item_widget.set_text (preference.string_value)
			change_item_widget.pointer_button_press_actions.force_extend (agent activate)
		end

	activate is
			-- Activate the text
		do
			change_item_widget.activate
			change_item_widget.set_text_validation_agent (agent validate_preference_text)
			if not change_item_widget.text_field.text.is_empty then
				change_item_widget.text_field.select_all
			end
		end

    validate_preference_text (a_text: STRING): BOOLEAN is
            -- Validate `a_text'.  Disallow input if text is not an integer and the preference
            -- is an INTEGER_PREFERENCE.
        local
            int: INTEGER_PREFERENCE
        do
            Result := True
            int ?= preference
            if int /= Void and then not a_text.is_integer then
                Result := False
            end
        end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class STRING_PREFERENCE_WIDGET

indexing
	description: "Code completable EV_ADD_REMOVE_LIST"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ADD_REMOVE_CLASS_LIST

inherit
	EV_ADD_REMOVE_LIST
		redefine
			text_field,
			build_widget,
			build_text_field
		end

create
	make

feature -- Access

		text_field: EB_CODE_COMPLETABLE_TEXT_FIELD

feature {NONE} -- GUI

	build_widget is
			-- Build current widget.
		local
			hbox: EV_HORIZONTAL_BOX
		do
			create list

			set_border_width (5)
			set_padding (5)

			extend (list)

			build_text_field ("Entry: ")

			text_field.change_actions.extend (agent update_button_status)
			text_field.return_actions.extend (agent add_item_in)

			create hbox
			hbox.set_border_width (5)
			hbox.extend (create {EV_CELL})
			create add_button.make_with_text ("Add")
			add_button.select_actions.extend (agent add_item_in)
			add_button.set_minimum_width (80)
			hbox.extend (add_button)
			hbox.disable_item_expand (add_button)
			add_button.disable_sensitive

			hbox.extend (create {EV_CELL})
			create apply_button.make_with_text ("Apply")
			apply_button.select_actions.extend (agent modify_item_in)
			apply_button.set_minimum_width (80)
			hbox.extend (apply_button)
			hbox.disable_item_expand (apply_button)
			apply_button.disable_sensitive

			hbox.extend (create {EV_CELL})
			create remove_button.make_with_text ("Remove")
			remove_button.select_actions.extend (agent remove_item_in)
			remove_button.set_minimum_width (80)
			hbox.extend (remove_button)
			hbox.disable_item_expand (remove_button)
			remove_button.disable_sensitive
			hbox.extend (create {EV_CELL})

			extend (hbox)
			disable_item_expand (hbox)
		end

	build_text_field (t: STRING) is
			-- Create text field part.
		local
			hbox: EV_HORIZONTAL_BOX
			label: EV_LABEL
			l_provider: EB_NORMAL_COMPLETION_POSSIBILITIES_PROVIDER
		do
			create l_provider.make (Void, Void, true)
			create text_field.make
			text_field.set_completing_feature (false)
			text_field.set_completion_possibilities_provider (l_provider)
			l_provider.set_code_completable (text_field)
			create hbox
			create label.make_with_text (t)
			hbox.extend (label)
			hbox.disable_item_expand (label)
			hbox.extend (text_field)
			extend (hbox)
			disable_item_expand (hbox)
		end

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end

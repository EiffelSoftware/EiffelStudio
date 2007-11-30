indexing
	description: "Code completable EV_ADD_REMOVE_LIST"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ADD_REMOVE_CLASS_LIST

inherit
	EV_ADD_REMOVE_LIST
		rename
			make as make_old
		redefine
			text_field,
			build_widget,
			build_text_field
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

create
	make

feature -- Init

	make (a_group_callback: FUNCTION [ANY, TUPLE, CONF_GROUP]) is
			-- Initialize
		require
			a_group_callback_not_void: a_group_callback /= Void
		do
			group_internal := a_group_callback
			make_old
		end

feature -- Access

	group: CONF_GROUP is
			-- Group for class auto completion
		do
			Result := group_internal.item (Void)
		end

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

			build_text_field (interface_names.l_Entry_colon)

			text_field.change_actions.extend (agent update_button_status)
			text_field.return_actions.extend (agent add_item_in)

			create hbox
			hbox.set_border_width (5)
			hbox.extend (create {EV_CELL})
			create add_button.make_with_text (interface_names.b_Add)
			add_button.select_actions.extend (agent add_item_in)
			add_button.set_minimum_width (80)
			hbox.extend (add_button)
			hbox.disable_item_expand (add_button)
			add_button.disable_sensitive

			hbox.extend (create {EV_CELL})
			create apply_button.make_with_text (interface_names.b_Rename)
			apply_button.select_actions.extend (agent modify_item_in)
			apply_button.set_minimum_width (80)
			hbox.extend (apply_button)
			hbox.disable_item_expand (apply_button)
			apply_button.disable_sensitive

			hbox.extend (create {EV_CELL})
			create remove_button.make_with_text (interface_names.b_Remove)
			remove_button.select_actions.extend (agent remove_item_in)
			remove_button.set_minimum_width (80)
			hbox.extend (remove_button)
			hbox.disable_item_expand (remove_button)
			remove_button.disable_sensitive
			hbox.extend (create {EV_CELL})

			extend (hbox)
			disable_item_expand (hbox)
		end

	build_text_field (t: STRING_GENERAL) is
			-- Create text field part.
		local
			hbox: EV_HORIZONTAL_BOX
			label: EV_LABEL
			l_provider: EB_NORMAL_COMPLETION_POSSIBILITIES_PROVIDER
		do
			create l_provider.make (Void, Void)
			l_provider.set_group_callback (group_internal)
			create text_field.make
			if has_parent then
				text_field.set_parent_window ((create {EVS_HELPERS}).widget_top_level_window (parent, False))
			end
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

	group_internal: FUNCTION [ANY, TUPLE, CONF_GROUP]

invariant
	invariant_clause: True -- Your invariant here

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

note
	description: "Dialog for class options."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_OPTION_DIALOG

inherit
	PROPERTY_DIALOG [STRING_TABLE [CONF_OPTION]]
		redefine
			create_interface_objects,
			initialize
		end

	OPTION_PROPERTIES
		undefine
			default_create, copy
		redefine
			refresh
		end

	CONF_GUI_INTERFACE_CONSTANTS
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_factory: like conf_factory; o: like group_options)
			-- Create.
		require
			a_factory_not_void: a_factory /= Void
		do
			conf_factory := a_factory
			group_options := o
			create debug_clauses.make (0)
			default_create
		ensure
			factory_set: conf_factory = a_factory
			group_options_set: group_options = o
		end

	create_interface_objects
		do
			Precursor
			create properties
			create new_class
			create class_list
		end

	initialize
			-- Initialization
		local
			hb, hb2: EV_HORIZONTAL_BOX
			vb, vb2: EV_VERTICAL_BOX
			l_btn: EV_BUTTON
			l_label: ES_LABEL
			l_description: ES_SCROLLABLE_LABEL
			l_frame: EV_FRAME
			p: like properties
		do
			Precursor {PROPERTY_DIALOG}

			create hb
			element_container.extend (hb)

			create vb
			hb.extend (vb)
			hb.disable_item_expand (vb)
			vb.set_minimum_width (220)
			vb.set_padding (layout_constants.default_padding_size)
			vb.set_border_width (layout_constants.default_border_size)

--			create class_list
			vb.extend (class_list)

			create l_label
			l_label.align_text_left
			vb.extend (l_label)
			vb.disable_item_expand (l_label)

--			create new_class
			vb.extend (new_class)
			vb.disable_item_expand (new_class)

			create hb2
			hb2.set_padding (layout_constants.default_padding_size)
			vb.extend (hb2)
			vb.disable_item_expand (hb2)

			hb2.extend (create {EV_CELL})
			create l_btn.make_with_text_and_action (conf_interface_names.general_add, agent add_class)
			l_btn.set_pixmap (conf_pixmaps.general_add_icon)
			layout_constants.set_default_width_for_button (l_btn)
			hb2.extend (l_btn)
			hb2.disable_item_expand (l_btn)

			create l_btn.make_with_text_and_action (conf_interface_names.general_remove, agent remove_class)
			l_btn.set_pixmap (conf_pixmaps.general_remove_icon)
			layout_constants.set_default_width_for_button (l_btn)
			hb2.extend (l_btn)
			hb2.disable_item_expand (l_btn)

			create vb2
			hb.extend (vb2)
			vb2.set_padding (layout_constants.default_padding_size)
			vb2.set_border_width (layout_constants.default_border_size)

			p := properties
			if p = Void then
				create p
				properties := p
			end
			vb2.extend (p)

			create l_description
			properties.set_description_field (l_description)
			l_description.set_minimum_height (50)
			create l_frame
			l_frame.set_style ({EV_FRAME_CONSTANTS}.ev_frame_lowered)
			l_frame.set_border_width (4)
			l_frame.extend (l_description)
			vb2.extend (l_frame)
			vb2.disable_item_expand (l_frame)

			set_size (700, 700)
			show_actions.extend (agent on_show)
		end

feature {NONE} -- Gui elements

	class_list: EV_LIST
			-- List of classes with special options.

	new_class: EV_TEXT_FIELD
			-- Text field to enter name of new class to add.

feature {NONE} -- Agents

	on_show
			-- Called if the dialog is shown.
		require
			initialized: is_initialized
		do
			refresh
		end

	add_class
			-- Add a new class.
		local
			l_name: STRING_32
			l_value: like value
		do
			l_name := new_class.text.as_upper
			l_value := value
			if not (l_name.is_empty or (l_value /= Void and then l_value.has (l_name))) then
				if l_value = Void then
					create l_value.make (1)
					value := l_value
				end
				l_value.force ({CONF_OPTION}.create_from_namespace_or_latest (latest_namespace), l_name)
				current_class := l_name
				refresh
			end
		end

	remove_class
			-- Remove a class.
		do
			if attached current_class as c then
				if attached value as l_value then
					l_value.remove (c)
				end
				current_class := Void
				refresh
			end
		end

	show_options (a_class: READABLE_STRING_GENERAL)
			-- Show options for `a_class'
		require
			properties_set: properties /= Void
			a_class_ok: attached value as v and then a_class /= Void and then v.has (a_class)
		local
			l_inh_opts: CONF_OPTION
		do
			current_class := a_class
			check
				class_in_value: attached value as l_value and then
				attached l_value.item (a_class) as l_opts
			then
				l_inh_opts := {CONF_OPTION}.create_from_namespace_or_latest (latest_namespace)
				l_inh_opts.merge (l_opts)
				l_inh_opts.merge (group_options)

				lock_update

				properties.reset
				add_misc_option_properties (l_opts, l_inh_opts, True, False)
				add_dotnet_option_properties (l_opts, l_inh_opts, True, True, False)
				add_assertion_option_properties (l_opts, l_inh_opts, True, False)
				add_warning_option_properties (l_opts, l_inh_opts, True, False)
				add_debug_option_properties (l_opts, l_inh_opts, True, False)

				properties.column (1).set_width (properties.column (1).required_width_of_item_span (1, properties.row_count) + 3)
				properties.set_expanded_section_store (class_section_expanded_status)

				unlock_update
			end
		ensure
			current_class_set: current_class = a_class
		end

feature {NONE} -- Implementation

	conf_factory: CONF_PARSE_FACTORY
			-- Create.

	group_options: CONF_OPTION
			-- Options of the group this classes belong to.

	current_class: detachable READABLE_STRING_GENERAL
			-- Currently selected class.

	refresh
			-- Refresh the displayed values.
		local
			l_sorted_list: ARRAYED_LIST [READABLE_STRING_GENERAL]
			l_item: EV_LIST_ITEM
			l_sorter: QUICK_SORTER [READABLE_STRING_GENERAL]
		do
			class_list.wipe_out
			properties.reset
			new_class.set_text ("")

			if attached value as l_value then
					-- sort class names alphabetically
				create l_sorted_list.make (l_value.count)
				across
					l_value as ic
				loop
					l_sorted_list.extend (@ ic.key)
				end
				create l_sorter.make (create {COMPARABLE_COMPARATOR [READABLE_STRING_GENERAL]})
				l_sorter.sort (l_sorted_list)

				from
					l_sorted_list.start
				until
					l_sorted_list.after
				loop
					create l_item.make_with_text (l_sorted_list.item_for_iteration)
					l_item.select_actions.extend (agent show_options (l_sorted_list.item_for_iteration))
					class_list.extend (l_item)
					if attached current_class as cl and then cl.same_string (l_sorted_list.item_for_iteration) then
						l_item.enable_select
					end
					l_sorted_list.forth
				end
			end
		end

	class_section_expanded_status: HASH_TABLE [BOOLEAN, STRING_GENERAL]
			-- Expanded status of sections of class options.
		once
			create Result.make (4)
			Result.force (True, conf_interface_names.section_general)
			Result.force (True, conf_interface_names.section_assertions)
			Result.force (False, conf_interface_names.section_warning)
			Result.force (False, conf_interface_names.section_debug)
		end

invariant
	elements: is_initialized implies class_list /= Void and new_class /= Void

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

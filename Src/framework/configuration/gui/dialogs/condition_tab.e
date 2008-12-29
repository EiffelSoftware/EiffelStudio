note
	description: "Tab page to edit condition."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONDITION_TAB

inherit
	EV_VERTICAL_BOX
		redefine
			data,
			initialize,
			is_in_default_state
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

	CONF_VALIDITY
		undefine
			default_create,
			copy,
			is_equal
		end

	CONF_GUI_INTERFACE_CONSTANTS
		undefine
			default_create,
			copy,
			is_equal
		end

	EV_UTILITIES
		undefine
			default_create,
			copy,
			is_equal
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		undefine
			default_create,
			copy,
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_condition: CONF_CONDITION)
			-- Create with `a_condition'.
		require
			a_condition_not_void: a_condition /= Void
		do
			data := a_condition
			default_create
		ensure
			condition_set: data = a_condition
		end

	initialize
			-- Initialize.
		local
			l_label: EV_LABEL
			vb, vb_grid: EV_VERTICAL_BOX
			hb_top, hb_version, hb: EV_HORIZONTAL_BOX
			l_frame: EV_FRAME
			li: EV_LIST_ITEM
			l_btn: EV_BUTTON
			l_cell: EV_CELL
		do
			Precursor

			set_border_width (layout_constants.default_border_size)

				-- top part (platforms, builds, multithreaded, .NET)
			create hb_top
			extend (hb_top)
			hb_top.set_padding (layout_constants.default_padding_size)

				-- platforms
			create l_frame.make_with_text (conf_interface_names.dial_cond_platforms)
			hb_top.extend (l_frame)
			create vb
			l_frame.extend (vb)
			vb.set_border_width (layout_constants.default_border_size)
			create platforms
			from
				platform_names.start
			until
				platform_names.after
			loop
				create li.make_with_text (platform_names.item_for_iteration)
				platforms.extend (li)
				if data.platform /= Void and then data.platform.item.value.has (platform_names.key_for_iteration) then
					platforms.check_item (li)
				end
				platform_names.forth
			end
			vb.extend (platforms)
			platforms.set_minimum_size (105, 75)
			create exclude_platforms.make_with_text (conf_interface_names.dial_cond_platforms_exclude)
			vb.extend (exclude_platforms)
			if data.platform /= Void and then data.platform.item.invert then
				exclude_platforms.enable_select
			end

				-- other
			create l_frame.make_with_text (conf_interface_names.dial_cond_other)
			hb_top.extend (l_frame)

			create hb
			l_frame.extend (hb)
			hb.set_border_width (layout_constants.default_border_size)

				-- build
			create vb
			hb.extend (vb)
			create build_enabled.make_with_text (conf_interface_names.dial_cond_build)
			vb.extend (build_enabled)
			create builds.make_with_strings (<<build_workbench_name, build_finalize_name>>)
			builds.disable_edit
			vb.extend (builds)
			vb.disable_item_expand (builds)
			if data.build /= Void then
				build_enabled.enable_select
				if data.build.item.invert then
					if data.build.item.value.first = build_workbench then
						builds.last.enable_select
					else
						builds.first.enable_select
					end
				else
					if data.build.item.value.first = build_workbench then
						builds.first.enable_select
					else
						builds.last.enable_select
					end
				end
			else
				builds.disable_sensitive
			end

				-- dynamic runtime
			append_small_margin (vb)
			create dynamic_runtime_enabled.make_with_text (conf_interface_names.dial_cond_dynamic_runtime)
			vb.extend (dynamic_runtime_enabled)
			create dynamic_runtime.make_with_strings (boolean_list)
			dynamic_runtime.disable_edit
			vb.extend (dynamic_runtime)
			vb.disable_item_expand (dynamic_runtime)
			if data.dynamic_runtime /= Void then
				dynamic_runtime_enabled.enable_select
				if data.dynamic_runtime.item then
					dynamic_runtime.first.enable_select
				else
					dynamic_runtime.last.enable_select
				end
			else
				dynamic_runtime.disable_sensitive
			end

				-- cell to separate left and right settings
			create l_cell
			l_cell.set_minimum_width (5)
			hb.extend (l_cell)
			hb.disable_item_expand (l_cell)

				-- dotnet
			create vb
			hb.extend (vb)
			create dotnet_enabled.make_with_text (conf_interface_names.dial_cond_dotnet)
			vb.extend (dotnet_enabled)
			create dotnet.make_with_strings (boolean_list)
			dotnet.disable_edit
			vb.extend (dotnet)
			vb.disable_item_expand (dotnet)
			if data.dotnet /= Void then
				dotnet_enabled.enable_select
				if data.dotnet.item then
					dotnet.first.enable_select
				else
					dotnet.last.enable_select
				end
			else
				dotnet.disable_sensitive
			end

				-- multithreaded
			append_small_margin (vb)
			create multithreaded_enabled.make_with_text (conf_interface_names.dial_cond_multithreaded)
			vb.extend (multithreaded_enabled)
			create multithreaded.make_with_strings (boolean_list)
			multithreaded.disable_edit
			vb.extend (multithreaded)
			vb.disable_item_expand (multithreaded)
			if data.multithreaded /= Void then
				multithreaded_enabled.enable_select
				if data.multithreaded.item then
					multithreaded.first.enable_select
				else
					multithreaded.last.enable_select
				end
			else
				multithreaded.disable_sensitive
			end

			append_small_margin (Current)

				-- version part
			create l_frame.make_with_text (conf_interface_names.dial_cond_version)
			extend (l_frame)
			disable_item_expand (l_frame)
			create vb
			l_frame.extend (vb)
			vb.set_border_width (layout_constants.default_border_size)
			vb.set_padding (layout_constants.default_padding_size)
			create hb_version
			vb.extend (hb_version)
			vb.disable_item_expand (hb_version)
			create version_min_compiler
			hb_version.extend (version_min_compiler)
			hb_version.disable_item_expand (version_min_compiler)
			version_min_compiler.set_minimum_width (version_field_width)
			hb_version.extend (create {EV_CELL})
			create l_label.make_with_text (conf_interface_names.dial_cond_version_compiler)
			hb_version.extend (l_label)
			hb_version.disable_item_expand (l_label)
			hb_version.extend (create {EV_CELL})
			create version_max_compiler
			hb_version.extend (version_max_compiler)
			hb_version.disable_item_expand (version_max_compiler)
			version_max_compiler.set_minimum_width (version_field_width)
			fill_compiler_version

			append_small_margin (Current)

			create hb_version
			vb.extend (hb_version)
			vb.disable_item_expand (hb_version)
			create version_min_msil_clr
			hb_version.extend (version_min_msil_clr)
			hb_version.disable_item_expand (version_min_msil_clr)
			version_min_msil_clr.set_minimum_width (version_field_width)
			hb_version.extend (create {EV_CELL})
			create l_label.make_with_text (conf_interface_names.dial_cond_version_clr)
			hb_version.extend (l_label)
			hb_version.disable_item_expand (l_label)
			hb_version.extend (create {EV_CELL})
			create version_max_msil_clr
			hb_version.extend (version_max_msil_clr)
			hb_version.disable_item_expand (version_max_msil_clr)
			version_max_msil_clr.set_minimum_width (version_field_width)
			fill_msil_clr_version

				-- custom
			create l_frame.make_with_text (conf_interface_names.dial_cond_custom)
			extend (l_frame)
			create vb
			l_frame.extend (vb)
			vb.set_border_width (layout_constants.default_border_size)
			vb.set_padding (layout_constants.default_padding_size)
			create vb_grid
			vb.extend (vb_grid)
			vb_grid.set_border_width (1)
			vb_grid.set_background_color ((create {EV_STOCK_COLORS}).black)
			create custom
			vb_grid.extend (custom)
			fill_custom
			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			hb.extend (create {EV_CELL})
			create l_btn.make_with_text_and_action (plus_button_text, agent add_custom)
			l_btn.set_minimum_width (small_button_width)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			create l_btn.make_with_text_and_action (minus_button_text, agent remove_custom)
			l_btn.set_minimum_width (small_button_width)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)

				-- connect actions
				-- platform
			platforms.focus_out_actions.extend (agent on_platform)
			exclude_platforms.select_actions.extend (agent on_platform)
				--other
			build_enabled.select_actions.extend (agent on_build_enabled)
			builds.select_actions.extend (agent on_build)
			dotnet_enabled.select_actions.extend (agent on_dotnet_enabled)
			dotnet.select_actions.extend (agent on_dotnet)
			multithreaded_enabled.select_actions.extend (agent on_multithreaded_enabled)
			multithreaded.select_actions.extend (agent on_multithreaded)
			dynamic_runtime_enabled.select_actions.extend (agent on_dynamic_runtime_enabled)
			dynamic_runtime.select_actions.extend (agent on_dynamic_runtime)

				--version
			version_min_compiler.focus_out_actions.extend (agent on_compiler_version)
			version_max_compiler.focus_out_actions.extend (agent on_compiler_version)
			version_min_msil_clr.focus_out_actions.extend (agent on_msil_clr_version)
			version_max_msil_clr.focus_out_actions.extend (agent on_msil_clr_version)
		end

feature -- Access

	data: CONF_CONDITION
			-- Condition of this tab.

feature {NONE} -- GUI elements

	platforms: EV_CHECKABLE_LIST
			-- Platforms list.

	exclude_platforms: EV_CHECK_BUTTON
			-- Are the selected platforms excluded?

	build_enabled: EV_CHECK_BUTTON
			-- Is the build value set?

	builds: EV_COMBO_BOX
			-- Build.

	multithreaded_enabled: EV_CHECK_BUTTON
			-- Is the multithreaded value set?

	multithreaded: EV_COMBO_BOX
			-- Multithreaded.

	dotnet_enabled: EV_CHECK_BUTTON
			-- Is the .NET value set?

	dotnet: EV_COMBO_BOX
			-- .NET

	dynamic_runtime_enabled: EV_CHECK_BUTTON
			-- Is the dynamic runtime value set?

	dynamic_runtime: EV_COMBO_BOX
			-- dynamic runtime

	version_min_compiler: EV_TEXT_FIELD
	version_max_compiler: EV_TEXT_FIELD
	version_min_msil_clr: EV_TEXT_FIELD
	version_max_msil_clr: EV_TEXT_FIELD
			-- version conditions

	custom: ES_GRID

feature {NONE} -- Actions

	on_platform
			-- Platform value was changed, update data.
		local
			l_pfs: LIST [EV_LIST_ITEM]
		do
			data.wipe_out_platform
			if exclude_platforms.is_selected then
				from
					l_pfs := platforms.checked_items
					l_pfs.start
				until
					l_pfs.after
				loop
					data.exclude_platform (get_platform (l_pfs.item.text))
					l_pfs.forth
				end
			else
				from
					l_pfs := platforms.checked_items
					l_pfs.start
				until
					l_pfs.after
				loop
					data.add_platform (get_platform (l_pfs.item.text))
					l_pfs.forth
				end
			end
		end

	on_dotnet_enabled
			-- enable/disable combo box to choose a value for .NET.
		do
			if dotnet_enabled.is_selected then
				dotnet.enable_sensitive
				on_dotnet
			else
				dotnet.disable_sensitive
				data.unset_dotnet
			end
		end

	on_multithreaded_enabled
			-- enable/disable combo box to choose a value for multithreaded.
		do
			if multithreaded_enabled.is_selected then
				multithreaded.enable_sensitive
				on_multithreaded
			else
				multithreaded.disable_sensitive
				data.unset_multithreaded
			end
		end

	on_dynamic_runtime_enabled
			-- enable/disable combo box to choose a value for dynamic runtime.
		do
			if dynamic_runtime_enabled.is_selected then
				dynamic_runtime.enable_sensitive
				on_dynamic_runtime
			else
				dynamic_runtime.disable_sensitive
				data.unset_dynamic_runtime
			end
		end

	on_build_enabled
			-- enable/disable combo box to choose a value for build.
		do
			if build_enabled.is_selected then
				builds.enable_sensitive
				on_build
			else
				builds.disable_sensitive
				data.wipe_out_build
			end
		end

	on_build
			-- Build value was changed, update data.
		do
			data.wipe_out_build
			data.add_build (get_build (builds.text))
		end

	on_dotnet
			-- Dotnet value was changed, update data.
		do
			check
				has_boolean_text: conf_interface_names.boolean_values.has (dotnet.text)
			end
			data.set_dotnet (boolean_value_from_name (dotnet.text))
		end

	on_multithreaded
			-- Multithreaded value hsas changed, udpate data.
		do
			check
				has_boolean_text: conf_interface_names.boolean_values.has (multithreaded.text)
			end
			data.set_multithreaded (boolean_value_from_name (multithreaded.text))
		end

	on_dynamic_runtime
			-- Dynamic_runtime value was changed, update data.
		do
			check
				has_boolean_text: conf_interface_names.boolean_values.has (dynamic_runtime.text)
			end
			data.set_dynamic_runtime (boolean_value_from_name (dynamic_runtime.text))
		end

	on_compiler_version
			-- Compiler version was changed.
		local
			l_ver: STRING
			l_min, l_max: CONF_VERSION
		do
			l_ver := version_min_compiler.text
			if not l_ver.is_empty then
				create l_min.make_from_string (l_ver)
			end
			l_ver := version_max_compiler.text
			if not l_ver.is_empty then
				create l_max.make_from_string (l_ver)
			end

			if (l_min /= Void and then l_min.is_error) or (l_max /= Void and then l_max.is_error) then
				fill_compiler_version;
				prompts.show_error_prompt (conf_interface_names.version_valid_format, parent_window (Current), Void)
			elseif l_min /= Void and l_max /= Void and l_min > l_max then
				fill_compiler_version;
				prompts.show_error_prompt (conf_interface_names.version_min_max, parent_window (Current), Void)
			elseif l_min /= Void or l_max /= Void then
				data.add_version (l_min, l_max, v_compiler)
			else
				data.unset_version (v_compiler)
			end
		end

	on_msil_clr_version
			-- MSIL CLR version was changed.
		local
			l_ver: STRING
			l_min, l_max: CONF_VERSION
		do
			l_ver := version_min_msil_clr.text
			if not l_ver.is_empty then
				create l_min.make_from_string (l_ver)
			end
			l_ver := version_max_msil_clr.text
			if not l_ver.is_empty then
				create l_max.make_from_string (l_ver)
			end

			if (l_min /= Void and then l_min.is_error) or (l_max /= Void and then l_max.is_error) then
				fill_msil_clr_version;
				prompts.show_error_prompt (conf_interface_names.version_valid_format, parent_window (Current), Void)
			elseif l_min /= Void and l_max /= Void and l_min > l_max then
				fill_msil_clr_version;
				prompts.show_error_prompt (conf_interface_names.version_min_max, parent_window (Current), Void)
			elseif l_min /= Void or l_max /= Void then
				data.add_version (l_min, l_max, v_msil_clr)
			else
				data.unset_version (v_msil_clr)
			end
		end

	update_variable (a_new_key: STRING_GENERAL; an_old_key: STRING_GENERAL)
			-- Update variable name from `an_old_key' to `a_new_key'.
		require
			an_old_key_ok: an_old_key /= Void and then data.custom /= Void and then data.custom.has (an_old_key)
			a_new_key_ok: a_new_key /= Void and then (data.custom = Void  or else not data.custom.has (a_new_key))
		do
			if not a_new_key.is_empty then
				data.custom.replace_key (a_new_key, an_old_key)
			end
			fill_custom
		end

	update_invert (a_value: STRING_GENERAL; a_key: STRING_GENERAL)
			-- Update inversion status of custom condition of `a_key'.
		require
			a_key_ok: a_key /= Void and then data.custom /= Void and then data.custom.has (a_key)
			a_value_ok: a_value /= Void and then (a_value.as_string_8.is_equal ("=") or a_value.as_string_8.is_equal ("/="))
		do
			if a_value.as_string_8.is_equal ("=") then
				data.custom.item (a_key).item.invert := False
			else
				data.custom.item (a_key).item.invert := True
			end
		end

	update_value (a_value: STRING_GENERAL; a_key: STRING_GENERAL)
			-- Update value of custom condition of `a_key'.
		require
			a_key_ok: a_key /= Void and then data.custom /= Void and then data.custom.has (a_key)
			a_value_not_void: a_value /= Void
		do
			if not a_value.is_empty then
				data.custom.item (a_key).item.value := a_value
			else
				fill_custom
			end
		end

	add_custom
			-- Add a new custom condition.
		do
			if not data.custom.has (conf_interface_names.dial_cond_new_custom) then
				data.custom.force ([conf_interface_names.dial_cond_new_custom_value, False], conf_interface_names.dial_cond_new_custom)
			end
			fill_custom
		end

	remove_custom
			-- Remove a custom condition.
		local
			l_item: TEXT_PROPERTY [STRING_GENERAL]
		do
			if not custom.selected_rows.is_empty then
				l_item ?= custom.selected_rows.first.item (1)
				check
					text_property: l_item /= Void
				end
				data.custom.remove (l_item.value)
				fill_custom
			end
		end

feature {NONE} -- Layout constants

	version_field_width: INTEGER = 100
			-- Width of version fields.

feature {NONE} -- Contract

	is_in_default_state: BOOLEAN = True
			-- Contract.

feature {NONE} -- Implementation

	fill_compiler_version
			-- Fill fields with the constraints for the compiler version.
		local
			l_version: EQUALITY_TUPLE [TUPLE [min: CONF_VERSION; max: CONF_VERSION]]
		do
			l_version := data.version.item (v_compiler)
			if l_version = Void then
				version_min_compiler.set_text ("")
				version_max_compiler.set_text ("")
			else
				if l_version.item.min = Void then
					version_min_compiler.set_text ("")
				else
					version_min_compiler.set_text (l_version.item.min.version)
				end
				if l_version.item.max = Void then
					version_max_compiler.set_text ("")
				else
					version_max_compiler.set_text (l_version.item.max.version)
				end
			end
		end

	fill_msil_clr_version
			-- Fill fields with the constraints for the msil clr version.
		local
			l_version: EQUALITY_TUPLE [TUPLE [min: CONF_VERSION; max: CONF_VERSION]]
		do
			l_version := data.version.item (v_msil_clr)
			if l_version = Void then
				version_min_msil_clr.set_text ("")
				version_max_msil_clr.set_text ("")
			else
				if l_version.item.min = Void then
					version_min_msil_clr.set_text ("")
				else
					version_min_msil_clr.set_text (l_version.item.min.version)
				end
				if l_version.item.max = Void then
					version_max_msil_clr.set_text ("")
				else
					version_max_msil_clr.set_text (l_version.item.max.version)
				end
			end
		end

	fill_custom
			-- Fill custom conditions.
		local
			l_cust: HASH_TABLE [EQUALITY_TUPLE [TUPLE [value: STRING_GENERAL; invert: BOOLEAN]], STRING_GENERAL]
			l_text: STRING_PROPERTY
			l_choice: STRING_CHOICE_PROPERTY
			i: INTEGER
			l_key: STRING_GENERAL
		do
			custom.wipe_out
			custom.enable_last_column_use_all_width
			custom.enable_selection_on_single_button_click
			custom.enable_single_row_selection
			custom.set_column_count_to (3)
			custom.column (1).set_title (conf_interface_names.dial_cond_custom_variable)
			custom.column (3).set_title (conf_interface_names.dial_cond_custom_value)
			l_cust := data.custom
			if l_cust /= Void then
				from
					l_cust.start
					i := 1
				until
					l_cust.after
				loop
					l_key := l_cust.key_for_iteration
					create l_text.make ("")
					l_text.pointer_button_press_actions.wipe_out
					l_text.pointer_double_press_actions.force_extend (agent l_text.activate)
					l_text.set_value (l_key)
					l_text.change_value_actions.extend (agent update_variable ({STRING_32} ?, l_key))
					custom.set_item (1, i, l_text)
					create l_choice.make_with_choices ("", <<"=", "/=">>)
					if l_cust.item_for_iteration.item.invert then
						l_choice.set_value ("/=")
					else
						l_choice.set_value ("=")
					end
					l_choice.change_value_actions.extend (agent update_invert ({STRING_32} ?, l_key))
					custom.set_item (2, i, l_choice)
					create l_text.make ("")
					l_text.pointer_button_press_actions.wipe_out
					l_text.pointer_double_press_actions.force_extend (agent l_text.activate)
					l_text.set_value (l_cust.item_for_iteration.item.value)
					l_text.change_value_actions.extend (agent update_value ({STRING_32} ?, l_key))
					custom.set_item (3, i, l_text)

					i := i + 1
					l_cust.forth
				end
			end
		end

	boolean_list: ARRAY [STRING_GENERAL]
			-- Array with boolean names
		do
			Result := <<conf_interface_names.boolean_true, conf_interface_names.boolean_false>>
		ensure
			Result_not_void: Result /= Void
			Result_has_two_value: Result @ 1 /= Void and Result @ 2 /= Void
		end

	boolean_value_from_name (a_string: STRING_GENERAL): BOOLEAN
			-- Boolean value from translated string.
		require
			a_string_not_void: a_string /= Void
			has_a_string: conf_interface_names.boolean_values.has (a_string)
		do
			Result := conf_interface_names.boolean_values.item (a_string)
		end

note
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

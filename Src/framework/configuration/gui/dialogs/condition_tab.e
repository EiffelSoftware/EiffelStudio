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
			create_interface_objects,
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

	create_interface_objects
		do
			Precursor
			create custom
			create version_max_msil_clr
			create version_min_msil_clr
			create version_max_compiler
			create version_min_compiler

			create dynamic_runtime
			create dynamic_runtime_enabled

			create platforms
			create exclude_platforms
			create concurrency
			create void_safety
			create exclude_concurrency
			create exclude_void_safety
			create build_enabled
			create builds
			create dotnet_enabled
			create dotnet
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
--			create platforms
			from
				platform_names.start
			until
				platform_names.after
			loop
				create li.make_with_text (platform_names.item_for_iteration)
				platforms.extend (li)
				if attached data.platform as l_platform and then l_platform.value.has (platform_names.key_for_iteration) then
					platforms.check_item (li)
				end
				platform_names.forth
			end
			vb.extend (platforms)
			platforms.set_minimum_size (105, 75)
--			create exclude_platforms
			exclude_platforms.set_text (conf_interface_names.dial_cond_platforms_exclude)
			vb.extend (exclude_platforms)
			if attached data.platform as l_platform and then l_platform.invert then
				exclude_platforms.enable_select
			end

				-- concurrency
			create l_frame.make_with_text (conf_interface_names.dial_cond_concurrency)
			hb_top.extend (l_frame)
			create vb
			l_frame.extend (vb)
			vb.set_border_width (layout_constants.default_border_size)
--			create concurrency
			from
				concurrency_names.start
			until
				concurrency_names.after
			loop
				create li.make_with_text (conf_interface_names.dial_cond_concurrency_value (concurrency_names.item_for_iteration))
				concurrency.extend (li)
				if attached data.concurrency as l_concurrency and then l_concurrency.value.has (concurrency_names.key_for_iteration) then
					concurrency.check_item (li)
				end
				concurrency_names.forth
			end
			vb.extend (concurrency)
			concurrency.set_minimum_size (105, 75)
--			create exclude_concurrency
			exclude_concurrency.set_text (conf_interface_names.dial_cond_concurrency_exclude)
			vb.extend (exclude_concurrency)
			if attached data.concurrency as l_concurrency and then l_concurrency.invert then
				exclude_concurrency.enable_select
			end

				-- void_safety
			create l_frame.make_with_text (conf_interface_names.dial_cond_void_safety)
			hb_top.extend (l_frame)
			create vb
			l_frame.extend (vb)
			vb.set_border_width (layout_constants.default_border_size)
			create void_safety
			from
				void_safety_names.start
			until
				void_safety_names.after
			loop
				create li.make_with_text (conf_interface_names.dial_cond_void_safety_value (void_safety_names.item_for_iteration))
				void_safety.extend (li)
				if attached data.void_safety as l_void_safety and then l_void_safety.value.has (void_safety_names.key_for_iteration) then
					void_safety.check_item (li)
				end
				void_safety_names.forth
			end
			vb.extend (void_safety)
			void_safety.set_minimum_size (105, 75)
--			create exclude_void_safety
			exclude_void_safety.set_text (conf_interface_names.dial_cond_void_safety_exclude)
			vb.extend (exclude_void_safety)
			if attached data.void_safety as l_void_safety and then l_void_safety.invert then
				exclude_void_safety.enable_select
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
--			create build_enabled
			build_enabled.set_text (conf_interface_names.dial_cond_build)
			vb.extend (build_enabled)
--			create builds
			builds.set_strings (<<build_workbench_name, build_finalize_name>>)
			builds.disable_edit
			vb.extend (builds)
			vb.disable_item_expand (builds)
			if attached data.build as l_build then
				build_enabled.enable_select
				if l_build.invert then
					if l_build.value.first = build_workbench then
						builds.last.enable_select
					else
						builds.first.enable_select
					end
				else
					if l_build.value.first = build_workbench then
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
--			create dynamic_runtime_enabled
			dynamic_runtime_enabled.set_text (conf_interface_names.dial_cond_dynamic_runtime)
			vb.extend (dynamic_runtime_enabled)

--			create dynamic_runtime
			dynamic_runtime.set_strings (boolean_list)
			dynamic_runtime.disable_edit
			vb.extend (dynamic_runtime)
			vb.disable_item_expand (dynamic_runtime)
			if attached data.dynamic_runtime as l_dynamic_runtime then
				dynamic_runtime_enabled.enable_select
				if l_dynamic_runtime.item then
					dynamic_runtime.first.enable_select
				else
					dynamic_runtime.last.enable_select
				end
			else
				dynamic_runtime.disable_sensitive
			end


				-- dotnet
			append_small_margin (vb)
--			create dotnet_enabled
			dotnet_enabled.set_text (conf_interface_names.dial_cond_dotnet)
			vb.extend (dotnet_enabled)
--			create dotnet
			dotnet.set_strings (boolean_list)
			dotnet.disable_edit
			vb.extend (dotnet)
			vb.disable_item_expand (dotnet)
			if attached data.dotnet as l_dotnet then
				dotnet_enabled.enable_select
				if l_dotnet.item then
					dotnet.first.enable_select
				else
					dotnet.last.enable_select
				end
			else
				dotnet.disable_sensitive
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
--			create version_min_compiler
			hb_version.extend (version_min_compiler)
			hb_version.disable_item_expand (version_min_compiler)
			version_min_compiler.set_minimum_width (version_field_width)
			hb_version.extend (create {EV_CELL})
			create l_label.make_with_text (conf_interface_names.dial_cond_version_compiler)
			hb_version.extend (l_label)
			hb_version.disable_item_expand (l_label)
			hb_version.extend (create {EV_CELL})
--			create version_max_compiler
			hb_version.extend (version_max_compiler)
			hb_version.disable_item_expand (version_max_compiler)
			version_max_compiler.set_minimum_width (version_field_width)
			fill_compiler_version

			append_small_margin (Current)

			create hb_version
			vb.extend (hb_version)
			vb.disable_item_expand (hb_version)
--			create version_min_msil_clr
			hb_version.extend (version_min_msil_clr)
			hb_version.disable_item_expand (version_min_msil_clr)
			version_min_msil_clr.set_minimum_width (version_field_width)
			hb_version.extend (create {EV_CELL})
			create l_label.make_with_text (conf_interface_names.dial_cond_version_clr)
			hb_version.extend (l_label)
			hb_version.disable_item_expand (l_label)
			hb_version.extend (create {EV_CELL})
--			create version_max_msil_clr
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
--			create custom
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
				-- concurrency
			concurrency.focus_out_actions.extend (agent on_concurrency)
			exclude_concurrency.select_actions.extend (agent on_concurrency)
				-- void_safety
			void_safety.focus_out_actions.extend (agent on_void_safety)
			exclude_void_safety.select_actions.extend (agent on_void_safety)
				--other
			build_enabled.select_actions.extend (agent on_build_enabled)
			builds.select_actions.extend (agent on_build)
			dotnet_enabled.select_actions.extend (agent on_dotnet_enabled)
			dotnet.select_actions.extend (agent on_dotnet)
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

	concurrency: EV_CHECKABLE_LIST
			-- Concurrency list.

	void_safety: EV_CHECKABLE_LIST
			-- Void_safety list.

	exclude_concurrency: EV_CHECK_BUTTON
			-- Are the selected concurrency elements excluded?

	exclude_void_safety: EV_CHECK_BUTTON
			-- Are the selected void_safety elements excluded?

	build_enabled: EV_CHECK_BUTTON
			-- Is the build value set?

	builds: EV_COMBO_BOX
			-- Build.

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

	on_concurrency
			-- Concurrency value was changed, update data.
		local
			is_excluded: BOOLEAN
		do
			data.wipe_out_concurrency
			is_excluded := exclude_concurrency.is_selected
			from
				concurrency.start
				concurrency_names.start
			until
				concurrency.after
			loop
				if concurrency.is_item_checked (concurrency.item) then
					if is_excluded then
						data.exclude_concurrency (concurrency_names.key_for_iteration)
					else
						data.add_concurrency (concurrency_names.key_for_iteration)
					end
				end
				concurrency.forth
				concurrency_names.forth
			end
		end

	on_void_safety
			-- void_safety value was changed, update data.
		local
			is_excluded: BOOLEAN
		do
			data.wipe_out_void_safety
			is_excluded := exclude_void_safety.is_selected
			from
				void_safety.start
				void_safety_names.start
			until
				void_safety.after
			loop
				if void_safety.is_item_checked (void_safety.item) then
					if is_excluded then
						data.exclude_void_safety (void_safety_names.key_for_iteration)
					else
						data.add_void_safety (void_safety_names.key_for_iteration)
					end
				end
				void_safety.forth
				void_safety_names.forth
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
			l_ver: STRING_32
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
				fill_compiler_version
				prompts.show_error_prompt (conf_interface_names.version_valid_format, parent_window (Current), Void)
			elseif l_min /= Void and then l_max /= Void and then l_min > l_max then
				fill_compiler_version
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
			l_ver: STRING_32
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
				fill_msil_clr_version
				prompts.show_error_prompt (conf_interface_names.version_valid_format, parent_window (Current), Void)
			elseif l_min /= Void and then l_max /= Void and then l_min > l_max then
				fill_msil_clr_version
				prompts.show_error_prompt (conf_interface_names.version_min_max, parent_window (Current), Void)
			elseif l_min /= Void or l_max /= Void then
				data.add_version (l_min, l_max, v_msil_clr)
			else
				data.unset_version (v_msil_clr)
			end
		end

	update_variable (a_new_key: READABLE_STRING_GENERAL; a_old_key: READABLE_STRING_GENERAL; a_old_value: READABLE_STRING_GENERAL)
			-- Update variable name from `a_old_key' to `a_new_key'.
		require
			a_old_key_ok: a_old_key /= Void and then attached data.custom as l_custom and then l_custom.has (a_old_key)
			a_old_value_ok: a_old_value /= Void and then attached l_custom.item (a_old_key) as l_item and then l_item.has (a_old_value)
		local
			d: CONF_CONDITION_CUSTOM_ATTRIBUTES
		do
			if not a_new_key.is_empty and then not a_new_key.same_string (a_old_key) then
				d := data.custom_attributes_for (a_old_key, a_old_value)
				if d = Void then
					create d
				end
				data.remove_custom (a_old_key, a_old_value)
				data.add_custom (a_new_key, a_old_value, d)
			end
			fill_custom
		end

	update_invert (a_invert_value: READABLE_STRING_GENERAL; a_value: READABLE_STRING_GENERAL; a_key: READABLE_STRING_GENERAL)
			-- Update inversion status of custom condition of `a_key'.
		require
			a_key_ok: a_key /= Void and then attached data.custom as l_custom and then l_custom.has (a_key)
			a_value_ok: a_value /= Void and then attached l_custom.item (a_key) as l_item and then l_item.has (a_value)
			a_invert_value_ok: a_invert_value /= Void and then (a_invert_value.starts_with ("=") or a_invert_value.starts_with ("/=") or a_invert_value.ends_with ("-match") or a_invert_value.ends_with ("-mismatch"))
		local
			d: CONF_CONDITION_CUSTOM_ATTRIBUTES
		do
			data.remove_custom (a_key, a_value)
			create d -- FIXME
			if a_invert_value.is_case_insensitive_equal (comp_equal) then
				d.inverted := False
				d.set_match ({CONF_CONDITION_CUSTOM_ATTRIBUTES}.case_sensitive_matching)
			elseif a_invert_value.is_case_insensitive_equal (comp_equal_mismatch) then
				d.inverted := True
				d.set_match ({CONF_CONDITION_CUSTOM_ATTRIBUTES}.case_sensitive_matching)
			elseif a_invert_value.is_case_insensitive_equal (comp_caseless_match) then
				d.inverted := False
				d.set_match ({CONF_CONDITION_CUSTOM_ATTRIBUTES}.case_insensitive_matching)
			elseif a_invert_value.is_case_insensitive_equal (comp_caseless_mismatch) then
				d.inverted := True
				d.set_match ({CONF_CONDITION_CUSTOM_ATTRIBUTES}.case_insensitive_matching)
			elseif a_invert_value.is_case_insensitive_equal (comp_regexp_match) then
				d.inverted := False
				d.set_match ({CONF_CONDITION_CUSTOM_ATTRIBUTES}.regexp_matching)
			elseif a_invert_value.is_case_insensitive_equal (comp_regexp_mismatch) then
				d.inverted := True
				d.set_match ({CONF_CONDITION_CUSTOM_ATTRIBUTES}.regexp_matching)
			elseif a_invert_value.is_case_insensitive_equal (comp_wildcard_match) then
				d.inverted := False
				d.set_match ({CONF_CONDITION_CUSTOM_ATTRIBUTES}.wildcard_matching)
			elseif a_invert_value.is_case_insensitive_equal (comp_wildcard_mismatch) then
				d.inverted := True
				d.set_match ({CONF_CONDITION_CUSTOM_ATTRIBUTES}.wildcard_matching)
			else
				check unknown: False end
			end
			-- note: d.inverted := a_invert_value.starts_with ("/=") or a_invert_value.ends_with ("-mismatch")
			data.add_custom (a_key, a_value, d)
		end

	update_value (a_value: READABLE_STRING_GENERAL; a_old_value: READABLE_STRING_GENERAL; a_key: READABLE_STRING_GENERAL)
			-- Update value of custom condition of `a_key'.
		require
			a_key_ok: a_key /= Void and then attached data.custom as l_custom and then l_custom.has (a_key.as_lower)
			a_old_value_ok: a_old_value /= Void and then attached l_custom.item (a_key.as_lower) as l_item and then l_item.has (a_old_value)
			a_value_not_void: a_value /= Void
		local
			d: CONF_CONDITION_CUSTOM_ATTRIBUTES
		do
			if not a_value.is_empty then
				d := data.custom_attributes_for (a_key, a_old_value)
				data.remove_custom (a_key, a_old_value)
				if d = Void then
					create d
				end
				data.add_custom (a_key, a_value, d)
					-- We need to update closed arguments of updating routines.
				fill_custom
			end
		end

	add_custom
			-- Add a new custom conditfion.
		do
			data.add_custom (conf_interface_names.dial_cond_new_custom, Conf_interface_names.dial_cond_new_custom_value, create {CONF_CONDITION_CUSTOM_ATTRIBUTES})
			fill_custom
		end

	remove_custom
			-- Remove a custom condition.
		local
			l_row: EV_GRID_ROW
		do
			if custom.has_selected_row then
				l_row := custom.selected_rows.first
				if
					attached {TEXT_PROPERTY [READABLE_STRING_GENERAL]} l_row.item (1) as l_key and then
					attached l_key.value as ks and then
					attached {TEXT_PROPERTY [READABLE_STRING_GENERAL]} l_row.item (3) as l_value and then
					attached l_value.value as vs
				then
					data.remove_custom (ks, vs)
				end
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
			l_version: TUPLE [min: detachable CONF_VERSION; max: detachable CONF_VERSION]
		do
			l_version := data.version.item (v_compiler)
			if l_version = Void then
				version_min_compiler.set_text ("")
				version_max_compiler.set_text ("")
			else
				if attached l_version.min as v_min then
					version_min_compiler.set_text (v_min.version)
				else
					version_min_compiler.set_text ("")
				end
				if attached l_version.max as v_max then
					version_max_compiler.set_text (v_max.version)
				else
					version_max_compiler.set_text ("")
				end
			end
		end

	fill_msil_clr_version
			-- Fill fields with the constraints for the msil clr version.
		local
			l_version: TUPLE [min: detachable CONF_VERSION; max: detachable CONF_VERSION]
		do
			l_version := data.version.item (v_msil_clr)
			if l_version = Void then
				version_min_msil_clr.set_text ("")
				version_max_msil_clr.set_text ("")
			else
				if attached l_version.min as v_min then
					version_min_msil_clr.set_text (v_min.version)
				else
					version_min_msil_clr.set_text ("")
				end
				if attached l_version.max as v_max then
					version_max_msil_clr.set_text (v_max.version)
				else
					version_max_msil_clr.set_text ("")
				end
			end
		end

	fill_custom
			-- Fill custom conditions.
		local
			l_cust: like data.custom
			l_text: STRING_PROPERTY
			l_choice: STRING_CHOICE_PROPERTY
			i: INTEGER
			l_key: READABLE_STRING_GENERAL
			l_values: STRING_TABLE [CONF_CONDITION_CUSTOM_ATTRIBUTES]
			l_custom_item: CONF_CONDITION_CUSTOM_ATTRIBUTES
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
					l_values := l_cust.item_for_iteration
					from
						l_values.start
					until
						l_values.after
					loop
						create l_text.make ("")
						l_text.pointer_button_press_actions.wipe_out
						l_text.activate_when_pointer_is_double_pressed
						l_text.set_value (l_key)
						l_text.change_value_actions.extend (agent update_variable ({READABLE_STRING_32} ?, l_key, l_values.key_for_iteration))
						custom.set_item (1, i, l_text)
						create l_choice.make_with_choices ("", create {ARRAYED_LIST [READABLE_STRING_32]}.make_from_array ({ARRAY [READABLE_STRING_32]} <<comp_equal, comp_equal_mismatch, comp_caseless_match, comp_caseless_mismatch, comp_regexp_match, comp_regexp_mismatch, comp_wildcard_match, comp_wildcard_mismatch>>))
						l_custom_item := l_values.item_for_iteration
						if l_custom_item.inverted then
							if l_custom_item.is_regular_expression then
								l_choice.set_value (comp_regexp_mismatch)
							elseif l_custom_item.is_wildcard then
								l_choice.set_value (comp_wildcard_mismatch)
							elseif l_custom_item.is_case_insensitive then
								l_choice.set_value (comp_caseless_mismatch)
							else
								l_choice.set_value (comp_equal_mismatch)
							end
						else
							if l_custom_item.is_regular_expression then
								l_choice.set_value (comp_regexp_match)
							elseif l_custom_item.is_wildcard then
								l_choice.set_value (comp_wildcard_match)
							elseif l_custom_item.is_case_insensitive then
								l_choice.set_value (comp_caseless_match)
							else
								l_choice.set_value (comp_equal)
							end
						end
						l_choice.change_value_actions.extend (agent update_invert ({READABLE_STRING_32} ?, l_values.key_for_iteration, l_key))
						custom.set_item (2, i, l_choice)
						create l_text.make ("")
						l_text.pointer_button_press_actions.wipe_out
						l_text.activate_when_pointer_is_double_pressed
						l_text.set_value (l_values.key_for_iteration)
						l_text.change_value_actions.extend (agent update_value ({READABLE_STRING_32} ?, l_values.key_for_iteration , l_key))
						custom.set_item (3, i, l_text)
						i := i + 1
						l_values.forth
					end
					l_cust.forth
				end
			end
		end

	boolean_list: ARRAY [READABLE_STRING_GENERAL]
			-- Array with boolean names
		do
			Result := <<conf_interface_names.boolean_true, conf_interface_names.boolean_false>>
		ensure
			Result_not_void: Result /= Void
			Result_has_two_value: Result @ 1 /= Void and Result @ 2 /= Void
		end

	boolean_value_from_name (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Boolean value from translated string.
		require
			a_string_not_void: a_string /= Void
			has_a_string: conf_interface_names.boolean_values.has (a_string)
		do
			Result := conf_interface_names.boolean_values.item (a_string)
		end

feature {NONE} -- Constants

	comp_equal: STRING_8 = "="
	comp_equal_mismatch: STRING_8 = "/="
	comp_caseless_match: STRING_8 = "caseless-match"
	comp_caseless_mismatch: STRING_8 = "caseless-mismatch"
	comp_regexp_match: STRING_8 = "regexp-match"
	comp_regexp_mismatch: STRING_8 = "regexp-mismatch"
	comp_wildcard_match: STRING_8 = "wildcard-match"
	comp_wildcard_mismatch: STRING_8 = "wildcard-mismatch"

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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

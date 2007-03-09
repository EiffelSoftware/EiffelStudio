indexing
	description: "Command in the object tool to define the default slice limits."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_GRID_SLICES_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			mini_pixmap,
			new_mini_toolbar_item
		end

	EB_SHARED_PREFERENCES

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	EB_VISION2_FACILITIES
		export
			{NONE} all
		end

	SHARED_DEBUGGED_OBJECT_MANAGER
		export
			{NONE} all
		end

	EB_SHARED_DEBUGGER_MANAGER

create
	make

feature -- Initialization

	make (a_tool: like tool) is
			-- Initialize `Current' and associate it with `tool'.
		do
			tool := a_tool
		end

feature -- Access

	menu_name: STRING_GENERAL is
			-- Menu name for `Current'.
		once
			Result := Interface_names.m_Set_slice_size
		end

	pixmap: EV_PIXMAP is
			-- Pixmaps representing the command.
		do
			--| No big pixmap is required for this command.
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			--| No big pixmap is required for this command.
		end

	mini_pixmap: EV_PIXMAP is
			-- Pixmap representing the command for mini toolbars.
		do
			Result := pixmaps.mini_pixmaps.debugger_set_sizes_icon
		end

	tooltip: STRING_GENERAL is
			-- Tooltip for the toolbar button.
		do
			Result := description
		end

feature -- Status report

	tool: ES_OBJECTS_GRID_MANAGER
			-- Object tool `Current' is associated with. `Void' if not `for_tool'.

	name: STRING is
			-- Name of the command.
		once
			Result := Interface_names.l_Set_slice_limits + "New"
		end

	description: STRING_GENERAL is
			-- Description of the command.
		once
			Result := Interface_names.l_Set_slice_limits_desc
		end

feature -- Execution

	execute is
			-- Change the default slice limits through a dialog box.
		do
			get_slice_limits_on_global

			debugger_manager.set_slices (slice_min, slice_max)
			debugger_manager.set_displayed_string_size (displayed_string_size)
			if set_as_default_requested then
				set_as_default_requested := False
				preferences.debugger_data.min_slice_preference.set_value (debugger_manager.min_slice)
				preferences.debugger_data.max_slice_preference.set_value (debugger_manager.max_slice)
				preferences.debugger_data.default_displayed_string_size_preference.set_value (debugger_manager.displayed_string_size)
			end

			debug ("debugger_interface")
				io.put_string ("Messages are displayed%N")
			end
			if refresh_tools_requested then
				refresh_tools_requested := False
				eb_debugger_manager.refresh_objects_grids
			end
		end

feature -- Basic operations

	new_mini_toolbar_item: EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new mini toolbar button for this command.
		do
			Result := Precursor
			Result.drop_actions.extend (agent drop_feature_on_object_stone)
			Result.drop_actions.extend (agent drop_object_stone)
			Result.drop_actions.set_veto_pebble_function (agent is_resizable (?))
		end

	is_resizable (st: ANY): BOOLEAN is
			-- Is the object represented by `st' droppable, i.e. SPECIAL?
		local
			obj_grid_item: ES_OBJECTS_GRID_LINE
			conv_obj: OBJECT_STONE
			conv_fost: FEATURE_ON_OBJECT_STONE
			l_item: EV_ANY
			l_addr: STRING
		do
			conv_obj ?= st
			if conv_obj = Void then
				conv_fost ?= st
				if conv_fost /= Void then
					conv_obj := conv_fost.object_stone
				end
			end
			obj_grid_item := object_grid_line_for (conv_obj)
			Result := obj_grid_item /= Void and then obj_grid_item.object_is_special_value
		end

	object_grid_line_for (ost: OBJECT_STONE): ES_OBJECTS_GRID_LINE is
			-- Object grid line related to `ost if any.
		local
			obj_grid_item: ES_OBJECTS_GRID_LINE
			l_item: EV_ANY
			l_addr: STRING
		do
			if ost /= Void then
				l_item := ost.ev_item
				if l_item /= Void then
					Result ?= l_item.data
				end
				if Result = Void	then
					l_addr := ost.object_address
					if tool /= Void	and l_addr /= Void then
						Result := tool.objects_grid_item (l_addr)
					end
				end
			end
		end

feature -- Obsolete

feature -- Inapplicable

feature {EB_PRETTY_PRINT_DIALOG} -- Properties

	slice_min: INTEGER
			-- Minimum index of displayed attributes in special objects.

	slice_max: INTEGER
			-- Maximum index of displayed attributes in special objects.

	displayed_string_size: INTEGER
			-- Size of string to be retrieved from the application
			-- when debugging

	refresh_tools_requested: BOOLEAN
			-- Tool's refreshing is requested.

	set_as_default_requested: BOOLEAN
			-- Set values as default ?
			-- (i.e: in preferences)

feature {NONE} -- Implementation

	Cst_field_label_width: INTEGER is 70
	Cst_border_width: INTEGER is 5
	Cst_padding_width: INTEGER is 5

	get_effective: BOOLEAN
			-- Did the user really enter new min/max values in the dialog box?
			-- Valid after each call to get_slice_limits.

	get_slice_limits_on_target (obj_grid_item: ES_OBJECTS_GRID_LINE) is
		do
			get_slice_limits (False, obj_grid_item)
		end

	get_slice_limits_on_global is
		do
			get_slice_limits (True, Void)
		end

	get_slice_limits (def: BOOLEAN; obj: ES_OBJECTS_GRID_LINE) is
			-- Display a dialog box to enter new slice limits
			-- as default values if `def',
			-- as object specific values otherwise,
			-- and fill slice_min and slice_max accordingly.
			-- if not `def', either `address' or `dv' should be specified.
		require
			default_xor_specific: def /= (obj /= Void)
		local
			dial: EV_DIALOG
			label: EV_LABEL
			cb_disp_str_limit: EV_CHECK_BUTTON
			cb_refresh, cb_set_as_default: EV_CHECK_BUTTON
			tf_disp_str_size: EV_TEXT_FIELD
			tf_minf: EV_TEXT_FIELD
			tf_maxf: EV_TEXT_FIELD
			resetb, okb, cancelb: EV_BUTTON
			maincont: EV_VERTICAL_BOX
			vbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
		do
				-- Build the dialog.
			create dial
			dial.set_title (Interface_names.t_Slice_limits)
			dial.set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)

				-- Build the dialog interface.
				-- Build containers.
			create maincont
			maincont.set_border_width (Cst_border_width)
			maincont.set_padding (Cst_padding_width)

			get_effective := False

				--| Get the current slices values
				--| and build widgets
			if def then
					--| Specific info for Global slices settings
					--| Warning messages (2 lines)
				create vbox
				create label.make_with_text (Interface_names.l_Slice_taken_into_account1)
				label.align_text_left
				vbox.extend (label)
				create label.make_with_text (Interface_names.l_Slice_taken_into_account2)
				label.align_text_left
				vbox.extend (label)
				extend_no_expand (maincont, vbox)
					--| Separator
				maincont.extend (create {EV_HORIZONTAL_SEPARATOR})

					--| String display size
				create cb_disp_str_limit.make_with_text ("no limit")
				create tf_disp_str_size

				tf_disp_str_size.set_minimum_width (Cst_field_label_width)

				create hbox
				create label.make_with_text (Interface_names.l_Max_displayed_string_size)
				label.align_text_left
				hbox.extend (label)

				create vbox
				vbox.extend (cb_disp_str_limit)
				vbox.extend (tf_disp_str_size)
				extend_no_expand (hbox, vbox)

				extend_no_expand (maincont, hbox)

					--| Separator
				maincont.extend (create {EV_HORIZONTAL_SEPARATOR})

					--| Set Value
				if debugger_manager.displayed_string_size = -1 then
					tf_disp_str_size.set_text (preferences.debugger_data.default_displayed_string_size.out)
					cb_disp_str_limit.enable_select
				else
					tf_disp_str_size.set_text (debugger_manager.displayed_string_size.out)
					cb_disp_str_limit.disable_select
				end
				on_cb_disp_str_limit_cb (cb_disp_str_limit, tf_disp_str_size)
				cb_disp_str_limit.select_actions.extend (agent on_cb_disp_str_limit_cb (cb_disp_str_limit, tf_disp_str_size))

				get_current_values
			else
				if obj /= Void then
						-- A special value is available, that's an easy one!
					debug ("debugger_interface")
						io.put_string ("Special_value found%N")
						io.put_string ("Capacity: " + obj.object_spec_capacity.out + "%N")
					end
					slice_min := obj.object_spec_lower
					slice_max := obj.object_spec_capacity - 1 --| FIXME jfiat:  why not object_spec_upper ?
				else
					check
						shoud_not_occurred: False
					end
				end
			end

			if def then
				create cb_set_as_default.make_with_text (interface_names.l_set_as_default)
				cb_set_as_default.disable_select

				create cb_refresh.make_with_text (interface_names.l_refresh_tools)
				cb_refresh.enable_select
			end

				--| Text field for min/max box
			create tf_minf
			create tf_maxf

			tf_minf.return_actions.extend (agent tf_maxf.set_focus)
			tf_minf.return_actions.extend (agent tf_maxf.select_all)
			tf_maxf.return_actions.extend (agent check_and_get_limits_from_fields (cb_set_as_default, cb_disp_str_limit, tf_disp_str_size, tf_minf, tf_maxf, cb_refresh, dial))

			if tf_disp_str_size /= Void then
				tf_disp_str_size.return_actions.extend (agent tf_minf.set_focus)
			end

				--| Set values
			update_fields (cb_disp_str_limit, tf_disp_str_size, tf_minf, tf_maxf)

				--| Buttons.
			create resetb.make_with_text (Interface_names.l_restore_defaults)
			resetb.select_actions.extend (agent restore_default_values)
			resetb.select_actions.extend (agent update_fields (cb_disp_str_limit, tf_disp_str_size, tf_minf, tf_maxf))

			create okb.make_with_text (Interface_names.b_Ok)
			okb.select_actions.extend (agent check_and_get_limits_from_fields (cb_set_as_default, cb_disp_str_limit, tf_disp_str_size, tf_minf, tf_maxf, cb_refresh, dial))

			create cancelb.make_with_text (Interface_names.b_Cancel)
			cancelb.select_actions.extend (agent dial.destroy)

				--| Slices box layout
			create vbox

					--| Slice Min box
			create hbox
			create label.make_with_text (Interface_names.l_Min_index)
			label.align_text_left
			hbox.extend (label)

			tf_minf.set_minimum_width (Cst_field_label_width)
			extend_no_expand (hbox, tf_minf)
			vbox.extend (hbox)

					--| Slice Max box
			create hbox
			create label.make_with_text (Interface_names.l_Max_index)
			label.align_text_left
			hbox.extend (label)
			tf_maxf.set_minimum_width (Cst_field_label_width)
			extend_no_expand (hbox, tf_maxf)
			vbox.extend (hbox)

			extend_no_expand (maincont, vbox)

				--| Separator
			maincont.extend (create {EV_HORIZONTAL_SEPARATOR})

				--| Refresh current tool ?
			if cb_set_as_default /= Void or cb_refresh /= Void then
				if cb_set_as_default /= Void then
					create hbox
					hbox.set_padding (Layout_constants.Default_padding_size)
					extend_no_expand (hbox, cb_set_as_default)
					extend_no_expand (maincont, hbox)
				end
				if cb_refresh /= Void then
					create hbox
					hbox.set_padding (Layout_constants.Default_padding_size)
					extend_no_expand (hbox, cb_refresh)
					extend_no_expand (maincont, hbox)
				end
				maincont.extend (create {EV_HORIZONTAL_SEPARATOR})
			end

				--| Buttons box
			create hbox
			hbox.set_padding (Layout_constants.Default_padding_size)
			hbox.extend (create {EV_CELL})
			extend_button (hbox, resetb)
			hbox.extend (create {EV_CELL})
			extend_button (hbox, okb)
			extend_button (hbox, cancelb)
			hbox.extend (create {EV_CELL})

			extend_no_expand (maincont, hbox)

			dial.wipe_out
			dial.extend (maincont)
			dial.set_default_cancel_button (cancelb)

				-- Display the dialog.

			debug ("debugger_interface")
				io.put_string ("displaying the dialog%N")
			end
			dial.show_modal_to_window (window_manager.last_focused_development_window.window)
		end

	on_cb_disp_str_limit_cb (cb_disp_str_limit: EV_CHECK_BUTTON; tf_disp_str_size: EV_TEXT_FIELD) is
		require
			cb_disp_str_limit /= Void
			tf_disp_str_size /= Void
		do
			if cb_disp_str_limit.is_selected then
				tf_disp_str_size.disable_sensitive
			else
				tf_disp_str_size.enable_sensitive
			end
		end

feature {ES_OBJECTS_GRID_LINE} -- Dropping action

	drop_feature_on_object_stone (st: FEATURE_ON_OBJECT_STONE) is
		require
			st_not_void: st /= Void
		local
			objst: OBJECT_STONE
		do
			objst := st.object_stone
			if objst /= Void then
				drop_object_stone (objst)
			end
		end

	drop_object_stone (st: OBJECT_STONE) is
			-- Change the slice limits for the object
			-- represented by `st' in the object tool managed objects.
		require
			st_not_void: st /= Void
		local
			l_item: EV_ANY
			l_st_addr: STRING
			obj_grid_item: ES_OBJECTS_GRID_LINE
			spec_cap: INTEGER
		do
			debug ("debugger_interface")
				io.put_string ("dropped stone%N")
			end

			obj_grid_item := object_grid_line_for (st)
			if obj_grid_item /= Void and then obj_grid_item.object_is_special_value then
				debug ("debugger_interface")
					io.put_string ("Objects grid item found%N")
					io.put_string ("Capacity: " + obj_grid_item.object_spec_capacity.out + "%N")
				end

				get_slice_limits_on_target (obj_grid_item)
				if get_effective then
					spec_cap := obj_grid_item.object_spec_capacity
					slice_min := slice_min.min (spec_cap)
					slice_max := slice_max.min (spec_cap)

					obj_grid_item.refresh_spec_items (slice_min, slice_max)
				end
			end
		end

feature {NONE} -- Implementation

	internal_set_limits (lower, upper: INTEGER; disp_str_size: INTEGER) is
			-- Change limits to `lower, upper' values.
		local
			nmin, nmax: INTEGER
		do
			nmin := lower
			nmax := upper

			nmin := nmin.max (0)
			nmax := nmax.max (nmin)

			slice_min := nmin
			slice_max := nmax

			if disp_str_size = -1 or disp_str_size > 0 then
				displayed_string_size := disp_str_size
			end

			get_effective := True
		end

	get_current_values is
			-- Get current values
		do
			slice_min := debugger_manager.min_slice
			slice_max := debugger_manager.max_slice
			displayed_string_size := debugger_manager.displayed_string_size
		end

	restore_default_values	is
			-- Restore default values
		do
			slice_min := preferences.debugger_data.min_slice
			slice_max := preferences.debugger_data.max_slice
			displayed_string_size := preferences.debugger_data.default_displayed_string_size
		end

	update_fields (cb_disp_str_limit: EV_CHECK_BUTTON; tf_disp_str_size: EV_TEXT_FIELD;
				tf_minf: EV_TEXT_FIELD; tf_maxf: EV_TEXT_FIELD) is
			--
		do
			if tf_disp_str_size /= Void then
				if displayed_string_size = -1 then
					tf_disp_str_size.set_text (preferences.debugger_data.default_displayed_string_size.out)
					cb_disp_str_limit.enable_select
				else
					tf_disp_str_size.set_text (displayed_string_size.out)
					cb_disp_str_limit.disable_select
				end
			end
			tf_minf.set_text (slice_min.out)
			tf_maxf.set_text (slice_max.out)
		end

	check_and_get_limits_from_fields (cb_set_as_default, cb_disp_str_limit: EV_CHECK_BUTTON; tf_disp_str_size: EV_TEXT_FIELD;
				tf_minf: EV_TEXT_FIELD; tf_maxf: EV_TEXT_FIELD;
				cb_refresh: EV_CHECK_BUTTON;
				dial: EV_DIALOG) is
			-- Set `slice_min' and `slice_max' according to the values entered
			-- in `tf_minf' and `tf_maxf'.
		require
			tf_minf_not_void: tf_minf /= Void
			tf_maxf_not_void: tf_maxf /= Void
		local
			str1, str2, str3: STRING
			i: INTEGER
			disp_size: INTEGER
			errd: EB_WARNING_DIALOG
			ok: BOOLEAN
		do
			ok := True
			if cb_disp_str_limit /= Void and then cb_disp_str_limit.is_selected then
				disp_size := - 1
			elseif tf_disp_str_size /= Void then
				str1 := tf_disp_str_size.text
				if not str1.is_integer then
					create errd.make_with_text (Warning_messages.w_Not_an_integer)
					tf_disp_str_size.select_all
					errd.show_modal_to_window (window_manager.last_focused_development_window.window)
					ok := False
				else
					i := str1.to_integer
					if i <= 0 then
						create errd.make_with_text (Warning_messages.w_Not_a_positive_integer)
						tf_disp_str_size.select_all
						errd.show_modal_to_window (window_manager.last_focused_development_window.window)
						ok := False
					else
						disp_size := i
					end
				end
			end
			str2 := tf_minf.text
			if not str2.is_integer then
				create errd.make_with_text (Warning_messages.w_Not_an_integer)
				tf_minf.select_all
				errd.show_modal_to_window (window_manager.last_focused_development_window.window)
				ok := False
			end
			str3 := tf_maxf.text
			if not str3.is_integer then
				create errd.make_with_text (Warning_messages.w_Not_an_integer)
				tf_maxf.select_all
				errd.show_modal_to_window (window_manager.last_focused_development_window.window)
				ok := False
			end
			if ok then
				set_as_default_requested := cb_set_as_default /= Void and then cb_set_as_default.is_selected
				refresh_tools_requested := cb_refresh /= Void and then cb_refresh.is_selected
				internal_set_limits (str2.to_integer, str3.to_integer, disp_size)
				dial.destroy
			end
		end

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

end -- class ES_OBJECTS_GRID_SLICES_CMD

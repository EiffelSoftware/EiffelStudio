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

	SHARED_DEBUG

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

create
	make

feature -- Initialization

	make (a_tool: like tool) is
			-- Initialize `Current' and associate it with `tool'.
		do
			tool := a_tool
			for_tool := True
		end

feature -- Access

	menu_name: STRING is
			-- Menu name for `Current'.
		once
			Result := Interface_names.m_Set_slice_size + "New"
		end

	pixmap: EV_PIXMAP is
			-- Pixmaps representing the command.
		do
			--| No big pixmap is required for this command.
		end

	mini_pixmap: EV_PIXMAP is
			-- Pixmap representing the command for mini toolbars.
		do
			Result := pixmaps.small_pixmaps.icon_slice_limits
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := description
		end

feature -- Measurement

feature -- Status report

	tool: ES_OBJECTS_GRID_MANAGER
			-- Object tool `Current' is associated with. `Void' iff not `for_tool'.

	pretty_dlg: EB_PRETTY_PRINT_DIALOG
			-- Dialog `Current' is associated with. `Void' iff `for_tool'.

	for_tool: BOOLEAN
			-- Is `Current' associated with an object tool or with a pretty print dialog?

	name: STRING is
			-- Name of the command.
		once
			Result := Interface_names.l_Set_slice_limits + "New"
		end

	description: STRING is
			-- Description of the command.
		once
			Result := Interface_names.l_Set_slice_limits_desc
		end

feature -- Execution

	execute is
			-- Change the default slice limits through a dialog box.
		do
			if for_tool then
				get_slice_limits_on_global
				min_slice_ref.set_item (slice_min)
				max_slice_ref.set_item (slice_max)
				debug ("debugger_interface")
					io.put_string ("Messages are displayed%N")
				end
			end
		end

feature -- Basic operations

	new_mini_toolbar_item: EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new mini toolbar button for this command.
		do
			Result := Precursor
			Result.drop_actions.extend (agent drop_object_stone)
			Result.drop_actions.set_veto_pebble_function (agent is_resizable (?))
		end

	is_resizable (st: ANY): BOOLEAN is
			-- Is the object represented by `st' droppable, i.e. SPECIAL?
		local
			obj_grid_item: ES_OBJECTS_GRID_LINE
			conv_obj: OBJECT_STONE
			nat_dv: EIFNET_DEBUG_NATIVE_ARRAY_VALUE
			l_item: EV_ANY
			l_addr: STRING
		do
			if for_tool then
				conv_obj ?= st
				if conv_obj /= Void then
					l_item ?= conv_obj.ev_item
					if l_item /= Void then
						obj_grid_item ?= l_item.data
					end
					if obj_grid_item = Void and then tool /= Void and then conv_obj.object_address /= Void then
						check
							tool /= Void
							-- XR: This shouldn't happen (no toolbar button for
							-- this command in the pretty print dialog!)
						end
						l_addr := conv_obj.object_address
						if l_addr /= Void then
							obj_grid_item := tool.objects_grid_item (l_addr)
						end
					end
					Result := obj_grid_item /= Void and then obj_grid_item.object_is_special_value
				end
			else
				l_addr := pretty_dlg.current_object.object_address
				if Application.is_dotnet then
						--| not working in case of not registered object
					if application.imp_dotnet.know_about_kept_object (l_addr) then
						nat_dv ?= Application.imp_dotnet.kept_object_item (l_addr)
					end
					Result := nat_dv /= Void
				else
					Result := debugged_object_manager.object_at_address_is_special (l_addr)
				end
			end
		end

feature -- Obsolete

feature -- Inapplicable

feature {EB_PRETTY_PRINT_DIALOG}

	slice_min: INTEGER
			-- Minimum index of displayed attributes in special objects.

	slice_max: INTEGER
			-- Maximum index of displayed attributes in special objects.

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
			tf_disp_str_size: EV_TEXT_FIELD
			tf_minf: EV_TEXT_FIELD
			tf_maxf: EV_TEXT_FIELD
			okb: EV_BUTTON
			cancelb: EV_BUTTON
			maincont: EV_VERTICAL_BOX
			vbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
		do
				-- Build the dialog.
			create dial
			dial.set_title (Interface_names.t_Slice_limits)
			dial.set_icon_pixmap (pixmaps.icon_dialog_window)

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
				create tf_disp_str_size.make_with_text (application.displayed_string_size.out)
				tf_disp_str_size.set_minimum_width (Cst_field_label_width)

				create hbox
				create label.make_with_text (Interface_names.l_Max_displayed_string_size)
				label.align_text_left
				hbox.extend (label)
				extend_no_expand (hbox, tf_disp_str_size)
				extend_no_expand (maincont, hbox)

					--| Separator
				maincont.extend (create {EV_HORIZONTAL_SEPARATOR})

				slice_min := min_slice_ref.item
				slice_max := max_slice_ref.item
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

				--| Text field for min/max box
			create tf_minf.make_with_text (slice_min.out)
			create tf_maxf.make_with_text (slice_max.out)

			tf_minf.return_actions.extend (agent tf_maxf.set_focus)
			tf_minf.return_actions.extend (agent tf_maxf.select_all)
			tf_maxf.return_actions.extend (agent check_and_get_limits_from_fields (tf_disp_str_size, tf_minf, tf_maxf, dial))

			if tf_disp_str_size /= Void then
				tf_disp_str_size.return_actions.extend (agent tf_minf.set_focus)
			end

				--| Buttons.
			create okb.make_with_text (Interface_names.b_Ok)
			okb.select_actions.extend (agent check_and_get_limits_from_fields (tf_disp_str_size, tf_minf, tf_maxf, dial))

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

				--| Buttons box
			create hbox
			hbox.set_padding (Layout_constants.Default_padding_size)
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
			if for_tool then
				dial.show_modal_to_window (window_manager.last_focused_development_window.window)
			else
				dial.show_modal_to_window (pretty_dlg.dialog)
			end
		end

feature {ES_OBJECTS_GRID_LINE} -- Dropping action

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

			l_item := st.ev_item
			if l_item /= Void then
				obj_grid_item ?= l_item.data
			end
			if obj_grid_item = Void and then tool /= Void and then st.object_address /= Void then
				check
					tool /= Void
					-- XR: This shouldn't happen (no toolbar button for
					-- this command in the pretty print dialog!)
				end
				l_st_addr := st.object_address
				if l_st_addr /= Void then
					obj_grid_item := tool.objects_grid_item (l_st_addr)
				end
			end
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

	internal_set_limits (lower, upper: INTEGER) is
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
			get_effective := True
		end

	check_and_get_limits_from_fields (tf_disp_str_size: EV_TEXT_FIELD; tf_minf: EV_TEXT_FIELD; tf_maxf: EV_TEXT_FIELD; dial: EV_DIALOG) is
			-- Set `slice_min' and `slice_max' according to the values entered
			-- in `tf_minf' and `tf_maxf'.
		require
			tf_minf_not_void: tf_minf /= Void
			tf_maxf_not_void: tf_maxf /= Void
		local
			str1, str2, str3: STRING
			errd: EV_WARNING_DIALOG
			ok: BOOLEAN
		do
			ok := True
			if tf_disp_str_size /= Void then
				str1 := tf_disp_str_size.text
				if not str1.is_integer then
					create errd.make_with_text (Warning_messages.w_Not_an_integer)
					tf_disp_str_size.select_all
					errd.show_modal_to_window (window_manager.last_focused_development_window.window)
					ok := False
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
				if str1 /= Void then
					application.set_displayed_string_size (str1.to_integer)
				end
				internal_set_limits (str2.to_integer, str3.to_integer)
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

end -- class EB_SET_SLICE_SIZE_CMD

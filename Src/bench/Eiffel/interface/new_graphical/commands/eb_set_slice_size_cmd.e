indexing
	description: "Command in the object tool to define the default slice limits."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SET_SLICE_SIZE_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			mini_pixmap,
			new_mini_toolbar_item
		end

	EB_DEBUG_TOOL_DATA
		export
			{NONE} all
		end

	ATTR_REQUEST -- To be able to modify special values bounds!! (Beurk)
		rename
			make as attr_request_make
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end
		
	EB_VISION2_FACILITIES
		export
			{NONE} all
		end
		
create
	make,
	make_for_pretty_print

feature -- Initialization

	make (a_tool: like tool) is
			-- Initialize `Current' and associate it with `tool'.
		do
			tool := a_tool
			for_tool := True
		end

	make_for_pretty_print (dl: EB_PRETTY_PRINT_DIALOG) is
			-- Initialize `Current' and associate it with a pretty print dialog.
			-- This changes the behavior of the class.
		do
			for_tool := False
			pretty_dlg := dl
		end

feature -- Access

	menu_name: STRING is
			-- Menu name for `Current'.
		once
			Result := Interface_names.m_Set_slice_size
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version at least).
			-- Items at position 3 and 4 contain text.
		do
			--| No big pixmap is required for this command.
		end

	mini_pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command for mini toolbars.
		do
			Result := Pixmaps.Icon_slice_limits_vsmall
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := description
		end

feature -- Measurement

feature -- Status report

	tool: EB_OBJECT_TOOL
			-- Object tool `Current' is associated with. `Void' iff not `for_tool'.

	pretty_dlg: EB_PRETTY_PRINT_DIALOG
			-- Dialog `Current' is associated with. `Void' iff `for_tool'.

	for_tool: BOOLEAN
			-- Is `Current' associated with an object tool or with a pretty print dialog?

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.l_Set_slice_limits
		end

	description: STRING is
			-- Description of the command.
		do
			Result := Interface_names.l_Set_slice_limits_desc
		end

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Execution

	execute is
			-- Change the default slice limits through a dialog box.
		do
			if for_tool then
				get_slice_limits (True, Void, Void)
				min_slice_ref.set_item (slice_min)
				max_slice_ref.set_item (slice_max)
				debug ("DEBUGGER_INTERFACE")
					io.putstring ("Messages are displayed%N")
				end
			else
				get_slice_limits (False, pretty_dlg.current_object.object_address, Void)
				pretty_dlg.refresh
			end
		end

feature -- Basic operations

	new_mini_toolbar_item: EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new mini toolbar button for this command.
		do
			Result := Precursor
			Result.drop_actions.extend (~drop_object_stone)
			Result.drop_actions.set_veto_pebble_function (~is_resizable (?))
		end

	is_resizable (st: ANY): BOOLEAN is
			-- Is the object represented by `st' droppable, i.e. SPECIAL?
		local
			obj: EB_OBJECT_DISPLAY_PARAMETERS
			conv_obj: OBJECT_STONE
			dv: SPECIAL_VALUE
			dobj: DEBUGGED_OBJECT
			item: EV_TREE_ITEM
		do
			if for_tool then
				conv_obj ?= st
				if conv_obj /= Void then
					item := conv_obj.tree_item 
					if item /= Void then
						dv ?= item.data
					end
					if dv /= Void then
						Result := True
					else
						obj := tool.get_object_display_parameters (conv_obj.object_address)
						if obj /= Void then
							create dobj.make (conv_obj.object_address, 0, 1)
							if dobj.is_special then
								Result := True
							end
						end
					end
				end
			else
				create dobj.make (pretty_dlg.current_object.object_address, 0, 1)
				if dobj.is_special then
					Result := True
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

	get_effective: BOOLEAN
			-- Did the user really enter new min/max values in the dialog box?
			-- Valid after each call to get_slice_limits.

	get_slice_limits (def: BOOLEAN; address: STRING; dv: SPECIAL_VALUE) is
			-- Display a dialog box to enter new slice limits
			-- as default values if `def', 
			-- as object specific values otherwise,
			-- and fill slice_min and slice_max accordingly.
			-- if not `def', either `address' or `dv' should be specified.
		require
			default_xor_specific: def /= (address /= Void or else dv /= Void)
			address_xor_dv: not (address /= Void and then dv /= Void)
		local
			dial: EV_DIALOG
			label: EV_LABEL
			minf: EV_TEXT_FIELD
			maxf: EV_TEXT_FIELD
			okb: EV_BUTTON
			cancelb: EV_BUTTON
			sep: EV_HORIZONTAL_SEPARATOR
			maincont: EV_VERTICAL_BOX
			vbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			obj: EB_OBJECT_DISPLAY_PARAMETERS
			dobj: DEBUGGED_OBJECT
		do
				-- Build the dialog.
			create dial
			dial.set_title (Interface_names.t_Slice_limits)

				-- Build the dialog interface.
				-- Build containers.
			create maincont

			maincont.set_border_width (5)
			maincont.set_padding (5)
			
			get_effective := False

				-- Build widgets.
			if def then
				create vbox
				create label.make_with_text (Interface_names.l_Slice_taken_into_account1)
				label.align_text_left
				vbox.extend (label)

				create label.make_with_text (Interface_names.l_Slice_taken_into_account2)
				label.align_text_left
				vbox.extend (label)

				maincont.extend (vbox)
				maincont.disable_item_expand (vbox)

				create sep
				maincont.extend (sep)
				maincont.disable_item_expand (sep)

				slice_min := min_slice_ref.item
				slice_max := max_slice_ref.item
				create minf.make_with_text (min_slice_ref.item.out)
				create maxf.make_with_text (max_slice_ref.item.out)
			else
				if address /= Void then
					debug ("DEBUGGER_INTERFACE")
						io.put_string ("object found%N")
						create dobj.make (address, 0, 2)
						io.putstring ("Capacity: " + dobj.capacity.out + "%N")
						io.putstring ("Max capacity: " + dobj.max_capacity.out + "%N")
					end
					obj := tool.get_object_display_parameters (address)
					if obj /= Void then
							-- An object tree object was dropped.
							-- We can try using its information, knowing that it may not be up-to-date.
						if obj.is_special then
							slice_min := obj.spec_lower
							slice_max := obj.capacity - 1
						else
							slice_min := obj.spec_lower
							slice_max := obj.spec_higher
						end
					else
							-- Hmm we just have an address, we can't do much at the moment...
						slice_min := min_slice_ref.item
						slice_max := max_slice_ref.item
					end
				else
						-- A special value is available, that's an easy one!
					debug ("DEBUGGER_INTERFACE")
						io.put_string ("Special_value found%N")
						io.putstring ("Capacity: " + dv.capacity.out + "%N")
					end
				
					slice_min := dv.sp_lower
					slice_max := dv.capacity - 1
				end
				create minf.make_with_text (slice_min.out)
				create maxf.make_with_text (slice_max.out)
			end

				-- Labels and text fields.
			minf.set_minimum_width (70)
			maxf.set_minimum_width (70)
			minf.return_actions.extend (maxf~set_focus)
			minf.return_actions.extend (maxf~select_all)
			maxf.return_actions.extend (~get_limits (minf, maxf, dial))

			create vbox
			create hbox
			create label.make_with_text (Interface_names.l_Min_index)
			label.align_text_left
			hbox.extend (label)
			hbox.extend (minf)
			hbox.disable_item_expand (minf)
			vbox.extend (hbox)

			create hbox
			create label.make_with_text (Interface_names.l_Max_index)
			label.align_text_left
			hbox.extend (label)
			hbox.extend (maxf)
			hbox.disable_item_expand (maxf)
			vbox.extend (hbox)

			maincont.extend (vbox)
			maincont.disable_item_expand (vbox)

				-- Buttons.
			create okb.make_with_text (Interface_names.b_Ok)
			okb.select_actions.extend (~get_limits (minf, maxf, dial))
			create cancelb.make_with_text (Interface_names.b_Cancel)
			cancelb.select_actions.extend (dial~destroy)

			create sep
			maincont.extend (sep)
			maincont.disable_item_expand (sep)

			create hbox
			hbox.set_padding (Layout_constants.Default_padding_size)
			hbox.extend (create {EV_CELL})
			extend_button (hbox, okb)
			extend_button (hbox, cancelb)
			hbox.extend (create {EV_CELL})

			maincont.extend (hbox)
			maincont.disable_item_expand (hbox)
			dial.wipe_out
			dial.extend (maincont)
			dial.set_maximum_height (dial.minimum_height)
			dial.set_default_cancel_button (cancelb)

				-- Display the dialog.
			dial.disable_user_resize
			debug ("DEBUGGER_INTERFACE")
				io.putstring ("displaying the dialog%N")
			end
			dial.show_modal_to_window (window_manager.last_focused_development_window.window)
		end

	drop_object_stone (st: OBJECT_STONE) is
			-- Change the slice limits for the object
			-- represented by `st' in the object tool managed objects.
		require
			st_not_void: st /= Void
		local
			obj: EB_OBJECT_DISPLAY_PARAMETERS
			dv: SPECIAL_VALUE
			dobj: DEBUGGED_OBJECT
			parent: EV_TREE_NODE_LIST
			item, item2: EV_TREE_ITEM
		do
			debug ("DEBUGGER_INTERFACE")
				io.putstring ("dropped stone%N")
			end
			
			item := st.tree_item 
			if item /= Void then
				dv ?= item.data
			end
			if dv /= Void then
				debug ("DEBUGGER_INTERFACE")
					io.put_string ("Special_value found%N")
					io.putstring ("Capacity: " + dv.capacity.out + "%N")
				end
				
				get_slice_limits (False, Void, dv)
				if get_effective then
					slice_min := slice_min.min (dv.capacity)
					slice_max := slice_max.min (dv.capacity)
					create dobj.make (dv.address, slice_min, slice_max)
					dv.set_sp_bounds (slice_min, slice_max)
					dv.items.wipe_out
					dv.items.append (dobj.attributes)
					parent ?= item.parent
					if parent /= Void then
						parent.start
						parent.search (item)
						parent.remove
						item2 := tool.debug_value_to_item (dv)
						parent.put_left (item2)
						item2.expand
					end
				end
			else
				obj := tool.get_object_display_parameters (st.object_address)
				if obj /= Void then
					debug ("DEBUGGER_INTERFACE")
						io.putstring ("Found an object at address " + st.object_address + "!%N")
					end
					create dobj.make (st.object_address, 0, 1)
					debug ("DEBUGGER_INTERFACE")
						io.putstring ("cap: " + dobj.capacity.out + "max: " + dobj.max_capacity.out + "%N")
					end
					if dobj.is_special then
						get_slice_limits (False, st.object_address, Void)
						if get_effective then
							obj.set_lower (slice_min)
							obj.set_higher (slice_max)
							obj.refresh
						end
					end
				end
			end
		end

	get_limits (minf: EV_TEXT_FIELD; maxf: EV_TEXT_FIELD; dial: EV_DIALOG) is
			-- Set `slice_min' and `slice_max' according to the values entered
			-- in `minf' and `maxf'.
		require
			minf_not_void: minf /= Void
			maxf_not_void: maxf /= Void
		local
			nmin, nmax: INTEGER
			str1, str2: STRING
			errd: EV_WARNING_DIALOG
			ok: BOOLEAN
		do
			ok := True
			str1 := minf.text
			if not str1.is_integer then
				create errd.make_with_text (Warning_messages.w_Not_an_integer)
				minf.select_all
				errd.show_modal_to_window (window_manager.last_focused_development_window.window)
				ok := False
			end
			str2 := maxf.text
			if not str2.is_integer then
				create errd.make_with_text (Warning_messages.w_Not_an_integer)
				maxf.select_all
				errd.show_modal_to_window (window_manager.last_focused_development_window.window)
				ok := False
			end
			if ok then
				nmin := str1.to_integer
				nmax := str2.to_integer
				nmin := nmin.max (0)
				nmax := nmax.max (nmin)
				slice_min := nmin
				slice_max := nmax
				dial.destroy
				get_effective := True
			end
		end

invariant
	invariant_clause: -- Your invariant here

end -- class EB_SET_SLICE_SIZE_CMD

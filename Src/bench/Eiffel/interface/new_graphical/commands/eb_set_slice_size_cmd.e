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
	make
--	,	make_for_pretty_print
	
--| FIXME JFIAT: remove link to EB_SET_SLICE_SIZE_CMD
--| the slice limits should be specific to Pretty display settings
--| not linked to other dialog
--| we need to decide on this
				

feature -- Initialization

	make (a_tool: like tool) is
			-- Initialize `Current' and associate it with `tool'.
		do
			tool := a_tool
			for_tool := True
		end
				
--	make_for_pretty_print (dl: EB_PRETTY_PRINT_DIALOG) is
--			-- Initialize `Current' and associate it with a pretty print dialog.
--			-- This changes the behavior of the class.
--		do
--			for_tool := False
--			pretty_dlg := dl
--			slice_min := 0
--			slice_max := Application.displayed_string_size
--		end

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
			obj: EB_OBJECT_DISPLAY_PARAMETERS
			conv_obj: OBJECT_STONE
			
			spec_dv: SPECIAL_VALUE
			nat_dv: EIFNET_DEBUG_NATIVE_ARRAY_VALUE
			
			dobj: DEBUGGED_OBJECT
			item: EV_TREE_ITEM
		do
			if for_tool then
				conv_obj ?= st
				if conv_obj /= Void then
					item := conv_obj.tree_item 
					if item /= Void then
						spec_dv ?= item.data
						nat_dv ?= item.data
					end
					if spec_dv /= Void or nat_dv /= Void then
						Result := True
					else
						if Application.is_dotnet then
							--| FIXME JFIAT: not working in case of not registered object
--							create {DEBUGGED_OBJECT_DOTNET} dobj.make (conv_obj.object_address, 0, 1)
--							if dobj.is_special then
--								Result := True
--							end						
							nat_dv ?= Application.imp_dotnet.kept_object_item (conv_obj.object_address)
							Result := nat_dv /= Void
						else
							obj := tool.get_object_display_parameters (conv_obj.object_address)
							if obj /= Void then
								create {DEBUGGED_OBJECT_CLASSIC} dobj.make (conv_obj.object_address, 0, 1)
								if dobj.is_special then
									Result := True
								end
							end
						end
					end
				end
			else
				if Application.is_dotnet then
							--| FIXME JFIAT: not working in case of not registered object
--					create {DEBUGGED_OBJECT_DOTNET} dobj.make (pretty_dlg.current_object.object_address, 0, 1)
--					if dobj.is_special then
--						Result := True
--					end					
					nat_dv ?= Application.imp_dotnet.kept_object_item (pretty_dlg.current_object.object_address)
					Result := nat_dv /= Void
				else
					create {DEBUGGED_OBJECT_CLASSIC} dobj.make (pretty_dlg.current_object.object_address, 0, 1)
					if dobj.is_special then
						Result := True
					end
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

	get_slice_limits (def: BOOLEAN; address: STRING; dv: ABSTRACT_SPECIAL_VALUE) is
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
						if Application.is_dotnet then
							create {DEBUGGED_OBJECT_DOTNET} dobj.make (address, 0, 2)			
						else
							create {DEBUGGED_OBJECT_CLASSIC} dobj.make (address, 0, 2)						
						end
						io.putstring ("Capacity: " + dobj.capacity.out + "%N")
						io.putstring ("Max capacity: " + dobj.max_capacity.out + "%N")						
					end
					if for_tool then
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
			minf.return_actions.extend (agent maxf.set_focus)
			minf.return_actions.extend (agent maxf.select_all)
			maxf.return_actions.extend (agent get_limits (minf, maxf, dial))

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
			okb.select_actions.extend (agent get_limits (minf, maxf, dial))
			create cancelb.make_with_text (Interface_names.b_Cancel)
			cancelb.select_actions.extend (agent dial.destroy)

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
			if for_tool then
				dial.show_modal_to_window (window_manager.last_focused_development_window.window)
			else
				dial.show_modal_to_window (pretty_dlg.window)
			end
		end

	drop_object_stone (st: OBJECT_STONE) is
			-- Change the slice limits for the object
			-- represented by `st' in the object tool managed objects.
		require
			st_not_void: st /= Void
		local
			obj: EB_OBJECT_DISPLAY_PARAMETERS
			abs_dv: ABSTRACT_DEBUG_VALUE
			abs_spec_dv: ABSTRACT_SPECIAL_VALUE
			spec_dv: SPECIAL_VALUE
			str_dv: EIFNET_DEBUG_STRING_VALUE
			nat_arr_dv: EIFNET_DEBUG_NATIVE_ARRAY_VALUE
			dobj: DEBUGGED_OBJECT
			parent: EV_TREE_NODE_LIST
			item, item2: EV_TREE_ITEM
		do
			debug ("DEBUGGER_INTERFACE")
				io.putstring ("dropped stone%N")
			end
			
			item := st.tree_item 
			if item /= Void then
				abs_spec_dv ?= item.data
			end
			if abs_spec_dv /= Void then
				debug ("DEBUGGER_INTERFACE")
					io.put_string ("Special_value found%N")
					io.putstring ("Capacity: " + abs_spec_dv.capacity.out + "%N")
				end
				
				get_slice_limits (False, Void, abs_spec_dv)
				if get_effective then
					slice_min := slice_min.min (abs_spec_dv.capacity)
					slice_max := slice_max.min (abs_spec_dv.capacity)

					abs_spec_dv.set_sp_bounds (slice_min, slice_max)
					abs_spec_dv.items.wipe_out

					spec_dv ?= abs_spec_dv
					if spec_dv /= Void then --| SPECIAL_VALUE						
						create {DEBUGGED_OBJECT_CLASSIC} dobj.make (spec_dv.address, slice_min, slice_max)
						spec_dv.items.append (dobj.attributes)
					else
						nat_arr_dv ?= abs_spec_dv
						if nat_arr_dv /= Void then
							nat_arr_dv.fill_items (slice_min, slice_max)
						end
					end
					
					parent ?= item.parent
					if parent /= Void then
						parent.start
						parent.search (item)
						parent.remove
						item2 := tool.debug_value_to_tree_item (abs_spec_dv)
						parent.put_left (item2)
						item2.expand
					end						
				end
			else
				check
					tool /= Void
					-- XR: This shouldn't happen (no toolbar button for
					-- this command in the pretty print dialog!)
				end
				obj := tool.get_object_display_parameters (st.object_address)
				if obj /= Void then
					debug ("DEBUGGER_INTERFACE")
						io.putstring ("Found an object at address " + st.object_address + "!%N")
					end
					--| FIXME jfiat [2003/10/08 - 18:19] Not very nice design ..
					if Application.is_dotnet then 
						abs_dv := Application.imp_dotnet.kept_object_item (st.object_address)
						str_dv ?= abs_dv
						if str_dv /= Void then
							slice_min := 0
							slice_max := str_dv.length
						else
							nat_arr_dv ?= abs_dv
							if nat_arr_dv /= Void then -- is Special
								get_slice_limits (False, st.object_address, Void)
								if get_effective then
									obj.set_lower (slice_min)
									obj.set_higher (slice_max)
									obj.refresh
								end
							end
						end
					else
						create {DEBUGGED_OBJECT_CLASSIC} dobj.make (st.object_address, 0, 1)
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

	get_limits (minf: EV_TEXT_FIELD; maxf: EV_TEXT_FIELD; dial: EV_DIALOG) is
			-- Set `slice_min' and `slice_max' according to the values entered
			-- in `minf' and `maxf'.
		require
			minf_not_void: minf /= Void
			maxf_not_void: maxf /= Void
		local
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
				internal_set_limits (str1.to_integer, str2.to_integer)
				dial.destroy
			end
		end

invariant
	invariant_clause: -- Your invariant here

end -- class EB_SET_SLICE_SIZE_CMD

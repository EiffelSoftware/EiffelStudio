indexing
	description: "Widget representing the context tree."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class 

	CONTEXT_TREE 

inherit 

	CONSTANTS

	SHARED_CONTEXT

	CONTEXT_STONE

	DRAWING_AREA
		rename
			make as dr_area_create,
			identifier as dr_area_identifier,
			cursor as drawing_cursor,
			init_toolkit as drawing_area_init_tookit
		end

	EB_DRAWING_BOX [TREE_ELEMENT]
		rename
			make as drawing_box_create
		export
			{NONE} all
			{NEW_CONTEXT_CATALOG, CONTEXT_CATALOG} wipe_out
			{ANY} enable_drawing, disable_drawing
		redefine
			execute,
			append
		end

	HOLE
		redefine
			compatible, process_type, process_context,
			process_attribute, process_instance
		select
			init_toolkit
		end

	CONTEXT_DRAG_SOURCE

	REMOVABLE

creation

	make

feature -- Creation

	make (a_name: STRING a_parent: SCROLLED_W) is
		local
			top_form, form: FORM
			del_com: DELETE_WINDOW
			close_button: CLOSE_WINDOW_BUTTON
			con_ed_hole: CON_ED_HOLE
			cut_hole: CUT_HOLE
			raise_widget_hole: RAISE_WIDGET_HOLE
			show_window_hole: SHOW_WINDOW_HOLE
			exp_parent_hole: EXPAND_PARENT_HOLE
		do
			dr_area_create (a_name, a_parent)
				--| To avoid the `empty_constraint' invariant violation
			before := True
			scrolled_w ?= a_parent
			scrolled_w.set_working_area (Current)
			!! current_position
			drawing_box_create (Current)
				
				-- Callbacks

			add_expose_action (Current, Second)
			add_button_press_action (1, Current, Third)
			add_button_press_action (3, Current, Third)
			initialize_transport

			set_action ("Ctrl<Btn1Down>", Current, Fourth)

				-- Callbacks for arrow keys
			set_action ("<Key>osfLeft", Current, Fifth)
			set_action ("<Key>osfRight", Current, Sixth)
			set_action ("<Key>osfUp", Current, Seventh)
			set_action ("<Key>osfDown", Current, Eighth)

				-- Used to resize the drawing area whenever the
				-- configuration (size, ...) of the parent scrolled
				-- window changes.
			scrolled_w.set_action ("<Configure>", Current, configure_action)

			!!positions.make

			set_background_color (Resources.drawing_area_color)
			register
		ensure
			target_is_current: target = Current
		end

feature -- Temporary!!!!!

--	transporter: TRANSPORTER is
--		once
--			Result := new_main_panel.base
--		end

feature 

	remove_yourself is
			-- Remove context represented by
			-- Current context stone of tree.
		do
			data.remove_yourself
		end

feature -- Stone

	target: WIDGET is
		do
			Result := Current
		end

	data: CONTEXT

feature {NONE}

	source: WIDGET is
		do
			Result := Current
		end
	
feature 

	cut (elt: TREE_ELEMENT) is
			-- Remove 'elt' from the tree.
		do
			start
			search (elt)
			if not after then
				remove
			end
		end

	append (elt: TREE_ELEMENT) is
			-- Append 'elt' to the tree.
		local
			display_elt: BOOLEAN
			a_parent: CONTEXT
		do
			display_elt := True
			if not elt.data.is_window then
					-- If it is not a window
				from
					a_parent := elt.data.parent
				until
					(a_parent = Void) or else not display_elt
				loop
					if not a_parent.tree_element.show_children then
						display_elt := False
					end
					a_parent := a_parent.parent
				end
			end
			if display_elt then
				Precursor (elt)
			end
		end
		
feature {NONE}

	scrolled_w: SCROLLED_W

feature 

	focus_label: FOCUS_LABEL

	configure_action: ANY is
		once
			!! Result
		end

feature {TREE_ELEMENT}

	current_position: COORD_XY_FIG

feature {NONE}

	positions: LINKED_LIST [COORD_XY_FIG]
			-- Position of the last element of each top window

feature 

	display (modified_context: CONTEXT) is
		require
			context_not_void: not (modified_context = Void)
		local
			saved_position: COORD_XY_FIG
			root_context: CONTEXT
			real_draw: BOOLEAN
			i: INTEGER
		do
			if not drawing_disabled then
				if positions.count < Shared_window_list.count then
					from
						positions.finish
						i := positions.count
					until
						i > Shared_window_list.count
					loop
						positions.put_right (current_position)
						i := i + 1
					end
				end
				root_context := modified_context.root
				if modified_context.is_root then
					real_draw := True
				end
				clear
				max_x := 0 max_y := 0
				set_new_position (10, 10, 10)
				from
					Shared_window_list.start
					positions.start
				until
					Shared_window_list.after
				loop
					if Shared_window_list.item = root_context then
						real_draw := True
					end
					if real_draw then
						saved_position := Shared_window_list.item.tree_element.coord_calc
						saved_position.set (max_x, max_y)
						positions.put (saved_position)
						set_new_position (10, max_y + 40, 10)
					else
						max_x :=  max_x.max (positions.item.x)
						set_new_position (10, positions.item.y + 40, 10)
					end
					Shared_window_list.forth
					positions.forth
				end
				set_max_size
				draw
			end
		end

	set_max_size is
		do
			set_size (scrolled_w.width.max (max_x+20),
					scrolled_w.height.max (max_y+20))
		end
	
feature {NONE}

	max_x, max_y: INTEGER

	
feature {TREE_ELEMENT}

	set_new_position (new_x, new_y, maxi_x: INTEGER) is
		do
			current_position.set (new_x, new_y)
			max_x := max_x.max (maxi_x)
			max_y := max_y.max (new_y)
		end

	
feature {NONE}

	execute (argument: ANY) is
		local
			a_group: LINKED_LIST  [CONTEXT]
			a_context: CONTEXT
			cmd: ARROW_MOVE_CMD
			void_stone: STONE
			d_x, d_y: INTEGER
			wind_c: WINDOW_C
		do
			if (argument = configure_action) then
				set_max_size
			elseif (argument = Second) then
					-- Expose event
				draw
			else
				find
				if not found then
					data := Void	
				elseif (argument = Third) then
						-- Selection before show command or transport.
					data := element.data
				elseif (argument = Fourth) then
						-- Group
					a_context := element.data
					a_group := a_context.group
					if a_context.grouped then
						a_group.start
						a_group.search (a_context)
						a_group.remove
						a_context.set_grouped (False)
					elseif a_group.empty or else a_context.parent = a_group.first.parent then
						a_group.finish
						a_group.put_right (a_context)
						a_context.set_grouped (True)
					end
					display (a_context)
				else
					a_context := element.data
					if (a_context.parent = Void) or else
					   a_context.parent.is_bulletin 
					then
						!!cmd
						cmd.execute (a_context)
						if (argument = Fifth) then
							d_x := -1
						elseif (argument = Sixth) then
							d_x := 1
						elseif (argument = Seventh) then
							d_y := -1
						elseif (argument = Eighth) then
							d_y := 1
						end
						cmd.move_context (d_x, d_y)
					end
				end
			end
		end

feature -- Hole

	compatible (st: STONE): BOOLEAN is
		do
			Result :=
				st.stone_type = Stone_types.attribute_type or else
				st.stone_type = Stone_types.context_type or else
				st.stone_type = Stone_types.type_stone_type or else
				st.stone_type = Stone_types.command_type	
		end

	process_instance (dropped: CMD_INST_STONE) is
			-- Add command associated to `dropped' in current
			-- state defined on the main panel.
		local
			the_stone: COMMAND_TOOL_HOLE
			the_behavior: BEHAVIOR
		do
			the_stone ?= dropped
			find
			if found and then the_stone /= Void then
				if main_panel.current_state = Void then
					main_panel.set_current_state (app_editor.initial_state_circle.data)
				end
				main_panel.current_state.find_input (element.data)
				if main_panel.current_state.after then					
					!! the_behavior.make
					the_behavior.set_context (element.data)
					the_behavior.set_internal_name ("")
					main_panel.current_state.add (element.data, the_behavior)
				else
					the_behavior := main_panel.current_state.output.data
				end
				the_behavior.set_input_data (element.data.default_event)
				the_behavior.set_output_data (the_stone.data)
				the_behavior.drop_pair
				the_behavior.reset_input_data
				the_behavior.reset_output_data
			end
		end

	process_attribute (dropped: ATTRIB_STONE) is
		do
			find
			if found then
				dropped.copy_attribute (element.data)
			end
		end

	process_type (dropped: TYPE_STONE) is
		-- Process stone in current hole
		local
			a_composite_c: COMPOSITE_C
			context_type: CONTEXT_TYPE
			group_stone: GROUP_ICON_STONE
			new_context: CONTEXT
			temp_w_context: TEMP_WIND_C
			perm_w_context: PERM_WIND_C
			st: like dropped
		do
			st := dropped
			group_stone ?= dropped
			if group_stone /= Void then
				st := group_stone.data
			end
			if main_panel.project_initialized then
				context_type ?= st
			end
			if context_type /= Void and then
				context_type = context_catalog.perm_wind_type then
					new_context := context_type.create_context (Void)
						-- arm the interface button
					main_panel.interface_entry.arm
			elseif context_type /= Void and then
				context_type = context_catalog.temp_wind_type then
					find
					if found then
						perm_w_context ?= element.data.root
						if perm_w_context /= Void then		
							new_context := context_type.create_context (perm_w_context)
						else
							temp_w_context ?= element.data.root
							perm_w_context ?= temp_w_context.parent
							if perm_w_context /= Void then	
								new_context := context_type.create_context (perm_w_context)
							end
						end
					end
			else
				find
				if found then
					a_composite_c ?= element.data
					if a_composite_c /= Void and then
						not a_composite_c.is_in_a_group and then
						not a_composite_c.is_a_group
					then
						if context_type /= Void and then 
							context_type.is_valid_parent (a_composite_c) 
						then
							new_context := context_type.create_context (a_composite_c)
						end
					end
				end
			end
			process_new_context (new_context)
		end

	process_context (dropped: CONTEXT_STONE) is
		-- Process stone in current hole
		local
			a_composite_c: COMPOSITE_C
			context_stone: CONTEXT_STONE
			window_c: WINDOW_C
			new_context: CONTEXT
			temp_w_context: TEMP_WIND_C
			perm_w_context: PERM_WIND_C
		do
			context_stone := dropped
			window_c ?= context_stone.data
			if window_c /= Void then
				if window_c.is_perm_window then
					new_context := window_c.create_context (Void)
				else
					find
					if found then
						perm_w_context ?= element.data.root
						if perm_w_context /= Void then			
							new_context := window_c.create_context (perm_w_context)
						else
							temp_w_context ?= element.data.root
							perm_w_context ?= temp_w_context.parent
							if perm_w_context /= Void then	
								new_context := window_c.create_context (perm_w_context)
							end
						end
					end
				end
			else
				find
				if found then
					a_composite_c ?= element.data
					if a_composite_c /= Void and then
						not a_composite_c.is_in_a_group and then
						not a_composite_c.is_a_group and then
						context_stone.data.is_valid_parent (a_composite_c)
					then
						new_context := context_stone.data.create_context 
												(a_composite_c)
					end
				end
			end
			process_new_context (new_context)
		end

	process_new_context (new_context: CONTEXT) is
		local
			temp_w_context: TEMP_WIND_C
		do
			if new_context /= Void then
				new_context.realize
				new_context.widget.manage
				temp_w_context ?= new_context
				if temp_w_context /= Void then
					temp_w_context.popup
				end
				display (new_context)
			end
		end

end


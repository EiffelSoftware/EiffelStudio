indexing
	description: "Widget representing the context tree."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class 
	CONTEXT_TREE 

inherit 
	EV_TREE
		redefine
			make, show, hide
		end

	WINDOWS

	CONSTANTS

	SHARED_CONTEXT

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the context tree.
		local
			tbar: EV_TOOL_BAR
 			raise_widget_hole: RAISE_WIDGET_HOLE
 			show_window_hole: SHOW_WINDOW_HOLE
 			exp_parent_hole: EXPAND_PARENT_HOLE
		do
			create main_box.make (par)
			main_box.set_spacing (2)
			create tbar.make (main_box)
			create raise_widget_hole.make (tbar)
			create show_window_hole.make (tbar)
			create exp_parent_hole.make (tbar)

			{EV_TREE} Precursor (main_box)
			set_values
			set_callbacks
		end

	set_values is
			-- Set the GUI values.
		do
--			set_background_color (Resources.tree_bg_color)
--			set_foreground_color (Resources.tree_fg_color)
		end

	set_callbacks is
			-- Set the GUI callbacks.
		local
			routine_cmd: EV_ROUTINE_COMMAND
		do
				--| Target command
			create routine_cmd.make (~process_context)
			add_pnd_command (Pnd_types.context_type, routine_cmd, Void)
			create routine_cmd.make (~process_type)
			add_pnd_command (Pnd_types.window_type, routine_cmd, Void)
		end

feature {NONE} -- GUI attribute

	main_box: EV_VERTICAL_BOX

feature -- Status setting

	show is
		do
			main_window.horizontal_split_area.set_parent (main_window.vertical_box)
			main_window.vertical_split_area.set_parent (main_window.horizontal_split_area)
		end

	hide is
		do
--			main_box.parent.item (2).set_parent (main_window.vertical_box)
			if main_window.vertical_split_area.shown then
				main_window.vertical_split_area.set_parent (main_window.vertical_box)
			end
			main_window.horizontal_split_area.set_parent (Void)
		end

feature {CONTEXT_TREE} -- Routine commands

	process_context (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
			-- Create new permanent windows
		local
			window_c: WINDOW_C
			new_context: CONTEXT
		do
			if main_window.project_initialized then
				window_c ?= ev_data.data
				if window_c /= Void and then window_c.is_perm_window then
					new_context := window_c.create_context (Void)
					process_new_context (new_context)
				end
			end
		end

	process_type (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
			-- Create new permanent windows
		local
			context_type: CONTEXT_TYPE
			new_context: CONTEXT
		do
			if main_window.project_initialized then
				context_type ?= ev_data.data
				if context_type /= Void
				and then context_type = context_catalog.container_page.perm_wind_type
				then
					new_context := context_type.create_context (Void)
						-- arm the interface button
					main_window.menu_bar.interface_entry.set_selected (True)
					process_new_context (new_context)
				end
			end
		end

	process_new_context (new_context: CONTEXT) is
		do
			if new_context /= Void then
				new_context.show
			end
		end

feature {NONE}

--	execute (argument: ANY) is
--		local
--			a_group: LINKED_LIST  [CONTEXT]
--			a_context: CONTEXT
--			cmd: ARROW_MOVE_CMD
--			void_stone: STONE
--			d_x, d_y: INTEGER
--			wind_c: WINDOW_C
--		do
--			if (argument = configure_action) then
--				set_max_size
--			elseif (argument = Second) then
--					-- Expose event
--				draw
--			else
--				find
--				if not found then
--					data := Void	
--				elseif (argument = Third) then
--						-- Selection before show command or transport.
--					data := element.data
--				elseif (argument = Fourth) then
--						-- Group
--					a_context := element.data
--					a_group := a_context.group
--					if a_context.grouped then
--						a_group.start
--						a_group.search (a_context)
--						a_group.remove
--						a_context.set_grouped (False)
--					elseif a_group.empty or else a_context.parent = a_group.first.parent then
--						a_group.finish
--						a_group.put_right (a_context)
--						a_context.set_grouped (True)
--					end
--					display (a_context)
--				else
--					a_context := element.data
--					if (a_context.parent = Void) or else
--					   a_context.parent.is_bulletin 
--					then
--						!!cmd
--						cmd.execute (a_context)
--						if (argument = Fifth) then
--							d_x := -1
--						elseif (argument = Sixth) then
--							d_x := 1
--						elseif (argument = Seventh) then
--							d_y := -1
--						elseif (argument = Eighth) then
--							d_y := 1
--						end
--						cmd.move_context (d_x, d_y)
--					end
--				end
--			end
--		end

end -- class CONTEXT_TREE


indexing
	description: "Context tree element: represents a context."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class TREE_ELEMENT 

inherit
	EV_TREE_ITEM
		rename
			make as item_make
		redefine
			data
		end

 	WINDOWS

	CONSTANTS

creation
	make

feature {NONE} -- Initialization

	make (ctxt: CONTEXT) is
			-- Create a tree element from a context.
		do
			if ctxt.is_root then
				make_with_text (main_window.context_tree, ctxt.title_label)
			else
				make_with_text (ctxt.parent.tree_element, ctxt.title_label)
			end
		--XX Add the pixmap representing the context:
		--XX set_pixmap (a_context.pixmap)
			set_data (ctxt)
			set_values
			set_callbacks
		end

	set_values is
		local
			tr_item: EV_TREE_ITEM
		do
			tr_item ?= parent
			if tr_item /= Void then
				tr_item.set_expand (True)
			end
		end

	set_callbacks is
		local
			arg: EV_ARGUMENT1 [ANY]
			cmd: EV_ROUTINE_COMMAND
		do
			create arg.make (data)
			add_button_press_command (3, create {PND_ACCELERATOR}, arg)
			activate_pick_and_drop (Void, Void)
			set_transported_data (data)
			set_data_type (Pnd_types.context_type)

			create cmd.make (~process_attribute)
			add_pnd_command (Pnd_types.attribute_type, cmd, Void)
			create cmd.make (~process_instance)
			add_pnd_command (Pnd_types.command_type, cmd, Void)
			create cmd.make (~process_context)
			add_pnd_command (Pnd_types.context_type, cmd, Void)
			create cmd.make (~process_type)
			add_pnd_command (Pnd_types.type_data_type, cmd, Void)
		end

feature -- Access

	data: CONTEXT

	selected: BOOLEAN

feature -- Basic action

	select_figure is
		do
			selected := True
--			data.set_selected_color
			from
				data.child_start
			until
				data.child_offright
			loop
				data.child.tree_element.select_figure
				data.child_forth
			end
		end

	deselect is
		do
--			data.deselect_color
			selected := False
			from
				data.child_start
			until
				data.child_offright
			loop
				data.child.tree_element.deselect
				data.child_forth
			end
		end

feature {TREE_ELEMENT} -- Routine commands

	process_attribute (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
		local
--			dt: ATTRIB_STONE
		do
--			dt ?= ev_data
--			if dt /= Void then
--				dt.copy_attribute (data)
--			end
		end

	process_instance (arg: EV_ARGUMENT; event_data: EV_PND_EVENT_DATA) is --dropped: CMD_INST_STONE) is
--			-- Add command associated to `dropped' in current
--			-- state defined on the main panel.
--		local
--			inst: CMD_INSTANCE
--			the_behavior: BEHAVIOR
		do
--			inst ?= ev_data.data
--			if inst /= Void then
--				if main_window.current_state = Void then
--					main_window.set_current_state (app_editor.initial_state_circle.data)
--				end
--				main_window.current_state.find_input (data)
--				if main_window.current_state.after then					
--					create the_behavior.make
--					the_behavior.set_context (data)
--					the_behavior.set_internal_name ("")
--					main_window.current_state.add (data, the_behavior)
--				else
--					the_behavior := main_window.current_state.output.data
--				end
--				the_behavior.set_input_data (data.default_event)
--				the_behavior.set_output_data (inst.data)
--				the_behavior.drop_pair
--				the_behavior.reset_input_data
--				the_behavior.reset_output_data
--			end
		end

	process_context (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
			-- Process data in current target
		local
			holder_c: HOLDER_C
			ctxt, new_context: CONTEXT
		do
			ctxt ?= ev_data.data
			if ctxt /= Void then
				if ctxt.is_perm_window then
					new_context := ctxt.create_context (Void)
				else
					holder_c ?= data
					if holder_c /= Void
					and then not holder_c.is_in_a_group
					and then not holder_c.is_a_group
					and then ctxt.is_valid_parent (holder_c)
					then
						new_context := ctxt.create_context (holder_c)
					end
				end
				process_new_context (new_context)
			end
		end

	process_type (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
		-- Process stone in current hole
		local
			context_type: CONTEXT_TYPE
			wind_c: WINDOW_C
			holder_c: HOLDER_C
--X			group_stone: GROUP_ICON_STONE
			new_context: CONTEXT
		do
--X			group_stone ?= dropped
--X			if group_stone /= Void then
--X				context_type := group_stone.data
--X			end
			if main_window.project_initialized then
				context_type ?= ev_data.data
			end
			if context_type /= Void then
				if context_type = context_catalog.container_page.perm_wind_type then
					new_context := context_type.create_context (Void)
						-- arm the interface menu entry
					main_window.menu_bar.interface_entry.set_selected (True)
				elseif context_type = context_catalog.container_page.temp_wind_type then
					wind_c ?= data
					if wind_c /= Void then
						new_context := context_type.create_context (wind_c)
					end
				else
					holder_c ?= data
					if holder_c /= Void
					and then not holder_c.is_in_a_group
					and then not holder_c.is_a_group
					and then context_type.is_valid_parent (holder_c)
					then
						new_context := context_type.create_context (holder_c)
					end
				end
				process_new_context (new_context)
			end
		end

	process_new_context (new_context: CONTEXT) is
		do
			if new_context /= Void then
				new_context.show
			end
		end

end -- class TREE_ELEMENT


indexing

	description: "Selector for the class_tool windows."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SELECTOR_W 

inherit
	SCROLLABLE_LIST
		redefine
			make, item
		end
	COMMAND

	HOLE 
		redefine
			compatible, process_class, process_classi, process_feature
		end

	WINDOWS
	WINDOW_ATTRIBUTES
	SHARED_EIFFEL_PROJECT
	EB_CONSTANTS

create
	make

feature --Initialization
	
	make (a_name: STRING; a_parent: SPLIT_WINDOW_CHILD) is
		do
			make_fixed_size (a_name,a_parent)
			set_widget_attributes (Current)
 			add_click_action (Current,"selector_command")
			selector_parent?= a_parent
			register
		end

	init_toggle (toggle: TOGGLE_B) is
			-- Init arm action.
		do
			toggle.add_activate_action (Current, Void);
			associated_toggle:=toggle
			if Project_resources.selector_window.actual_value then
				show_selector
			else
				hide_selector
			end
		end;

feature -- Redefine

	stone_type:INTEGER is  
			-- A selector window does not have a correspondant stone.
		do
		end

	target:WIDGET is
		do
			Result := Current
		end

	compatible(dropped: STONE): BOOLEAN is
		do
			Result := True
		end

	
feature -- Hole processing

	process_classi (a_stone: CLASSI_STONE) is
			-- Process dropped stone `a_stone'.
		local
			new_tool: CLASS_W
		do
			new_tool := window_manager.class_window
			new_tool.display
			new_tool.process_classi (a_stone)
		end
 
	process_class (a_stone: CLASSC_STONE) is
			-- Process dropped stone `a_stone'.
		local
			new_tool: CLASS_W
		do
			new_tool := window_manager.class_window
			new_tool.display
			new_tool.process_class (a_stone)
		end
 
	process_feature (a_stone: FEATURE_STONE) is
			-- Process dropped stone `a_stone'.
		local
			new_tool: ROUTINE_W
		do
			new_tool := window_manager.routine_window
			new_tool.display
			new_tool.process_feature (a_stone)
		end

feature -- Access

	associated_toggle: TOGGLE_B;
			-- associated toggle button with toolbar

	item: SCROLLABLE_LIST_SELECTOR_ELEMENT is
		do
 			Result ?= implementation.item
 		end;

	selector_parent: SPLIT_WINDOW_CHILD

feature -- User interface

	show_selector is
		do
			manage
			associated_toggle.set_toggle_on
			selector_parent.manage
		end

	hide_selector is
		do
			unmanage
			associated_toggle.set_toggle_off
			selector_parent.unmanage
		end

	add_tool_entry(t_w:TOOL_W) is
		local
			tmp: SCROLLABLE_LIST_SELECTOR_ELEMENT
		do
			create tmp.make (t_w)
			extend(tmp)
		end

	change_tool_entry (t_w: TOOL_W) is
		local
			tmp: SCROLLABLE_LIST_SELECTOR_ELEMENT
  			t_name:STRING
		do
			t_name := clone (t_w.eb_shell.icon_name)
			create tmp.make (t_w)

				-- If two classes are opened on the same class, the new opened class
				-- is marked as read-only
--			if t_name /= Void and then is_tool_read_only (t_name,t_w) then
--				tmp.set_read_only
--			end

			from
				start
			until
				after or else t_w = item.tool
			loop
				forth
			end

			if index <= count then 
				replace(tmp)
			end
		end

	remove_tool_entry (t_w: TOOL_W) is
		do
			from
				start
			until
				after or else t_w = item.tool
			loop
				forth
			end

			if index <= count then 
				remove
			end
		end

feature -- Basic operations

	is_tool_read_only (tool_name: STRING; t_w: TOOL_W): BOOLEAN is
		local
			tmp:STRING
			class_w: CLASS_W
			classc_stone: CLASSC_STONE
			classi_stone: CLASSI_STONE
		do
			class_w ?= t_w
			if class_w /= Void then
				classc_stone ?= class_w.stone
				if classc_stone /= Void then
					Result := classc_stone.e_class.lace_class.is_read_only
				else
					classi_stone ?= class_w.stone
					if classi_stone /= Void then
						Result := classi_stone.class_i.is_read_only
					end
				end
			end

			if not Result then
				from
					start
				until
					after or Result
				loop
					if item.tool /= t_w then
						tmp := clone(item.value)
						tmp.to_upper
						if tmp.substring_index ("[READ-ONLY]", 1) = 0 then
							if tmp /= Void and then tmp.is_equal(tool_name) then
								Result := True
							end
						end
					end
					forth	
				end
			end
		end

	execute (argument: ANY) is
			-- Execute Current command.
			-- `argument' is automatically passed by
			-- EiffelVision when Current command is
			-- invoked as a callback.
		local
			arg_string: STRING
			local_name:STRING
			local_tool_w:TOOL_W
			selection: SCROLLABLE_LIST_SELECTOR_ELEMENT
		do
			arg_string ?= argument
			if arg_string /= Void and then arg_string.is_equal("selector_command") then
				selection ?= selected_item
				if selection /=Void then
					local_name:=clone(selection.value)
					local_tool_w ?= selection.tool
					if local_tool_w /= Void and then local_tool_w.realized then
						local_tool_w.force_raise
					end
				end
			else
				if associated_toggle.state then
					show_selector
				else
					hide_selector
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class SELECTOR_W


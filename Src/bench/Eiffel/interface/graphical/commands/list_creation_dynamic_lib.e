indexing

	description:
		"Popup a list of all valid creation procedures for a dynamic lib. "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	LIST_CREATION_DYNAMIC_LIB

inherit
	TOOL_COMMAND
	WINDOWS
	SHARED_EIFFEL_PROJECT

create
	make

feature -- Initialization

	make (d_cl:CLASS_C; d_r:E_FEATURE; d_i:INTEGER; d_a, d_c: STRING) is
		do
			init (Project_tool)
			d_class := d_cl
			d_routine := d_r
			d_index := d_i
			d_alias := d_a
			d_call_type := d_c
		end

feature -- Properties

	name: STRING is
			-- Name of the command
		do
			Result := "Creation procedure ?"
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := "Creation procedure"
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	d_class: CLASS_C
	d_routine: E_FEATURE
	d_index: INTEGER
	d_alias, d_call_type: STRING

feature -- Interface

	choose_creation is
		do
			work (Void)
		end

feature {NONE} -- Execution

	work (argument: ANY) is
			-- Execute Current.
		local
			d_creation: E_FEATURE
		do
			if argument = Void then
				selected := Void
				create_and_show_choices
			elseif argument = choices then
				if choices.position /= 0 then
					selected := choices.selected_item
				end
				if selected /= Void then
					from
						list.start
					until
						d_creation /= Void or else list.after 
					loop
						if list.item.name.is_equal ( selected ) then
							d_creation := list.item
						end
						list.forth
					end
					dynamic_lib_tool.process (d_class, d_creation, d_routine,
												d_index, d_alias, d_call_type)
				end
				dynamic_lib_tool.synchronize
			end
		end
	
feature {NONE} -- Implementation

	valid_creation (cl:CLASS_C): LINKED_LIST[E_FEATURE] is
			-- Calculate the list of valid creation procedure.
		local
			list_creators: ARRAY[STRING]
			tmp_creation: E_FEATURE
			i, max: INTEGER
			classC: CLASS_C
		do
			classC ?= cl
			if classC.creators /= Void then
				list_creators ?= classC.creators.current_keys
				create Result.make
				if list_creators /= Void then
					max:= list_creators.upper
					from
						i:=list_creators.lower
					until
						i > max
					loop
						tmp_creation := classC.api_feature_table.item (list_creators @ i)
						if tmp_creation /= Void and then tmp_creation.arguments = Void then
							Result.extend (tmp_creation)
						elseif tmp_creation = Void then
								-- Error: no creation procedure available	
						end
						i:=i+1
					end
				end
			end
		end

	create_and_show_choices  is
			-- Creates the choice window, fills it,
			-- and pops it up.
			-- `a_button' is used as parent.
		local
			a_list: LINKED_LIST [STRING]
		do
			if choices = Void then
				create choices.make (Project_tool)
			end
			list := valid_creation (d_class)

			if list = Void then				
				dynamic_lib_tool.process (d_class, d_routine, d_routine,
											d_index, d_alias, d_call_type)
			elseif list.is_empty then
				warner (dynamic_lib_tool.eb_shell).gotcha_call ("There is no valid creation for this feature.%N(ie: with no argument)")
			elseif list.count =1 then
				dynamic_lib_tool.process (d_class, list.first, d_routine,
											d_index, d_alias, d_call_type)
			elseif list /= Void and then not list.is_empty then
				create a_list.make
				from 
					list.start
				until 
					list.after
				loop
					a_list.extend (list.item.name)
					a_list.forth
					list.forth
				end

				choices.popup (Current, a_list, name)
				choices.select_i_th (1)
			end
		end

	selected: STRING
	list: LINKED_LIST [E_FEATURE]

feature {NONE} -- Properties

	choices: CHOICE_W;
			-- Window to popup the choices.
			
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

end -- class LIST_CREATION_DLL


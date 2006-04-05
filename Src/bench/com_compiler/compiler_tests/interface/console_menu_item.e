indexing
	description: "Text based menu item "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSOLE_MENU_ITEM

create
	make

feature {NONE} -- Initialization
	
	make (a_option: like option; a_title: like title; a_initial_select_action: PROCEDURE [ANY, TUPLE [ARRAYED_LIST [STRING]]]) is
			-- create a menu item
		require
			non_void_option: a_option /= Void
			non_empty_option: not a_option.is_empty
			non_void_title: a_title /= Void
			non_empty_title: not a_title.is_empty
		do
			set_option (a_option)
			set_title (a_title)
			
			create select_actions
			
			if a_initial_select_action /= Void then
				select_actions.extend (a_initial_select_action)
			end
		end

feature -- Access

	option: STRING
		-- option selection value
		
	title: STRING
		-- title of menu item
		
	select_actions: ACTION_SEQUENCE [TUPLE [ARRAYED_LIST [STRING]]]
		-- list of agents to call when option is selected
		
	is_return: BOOLEAN
		-- is item designated for returning/exiting from menu

feature -- Element change

	set_option (a_option: STRING) is
			-- set 'option' with 'a_option'
		require
			non_void_option: a_option /= Void
			non_empty_option: not a_option.is_empty
		do
			option := clone (a_option)
		ensure
			option_set: option.is_equal (a_option)
		end
		
	set_title (a_title: STRING) is
			-- set 'title' with 'a_title'
		require
			non_void_title: a_title /= Void
			non_empty_title: not a_title.is_empty
		do
			title := clone (a_title)
		ensure
			title_set: title.is_equal (a_title)
		end
		
feature -- Basic operations

	select_item (a_arguments: ARRAYED_LIST [STRING]) is
			-- call all agents in 'select_actions'
		do
			select_actions.call([a_arguments])
		end
		
feature {CONSOLE_MENU} -- Status Setting

	set_return(a_is_return: BOOLEAN) is
			-- set current item to be designated menu return/exit item
		do
			is_return := a_is_return
		end
	
invariant
	non_void_option: option /= Void
	non_empty_option: not option.is_empty
	non_void_title: title /= Void
	non_empty_title: not title.is_empty

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
end -- class CONSOLE_MENU_ITEM

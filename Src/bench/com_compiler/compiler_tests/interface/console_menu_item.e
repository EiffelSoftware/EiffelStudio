indexing
	description: "Text based menu item "
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
			option := a_option.clone (a_option)
		ensure
			option_set: option.is_equal (a_option)
		end
		
	set_title (a_title: STRING) is
			-- set 'title' with 'a_title'
		require
			non_void_title: a_title /= Void
			non_empty_title: not a_title.is_empty
		do
			title := a_title.clone (a_title)
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

end -- class CONSOLE_MENU_ITEM

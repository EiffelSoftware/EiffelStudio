indexing
	description	: "Text base menu system"
	date: "$Date$"
	revision: "$Revision$"
	
class
	CONSOLE_MENU

create
	make
	
feature {NONE} -- Initialization

	make (a_title: STRING) is
			-- create a menu
		require
			non_void_title: a_title /= Void
		do
			title := a_title.clone (a_title)
			create items.make
		ensure
			title_set: title.is_equal (a_title)
		end

feature -- Access

	title: STRING
			-- title of menu
		
	items: LINKED_LIST [CONSOLE_MENU_ITEM]
			-- menu items
		
	last_option_processed: BOOLEAN
		-- was last option processed?
		
	return_item: CONSOLE_MENU_ITEM
		-- item responsbile for return from the menu
		
feature -- Basic Operations

	show is
			-- show the menu
		require
			return_item_set: return_item /= Void
			return_item_in_menu: items.has (return_item)
			not_enough_items: items.count > 0
		do
			display_menu
			get_menu_selection
		end
		

	display_menu is
			-- display menu
		require
			return_item_set: return_item /= Void
			return_item_in_menu: items.has (return_item)
			not_enough_items: items.count > 0
		local
			l_seperator: STRING
		do
			exit_menu := False
			if not title.is_empty then
				create l_seperator.make_filled ('=', title.count)
				io.new_line
				io.putstring (title)
				io.new_line
				io.putstring (l_seperator)
			end
			
			io.new_line
		
			from
				items.start
			until
				items.after
			loop
				display_item (items.item)
				check
					non_off: not items.after
				end
				items.forth
			end
		end
		
	get_menu_selection is
			-- ask user for menu choice
		require
			return_item_set: return_item /= Void
			return_item_in_menu: items.has (return_item)
		do
			exit_menu := False
			io.putstring ("%N%NPlease enter your selection: ")
			io.read_line
			parse_and_process_user_selection (io.laststring)
		end
		
	set_return_item (a_item: CONSOLE_MENU_ITEM) is
			-- set the item responsible for exiting the current menu
		require
			non_void_item: a_item /= Void
			item_in_menu: items.has (a_item)
		do
			if return_item /= Void then
				return_item.set_return (False)
			end
			return_item := a_item
			return_item.set_return (True)
		ensure
			return_item_set: return_item = a_item
		end

feature -- Element Change
		
	add_item (a_item: CONSOLE_MENU_ITEM) is
			-- add an item to menu
		require
			non_void_item: a_item /= Void
			already_added: not items.has (a_item)
		do
			items.extend (a_item)
		ensure
			item_added: items.has (a_item)
		end
		
feature -- Removal

	remove_item (a_item: CONSOLE_MENU_ITEM) is
			-- remove an item from menu
		require
			non_void_item: a_item /= Void
			is_in_menu: items.has (a_item)
		local
			l_removed: BOOLEAN
		do
			if a_item.is_equal (return_item) then
				return_item := Void
				from
					items.start
				until
					items.after or l_removed
				loop
					if items.item.is_equal (a_item) then
						items.remove
						l_removed := True
					else
						items.forth
					end
				end
			end
		ensure
			item_removed: not items.has (a_item)
		end

feature {NONE} -- Implementation

	get_item_from_option (a_option: STRING): CONSOLE_MENU_ITEM is
			-- retieve a menu item from 'a_option'
		require
			non_void_option: a_option /= Void
			non_emtpy_option: not a_option.is_empty
		local
			l_found: BOOLEAN
		do
			from
				items.start
			until
				items.after or l_found
			loop
				if items.item.option.is_equal (a_option) then
					l_found := True
					Result := items.item
				else
					items.forth
				end
			end
		end
			
	display_item (a_item: CONSOLE_MENU_ITEM) is
			-- display a single menu item
		require
			non_void_item: a_item /= Void
		do
			io.new_line
			io.putstring (" (" + a_item.option + "): ")
			io.putstring (a_item.title)
		end
		
	display_invalid_selection (a_selection: STRING) is
			-- display to user that selection was invalid
		do
			display_menu
			io.putstring ("%N%NINVALID SELECTION You selected '" + a_selection + "'")
			io.putstring ("%NPlease re-select from the menu.")
			get_menu_selection
		end
		
	parse_and_process_user_selection (a_selection: STRING) is
			-- parse user entered selection and processes it
		require
			non_void_selection: a_selection /= Void
		local
			l_option: STRING
			l_args_list: ARRAYED_LIST [STRING]
			l_spc_index: INTEGER
			l_temp_selection: STRING
		do
			l_temp_selection := a_selection.clone (a_selection)
			l_temp_selection.prune_all_leading (' ')
			l_temp_selection.prune_all_trailing (' ')
			l_spc_index := a_selection.index_of (' ', 1)
			if l_spc_index > 0 then
				l_option := l_temp_selection.substring (1, l_spc_index - 1)
				l_temp_selection := l_temp_selection.substring (l_spc_index + 1, l_temp_selection.count)
				l_args_list := parse_arguments (l_temp_selection)
			else
				l_option := l_temp_selection
				create l_args_list.make (0)
			end
			if is_valid_option (l_option) then
				process_option (l_option, l_args_list)				
				if not exit_menu then
					display_menu
					get_menu_selection
				end
			else
				display_invalid_selection (a_selection)
			end
		end
		
	parse_arguments (a_arg_string: STRING): ARRAYED_LIST [STRING] is
			-- parse 'a_arg_string' and return an arrayed list of string
		require
			non_void_arguments: a_arg_string /= Void
		local
			l_temp_args: STRING
			l_in_quote: BOOLEAN
			l_spc_index: INTEGER
			l_pos: INTEGER
			l_arg: STRING
		do
			l_temp_args := a_arg_string.clone (a_arg_string)
			l_temp_args.prune_all_leading (' ')
			l_temp_args.prune_all_trailing (' ')
			
			create Result.make (0)
			if a_arg_string.count > 0 then
				from
					l_pos := 1
					l_spc_index := 1
				until
					l_pos > a_arg_string.count
				loop
					if a_arg_string.item (l_pos).is_equal ('%"') then
						l_in_quote := not l_in_quote	
						if l_in_quote then
							l_spc_index := l_pos + 1
						else
								if l_spc_index <= l_pos - 1 then
								Result.extend (a_arg_string.substring (l_spc_index, l_pos - 1))	
							else
								Result.extend ("")
							end
							if l_pos < a_arg_string.count and then not a_arg_string.item (l_pos + 1).is_equal (' ')  then
								l_spc_index := l_pos + 1
							else
								-- set to zero for non-quote args
								l_spc_index := 0	
							end
							
						end
					end
					if not l_in_quote then
						if a_arg_string.item (l_pos).is_equal (' ') then
							if l_pos < a_arg_string.count and then not a_arg_string.item (l_pos + 1).is_equal (' ')  then
								if l_spc_index > 0  then
									l_arg := a_arg_string.substring (l_spc_index, l_pos - 1)
									l_arg.prune_all_trailing (' ')
									Result.extend (l_arg)
								end
								l_spc_index := l_pos + 1
							end	
						end						
					end
					l_pos := l_pos + 1	
				end
				
				-- if still in quote then take arg as 'l_spc_index' - 'a_arg_string.count'
				-- also need this to get the last arg
				if l_spc_index > 0 then
					Result.extend (a_arg_string.substring (l_spc_index, a_arg_string.count))	
				end
				
			end
		ensure
			non_void_Result: Result /= Void
		end
		
	process_option (a_option: STRING; a_arguments: ARRAYED_LIST [STRING]) is
			-- process a choosen menu option 'a_option' with the arguments 'a_arguments'
		require
			non_void_option: a_option /= Void
			non_empty_option: not a_option.is_empty
			non_void_arguments: a_arguments /= Void
			valid_option: is_valid_option (a_option)
			non_void_return_item: return_item /= Void
		local
			l_item: CONSOLE_MENU_ITEM
		do
			last_option_processed := False
			
			l_item := get_item_from_option (a_option)
			if l_item /= Void then
				l_item.select_item (a_arguments)
				last_option_processed := True
				
				if l_item.is_equal (return_item) then
					exit_menu := True
				end
			end
		ensure
			option_processed: last_option_processed
		end
		
	exit_menu: BOOLEAN
		-- should menu exit?
		
feature {NONE} -- Validation

	is_valid_option (a_option: STRING): BOOLEAN is
			-- is 'a_option' a valid menu option
		require
			non_void_option: a_option /= Void
		do
			if not a_option.is_empty then
				from
					items.start
				until
					items.after or Result
				loop
					if items.item.option.is_equal (a_option) then
						Result := True
					else
						items.forth
					end
				end
			end
		end		
		
invariant
	non_void_items: items /= Void
	non_void_title: title /= Void

end -- class CONSOLE_MENU

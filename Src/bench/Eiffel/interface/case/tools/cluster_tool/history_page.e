indexing
	description: "History page"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	HISTORY_PAGE

inherit

	OBSERVER

	ONCES
		
	CONSTANTS

creation
	make

feature -- Initialization

	make(par: EV_NOTEBOOK) is
		require
			notebook_exists: par /= Void
		local
			com: EV_ROUTINE_COMMAND
		do
			!! history_list.make(par)
			par.append_page(history_list,"History")
 			--history.set_history_page(Current)
			observer_management.add_observer (history, Current)

			!! com.make(~process_click)
			history_list.add_select_command(com, Void)
		end

feature -- Implementation

	history_list: EV_LIST

feature -- Actions

	process_click (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			item: EV_LIST_ITEM
		do
			if history_list /= Void then
				item := history_list.selected_item
	
				if item /= Void then			
					history.go_i_th(item.index)
				end
			end
		end

	update is 
		local
			history_command: LINKED_LIST [UNDOABLE_EFC]

			elem: HISTORY_ITEM
		do 
			if history_list /= Void then
				history_list.clear_items

				history_command := clone (history)

				if history_command.count>0 then
					from
						history_command.start
					until
						history_command.after
					loop
						!! elem.make_with_command (history_list, history_command.item)
						history_command.forth
					end
					history_list.select_item (history.index)
				end
			end
		end
	
end -- class HISTORY_PAGE

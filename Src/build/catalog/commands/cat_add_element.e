indexing
	description: "Abstract undoable command to remove a %
				%command in the command catalog."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CAT_ADD_ELEMENT

inherit
	CAT_COMMAND
	
feature -- Access

	name: STRING is
		do
			Result := Command_names.cat_new_cmd_name
		end
	
feature -- Basic operations

	execute (arg: EV_ARGUMENT2 [like element, like page]; event_data: EV_EVENT_DATA) is
		do
			element := arg.first
			page := arg.second
		end

	undo is
		local
			p: like page
			found: BOOLEAN
--			pages: LINKED_LIST [CAT_PAGE [DATA]]
		do
-- 			page.start
-- 			page.search (element)
-- 			if not page.after then
-- 				page.remove
-- 			else
-- 				-- must be in other page
-- 				from
-- 					pages := catalog.pages
-- 					pages.start
-- 				until
-- 					pages.after or found
-- 				loop
-- 					p := pages.item
-- 					if page /= p then
-- 						p.start
-- 						p.search (element)
-- 						if not p.after then
-- 							p.remove
-- 							found := True
-- 						end
-- 					end
-- 					pages.forth
-- 				end
-- 			end
			element.set_parent (Void)
 			reset_element
		end

	redo is
		do
			element.set_parent (page)
		end

	
feature {NONE}

	reset_element is
		deferred
		end

	catalog: CATALOG is 
		deferred
		end

end -- class CAT_ADD_ELEMENT


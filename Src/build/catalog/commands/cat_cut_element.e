indexing
	description: "Abstract undoable command to remove a %
				%command in the command catalog."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class CAT_CUT_ELEMENT

inherit

	CAT_COMMAND
	
feature -- Access

	name: STRING is
		do
			Result := Command_names.cat_cut_cmd_name
		end

feature -- Basic operations

	execute (arg: EV_ARGUMENT2 [like element, like page]; event_data: EV_EVENT_DATA) is
		do
			element := arg.first
			page := arg.second
--XX		position := element.index
			element.set_parent (Void)
		end

	undo is
		do
--			if position = 1 and then page.empty then
				element.set_parent (page)
--			else
--				if page.count <= (position - 1) then
--					page.extend (element)
--				else
--					page.go_i_th (position -1)
--					page.put_right (element)
--				end
--			end
		end

	redo is
		local
			p: like page
			found: BOOLEAN
--			pages: LINKED_LIST [CAT_PAGE [DATA]]
		do
			element.set_parent (Void)
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
-- 							position := p.index
-- 							p.remove
-- 							found := True
-- 							page := p
-- 						end
-- 					end
-- 					pages.forth
-- 				end	
-- 			end	
		end

feature {NONE}

--XX position: INTEGER

end -- class CAT_CUT_ELEMENT


indexing

	description: 
		"Command associated to the workarea. Brings an editor %
		%corresponding to the selected entity and targeted on it.";
	date: "$Date$";
	revision: "$Revision $"

class 
	WORKAREA_BRING_EDITOR

inherit
	WORKAREA_COMMAND

creation

	make

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Bring an editor corresponding to the selected 
			-- entity and targeted on it
		local
			active_entity: GRAPH_FORM
			create_win: CREATE_EDITOR_WINDOW_COM
			selected: BOOLEAN
		do
-- 			check
-- 				not_used: not_used = Void
-- 			end
-- 			active_entity := workarea.active_entity
-- 			if active_entity /= Void then
-- 				selected := active_entity.selected
-- 				if not selected then
-- 					active_entity.select_it
-- 					active_entity.partial_draw
-- 				end
-- 			--	!! create_win
-- 				create_win.execute (active_entity.data)
-- 				if not selected then
-- 					active_entity.unselect
-- 					workarea.refresh
-- 				end
-- 			end
		end

end -- class WORKAREA_BRING_EDITOR








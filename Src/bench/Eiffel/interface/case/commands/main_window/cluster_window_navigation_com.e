indexing

	description: "Command that focus a cluster window's display %
		%on one specific part of its drawing area."; 
	date: "$Date$";
	revision: "$Revision $"

class 
	CLUSTER_WINDOW_NAVIGATION_COM

inherit
	EC_COMMAND

creation
	make

feature {NONE} -- Initialization

	make (cw: like cluster_window; d  : INTEGER) is
			-- Associate Current command to cluster window `cw'
			-- direct corresponds to a direction, please see
			-- cluster_window for the translation ...
		require
			cw_exists: cw /= Void
		do
			cluster_window := cw
			direct := d
		ensure
			cluster_window_set: cluster_window = cw
		end

feature -- Properties

	cluster_window: MAIN_WINDOW
			-- Associated cluster window

	direct : INTEGER
feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Focus the cluster window's display in the area
			-- specified by `direction'. 
		local
-- 			value, value1: INTEGER
-- 			cw: like cluster_window
-- 			draw_win: WORKAREA
-- 			entity: CLUSTER_DATA
-- 			scroll_win: SCROLLED_W
-- 			err : BOOLEAN
		do
-- 			if not err then
-- 			cw := cluster_window
-- 			if cw.entity /= Void then
-- 				draw_win := cw.draw_window
-- 				entity := cw.entity
-- 				scroll_win := cw.scrolled_window
-- 				if direct = 1 then
-- 					draw_win.go_to_top;
-- 				elseif direct = 2 then
-- 					value := - entity.height + scroll_win.height - 40; -- 40 before
-- 					draw_win.go_to_bottom (value);
-- 				elseif direct = 3 then
-- 					draw_win.go_to_left;
-- 				elseif direct = 4 then
-- 					value := - entity.width + scroll_win.width -40; -- 40 before
-- 					draw_win.go_to_right (value)
-- 				end
-- 			end
-- 			end
-- 		rescue
-- 			err := TRUE 
-- 			retry
		end;

invariant
	cluster_window_exists: cluster_window /= Void

end -- class CLUSTER_WINDOW_NAVIGATION_COM

indexing
	description: "Class which put the handles in a nice way ..."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ADV_COM

inherit

	--EC_LICENCED_COMMAND
	--	select
	--		execute_licensed
	--	end

	--EDITOR_WINDOW_COM
	--EC_EDITOR_WINDOW_COM
	--	redefine
	--		editor_window
	--	end;

	EV_COMMAND

	CONSTANTS

	UNDOABLE_EFC

feature -- Initialization

	make(dat: RELATION_DATA) is
			-- Initialize
		require
			data_exists: dat /= Void
		do
			data := dat
		end

feature -- for the undoability

	redo is
		local
			remove_handles: REMOVE_HANDLES_U
			handx,handy : INTEGER -- coordinate of the new handle ...
			err : BOOLEAN
			hand : HANDLE_DATA
			move_handle_undoable: MOVE_HANDLE_U;
			n1,n2 : BOOLEAN
			xmin,xmax,ymin,ymax : INTEGER
			add_hand : ADD_HANDLE_U
			gr : GRAPH_FORM
		do
			if not err then 
				if data.f_rom.parent_cluster=data.t_o.parent_cluster then
				-- we start by removing all the handles ...
				!! remove_handles.make (data)
				n1 := ( data.f_rom.x> data.t_o.x )
				n2 := ( data.f_rom.y> data.t_o.y )
				if n1 then 
						xmax := data.f_rom.x
						xmin := data.t_o.x
				else
						xmin := data.f_rom.x
						xmax := data.t_o.x
				end
				if n2 then 
						ymax := data.f_rom.y
						ymin := data.t_o.y
				else
						ymin := data.f_rom.y
						ymax := data.t_o.y
				end

				if right then
					-- right algo
						handx := xmin
						if (n1 and not n2) or (not n1 and n2) then
							handy := ymin
						else
							handy := ymax
						end
				else
					-- left algo
						handx := xmax
						if (n2 and not n1) or (not n2 and n1 ) then
							handy := ymax
						else
							handy := ymin
						end
				end
				-- We should check here if the handle is contained in one of the classes
				-- ( to avoid an ugly link ... )
				!! hand
				hand.set_x ( handx )
				hand.set_y ( handy )
				hand.put_in_cluster (data.f_rom.parent_cluster )
				!! add_hand.make_str ( data ,hand)
				workareas.refresh
			else
				-- link cross different clusters
			--	Windows.message(editor_window, "Mn", Void )
			end
			end
			rescue
				err := TRUE
			--	Windows.add_message ("execute of adv_com failed...",1)
				retry
	end

	undo is
		do
		end

	name : STRING is "Put link straight"

feature -- Properties

	data: RELATION_DATA
		-- Data described by Current.

	symbol: EV_PIXMAP is
			-- Symbol representing button to which Current 
			-- command is associated.
		once
			Result := Pixmaps.remove_handles_pixmap
		end

	right : BOOLEAN is deferred end
		-- do we process by the right first ?

feature -- Exection

	execute (args: EV_ARGUMENT; dat: EV_EVENT_DATA) is
		do
			redo
		end


end -- class ADV_COM

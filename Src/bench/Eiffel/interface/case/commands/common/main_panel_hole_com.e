indexing

	description: 
		"Command that allows the creation of one or several editors, %
		%targetted on the objet(s) dropped in the main panel surface.";
	date: "$Date$";
	revision: "$Revision $"

class 
	MAIN_PANEL_HOLE_COM 

inherit

	EC_COMMAND
		redefine
			process_any, stone_type
		end;

feature -- Properties

	stone_type: INTEGER is
			-- Stone type that Current hole accepts
		do
			Result := Stone_types.any_type
		end;

feature -- Update

	process_any (s: EC_STONE) is
			-- Process dropped stone `stone' and create an editor
			-- if it is editable.
		local
			create_win: CREATE_EDITOR_WINDOW_COM;
			group_stone: GROUP_STONE;
			stones: LINKED_LIST [EC_STONE]
		do
			group_stone ?= s;
			if group_stone = Void then
			--	!! create_win;
				create_win.execute (s.data);
			else
				from
					stones := group_stone.stones;
					stones.start
				until
					stones.after
				loop
			--		!! create_win;
					create_win.execute (stones.item.data);
					stones.forth
				end
			end
		end;

feature {NONE} -- Inapplicable

    execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
        do
        end

end -- class MAIN_PANEL_HOLE_COM

indexing

	description: "Stone that refers to associated handle data.";
	date: "$Date$";
	revision: "$Revision $"

class HANDLE_STONE

inherit

	STONE

creation

	make

feature -- Initialication

	make (a_data: like data; w_area: like workarea) is
			-- Set data to `a_data' and 
			-- workarea to `w_area'.
		require
			valid_data: a_data /= Void;
			valid_workarea: w_area /= Void;
		do
			data := a_data;
			workarea := w_area;
		ensure
			set: workarea = w_area and then
			data = a_data
		end;

feature -- Properties

	data: HANDLE_DATA;
			-- Associated handle data

	workarea: WORKAREA;
			-- Workarea that contains handle

	--stone_cursor: SCREEN_CURSOR is
	--		-- Cursor associated with
	--		-- Current stone during transport
	--	do
		--	Result := Cursors.handle_cursor
	--	end;

	stone_type_pnd: EV_PND_TYPE is 
			-- Current stone type
		do
			Result := stone_types.handle_type_pnd
		end

	destroy_command: DESTROY_HANDLE is
			-- Command to destroy a handle.
		local
			others: GRAPH_REL_LIST [GRAPH_RELATION];
			list: LINKED_SET [RELATION_DATA];
		do
			!! others.make;
			others.merge (workarea.inherit_list.links_who_has (data));
			others.merge (workarea.cli_sup_list.links_who_has (data));
			others.merge (workarea.aggreg_list.links_who_has (data));
			list := others.datas;
			!! Result.make (list, data)
		end

feature -- Update

	process (com: EC_COMMAND) is
			-- Process Current stone dropped in a correct hole 
			-- with command `com' 
		do
		end;

feature -- Access

	is_valid: BOOLEAN is
			-- Is Current stone valid?
		do
			Result := data /= Void and then data.is_in_system;
		end;

feature -- Element change

	insert_before (a_stone: like Current) is
			-- Insert a_stone before Current;
		do
		end;

feature -- Duplication

	copy_data (a_stone: like Current) is
			-- Copy `a_stone' data to Current;
		do
		end;

end -- class HANDLE_STONE

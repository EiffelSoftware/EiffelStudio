indexing

	description: 
		"Stone that refers to a number of grouped elements %
		%in the workarea.";
	date: "$Date$";
	revision: "$Revision $"

class GROUP_STONE

inherit

	EC_STONE
		rename
			destroy_data as destroy_group
		redefine
			destroy_group--, stone_type
		end;

creation

	make

feature -- Initialization

	make (list: like group_list; sel_stone: STONE) is
			-- Set group_list to `list' and 
			-- selected_stone to `sel_stone'.
		require
			valid_list: list /= Void;
			not_empty_list: not list.empty;
			valid_stone: sel_stone /= Void
		do
			group_list := list;
			selected_stone := sel_stone
		ensure
			set: group_list = list and then
				selected_stone = sel_stone
		end;

feature -- Properties

	data: DATA is
			-- Associated data
		do
			-- Useless
		end;

	group_list: LINKED_LIST [GRAPH_FORM];
			-- List of the grouped graphical objects

	selected_stone: EC_STONE;
			-- Stone dragged

	stones: LINKED_LIST [EC_STONE] is
			-- Stones from the group_list
		do
			!! Result.make;
			from
				group_list.start
			until
				group_list.after
			loop
				Result.put_front (group_list.item.stone);
				group_list.forth
			end;
		end

	--stone_cursor: SCREEN_CURSOR is
	--		-- Cursor associated with
	--		-- Current stone during transport
	--	do
	--		Result := Cursors.group_cursor
	--	end;

	stone_type_pnd: EV_PND_TYPE is
			-- Current stone type of selected stone
		do
			Result := selected_stone.stone_type_pnd
		end;

	destroy_command: DESTROY is
			-- Returns Void.
		do
		end;

feature -- Access

	is_valid: BOOLEAN is
			-- Is Current stone valid?
		do
			Result := true
		end;

feature -- Update

	process (com: EC_COMMAND) is
			-- Process Current stone dropped in a correct hole 
			-- with command `com' 
		do
			--selected_stone.process (com)
			com.process_group	( Current	)
		end;

feature -- Removal

	destroy_group is
			-- Destroy the group found in group_list.
		local
			l: LINKED_LIST [DESTROY];
			destroy_entities_u: DESTROY_ENTITIES_U;
			dest: DESTROY;
			link_form: GRAPH_LINKABLE;
			cluster_form: GRAPH_LINKABLE;
			found: BOOLEAN;
			cur: CURSOR
		do
			!! l.make;
			from
				group_list.start
			until
				group_list.after
			loop
				link_form ?= group_list.item;
				if link_form = Void then
					l.put_front (group_list.item.stone.destroy_command);
				else
					cur := group_list.cursor;
					from
						found := False;
						group_list.start
					until
						group_list.after or else found
					loop
						cluster_form ?= group_list.item;
						if cluster_form /= Void and then
							cluster_form /= link_form
						then
							found := cluster_form.data.contains_linkable 
										(link_form.data)
						end;
						group_list.forth
					end;
					if not found then
						l.put_front (link_form.stone.destroy_command);
					end;
					group_list.go_to (cur)
				end;
				group_list.forth
			end
			!! destroy_entities_u.make (l);
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

end -- class GROUP_STONE

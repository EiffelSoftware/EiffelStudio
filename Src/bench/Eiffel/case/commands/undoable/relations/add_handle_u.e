indexing

	description: 
		"Undoable command for adding a handle.";
	date: "$Date$";
	revision: "$Revision $"

class ADD_HANDLE_U 

inherit

	UNDOABLE_EFC

creation

	make, make_str

feature -- Initialization

	make (a_link: GRAPH_RELATION;
			a_position: like position;
			handle: like new_handle;
			init_x, init_y: INTEGER) is
			-- Create a new handle.
		require
			void_link: a_link /= void;
			valid_min_pos: a_position >= 0;
			valid_max_pos: a_position <= a_link.data.break_points.count;
			valid_handle: handle /= void
		local
			cl: CLI_SUP_DATA;
		do
			set_watch_cursor;
			record;
			link := a_link.data;
			position := a_position;
			if link.is_client then
				cl ?= link;
				check_label_handle (cl, a_link.handles, False, init_x, init_y);
				if cl.is_reverse_link then
					check_label_handle (cl, a_link.handles, True, init_x, init_y);
				end
			end
			new_handle := handle;
			redo;
			restore_cursor;
		end

	make_str (a_link: RELATION_DATA;
			handle: like new_handle) is
			-- Create a new handle.
		require
			void_link: a_link /= void;
			valid_handle: handle /= void
		local
			cl: CLI_SUP_DATA;
		do
			set_watch_cursor;
			record;
			link := a_link
			if link.is_client then
			--	cl ?= link;
			--	check_label_handle (cl, a_link.handles, False, 0, 0);
			--	if cl.is_reverse_link then
			--		check_label_handle (cl, a_link.handles, True, 0, 0);
			--	end
			end
			new_handle := handle;
			redo;
			restore_cursor;
		end


feature -- Property

	name: STRING is "New handle"

	increase_handle_nbr: BOOLEAN
			-- Increase handle nbr?

	increase_reverse_handle_nbr: BOOLEAN
			-- Increase reverse handle nbr?

feature -- Update

	redo is
			-- Re-execute command (after it was undone).
		local
			cl: CLI_SUP_DATA
		do
			new_handle.set_shared (new_handle.shared+1);
			link.break_points.go_i_th (position);
			link.break_points.put_right (new_handle);
			if link.is_client then
				cl ?= link;
				if increase_handle_nbr then
					cl.label.increment_handle_nbr
				elseif increase_reverse_handle_nbr then
					cl.reverse_label.increment_handle_nbr
				end
			end;
			workareas.change_data (link);
			workareas.refresh;
			System.set_is_modified
		end;

	undo is
			-- Cancel effect of executing the command.
		local
			cl: CLI_SUP_DATA
		do
			link.break_points.go_i_th (position+1);
			link.break_points.remove;
			new_handle.set_shared (new_handle.shared-1);
			if link.is_client then
				cl ?= link
				if increase_handle_nbr then
					cl.label.decrement_handle_nbr
				elseif increase_reverse_handle_nbr then
					cl.reverse_label.decrement_handle_nbr
				end
			end;
			workareas.change_data (link);
			workareas.refresh;
			System.set_is_modified
		end; 

feature {NONE} -- Implementation

	link: RELATION_DATA;
			-- Link who will have a new handle

	position: INTEGER;
			-- Handle after which is located the new one

	new_handle: HANDLE_DATA
			-- New handle created

	check_label_handle (cli_sup: CLI_SUP_DATA;
			handles: ARRAYED_LIST [EC_HANDLE];
			is_reverse: BOOLEAN; init_x, init_y: INTEGER) is
			-- Check label handle. `is_reverse' indicates to use
			-- reverse label.
		require
			valid_cli_sup: cli_sup /= Void;
			valid_is_reverse: is_reverse implies cli_sup.is_reverse_link
		local
			l_data: LABEL_DATA;
			rel_to_pt, rel_from_pt: EC_COORD_XY;
			x, y: INTEGER;
			dx, dy: INTEGER;
			init_dx, init_dy: INTEGER;
			init_ratio: REAL;
			handle_position: INTEGER
		do
			if is_reverse then
				l_data := cli_sup.reverse_label
			else
				l_data := cli_sup.label
			end;
			if not l_data.empty then
				handle_position := position + 1;
				if handle_position = l_data.from_handle_nbr or else
					handle_position = l_data.to_handle_nbr
				then
					-- Check to see if new handle is between
					-- label and label_from_handle_nbr.
					if is_reverse then
						rel_from_pt := handles.i_th (cli_sup.reverse_from_handle_nbr);
						rel_to_pt := handles.i_th (cli_sup.reverse_to_handle_nbr);
					else
						rel_from_pt := handles.i_th (l_data.from_handle_nbr);
						rel_to_pt := handles.i_th (l_data.to_handle_nbr);
					end

					dx := rel_to_pt.x - rel_from_pt.x;
					dy := rel_to_pt.y - rel_from_pt.y;

					init_dx := init_x - rel_from_pt.x;
					init_dy := init_y - rel_from_pt.y;
						-- Ratio for initial mouse pointer position
						-- in relation to the line.
					init_ratio := ((init_dx*init_dx) + (init_dy*init_dy)) /
									((dx*dx) + (dy*dy));
					if init_ratio < (l_data.from_ratio * l_data.from_ratio) then
						-- The initial position of mouse pointer
						-- on the line is closer to from point
						-- of the label than the label itself.
						if is_reverse then
							increase_reverse_handle_nbr := True
						else
							increase_handle_nbr := True
						end
					end;
				elseif handle_position < l_data.from_handle_nbr then
					if is_reverse then
						increase_reverse_handle_nbr := True
					else
						increase_handle_nbr := True
					end
				end
			end
		end;


end -- class ADD_HANDLE_U

indexing

	description: 
		"Undoable command for swapping like elements.";
	date: "$Date$";
	revision: "$Revision $"

class SWAP_ELEMENT_U

inherit

	UNDOABLE_EFC
		undefine
			free_data, request_for_data
		end

creation

	make

feature -- Initialization

	make (data_cont: like data_container; l: like list; ins, ref: like inserted_data) is
		require
			valid_parent: data_cont /= Void;
			l_not_void: l /= Void;
			ins_and_ref_not_void: ins /= Void and ref /= Void
		local
			pos: INTEGER
		do
			if ins /= ref then
				l.start;
				l.search (ref);
				if not l.after then
					pos := l.index;
					l.start;
					l.search (ins);
					if not l.after then
						original_position := l.index;
						if original_position /= (pos - 1) then
							data_container := data_cont;
							list := l;
							inserted_data := ins;
							reference_data := ref;
							record;
							redo
						end;
					end
				end;
			end;	
		end;

feature -- Update

	redo is
			-- Execute command.
		do
			insert_data;
		end;

	undo is
			-- Cancel effect of executing the command.
		do
			undo_insert_data
		end;

feature -- Property

	name: STRING is 
		do
			!! Result.make (0);
			Result.append ("Swap ");
			Result.append (inserted_data.name_for_command)
		end;

feature {NONE} -- Implementation


	list: LINKED_LIST [like inserted_data];
	request_for_data is
		do
			data_container.request_for_information;
		end;

	free_data is
		do
			data_container.free_information
		end;

	data_container: DATA;

	original_position: INTEGER
			-- Position where inserted_data was before being
			-- inserted 

	inserted_data: DATA;
			-- Data inserted

	reference_data: DATA;
			-- Data which inserted_data will be before

	update is
		require
			data_container_has_elements: data_container.has_elements
		do
			data_container.update_display (inserted_data)
		end;

	undo_insert_data is
		require
			list_has_item: list.has (inserted_data);
			list_has_item: list.has (reference_data);
		do
			list.start;
			list.prune (inserted_data);
			list.go_i_th (original_position - 1);
			list.put_right (inserted_data);	
			update;
		end

	insert_data is
		require
			list_has_item: list.has (inserted_data);
			list_has_item: list.has (reference_data);
		do
			list.start;
			list.prune (inserted_data);
			list.start;
			list.search (reference_data);
			list.put_left (inserted_data);
			update;
		end;
	
end -- class SWAP_ELEMENT_U

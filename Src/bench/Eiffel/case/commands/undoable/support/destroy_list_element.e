indexing

	description: 
		"Abstract clas for destroying feature elements (pre, posts, & arg).";
	date: "$Date$";
	revision: "$Revision $"

class DESTROY_LIST_ELEMENT

inherit

	DESTROY
		redefine
			request_for_data,
			free_data
		end

creation

	make

feature -- Initialization

	make (a_data: like data_container; l: like list; destroy_d: like data) is
			-- Destroy data `destroy_d' in list `l' contained in object
			-- `a_data'.
		require
			l_has_a_data: l.has (destroy_d)
		do
			data := destroy_d;
		--	list := l;
			data_container := a_data;
		end;

feature -- Update

	redo is
			-- Execute command.
		do
			remove_data;
		end;

	undo is
			-- Cancel effect of executing the command.
		do
			add_data
		end;

feature {NONE}

	list: LINKED_LIST [like data];

	add_data is
		require
			list_not_has_item: not list.has (data)
		do
			list.go_i_th (position);
			list.put_right (data);	
		ensure
			list_has_item: list.has (data)
		end

	request_for_data is
		do
			data_container.request_for_information;
		end;

	free_data is
		do
			data_container.free_information
		end;

	data_container: DATA;

	position: INTEGER;

	remove_data is
		require
			list_has_item: list.has (data)
		do
			list.start;
			list.search (data);
			position := list.index - 1;
			list.remove;
		ensure
			list_not_has_item: not list.has (data)
		end;
	
	update is
		require else
			data_container_has_elements: data_container.has_elements
		do
--			data_container.update_display (data);
--			windows.namer_window.update;
		end;

	name: STRING is
		do
			!! Result.make (0);
			Result.append ("Remove ");
			Result.append (data.name_for_command)
		end;
end -- class DESTROY_LIST_ELEMENT

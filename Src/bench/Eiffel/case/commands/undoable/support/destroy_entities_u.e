indexing

	description: 
		"Undoble command that destroyes a list of entities.";
	date: "$Date$";
	revision: "$Revision $"

class DESTROY_ENTITIES_U 

inherit

	UNDOABLE_EFC
		redefine
			free_data, request_for_data
		end

creation

	make

feature -- Initialization

	make (list: like destroys_list) is
			-- Create a new class
		require
			has_list: list /= void;
			list_not_empty: not list.empty
		do
			destroys_list := list
			record
			redo
		ensure
			list_correctly_set: destroys_list = list
		end

feature -- Property

	name: STRING is 
		do
			!! Result.make (0);
			if destroys_list.count = 1 then
				Result.append (destroys_list.first.name);
			else
				Result.append ("Destroy entities");
			end
		end;

feature -- Update

	redo is
			-- Re-execute command (after it was undone).
		do
			from
				destroys_list.start
			until
				destroys_list.off
			loop
				destroys_list.item.redo
				destroys_list.forth
			end;
			destroys_list.first.update
		end

	undo is
			-- Cancel effect of executing the command.
		do
			from
				destroys_list.start
			until
				destroys_list.off
			loop
				destroys_list.item.undo
				destroys_list.forth
			end;
			destroys_list.first.update
			workareas.refresh
		end

feature {NONE} -- Private datas

	destroys_list: LINKED_LIST [DESTROY]


	free_data, request_for_data is do end

invariant

	has_list: destroys_list /= void
	list_not_empty: not destroys_list.empty

end -- class DESTROY_ENTITIES_U

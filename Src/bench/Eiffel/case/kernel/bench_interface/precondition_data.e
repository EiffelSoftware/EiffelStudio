indexing

	description: "Precondition information.";
	date: "$Date$";
	revision: "$Revision $"

class PRECONDITION_DATA 

inherit

	FEATURE_ELEMENT_DATA;
	ASSERTION_INFO

creation

	make, make_from_storer

feature -- Properties

	--stone_cursor: SCREEN_CURSOR is
	--	do
	--	--	Result := Cursors.precondition_cursor
	--	end;

	stone_type: INTEGER is
		do
			Result := Stone_types.precondition_type
		end;

	destroy_command (a_data: FEATURE_DATA): DESTROY_LIST_ELEMENT is
		do
			!! Result.make (a_data, a_data.preconditions, Current);
		end;

feature -- Access

	is_valid_for (data: DATA): BOOLEAN is
		local
			fd: FEATURE_DATA
		do
			fd ?= data;
			Result := fd /= Void and then fd.preconditions /= Void
						and then fd.preconditions.has (Current);
		end;

feature -- Element change

	insert_before (data_cont: FEATURE_DATA; a_data: like Current) is
			-- Insert Current before `a_data'
		local
			swap: SWAP_ELEMENT_U
		do
			!! swap.make (data_cont, data_cont.preconditions, Current, a_data)
		end;

end -- class PRECONDITION_DATA

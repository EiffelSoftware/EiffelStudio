indexing

	description: "Invariant information.";
	date: "$Date$";
	revision: "$Revision $"

class INVARIANT_DATA 

inherit

	CLASS_ELEMENT_DATA;
	ASSERTION_INFO		

creation

	make, make_from_storer

feature -- Properties

	--stone_cursor: SCREEN_CURSOR is
	--	do
	--	--	Result := Cursors.invariant_cursor
	--	end;	

	stone_type: INTEGER is
		do
			Result := Stone_types.invariant_type
		end;

	destroy_command (a_data: CLASS_DATA): DESTROY_LIST_ELEMENT is
		do
			--!! Result.make (a_data, a_data.invariants, Current);
		end;

feature -- Access

	is_valid_for (data: DATA): BOOLEAN is
		local
			cd: CLASS_DATA
			il: ELEMENT_LIST [INVARIANT_DATA]
		do
		--	cd ?= data;
		--	if cd /= Void then
		--		il := cd.invariants
		--	end
		--	Result := cd /= Void and then il /= Void and then
		--				il.has (Current);
		end;

feature -- Element change

	insert_before (data_cont: CLASS_DATA; a_data: like Current) is
			-- Insert Current before `a_data'
		local
			swap: SWAP_ELEMENT_U
		do
		--	!! swap.make (data_cont, data_cont.invariants, Current, a_data)
		end;

feature -- Output

	generate_chart (text_area: TEXT_AREA; data: CLASS_DATA) is
		require
			valid_tag: tag /= Void
		do
		--	text_area.append_clickable_string (stone (data), tag);
		end;

end -- class INVARIANT_DATA

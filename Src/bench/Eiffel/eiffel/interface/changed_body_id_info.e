class CHANGED_BODY_ID_INFO

creation
	make

feature

	body_index: INTEGER;

	new_body_id: INTEGER;

	is_code_replicated: BOOLEAN;

	make (b: BOOLEAN; b_ind, new: INTEGER) is
		do
			is_code_replicated := b;
			body_index := b_ind;
			new_body_id := new;
		end;

end

class CHANGED_BODY_ID_INFO

creation
	make

feature

	body_index: BODY_INDEX;

	new_body_id: BODY_ID;

	is_code_replicated: BOOLEAN;

	make (b: BOOLEAN; b_ind: BODY_INDEX; new: BODY_ID) is
		do
			is_code_replicated := b;
			body_index := b_ind;
			new_body_id := new;
		end;

end

class CHANGED_BODY_ID_INFO

creation
	make

feature

	body_index: BODY_INDEX;

	new_body_id: BODY_ID;

	is_code_replicated: BOOLEAN;

	written_in: CLASS_ID
		-- the class in which the feature is written

	has_to_update_dependances: BOOLEAN
		-- did we have to update the dependancies
		-- of the class when changing the body_id ?

	make (b: BOOLEAN; b_ind: BODY_INDEX; new: BODY_ID; cid: CLASS_ID; update_dep: BOOLEAN) is
		do
			is_code_replicated := b;
			body_index := b_ind;
			new_body_id := new;
			written_in := cid
			has_to_update_dependances := update_dep
		end;

end

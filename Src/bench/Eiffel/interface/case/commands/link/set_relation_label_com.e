indexing

	description: 
		"Command to set the relation label to a link.";
	date: "$Date$";
	revision: "$Revision $"

class SET_RELATION_LABEL_COM 

inherit

	SON_COM
		redefine
			parent_object
		end

creation 

	make

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Update the current cluster name.
		local
			new_name, label: STRING;
			change_relation_label_u: CHANGE_RELATION_LABEL_U;
			reverse: BOOLEAN
		do
		--	new_name := parent_object.input_label_form.text;
		--	reverse := parent_object.relation_window.reverse_side;
		--	if reverse then
		--		label := parent_object.relation_window.clientele_link.reverse_label
		--	else
		--		label := parent_object.relation_window.clientele_link.label
		--	end;
		--	if not new_name.is_equal (label) then
		--		!! change_relation_label_u.make (parent_object.relation_window.clientele_link,
		--						new_name, reverse)
		--	end
		end 

feature {NONE} -- Implementation property

	parent_object: EC_RELATION_LABEL_PAGE 

end -- class SET_RELATION_LABEL_COM

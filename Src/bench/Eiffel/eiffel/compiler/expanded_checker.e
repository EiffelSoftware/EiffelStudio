-- Look for expanded circuit through the expanded client rule

class EXPANDED_CHECKER 

inherit

	SHARED_WORKBENCH;
	SHARED_ERROR_HANDLER;

creation

	make
	
feature 

	current_type: CLASS_TYPE;
			-- Current class type to check

	id_set: SORTED_SET [INTEGER];
			-- Set of class id

	make is
		do
			!!id_set.make;
		end;

	set_current_type (t: like current_type) is
			-- Assign `t' to `current_type'.
		do
			current_type := t;
		end;

	check_expanded is
			-- Check `current_type'
		require
			current_type_exists: current_type /= Void
		do
			recursive_check (current_type);
			id_set.wipe_out;
			Error_handler.checksum;
		end;

	
feature {NONE}

	recursive_check (class_type: CLASS_TYPE) is
		require
			good_argument: class_type /= Void;
		local
			current_skeleton: SKELETON;
			expanded_desc: EXPANDED_DESC;
			client_type: CLASS_TYPE;
			id: INTEGER;
			vlec: VLEC;
			finished: BOOLEAN;
			attr_desc: ATTR_DESC;
			stop_recursion: BOOLEAN;
		do
			stop_recursion := id_set.has (class_type.associated_class.id);
			from
				current_skeleton := class_type.skeleton;
debug
io.error.putstring ("Recursive check%N");
current_skeleton.trace;
end;
				current_skeleton.go_expanded;
			until
				current_skeleton.after or else finished
			loop
				attr_desc := current_skeleton.item;	
				if attr_desc.is_expanded = False then
					finished := True
				else
					expanded_desc ?= attr_desc;
					client_type := System.class_type_of_id (expanded_desc.type_id);
					id := client_type.associated_class.id;
					if id = current_type.associated_class.id then
							-- Found expanded circuit
						!!vlec;
						vlec.set_class_id (id);
						vlec.set_class_type (current_type);
						Error_handler.insert_error (vlec);
					else
						id_set.put (id);
						if not stop_recursion then
							recursive_check (client_type);
						end;
					end;
				end;

				current_skeleton.forth;
			end;
		end;

end

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
			current_type := Void;
		end;

	
feature {NONE}

	recursive_check (class_type: CLASS_TYPE) is
		require
			good_argument: class_type /= Void;
		local
			current_skeleton: SKELETON;
			expanded_desc: EXPANDED_DESC;
			client_type: CLASS_TYPE;
			client: CLASS_C;
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
					client := client_type.associated_class;
					id := client.id;
					if id = current_type.associated_class.id then
							-- Found expanded circuit
						!!vlec;
						vlec.set_class (current_type.associated_class);
						vlec.set_client (class_type.associated_class);
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

feature

	check_actual_type (a_type: TYPE_A) is
		require
			type_has_generics: a_type.has_generics
		local
			gen_type: GEN_TYPE_A
		do
			gen_type ?= a_type;
			recursive_check_type (gen_type);
			Error_handler.checksum;
			id_set.wipe_out;
		end;

feature {NONE}

	recursive_check_type (a_type: TYPE_A) is
		local
			ass_c: CLASS_C;
			generics: ARRAY [TYPE_A];
			i: INTEGER;
			vlec: VLEC;
		do
			if a_type.has_generics then
				if a_type.is_expanded then
					ass_c := a_type.associated_class;
					if not id_set.has (ass_c.id) then
						if ass_c.is_expanded then
							id_set.put (ass_c.id);
						end;
					else
						!!vlec;
						vlec.set_class (System.current_class);
						vlec.set_client (ass_c);
						Error_handler.insert_error (vlec);
					end;
				end;
				from
					generics := a_type.generics;
					i := generics.lower
				until
					i > generics.upper
				loop
					recursive_check_type (generics.item (i));
					i := i + 1;
				end;
			end;
		end;

end

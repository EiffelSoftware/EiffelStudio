-- Description of the supplier of a class: each feature name written in the
-- associated class is associated to a supplier list (list of ids).

class CLASS_DEPENDANCE 

inherit

	EXTEND_TABLE [SORTED_SET [DEPEND_UNIT], STRING];
	IDABLE
		undefine
			twin
		end;
	SHARED_WORKBENCH
		undefine
			twin
		end

creation

	make

	
feature 

	id: INTEGER;
			-- Id of the associated class

	set_id (i: INTEGER) is
			-- Assign `i' to `id'.
		do
			id := i;
		end; -- set_id

	associated_class: CLASS_C is
			-- Associated class
		do
			Result := System.class_of_id (id);
		end;

	update is
			-- Update the table, i.e. remove the dependance
			-- if the supplier class does not exist in the system
		local
			set: SORTED_SET [DEPEND_UNIT];
			modified: BOOLEAN;
		do
			from
				start
			until
				offright
			loop
				set := item_for_iteration;
				from
					set.start
				until
					set.offright or modified
				loop
					if System.class_of_id (set.item.id) = Void then
						modified := True
					end;
					set.forth;
				end;
				if modified = True  then
					associated_class.insert_changed_feature (key_for_iteration);
					remove (key_for_iteration);
					modified := False;
				end;
				forth
			end;
		end;

end

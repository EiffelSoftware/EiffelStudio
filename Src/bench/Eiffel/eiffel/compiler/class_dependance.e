-- Description of the supplier of a class: each feature name written in the
-- associated class is associated to a supplier list (list of ids).

class CLASS_DEPENDANCE 

inherit

	EXTEND_TABLE [FEATURE_DEPENDANCE, BODY_ID]
		redefine
			remove, put, item
		end
	IDABLE
		undefine
			is_equal, copy
		end;
	SHARED_WORKBENCH
		undefine
			is_equal, copy
		end

creation
	make

	
feature 

	id: CLASS_ID;
			-- Id of the associated class

	set_id (i: CLASS_ID) is
			-- Assign `i' to `id'.
		do
			id := i;
		end; -- set_id

	associated_class: CLASS_C is
			-- Associated class
		do
			Result := System.class_of_id (id);
		end;

	item (bid: BODY_ID): FEATURE_DEPENDANCE is
			--securised access to the dependances
		local
			body_id: BODY_ID
		do
			body_id := updated_id (bid)
			Result := {EXTEND_TABLE} Precursor (bid)
		end	
	
	put (f: FEATURE_DEPENDANCE; bid: BODY_ID) is
			-- we must update the correspondance table in the server
		local
			body_id: BODY_ID
		do
			-- to update the id may be not necessary, but this way we are sure it 
			-- is the younger one
			body_id := updated_id (bid)
			System.depend_server.add_correspondance (body_id, id)
			{EXTEND_TABLE} Precursor (f, bid)
		end

	remove (bid: BODY_ID) is
			-- we must update the correspondance table in the server
		local
			body_id: BODY_ID
		do
			body_id := updated_id  (bid)
			System.depend_server.remove_correspondance (bid)
			{EXTEND_TABLE} Precursor (bid)
		end

	item_of_name (n: STRING): FEATURE_DEPENDANCE is
			-- to find the dependances of a feature from its name
		local
			feature_found: BOOLEAN	
		do
			from
				start
			until
				after or else feature_found
			loop
				feature_found := item_for_iteration.feature_name.is_equal (n)
				if not feature_found then
					forth
				end
			end	
			if feature_found then
				Result := item_for_iteration
			end
		end
			
	updated_id (i: BODY_ID): BODY_ID is
			-- give the newest id corresponding to body id 'i'
		do
			Result := System.onbidt.item (i)
		end;

	change_ids (new_id, old_id: BODY_ID) is
			-- updates the body ids in the server in case of change
		local
			info: FEATURE_DEPENDANCE
		do
			info := item (old_id)
			remove (old_id)
			put (info, new_id)
		end
end

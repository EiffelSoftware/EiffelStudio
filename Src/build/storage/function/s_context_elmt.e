

class S_CONTEXT_ELMT  

inherit

	STORAGE_INFO
		export
			{NONE} all
		end


creation

	make

	
feature 

	make (other: CONTEXT) is
		do
			identifier := other.identifier;
			full_name := clone (other.full_name);
		end;

	
feature {NONE}

	identifier: INTEGER;

	
feature 


	full_name: STRING;

	context: CONTEXT is
		do
			if identifier_changed_table.has (full_name) then
				identifier := identifier_changed_table.item (full_name);
			end;

			if for_import.value and then name_changed_table.has (full_name) then
				full_name := name_changed_table.item (full_name);
			end;
			Result := context_table.item (identifier);
			
			if Result = Void or else not full_name.is_equal (Result.full_name) then
				Result := find_context;
			end;
		end;

	find_context: CONTEXT is
		local
			found: BOOLEAN;
		do
			from
				context_table.start
			until
				context_table.off or found
			loop
				Result := context_table.item_for_iteration;
				if full_name.is_equal (Result.full_name) then
					found := True;
				else
					Result := Void;
				end;
				context_table.forth;
			end;
		end;
			
end

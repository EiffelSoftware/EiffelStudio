
class S_EVENT_ELMT 

inherit

	SHARED_STORAGE_INFO

creation

	make

feature 

	make (other: EVENT) is
		do
			identifier := other.identifier;
		end;

	event: EVENT is
		do
			if identifier < 0 then
				Result := event_table.item (- identifier);
			else
				Result := translation_table.item (identifier);
			end;
		end;

feature {NONE}

	identifier: INTEGER;

end

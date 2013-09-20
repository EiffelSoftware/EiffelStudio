note
	description: "Enumeration of the four different write operations: Insert, Update, Delete and No_operation."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

frozen class
	PS_WRITE_OPERATION

feature

	Update: PS_WRITE_OPERATION
			-- Update semantics: In simple objects, it will update all objects listed in the `attributes' list.
			-- In collections, it will (logically) delete the collection in the database and reinsert it with all `values'.
		once
			create Result
		end

	Insert: PS_WRITE_OPERATION
			-- Insert semantics: In simple objects, it will insert all objects listed in the `attributes' list.
			-- In collections, it will insert the values in `values', adding them to possible present data in the database.
		once
			create Result
		end

	Delete: PS_WRITE_OPERATION
			-- Delete semantics: Will always delete the whole object regardless of the values in `attributes' or the whole collection.
		once
			create Result
		end

	No_operation: PS_WRITE_OPERATION
			-- No operation: Backend will ignore this object, but it might be needed to resolve primary keys.
		once
			create Result
		end

end

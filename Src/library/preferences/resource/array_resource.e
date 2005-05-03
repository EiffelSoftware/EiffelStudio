indexing
	description	: "Array resource."
	date		: "$Date:"
	revision	: "$Revision$"

class
	ARRAY_PREFERENCE

inherit
	TYPED_PREFERENCE [ARRAY [STRING]]

create {PREFERENCE_FACTORY}
	make, make_from_string_value

feature -- Access

	string_value: STRING is
			-- String representation of `value'.				
		local
			index: INTEGER
		do
			create Result.make_empty
			from
				index := 1
			until
				index > value.count
			loop
				Result.append (value.item (index))
				if not (index = value.count) then
					Result.append (";")
				end
				index := index + 1
			end
		end	

	string_type: STRING is
			-- String description of this resource type.
		once
			Result := "LIST"
		end	

	selected_value: STRING is
			-- 
		do
			--TODO: neilc.
			Result := value.item (1)	
		end		

feature -- Query

	valid_value_string (a_string: STRING): BOOLEAN is
			-- Is `a_string' valid for this resource type to convert into a value?		
		do
			Result := a_string /= Void
		end		

feature {PREFERENCES} -- Access

	generating_resource_type: STRING is
			-- The generating type of the resource for graphical representation.
		once
			Result := "TEXT"
		end

feature {STRING_PREFERENCE_WIDGET} -- Implementation

	set_value_from_string (a_value: STRING) is
			-- Parse the string value `a_value' and set `value'.
		local
			start_pos, end_pos: INTEGER			
		do
			create value.make (1, 0)
			if not a_value.is_empty then
				from
					start_pos := 1
					end_pos := a_value.index_of (';', start_pos)
				until
					end_pos = 0 or start_pos = a_value.count
				loop
					value.force (a_value.substring (start_pos, end_pos - 1), value.count + 1)
					start_pos := end_pos + 1
					end_pos := a_value.index_of (';', start_pos)
				end
				if start_pos <= a_value.count then
					value.force (a_value.substring (start_pos, a_value.count), value.count + 1)
				end
			end
			set_value (value)
		end	
		
end -- class ARRAY_PREFERENCE

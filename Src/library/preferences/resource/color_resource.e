indexing
	description	: "Color resource."
	date		: "$Date$"
	revision	: "$Revision$"
 
class
	COLOR_RESOURCE 
 
inherit
	TYPED_RESOURCE [EV_COLOR]
 
create {RESOURCE_FACTORY}
	make, make_from_string_value
 
feature -- Access
						
	string_value: STRING is
			-- String representation of `value'.		
		do
			Result := value.red_8_bit.out + ";" + value.green_8_bit.out + ";" + value.blue_8_bit.out
		end	
		
	string_type: STRING is
			-- String description of this resource type.
		once
			Result := "COLOR"
		end		
		
feature -- Query

	valid_value_string (a_string: STRING): BOOLEAN is
			-- Is `a_string' valid for this resource type to convert into a value?
			-- String must conform to the following stucture: "xxx;xxx;xxx" where xxx represents
			-- an integer value between 0 and 255.
		local
			s, rgbval: STRING
			i: INTEGER
		do
			s := a_string.twin
			if s.occurrences (';') = 2 then
				i := s.index_of (';', 1)
				rgbval := s.substring (1, i - 1)
				Result := not rgbval.is_empty and then rgbval.count < 4 and then rgbval.is_integer
				if Result then
					s := s.substring (rgbval.count + 2, s.count)
					i := s.index_of (';', 1)
					rgbval := s.substring (1, i - 1)
					Result := not rgbval.is_empty and then rgbval.count < 4 and then rgbval.is_integer
					if Result then
						s := s.substring (rgbval.count + 2, s.count)
						rgbval := s.substring (1, s.count)
						Result := not rgbval.is_empty and then rgbval.count < 4 and then rgbval.is_integer
					end
				end
			end
		end			
	
feature {PREFERENCES} -- Access

	generating_resource_type: STRING is
			-- The generating type of the resource for graphical representation.
		once
			Result := "COLOR"
		end	
		
feature {NONE} -- Implementation

	set_value_from_string (a_value: STRING) is
			-- Parse the string value `a_value' and set `value'.
		local
			s, rgbval: STRING
			i, r, g, b: INTEGER
		do
			s := a_value.twin
				
				-- Red value
			i := s.index_of (';', 1)
			rgbval := s.substring (1, i - 1)
			r := rgbval.to_integer
			
				-- Green value
			s := s.substring (rgbval.count + 2, s.count)
			i := s.index_of (';', 1)
			rgbval := s.substring (1, i - 1)
			g := rgbval.to_integer
			
				-- Blue value
			s := s.substring (rgbval.count + 2, s.count)				
			rgbval := s.substring (1, s.count)
			b := rgbval.to_integer
		
			create value.make_with_8_bit_rgb (r, g, b)
		end	

end -- class COLOR_RESOURCE

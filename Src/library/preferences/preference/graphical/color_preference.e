indexing
	description	: "Color preference."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
 
class
	COLOR_PREFERENCE 
 
inherit
	TYPED_PREFERENCE [EV_COLOR]
 
create {PREFERENCE_FACTORY}
	make, make_from_string_value
 
feature -- Access
						
	string_value: STRING is
			-- String representation of `value'.		
		do
			if is_auto then
				Result := auto_preference.string_value
			else
				Result := internal_value.red_8_bit.out + ";" + internal_value.green_8_bit.out + ";" + internal_value.blue_8_bit.out	
			end			
		end	
		
	string_type: STRING is
			-- String description of this preference type.
		once
			Result := "COLOR"
		end
	
feature -- Query

	valid_value_string (a_string: STRING): BOOLEAN is
			-- Is `a_string' valid for this preference type to convert into a value?
			-- String must conform to the following structure: "xxx;xxx;xxx" where xxx represents
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
			elseif s.is_equal (auto_string) then
				Result := True
			end
		end			
	
feature {PREFERENCES} -- Access

	generating_preference_type: STRING is
			-- The generating type of the preference for graphical representation.
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
			
			if s.is_equal (auto_string) then
				set_value (auto_default_value)
			else				
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
			
				set_value (create {EV_COLOR}.make_with_8_bit_rgb (r, g, b))
			end
		end	

	auto_default_value: EV_COLOR is
			-- Value to use when Current is using auto by default (until real auto is set)
		once
			create Result
		end	

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class COLOR_PREFERENCE

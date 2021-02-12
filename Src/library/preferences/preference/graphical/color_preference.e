note
	description: "Color preference."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COLOR_PREFERENCE

inherit
	TYPED_PREFERENCE [EV_COLOR]
		redefine
			init_value_from_string
		end

create {PREFERENCE_FACTORY}
	make, make_from_string_value

feature {NONE} -- Initialization

	 init_value_from_string (a_value: READABLE_STRING_GENERAL)
			-- Set initial value from String `a_value'
		do
			create internal_value.make_with_8_bit_rgb (0, 0, 0)
			Precursor (a_value)
		end

feature {PREFERENCE_EXPORTER} -- Access

	text_value: STRING_32
			-- String representation of `value'.
		do
			Result := color_text_value (value)
		end

	color_text_value (a_value: EV_COLOR): STRING_32
		do
			create Result.make (11)
			Result.append_integer (a_value.red_8_bit)
			Result.append_character (';')
			Result.append_integer (a_value.green_8_bit)
			Result.append_character (';')
			Result.append_integer (a_value.blue_8_bit)
		end

feature -- Access

	string_type: STRING
			-- String description of this preference type.
		once
			Result := "COLOR"
		end

feature -- Element change

	set_as_default_value (a_value: EV_COLOR)
		do
			set_default_value (color_text_value (a_value))
		end

feature -- Query

	valid_value_string (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_string' valid for this preference type to convert into a value?
			-- String must conform to the following structure: "xxx;xxx;xxx" where xxx represents
			-- an integer value between 0 and 255.
		local
			s,
			rgbval: STRING_32
			i: INTEGER
		do
			s := a_string.to_string_32
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
			elseif s.same_string (auto_string) then
				Result := True
			end
		end

feature {PREFERENCES} -- Access

	generating_preference_type: STRING
			-- The generating type of the preference for graphical representation.
		once
			Result := "COLOR"
		end

feature {NONE} -- Implementation

	set_value_from_string (a_value: READABLE_STRING_GENERAL)
			-- Parse the string value `a_value' and set `value'.
		local
			s, rgbval: STRING_32
			i, r, g, b: INTEGER
		do
			if a_value.same_string (auto_string) then
				set_value (auto_default_value)
			else
				s := a_value.to_string_32

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

	auto_default_value: EV_COLOR
			-- Value to use when Current is using auto by default (until real auto is set)
		once
			create Result
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class COLOR_PREFERENCE

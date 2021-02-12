note
	description: "Font preference."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FONT_PREFERENCE

inherit
	TYPED_PREFERENCE [EV_FONT]
		redefine
			set_value
		end

	EV_FONT_CONSTANTS
		undefine
			is_equal
		end

create {PREFERENCE_FACTORY}
	make, make_from_string_value

feature {PREFERENCE_EXPORTER} -- Access

	text_value: STRING_32
			-- String representation of `value'.		
		do
			Result := generated_value
		end

feature -- Status Setting

	set_value (a_value: EV_FONT)
			-- Set the value with the wanted font.
		require else
			valid_font: a_value /= Void and then not a_value.is_destroyed
		do
			Precursor {TYPED_PREFERENCE} (a_value)
			set_face (a_value.name)
			shape := a_value.shape
			weight := a_value.weight
			height := a_value.height_in_points
			family := a_value.family
		end

	set_as_default_value (a_value: EV_FONT)
		do
			set_default_value (font_text_value (a_value))
		end

	string_type: STRING
			-- String description of this preference type.
		once
			Result := "FONT"
		end

feature -- Query

	valid_value_string (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_string' valid for this preference type to convert into a value?
			-- An valid string takes the form "faces-shape-weight-height-family".
		do
			Result := a_string.to_string_32.occurrences ('-') >= 4
		end

feature {PREFERENCES} -- Access

	generating_preference_type: STRING
			-- The generating type of the preference for graphical representation.
		once
			Result := "FONT"
		end

feature {NONE} -- Implementation

	face: detachable STRING_32
			-- Font faces
	shape,
	weight,
	height,
	family: INTEGER
		-- Attributes

	set_value_from_string (a_value: READABLE_STRING_GENERAL)
			-- Parse the string value `a_value' and set `value'.
			--| `a_value' should be like "Fontname-r-regular-8-screen" ie "face-shape-weight-height-family" (shape is one letter: r or i )
		local
			s: STRING_32
			i, j: INTEGER
			l_value: detachable like value
		do
			s := a_value.to_string_32
			if s.occurrences ('-') >= 5 then
					-- The face has dash in the name: such as "DigitalSerial-Xbold-r-regular-8-screen"
					-- so we analyze the string starting from the end.
				j := s.count
				i := s.last_index_of ('-', j)
				check has_family_value: i > 0 end
				set_family (s.substring (i + 1, j))
				j := i - 1

				i := s.last_index_of ('-', j)
				check has_height_value: i > 0 end
				set_height (s.substring (i + 1, j))
				j := i - 1

				i := s.last_index_of ('-', j)
				check has_weight_value: i > 0 end
				set_weight (s.substring (i + 1, j))
				j := i - 1

				i := s.last_index_of ('-', j)
				check has_shape_value: i > 0 end
				set_shape (s.substring (i + 1, j))
				j := i - 1

				check is_valid_face: s.is_whitespace end
				set_face (s.substring (1, j))
				create l_value.make_with_values (family, weight, shape, height)
			else
				j := 1
				i := s.index_of('-', j)
				if i > 0 then
					set_face (s.substring (j, i - 1))
					j := i + 1
					i := s.index_of ('-', j)
					if i > 0 then
						set_shape (s.substring (j, i - 1))
						j := i + 1
						i := s.index_of ('-', j)
						if i > 0 then
							set_weight (s.substring (j, i - 1))
							j := i + 1
							i := s.index_of ('-', j)
							if i > 0 then
								set_height (s.substring (j, i - 1))
								set_family (s.substring (i + 1, s.count))
							end
						end
					end
					create l_value.make_with_values (family, weight, shape, height)
				end
			end
			if l_value /= Void then
					internal_value := l_value
					l_value.set_height_in_points (height)
					if attached face as l_face then
						l_value.preferred_families.extend (l_face)
					end
					set_value (l_value)
			else
				create internal_value
			end
		end

	generated_value: STRING_32
			-- String generated value for display and saving purposes.
		require
			has_value: value /= Void
		do
			Result := font_text_value (value)
		end

	font_text_value (a_value: like value): STRING_32
			-- String generated value for `a_value` for display and saving purposes.
		require
			has_value: a_value /= Void
		do
			create Result.make (50)
			if attached a_value.name as l_face then
				Result.append (l_face)
			else
				check has_face: False end
			end

			Result.append_character ('-')
			inspect a_value.shape
			when shape_italic then
				Result.append_character ('i')
			when shape_regular then
				Result.append_character ('r')
			else
				check has_valid_shape: False end
					-- Use default
				Result.append_character ('r')
			end

			Result.append_character ('-')
			inspect a_value.weight
			when weight_black then
				Result.append ("black")
			when weight_thin then
				Result.append ("thin")
			when weight_regular then
				Result.append ("regular")
			when weight_bold then
				Result.append ("bold")
			else
				check has_valid_weight: False end
					-- Use default
				Result.append ("regular")
			end
			Result.append_character ('-')
			Result.append_integer (height)
			Result.append_character ('-')

			inspect a_value.family
			when family_roman then
				Result.append ("roman")
			when family_screen then
				Result.append ("screen")
			when family_sans then
				Result.append ("sans")
			when family_modern then
				Result.append ("modern")
			when family_typewriter then
				Result.append ("typewriter")
			else
				check has_valid_family: False end
					-- Use default
				Result.append ("sans")
			end
		end

	set_face (s: READABLE_STRING_GENERAL)
			-- Set shape according to `s'.
		require
			not_void: s /= Void
		do
			face := s.as_string_32
		end

	set_shape (s: READABLE_STRING_GENERAL)
			-- Set shape according to `s'.
		require
			not_void: s /= Void
		do
			if s.is_case_insensitive_equal ("i") or s.is_case_insensitive_equal ("italic") then
				shape := shape_italic
			elseif s.is_case_insensitive_equal ("r") or s.is_case_insensitive_equal ("regular") then
				shape := shape_regular
			end
		end

	set_weight (s: READABLE_STRING_GENERAL)
			-- Set `weight' according to `s'.
		require
			not_void: s /= Void
		do
			if s.is_case_insensitive_equal ("thin") then
				weight := weight_thin
			elseif s.is_case_insensitive_equal ("regular") then
				weight := weight_regular
			elseif s.is_case_insensitive_equal ("bold") then
				weight := weight_bold
			elseif s.is_case_insensitive_equal ("black") then
				weight := weight_black
			end
		end

	set_family (s: READABLE_STRING_GENERAL)
			-- Set `family' according to `s'.
		require
			not_void: s /= Void
		do
			if s.is_case_insensitive_equal ("screen") then
				family := family_screen
			elseif s.is_case_insensitive_equal ("roman") then
				family := family_roman
			elseif s.is_case_insensitive_equal ("sans") then
				family := family_sans
			elseif s.is_case_insensitive_equal ("typewriter") then
				family := family_typewriter
			elseif s.is_case_insensitive_equal ("modern") then
				family := family_modern
			end
		end

	set_height (s: READABLE_STRING_GENERAL)
			-- Set `height' according to `s'
		require
			not_void: s /= Void
		do
			if s.is_integer then
				height := s.to_integer
			end
		end

	auto_default_value: EV_FONT
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




end -- class FONT_PREFERENCE

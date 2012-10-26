note
	description	: "Font preference."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

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

feature {PREFERENCE, PREFERENCE_WIDGET, PREFERENCES_STORAGE_I, PREFERENCE_VIEW} -- Access

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
			Result := a_string.to_string_32.occurrences ('-') = 4
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
		local
			s: STRING_32
			i: INTEGER
			l_value: like value
		do
			s := a_value.to_string_32
			i := s.index_of('-', 1)
			if i > 0 then
				set_face (s.substring (1, i - 1))
				s := s.substring (i + 1, s.count)
				i := s.index_of ('-',1)
				if i > 0 then
					set_shape (s.substring (1, i - 1))
					s := s.substring (i + 1, s.count)
					i := s.index_of ('-',1)
					if i > 0 then
						set_weight (s.substring (1, i - 1))
						s := s.substring (i + 1, s.count)
						i := s.index_of ('-',1)
						if i > 0 then
							set_height (s.substring (1, i - 1))
							set_family (s.substring (i + 1, s.count))
						end
					end
				end
				create l_value.make_with_values (family, weight, shape, height)
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
		local
			v: STRING_32
			l_value: like value
		do
			l_value := value
			check attached l_value end -- implied by precondition `has_value'

			create v.make (50)
			if attached face as l_face then
				v.append (l_face)
			else
				check has_face: False end
			end

			v.append_character ('-')
			inspect l_value.shape
			when shape_italic then
				v.append_character ('i')
			when shape_regular then
				v.append_character ('r')
			end
			v.append_character ('-')
			inspect l_value.weight
			when weight_black then
				v.append ("black")
			when weight_thin then
				v.append ("thin")
			when weight_regular then
				v.append ("regular")
			when weight_bold then
				v.append ("bold")
			end
			v.append_character ('-')
			v.append_integer (height)
			v.append_character ('-')

			inspect l_value.family
			when family_roman then
				v.append ("roman")
			when family_screen then
				v.append ("screen")
			when family_sans then
				v.append ("sans")
			when family_modern then
				v.append ("modern")
			when family_typewriter then
				v.append ("typewriter")
			end
			Result := v
		end

	set_face (s: READABLE_STRING_GENERAL)
			-- Set shape according to `s'.
		require
			not_void: s /= Void
		do
			face := s.as_string_32
		end

	set_shape (s: STRING)
			-- Set shape according to `s'.
		require
			not_void: s /= Void
		local
			s1: STRING
		do
			s1 := s.as_lower
			if s1.same_string ("i") or s1.same_string ("italic") then
				shape := shape_italic
			elseif s1.same_string ("r") or s1.same_string ("regular") then
				shape := shape_regular
			end
		end

	set_weight (s: STRING)
			-- Set `weight' according to `s'.
		require
			not_void: s /= Void
		local
			s1: STRING
		do
			s1 := s.as_lower
			if s1.same_string ("thin") then
				weight := weight_thin
			elseif s1.same_string ("regular") then
				weight := weight_regular
			elseif s1.same_string ("bold") then
				weight := weight_bold
			elseif s1.same_string ("black") then
				weight := weight_black
			end
		end

	set_family (s: STRING)
			-- Set `family' according to `s'.
		require
			not_void: s /= Void
		local
			s1: STRING
		do
			s1 := s.as_lower
			if s1.same_string ("screen") then
				family := family_screen
			elseif s1.same_string ("roman") then
				family := family_roman
			elseif s1.same_string ("sans") then
				family := family_sans
			elseif s1.same_string ("typewriter") then
				family := family_typewriter
			elseif s1.same_string ("modern") then
				family := family_modern
			end
		end

	set_height (s: STRING)
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
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class FONT_PREFERENCE

note
	description	: "Font resource."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	IDENTIFIED_FONT_PREFERENCE

inherit
	TYPED_PREFERENCE [EV_IDENTIFIED_FONT]
		redefine
			set_value
		end

	EV_FONT_CONSTANTS
		undefine
			is_equal
		end

	EV_SHARED_SCALE_FACTORY
		undefine
			default_create
		end

create {PREFERENCE_FACTORY}
	make, make_from_string_value

feature -- Access

	text_value: STRING_32
			-- String representation of `value'.		
		do
			Result := generated_value
		end

feature -- Status Setting

	set_value (a_value: like value)
			-- Set the value with the wanted font.
		require else
			valid_font: a_value /= Void and then not a_value.font.is_destroyed
		do
			Precursor {TYPED_PREFERENCE} (a_value)
			face := value.font.name
			shape := value.font.shape
			weight := value.font.weight
			height := value.font.height_in_points
			family := value.font.family
		end

	string_type: STRING
			-- String description of this resource type.
		once
			Result := "IDENTIFIEDFONT"
		end

feature -- Query

	valid_value_string (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_string' valid for this preference type to convert into a value?
			-- An valid string takes the form "faces-shape-weight-height-family".
		do
			Result := a_string.as_string_32.occurrences ('-') = 4
		end

feature {PREFERENCES} -- Access

	generating_preference_type: STRING
			-- The generating type of the preference for graphical representation.
		once
			Result := "IDENTIFIED_FONT"
		end

feature {NONE} -- Implementation

	face: STRING_32
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
		do
			create s.make (a_value.count)
			s.append_string_general (a_value)

			i := s.index_of ('-', 1)
			if i > 0 then
				face := s.substring (1, i - 1)
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
				internal_value := font_factory.registered_font (create {EV_FONT}.make_with_values (family, weight, shape, height))
				internal_value.font.set_height_in_points (height)
				internal_value.font.preferred_families.extend (face)
				set_value (internal_value)
			end
		end

	generated_value: STRING_32
			-- String generated value for display and saving purposes.
		require
			has_value: value /= Void
		local
			v: STRING_32
			l_font: EV_FONT
		do
			create v.make (50)
			v.append (face)
			v.append_character ('-')
			l_font := value.font
			inspect l_font.shape
			when shape_italic then
				v.append_character ('i')
			when shape_regular then
				v.append_character ('r')
			end
			v.append_character ('-')
			inspect l_font.weight
			when weight_black then
				v.append ({STRING_32} "black")
			when weight_thin then
				v.append ({STRING_32} "thin")
			when weight_regular then
				v.append ({STRING_32} "regular")
			when weight_bold then
				v.append ({STRING_32} "bold")
			end
			v.append_character ('-')
			v.append (height.out)
			v.append_character ('-')
			inspect l_font.family
			when family_roman then
				v.append ({STRING_32} "roman")
			when family_screen then
				v.append ({STRING_32} "screen")
			when family_sans then
				v.append ({STRING_32} "sans")
			when family_modern then
				v.append ({STRING_32} "modern")
			when family_typewriter then
				v.append ({STRING_32} "typewriter")
			end
			Result := v
		end

	set_shape (a_shape: READABLE_STRING_GENERAL)
			-- Set shape according to `s'.
		require
			not_void: a_shape /= Void
		local
			s: READABLE_STRING_GENERAL
		do
			s := a_shape.as_lower
			if
				s.same_string ("i") or
				s.same_string ("italic")
			then
				shape := shape_italic
			elseif
				s.same_string ("r") or
				s.same_string ("regular")
			then
				shape := shape_regular
			end
		end

	set_weight (s: READABLE_STRING_GENERAL)
			-- Set `weight' according to `s'.
		require
			not_void: s /= Void
		local
			s1: READABLE_STRING_GENERAL
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

	set_family (s: READABLE_STRING_GENERAL)
			-- Set `family' according to `s'.
		require
			not_void: s /= Void
		local
			s1: READABLE_STRING_GENERAL
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

	set_height (s: READABLE_STRING_GENERAL)
			-- Set `height' according to `s'
		require
			not_void: s /= Void
		do
			if s.is_integer then
				height := s.to_integer
			end
		end

	auto_default_value: EV_IDENTIFIED_FONT
			-- Value to use when Current is using auto by default (until real auto is set)
		once
			Result := font_factory.registered_font (create {EV_FONT})
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class IDENTIFIED_FONT_PREFERENCE

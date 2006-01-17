indexing
	description	: "A resource value for string resources."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	FONT_RESOURCE

inherit
	STRING_RESOURCE
		redefine
			make, set_value, xml_trace, registry_name
		end

	EV_FONT_CONSTANTS
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_value: STRING) is
			-- Initialize Current
		do
			name := a_name
			default_value := a_value
			if a_value /= Void then
				set_value (a_value)
			end
		end

feature -- Access

	actual_value: EV_FONT is
			-- Font value
		local
			i, j: INTEGER
		do
			create Result.make_with_values (family, weight, shape, height)
			from
				i := 1
				j := faces.index_of (',', i)
			until
				j = 0
			loop
				Result.preferred_families.extend (faces.substring (i, j))
				i := j + 1
				j := faces.index_of (',', i)
			end
			Result.preferred_families.extend (faces.substring (i, faces.count))
		end

	valid_actual_value: EV_FONT is
			-- A non void font value
		do
			Result := actual_value
			if Result = Void then
				create Result
			end
		ensure
			valid_result: Result /= Void
		end;

feature -- Status Setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		local
			s: STRING
			i: INTEGER
		do
			value := new_value
			s := clone (value)
			i := s.index_of('-', 1)
			if i > 0 then
				faces := s.substring (1, i - 1)
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
			end
		end

	set_actual_value (f: EV_FONT) is
			-- Set the value with the wanted font.
		require
			valid_font: f /= Void and then not f.is_destroyed
		do
			actual_faces := f.preferred_families
			shape := f.shape
			weight := f.weight
			height := f.height
			family := f.family
			generate_value
		end

feature {NONE} -- Implementation

	faces : STRING

	shape, weight, height, family: INTEGER

feature -- Output

	xml_trace: STRING is
			-- XML representation of current
		local
			xml_name, xml_value: STRING
		do
			xml_name := name
			xml_value := value

			create Result.make (27 + xml_name.count + xml_value.count)
			Result.append ("<TEXT>")
			Result.append (xml_name)
			Result.append ("<FONT>")
			Result.append (xml_value)
			Result.append ("</FONT></TEXT>")
		end

	registry_name: STRING is
			-- name of Current in the registry
		do
			Result := "EIFFON_" + name
		end

feature {NONE} -- Implementation

	actual_faces: ACTIVE_LIST [STRING]

	generate_value is
			-- Generate `value' and `faces' according to `actual_faces', `weight', `height', `family' and `shape'.
		local
			v: STRING
		do
			create v.make (50)
			from
				actual_faces.start
			until
				actual_faces.after
			loop
				v.append (actual_faces.item)
				actual_faces.forth
				if not actual_faces.after then
					v.append (",")
				end
			end
			faces := clone (v)
			v.append ("-")
			inspect shape
			when shape_italic then
				v.append ("i")
			when shape_regular then
				v.append ("r")
			end
			v.append ("-")
			inspect weight
			when weight_black then
				v.append ("black")
			when weight_thin then
				v.append ("thin")
			when weight_regular then
				v.append ("regular")
			when weight_bold then
				v.append ("bold")
			end
			v.append ("-")
			v.append (height.out)
			v.append ("-")
			inspect family
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
			value := v
		end

	set_shape (s: STRING) is
			-- Set shape according to `s'.
		require
			not_void: s /= Void
		local
			s1: STRING
		do
			s1 := s
			s1.to_lower
			if s1.is_equal ("i") or s1.is_equal ("italic") then
				shape := shape_italic
			elseif s1.is_equal ("r") or s1.is_equal ("regular") then
				shape := shape_regular
			end
		end

	set_weight (s: STRING) is
			-- Set `weight' according to `s'.
		require
			not_void: s /= Void
		local
			s1: STRING
		do
			s1 := s
			s1.to_lower
			if s1.is_equal ("thin") then
				weight := weight_thin
			elseif s1.is_equal ("regular") then
				weight := weight_regular
			elseif s1.is_equal ("bold") then
				weight := weight_bold
			elseif s1.is_equal ("black") then
				weight := weight_black
			end
		end

	set_family (s: STRING) is
			-- Set `family' according to `s'.
		require
			not_void: s /= Void
		local
			s1: STRING
		do
			s1 := s
			s1.to_lower
			if s1.is_equal ("screen") then
				family := family_screen
			elseif s1.is_equal ("roman") then
				family := family_roman
			elseif s1.is_equal ("sans") then
				family := family_sans
			elseif s1.is_equal ("typewriter") then
				family := family_typewriter
			elseif s1.is_equal ("modern") then
				family := family_modern
			end
		end

	set_height (s: STRING) is
			-- Set `height' according to `s'
		require
			not_void: s /= Void
		do
			if s.is_integer then
				height := s.to_integer
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class FONT_RESOURCE

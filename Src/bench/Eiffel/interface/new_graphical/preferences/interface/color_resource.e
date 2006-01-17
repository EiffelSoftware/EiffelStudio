indexing
	description	: "A resource value for color resources."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
 
class
	COLOR_RESOURCE 
 
inherit
	STRING_RESOURCE
		redefine
			set_value, make, xml_trace, registry_name
		end
 
create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_value: STRING) is
			-- Initialize Current with `a_name' and value `a_value'.
		do
			name := a_name
			default_value := a_value
			if a_value /= Void then
				set_value (a_value)
			end
		end
 
feature -- Access

	actual_value: EV_COLOR is
			-- Color value of resource
		do
			if not color_is_void then
				create Result.make_with_8_bit_rgb (r, g, b)
			elseif not is_voidable then
				Result := default_color
			end
		end

	negative_value: EV_COLOR is
			-- Negative value of resource
		do
			if not color_is_void then
				create Result.make_with_8_bit_rgb (255 - r, 255 - g, 255 - b)
			end
		end

	valid_actual_value: EV_COLOR is
			-- Non void color value
		do
			Result := actual_value
			if Result = Void then
				Result := default_color
			end
		ensure
			valid_result: Result /= Void
		end

	default_color: EV_COLOR is
			-- Default color (Black)
		once
			create Result.make_with_rgb (0, 0, 0)
		end

feature -- Status report

	color_is_void: BOOLEAN
			-- Is the resource marked as "auto"?
			
	is_voidable: BOOLEAN
			-- May the resource be Void?/May the resource be marked as "auto"?

feature -- Status setting

	set_value_with_color (new_value: STRING; col: EV_COLOR) is
		require
			color_exists: col /= Void
			value_exists: new_value /= Void
		do
			value := new_value
			r := col.red_8_bit
			g := col.green_8_bit
			b := col.blue_8_bit
			color_is_void := False
		end

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		local
			s: STRING
			i: INTEGER
		do
			value := new_value
			s := clone (value)
			i := s.index_of(';', 1)
			if i > 0 then
				r := head_integer (s, i - 1)
				s := s.substring (i + 1, s.count)
				i := s.index_of (';',1)
				if i > 0 then
					g := head_integer (s, i - 1)
					s := s.substring (i + 1, s.count)
					b := head_integer (s, s.count)
				else
					r := 0
					g := 0
					b := 0
				end
				color_is_void := False
			else
				r := 0
				g := 0
				b := 0
				s.to_lower
				color_is_void := s.is_equal ("auto")
			end
		end

		set_void is
				-- Set current on "auto" value.
			require
				may_be_void: is_voidable
			do
				value := "auto"
				r := 0
				g := 0
				b := 0
				color_is_void := True
			end
			
		allow_void is
				-- `Current' may return a Void color after this, and be set to auto.
			do
				is_voidable := True
			end
		
			
feature {NONE} -- Implementation

	r, g, b: INTEGER

	head_real (s: STRING; i: INTEGER): REAL is
			-- Real represented by the `i' first characters of `s'
			-- Result is always in [0..1], being truncated if necessary.
			-- (Result is 0 if no integer is recognized)
		require
			not_void: s /= Void
			index_possible: i>0 and then i<=s.count	
		local
			s1: STRING
		do
			s1 := s.substring (1, i)
			if s1.is_real then
				Result := s1.to_real
			end
			if Result > 1 then
				Result := 1
			elseif Result < 0 then
				Result := 0
			end
		end

	head_integer (s: STRING; i: INTEGER): INTEGER is
			-- Integer represented by the `i' first characters of `s'
			-- Result is always in [0..255], being truncated if necessary.
			-- (Result is 0 if no integer is recognized)
		require
			not_void: s /= Void
			index_possible: i>0 and then i<=s.count	
		local
			s1: STRING
		do
			s1 := s.substring (1, i)
			if s1.is_integer then
				Result := s1.to_integer
			end
			if Result > 255 then
				Result := 255
			elseif Result < 0 then
				Result := 0
			end
		end

feature -- Output

	xml_trace: STRING is
			-- XML representation of current
		do
			Result := "<TEXT>"
			Result.append (name)
			Result.append ("<COLOR>")
			Result.append (value)
			Result.append ("</COLOR></TEXT>")
		end

	registry_name: STRING is
			-- name of Current in the registry
		do
			Result := "EIFCOL_" + name
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

end -- class COLOR_RESOURCE

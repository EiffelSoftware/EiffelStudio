indexing
	description: "Actual type for character type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class CHARACTER_A

inherit
	BASIC_A
		rename
			make as cl_make
		redefine
			is_character, is_character_32, type_i, associated_class, same_as, process
		end

create
	make

feature -- Initialization

	make (w: BOOLEAN) is
			-- Create instance of CHARACTER_A. If `w' a normal character.
			-- Otherwise a wide character.
		do
			is_character_32 := w
			cl_make (associated_class.class_id)
		ensure
			is_character_32_set: is_character_32 = w
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_character_a (Current)
		end

feature -- Property

	is_character: BOOLEAN is True
			-- Is the current type a character type ?

	is_character_32: BOOLEAN
			-- Is the type a character 32 bits type?

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			char: like Current
		do
			Result := other.is_character
			if Result then
				char ?= other
				Result := is_character_32 = char.is_character_32
					and then has_attached_mark = char.has_attached_mark
					and then has_detachable_mark = char.has_detachable_mark
			end
		end

	associated_class: CLASS_C is
			-- Class CHARACTER
		do
			if is_character_32 then
				Result := System.character_32_class.compiled_class
			else
				Result := System.character_8_class.compiled_class
			end
		end

feature {COMPILER_EXPORTER}

	type_i: CHAR_I is
			-- C type
		do
			if is_character_32 then
				Result := Wide_char_c_type
			else
				Result := Char_c_type
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end -- class CHARACTER_A

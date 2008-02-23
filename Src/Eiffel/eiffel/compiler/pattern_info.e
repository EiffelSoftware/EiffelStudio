indexing
	description: "[
		Description of a pattern. Used for workbench code generation to ease
		transfer of control between C generated code and melted code.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class PATTERN_INFO

inherit
	HASHABLE
		redefine
			is_equal
		end;
	SHARED_WORKBENCH
		redefine
			is_equal
		end;
	COMPILER_EXPORTER
		redefine
			is_equal
		end

create

	make

feature

	pattern_id: INTEGER;
			-- Pattern unique identifier

	written_in: INTEGER;
			-- Id of the class where the pattern comes from

	pattern: PATTERN;
			-- Pattern

	make (i: INTEGER; p: PATTERN) is
			-- Initialization
		do
			written_in := i;
			pattern := p;
		end;

	set_written_in (i: INTEGER) is
			-- Assign `i' to `written_in'.
		do
			written_in := i;
		end;

	set_pattern (p: PATTERN) is
			-- Assign `p' to `pattern'.
		do
			pattern := p;
		end;

	set_pattern_id (i: INTEGER) is
			-- Assign `i' to `pattern_id'.
		do
			pattern_id := i;
		end;

	is_equal (other: PATTERN_INFO): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result :=
				written_in = other.written_in
				and then pattern.is_equal (other.pattern);
		end;

	hash_code: INTEGER is
			-- Hash code
		do
			Result := written_in.bit_xor (pattern.hash_code)
		end;

	associated_class: CLASS_C is
			-- Associated class to the current pattern information
		do
			Result := System.class_of_id (written_in);
		end;

	instantiation_in (type: CLASS_TYPE): PATTERN is
			-- Instantiation of `pattern' in the context of `type'.
		require
			good_argument: type /= Void
			consistency1: type.associated_class.conform_to (associated_class)
			pattern_valid: pattern.is_valid (associated_class)
		do
			Result := pattern
			Result := Result.instantiation_in (associated_class.meta_type (type))
		ensure
			result_not_void: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end

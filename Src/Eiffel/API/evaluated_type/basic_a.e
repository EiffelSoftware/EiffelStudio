indexing
	description: "Actual type for simple types."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

deferred class
	BASIC_A

inherit
	CL_TYPE_A
		undefine
			type_i
		redefine
			feature_type, instantiation_in, instantiation_of,
			meta_type, is_basic,
			good_generics, is_valid, error_generics
		end

feature -- Access

	is_basic: BOOLEAN is True
			-- Is the current actual type a basic one ?

	is_valid: BOOLEAN is
			-- The associated class is still in the system
		do
			Result := True
		end

feature {COMPILER_EXPORTER}

	feature_type (f: FEATURE_I): TYPE_A is
			-- Type of the feature `f' in the context of Current
		do
			Result ?= f.type
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): TYPE_A is
			-- Instantiated type in the context of `type'
		do
			Result := Current
		end

	instantiation_of (type: TYPE_A; a_class_id: INTEGER): TYPE_A is
			-- Insatiation of `type' in s simple type
		do
			Result := type.actual_type
		end

	meta_type: BASIC_I is
			-- Associated meta type
		do
			Result := type_i
		end

	type_i: BASIC_I is
			-- Instantiated type.
			--| Return type is redefined that's why we need
			--| this declaration.
		deferred
		end

	good_generics: BOOLEAN is
			-- Has the current type the right number of generic types ?
		do
			Result := True
		end

	error_generics: VTUG is
		do
		end

invariant
	is_basic: is_basic
	is_expanded: is_expanded

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

end -- class BASIC_A

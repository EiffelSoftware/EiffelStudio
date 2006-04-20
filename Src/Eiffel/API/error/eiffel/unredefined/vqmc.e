indexing
	description: "Error on type of a constant feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class VQMC

inherit
	EIFFEL_ERROR
		redefine
			build_explain
		end

	SHARED_TYPES
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

feature -- Properties

	feature_name: STRING
			-- Constant name
			-- [Note that the class id where the constant is written is
			-- `class_id'.]

	code: STRING is "VQMC"
			-- Error code

	constant_type: TYPE_A
			-- Type of constant as defined.

	expected_type: TYPE_A
			-- Type of declaration of constant.

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
			a_text_formatter.add ("Constant name: ")
			a_text_formatter.add (feature_name)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Found constant of type: ")
			constant_type.append_to (a_text_formatter)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Declared type: ")
			expected_type.append_to (a_text_formatter)
			a_text_formatter.add_new_line
		end

feature {COMPILER_EXPORTER} -- Setting

	set_feature_name (i: STRING) is
			-- Assign `i' to `feature_name'.
		do
			feature_name := i
		end

	set_constant_type (a_const: VALUE_I) is
			-- Assign proper type to `constant_type'
		require
			a_const_not_void: a_const /= Void
		local
			bit_value: BIT_VALUE_I
			l_int: INTEGER_CONSTANT
		do
			if a_const.is_bit then
				bit_value ?= a_const
				create {BITS_A} constant_type.make (bit_value.bit_count)
			elseif a_const.is_boolean then
				constant_type := Boolean_type
			elseif a_const.is_character then
				constant_type := Character_type
			elseif a_const.is_real_64 or a_const.is_real_32 then
				constant_type := Real_64_type
			elseif a_const.is_integer then
				l_int ?= a_const
				check
					l_int /= Void
				end
				constant_type := l_int.manifest_type
			elseif a_const.is_string then
				create {CL_TYPE_A} constant_type.make (System.string_id)
			else
				check
					not_reached: False
				end
			end
		ensure
			constant_type_set: constant_type /= Void
		end

	set_expected_type (t: TYPE_A) is
			-- Assign `t' to `expected_type'.
		require
			t_not_void: t /= Void
		do
			expected_type := t
		ensure
			expected_type_set: expected_type = t
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

end -- class VQMC

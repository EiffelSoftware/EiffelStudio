indexing
	description: "Objects that represents data from compiler..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_DATA_FROM_COMPILER

inherit
	SHARED_EIFFEL_PROJECT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		local
			sys: SYSTEM_I
			cl_i: CLASS_I
		do
			sys := Eiffel_system.system
			cl_i := sys.any_class
			if cl_i /= Void then
				any_class_c := cl_i.compiled_class
			end

			cl_i := sys.routine_class
			if cl_i /= Void then
				routine_class_c := cl_i.compiled_class
			end

			cl_i := sys.tuple_class
			if cl_i /= Void then
				tuple_class_c := cl_i.compiled_class
			end

			cl_i := sys.string_8_class
			if cl_i /= Void then
				string_8_class_c := cl_i.compiled_class
			end

			cl_i := sys.string_32_class
			if cl_i /= Void then
				string_32_class_c := cl_i.compiled_class
			end


			cl_i := sys.natural_8_class
			if cl_i /= Void then
				natural_8_class_c := cl_i.compiled_class
			end

			cl_i := sys.natural_16_class
			if cl_i /= Void then
				natural_16_class_c := cl_i.compiled_class
			end

			cl_i := sys.natural_32_class
			if cl_i /= Void then
				natural_32_class_c := cl_i.compiled_class
			end

			cl_i := sys.natural_64_class
			if cl_i /= Void then
				natural_64_class_c := cl_i.compiled_class
			end

			cl_i := sys.Integer_8_class
			if cl_i /= Void then
				integer_8_class_c := cl_i.compiled_class
			end

			cl_i := sys.Integer_16_class
			if cl_i /= Void then
				integer_16_class_c := cl_i.compiled_class
			end

			cl_i := sys.Integer_32_class
			if cl_i /= Void then
				integer_32_class_c := cl_i.compiled_class
			end

			cl_i := sys.Integer_64_class
			if cl_i /= Void then
				integer_64_class_c := cl_i.compiled_class
			end

			cl_i := sys.Boolean_class
			if cl_i /= Void then
				boolean_class_c := cl_i.compiled_class
			end

			cl_i := sys.character_8_class
			if cl_i /= Void then
				character_8_class_c := cl_i.compiled_class
			end

			cl_i := sys.character_32_class
			if cl_i /= Void then
				character_32_class_c := cl_i.compiled_class
			end

			cl_i := sys.real_32_class
			if cl_i /= Void then
				real_32_class_c := cl_i.compiled_class
			end

			cl_i := sys.real_64_class
			if cl_i /= Void then
				real_64_class_c := cl_i.compiled_class
			end

			cl_i := sys.Pointer_class
			if cl_i /= Void then
				pointer_class_c := cl_i.compiled_class
			end

			cl_i := sys.Bit_class
			if cl_i /= Void then
				bit_class_c := cl_i.compiled_class
			end


			cl_i := sys.system_object_class
			if cl_i /= Void then
				system_object_class_c := cl_i.compiled_class
			end

			cl_i := sys.system_string_class
			if cl_i /= Void then
				system_string_class_c := cl_i.compiled_class
			end

			cl_i := sys.native_array_class
			if cl_i /= Void then
				native_array_class_c := cl_i.compiled_class
			end

		end

feature -- Access

	any_class_c: CLASS_C
	routine_class_c: CLASS_C
	tuple_class_c: CLASS_C
	string_8_class_c: CLASS_C
	string_32_class_c: CLASS_C
	natural_8_class_c: CLASS_C
	natural_16_class_c: CLASS_C
	natural_32_class_c: CLASS_C
	natural_64_class_c: CLASS_C
	integer_8_class_c: CLASS_C
	integer_16_class_c: CLASS_C
	integer_32_class_c: CLASS_C
	integer_64_class_c: CLASS_C
	boolean_class_c: CLASS_C
	character_8_class_c: CLASS_C
	character_32_class_c: CLASS_C
	real_32_class_c: CLASS_C
	real_64_class_c: CLASS_C
	pointer_class_c: CLASS_C
	bit_class_c: CLASS_C

feature -- IL Access

	system_object_class_c: CLASS_C
	system_string_class_c: CLASS_C;
	native_array_class_c: CLASS_C;

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

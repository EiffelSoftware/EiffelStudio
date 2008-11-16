indexing
	description: "Byte code for creating an instance of TYPE [X] type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TYPE_EXPR_B

inherit
	EXPR_B
		redefine
			register, set_register, analyze, generate,
			propagate, print_register, unanalyze,
			is_simple_expr, allocates_memory, is_constant_expression
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (v: like type_data) is
			-- Assign `v' to `type_data'.
		require
			v_not_void: v /= Void
		do
			type_data := v
		ensure
			type_data_set: type_data = v
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_type_expr_b (Current)
		end

feature -- Access

	type_data: GEN_TYPE_A
			-- Character value

	type: CL_TYPE_A is
			-- String type
		do
			if is_dotnet_type then
				Result := system_type_type
			else
				Result := type_data
			end
		end

	register: REGISTRABLE
			-- Where type object is kept to ensure it is GC safe

feature -- Properties

	is_dotnet_type: BOOLEAN
			-- Is current a manifest System.Type constant?

	used (r: REGISTRABLE): BOOLEAN is
			-- Register `r' is not used for type computation
		do
		end

	is_simple_expr: BOOLEAN is True
			-- A type expression is a simple expression

	is_constant_expression: BOOLEAN is True
			-- A type constant is constant.

	allocates_memory: BOOLEAN is True
			-- Current always allocates memory.

feature -- Settings

	set_register (r: REGISTRABLE) is
			-- Set `register' to `r'
		do
			register := r
		end

	set_is_dotnet_type (v: like is_dotnet_type) is
			-- Set `is_dotnet_type' with `v'.
		do
			is_dotnet_type := v
		ensure
			is_dotnet_type_set: is_dotnet_type = v
		end

feature -- Code analyzis

	propagate (r: REGISTRABLE) is
			-- Propagate `r'
		do
			if not context.propagated then
				if r = No_register and r.c_type.same_class_type (c_type) then
					register := r
					context.set_propagated
				end
			end
		end

	unanalyze is
			-- Undo analysis work.
		do
			register := Void
		end

	analyze is
			-- Analyze the type
		do
				-- We get a register to store the type because of the garbage
				-- collector: assume we write f("one", "two"), then the GC
				-- could be invoked while allocating "two" and move "one" right
				-- under the back of the C (without notifying it, how could I?).
			get_register
		end

feature -- C code generation

	generate is
			-- Generate the type
		local
			buf: GENERATION_BUFFER
			l_type_creator: CREATE_INFO
		do
			fixme ("Instance should be unique.")
			buf := buffer
			l_type_creator := context.real_type (type_data).create_info
			l_type_creator.generate_start (buf)
			l_type_creator.generate_gen_type_conversion (0)
			buf.put_new_line
			register.print_register
			buf.put_string (" = ")
			l_type_creator.generate
			buf.put_character (';')
			l_type_creator.generate_end (buf)
		end

	print_register is
			-- Print the type (or the register in which it is held)
		do
			register.print_register
		end

feature {NONE} -- Implementation: types

	system_type_type: CL_TYPE_A is
			-- Type of SYSTEM_TYPE.
		require
			il_generation: System.il_generation
		once
			create Result.make (System.system_type_id)
		ensure
			system_type_type_not_void: Result /= Void
		end

invariant
	type_data_not_void: type_data /= Void
	type_data_generics_count: type_data.generics.count = 1

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

indexing
	description: "Creation with an hardwired dynamic type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CREATE_TYPE

inherit
	CREATE_INFO
		redefine
			created_in, generate, generate_cid, is_explicit
		end

create
	make

feature	{NONE} -- Initialization

	make (t: like type) is
			-- Assign `t' to `type'.
		require
			t_not_void: t /= Void
		do
			type := t
		ensure
			type_set: type = t
		end

feature -- Access

	type: TYPE_I
			-- Type to create

feature -- C code generation

	analyze is
			-- Analyze of generated code.
		do
			if is_generic then
					-- We always need current object when it
					-- is generic.
				context.mark_current_used
				context.add_dftype_current
			end
		end

	generate_type_id (buffer: GENERATION_BUFFER; final_mode: BOOLEAN) is
			-- Generate creation type id.
		local
			cl_type_i : CL_TYPE_I
			gen_type_i: GEN_TYPE_I
		do
			cl_type_i ?= context.creation_type (type)
			gen_type_i ?= cl_type_i
			if gen_type_i /= Void then
				buffer.put_string ("typres")
			else
				if final_mode then
					buffer.put_type_id (cl_type_i.type_id)
				else
					buffer.put_string ("RTUD(")
					buffer.put_static_type_id (cl_type_i.associated_class_type.static_type_id)
					buffer.put_character (')')
				end
			end
		end

	generate is
			-- Generate creation type.
		local
			l_buffer: GENERATION_BUFFER
			l_final_mode: BOOLEAN
			l_cl_type: CL_TYPE_I
			l_tuple_type: TUPLE_TYPE_I
			l_is_tuple: BOOLEAN
		do

			l_buffer := context.buffer
			l_final_mode := not context.workbench_mode
			l_cl_type := type_to_create
			l_tuple_type ?= l_cl_type
			l_is_tuple := l_tuple_type /= Void

			if l_final_mode and not l_is_tuple then
				l_buffer.put_string ("RTLNS(")
				generate_type_id (l_buffer, l_final_mode)
				l_buffer.put_string (", ")
				l_buffer.put_type_id (l_cl_type.type_id)
				l_buffer.put_string (", ")
				l_cl_type.associated_class_type.skeleton.generate_size (l_buffer)
			else
				if l_is_tuple then
					l_buffer.put_string ("RTLNTS(")
				else
					l_buffer.put_string ("RTLN(")
				end
				generate_type_id (l_buffer, l_final_mode)
			end
			if l_is_tuple then
					-- Add `count' parameter and if it is full of basic types.
				check
					l_tuple_type_not_void: l_tuple_type /= Void
				end
				l_buffer.put_string (", ")
					-- We add `+1' so that we do not need to do `i - 1' each time
					-- we want to access a tuple item in TUPLE class.
				l_buffer.put_integer (l_tuple_type.true_generics.count + 1)
				l_buffer.put_string (", ")
				if l_tuple_type.is_basic_uniform then
					l_buffer.put_integer (1)
				else
					l_buffer.put_integer (0)
				end
			end
			l_buffer.put_character (')')
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for a hardcoded creation type.
		local
			cl_type_i: CL_TYPE_I
			gen_type_i: GEN_TYPE_I
			local_index: INTEGER
		do
			cl_type_i ?= context.creation_type (type)
			check
				cl_type_i_not_void: cl_type_i /= Void
			end
			if cl_type_i.is_expanded and then cl_type_i.is_external then
					-- Load a default value of a local variable.
				context.add_local (cl_type_i)
				local_index := context.local_list.count
				il_generator.put_dummy_local_info (cl_type_i, local_index)
				il_generator.generate_local (local_index)
			else
					-- Create object using default constructor.
				il_generator.create_object (cl_type_i.implementation_id)
			end
			gen_type_i ?= cl_type_i
			if gen_type_i /= Void then
				if cl_type_i.is_expanded then
						-- Box expanded object.
					il_generator.generate_metamorphose (cl_type_i)
				end
				il_generator.duplicate_top
				gen_type_i.generate_gen_type_il (il_generator, True)
				il_generator.assign_computed_type
				if cl_type_i.is_expanded then
						-- Load value of a value type object.
					il_generator.generate_unmetamorphose (cl_type_i)
				end
			end
		end

	generate_il_type is
			-- Generate IL code to load type.
		local
			cl_type_i: CL_TYPE_I
		do
			cl_type_i ?= context.creation_type (type)
			cl_type_i.generate_gen_type_il (il_generator, True)
		end

	created_in (other: CLASS_TYPE): TYPE_I is
			-- Resulting type of Current as if it was used to create object in `other'
		do
			Result := type
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a hardcoded creation type
		local
			cl_type_i: CL_TYPE_I
			gen_type : GEN_TYPE_I
		do
			ba.append (Bc_ctype)
			cl_type_i ?= context.creation_type (type)
			gen_type  ?= cl_type_i
			ba.append_short_integer (cl_type_i.type_id - 1)

			if gen_type /= Void then
				ba.append_short_integer (context.current_type.generated_id (False))
				gen_type.make_gen_type_byte_code (ba, True)
			end

			ba.append_short_integer (-1)
		end

feature -- Generic conformance

	is_explicit: BOOLEAN is
			-- Is Current type fixed at compile time?
		do
			Result := type.is_explicit
		end

	generate_gen_type_conversion (node : BYTE_NODE) is

		local
			gen_type : GEN_TYPE_I
		do
			gen_type ?= context.creation_type (type)

			if gen_type /= Void then
				node.generate_gen_type_conversion (gen_type)
			end
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode : BOOLEAN) is
			-- Generate creation type.
		do
			generate_type_id (buffer, final_mode)
			buffer.put_character (',')
		end

	type_to_create : CL_TYPE_I is
		do
			Result ?= context.creation_type (type)
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

end -- class CREATE_TYPE

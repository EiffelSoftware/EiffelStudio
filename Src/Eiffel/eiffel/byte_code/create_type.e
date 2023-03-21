note
	description: "Creation with an hardwired dynamic type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CREATE_TYPE

inherit
	CREATE_INFO
		redefine
			generate, generate_cid, is_explicit, make_byte_code
		end

create
	make

feature	{NONE} -- Initialization

	make (t: like type)
			-- Assign `t' to `type'.
		require
			t_not_void: t /= Void
			t_not_is_like: not t.is_like
		do
			type := t
		ensure
			type_set: type = t
		end

feature -- Access

	type: TYPE_A
			-- Type to create

feature -- Update

	updated_info: CREATE_TYPE
			-- <Precursor>
		local
			l_type: TYPE_A
		do
			l_type := context.descendant_type (type)
			if l_type /= type then
				if attached {CREATE_TYPE} l_type.create_info as l_info then
					Result := l_info
				else
					check should_not_happen: False end
					create {CREATE_TYPE} Result.make (l_type)
				end
			else
				Result := Current
			end
		end

feature -- C code generation

	analyze
			-- Analyze of generated code.
		do
			if is_generic then
					-- We always need current object when it
					-- is generic.
				context.mark_current_used
				context.add_dftype_current
			end
		end

	generate_type (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; a_level: NATURAL)
			-- Generate creation type id.
		do
			if attached {GEN_TYPE_A} type then
				buffer.put_string ("typres")
				buffer.put_natural_32 (a_level)
			else
				buffer.put_string ("eif_new_type(")
				buffer.put_integer (type.generated_id (final_mode, context.context_class_type.type))
				buffer.put_two_character (',', ' ')
					-- Discard the upper bits as `eif_new_type' only accepts the lower part.
				buffer.put_hex_natural_16 (type.annotation_flags & 0x00FF)
				buffer.put_character (')')
			end
		end

	generate
			-- Generate creation type.
		local
			l_buffer: GENERATION_BUFFER
			l_final_mode: BOOLEAN
			l_cl_type: CL_TYPE_A
			l_tuple_type: TUPLE_TYPE_A
			l_is_tuple: BOOLEAN
		do

			l_buffer := context.buffer
			l_final_mode := not context.workbench_mode
			l_cl_type := type_to_create
			l_tuple_type := {TUPLE_TYPE_A} / l_cl_type
			l_is_tuple := l_tuple_type /= Void

			if l_final_mode and not l_is_tuple then
				l_buffer.put_string ("RTLNS(")
				generate_type_id (l_buffer, l_final_mode, 0)
				l_buffer.put_string (", ")
				l_buffer.put_type_id (l_cl_type.type_id (context.context_class_type.type))
				l_buffer.put_string (", ")
				l_cl_type.associated_class_type (context.context_class_type.type).skeleton.generate_size (l_buffer, True)
			else
				if l_is_tuple then
					l_buffer.put_string ("RTLNTS(")
				else
					l_buffer.put_string ("RTLN(")
				end
				generate_type_id (l_buffer, l_final_mode, 0)
			end
			if l_is_tuple then
					-- Add `count' parameter and if it is full of basic types.
				check
					l_tuple_type_not_void: l_tuple_type /= Void
				end
				l_buffer.put_string (", ")
					-- We add `+1' so that we do not need to do `i - 1' each time
					-- we want to access a tuple item in TUPLE class.
				l_buffer.put_integer (l_tuple_type.generics.count + 1)
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

	generate_il
			-- Generate IL code for a hardcoded creation type.
		do
			il_generator.generate_creation (type)
			if type.is_expanded then
					-- Load value of a boxed value type object.
				il_generator.generate_unmetamorphose (type)
			end
		end

	generate_il_type
			-- Generate IL code to load type.
		do
			type.generate_gen_type_il (il_generator, True)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY)
			-- Generate byte code for a hardcoded creation type
		local
			t: CL_TYPE_A
		do
			t := context.context_class_type.type
			check has_associated_class_type: type.has_associated_class_type (t) end
			type.make_type_byte_code (ba, True, t)
		end

feature -- Generic conformance

	is_explicit: BOOLEAN
			-- Is Current type fixed at compile time?
		do
			Result := type.is_explicit
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode : BOOLEAN)
			-- Generate creation type.
		do
				-- If we are here, it means that it is known that the type cannot have
				-- sublevel, thus the value of `0'. This is usually the case when describing
				-- an attribute type in eskelet.c
			generate_type_id (buffer, final_mode, 0)
			buffer.put_character (',')
		end

	type_to_create : detachable CL_TYPE_A
		do
			Result := {like type_to_create} / type
		end

invariant
	type_not_void: type /= Void

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

end -- class CREATE_TYPE

indexing
	description: "Creation type like an argument."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_ARG

inherit
	CREATE_INFO
		redefine
			created_in, generate_cid, make_type_byte_code,
			generate_cid_array, generate_cid_init
		end

	SHARED_GENERATION
		export
			{NONE} all
		end

feature -- Access

	position: INTEGER
			-- Position of the argument type to create in the argument
			-- list of the current treated feature

feature -- Settings

	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		do
			position := i
		end

feature -- C code generation

	analyze is
		do
			if is_generic then
				context.mark_current_used
				context.add_dftype_current
			elseif type_to_create = Void then
				context.mark_current_used
			end
		end

	generate_type_id (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; a_level: NATURAL) is
			-- Generate creation type. Take the dynamic type of the argument
			-- if possible, otherwise take its static type.
		do
			buffer.put_string ("RTCA(arg")
			buffer.put_integer (position)
			buffer.put_string (gc_comma)
			associated_create_info.generate_type_id (buffer, final_mode, a_level)
			buffer.put_character (')')
		end

feature -- IL code generation

	generate_il is
			-- Generate creation type. Take the dynamic type of the argument
			-- if possible, otherwise take its static type.
		do
			internal_generate_il (False)
		end

	generate_il_type is
			-- Generate IL code to load type of argument creation type.
			-- Take the dynamic type of the argument if possible,
			-- otherwise take its static type.
		do
			internal_generate_il (True)
		end

	created_in (other: CLASS_TYPE): TYPE_A is
			-- Resulting type of Current as if it was used to create object in `other'
		do
				-- Used to be `type_to_create.created_in' but I felt it was not really necessary.
			Result := type_to_create
		end

feature {NONE} -- IL code generation

	internal_generate_il (a_is_for_type: BOOLEAN) is
		local
			l_type: TYPE_A
			creation_label, end_label: IL_LABEL
			l_info: CREATE_INFO
		do
			l_type := argument_type
			l_info := associated_create_info

			creation_label := Il_label_factory.new_label
			end_label := Il_label_factory.new_label

			il_generator.generate_argument (position)
			il_generator.put_default_value (l_type)
			il_generator.generate_binary_operator ({IL_CONST}.il_eq, False)
			il_generator.branch_on_false (creation_label)

				-- Object is null, we are therefore creating an object of
				-- the declared type.
			if a_is_for_type then
				l_info.generate_il_type
			else
				l_info.generate_il
			end
			il_generator.branch_to (end_label)

			il_generator.mark_label (creation_label)

				-- Object is not null, so we put it on top of stack and call
				-- the runtime feature that knows how to create an object
				-- of the same type as another object.
			il_generator.generate_argument (position)
			if a_is_for_type then
				il_generator.load_type
			else
				il_generator.create_like_object
			end

			il_generator.mark_label (end_label)

			if not a_is_for_type then
				il_generator.generate_check_cast (Void, context.real_type (l_type))
			end
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an argument anchored type.
		do
			ba.append (Bc_carg)
			associated_create_info.make_byte_code (ba)
			ba.append_short_integer (position)
		end

feature -- Generic conformance

	generate_cid (buffer: GENERATION_BUFFER; final_mode : BOOLEAN) is
		do
				-- If we are here, it means that it is known that the type cannot have
				-- sublevel, thus the value of `0'. This is usually the case when describing
				-- an attribute type in eskelet.c
			generate_type_id (buffer, final_mode, 0)
			buffer.put_character (',')
		end

	make_type_byte_code (ba : BYTE_ARRAY) is

		do
			ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.like_arg_type)
			ba.append_short_integer (position)
			associated_create_info.make_byte_code (ba)
		end

	generate_cid_array (buffer : GENERATION_BUFFER;
						final_mode : BOOLEAN; idx_cnt : COUNTER) is
		local
			dummy : INTEGER
		do
			buffer.put_string ("0,")
			dummy := idx_cnt.next
		end

	generate_cid_init (buffer : GENERATION_BUFFER; final_mode : BOOLEAN; idx_cnt : COUNTER; a_level: NATURAL) is
		local
			dummy : INTEGER
		do
			generate_start (buffer)
			generate_gen_type_conversion (a_level + 1)
			buffer.put_new_line
			buffer.put_string ("typarr")
			buffer.put_natural_32 (a_level)
			buffer.put_character ('[')
			buffer.put_integer (idx_cnt.value)
			buffer.put_four_character (']', ' ', '=', ' ')
			generate_type_id (buffer, final_mode, a_level + 1)
			buffer.put_character (';')
			generate_end (buffer)
			dummy := idx_cnt.next
		end

feature -- Type information

	type_to_create : CL_TYPE_A is
		do
			Result ?= argument_type
		end

	argument_type: TYPE_A is
			-- Type of argument as declared.
		do
			Result := context.creation_type (context.byte_code.arguments.item (position))
		ensure
			argument_type_not_void: Result /= Void
		end

	associated_create_info: CREATE_INFO is
		local
			l_type: TYPE_A
			l_formal: FORMAL_A
		do
			l_type := context.creation_type (argument_type)
			if l_type.is_like then
				if l_type.is_like_current then
					create {CREATE_CURRENT} Result
				else
					Result := l_type.create_info
				end
			elseif l_type.is_formal then
				l_formal ?= l_type
				check
					l_formal_not_void: l_formal /= Void
				end
				create {CREATE_FORMAL_TYPE} Result.make (l_formal)
			else
				create {CREATE_TYPE} Result.make (l_type)
			end
		ensure
			refined_create_info_not_void: Result /= Void
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

end -- class CREATE_ARG

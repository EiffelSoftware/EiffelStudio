note
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
			generate_cid, make_type_byte_code,
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

	set_position (i: INTEGER)
			-- Assign `i' to `position'.
		do
			position := i
		end

feature -- Update

	updated_info: CREATE_INFO
			-- <Precursor>
		do
				-- Nothing to be done as the position of the like argument will never change. The type
				-- we get via `context.byte_code.arguments.item (position)' is always the proper type
				-- for the context in which we generate the code, so no need to update it either.
			Result := Current
		end

feature -- C code generation

	analyze
		local
			argument_node: ARGUMENT_BL
		do
			associated_create_info.analyze
				-- Make sure the argument is GC-protected.
				-- Otherwise it can be collected or moved before type information is retrieved.
				-- See eweasel test#exec347 ("TEST1.h").
			create argument_node
			argument_node.set_position (position)
			argument_node.analyze
		end

	generate_type (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; a_level: NATURAL)
			-- Generate creation type. Take the dynamic type of the argument
			-- if possible, otherwise take its static type.
		do
			buffer.put_string ("RTCA(arg")
			buffer.put_integer (position)
			buffer.put_string ({C_CONST}.comma_space)
			associated_create_info.generate_type (buffer, final_mode, a_level)
			buffer.put_character (')')
		end

feature -- IL code generation

	generate_il
			-- Generate creation type. Take the dynamic type of the argument
			-- if possible, otherwise take its static type.
		do
			internal_generate_il (False)
		end

	generate_il_type
			-- Generate IL code to load type of argument creation type.
			-- Take the dynamic type of the argument if possible,
			-- otherwise take its static type.
		do
			internal_generate_il (True)
		end

feature {NONE} -- IL code generation

	internal_generate_il (a_is_for_type: BOOLEAN)
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
				il_generator.generate_check_cast (Void, l_type)
			end
		end

feature -- Generic conformance

	generate_cid (buffer: GENERATION_BUFFER; final_mode : BOOLEAN)
		do
				-- If we are here, it means that it is known that the type cannot have
				-- sublevel, thus the value of `0'. This is usually the case when describing
				-- an attribute type in eskelet.c
			generate_type_annotations (buffer, final_mode, 0)
			buffer.put_character (',')
			generate_type_id (buffer, final_mode, 0)
			buffer.put_character (',')
		end

	make_type_byte_code (ba : BYTE_ARRAY)

		do
			ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.like_arg_type)
			ba.append_short_integer (position)
			argument_type.make_type_byte_code (ba, True, context.context_class_type.type)
		end

	generate_cid_array (buffer : GENERATION_BUFFER;
						final_mode : BOOLEAN; idx_cnt : COUNTER)
		local
			dummy : INTEGER
		do
				-- Placeholder for annotations and id.
			buffer.put_string ("0,0,")
			dummy := idx_cnt.next
			dummy := idx_cnt.next
		end

	generate_cid_init (buffer : GENERATION_BUFFER; final_mode : BOOLEAN; idx_cnt : COUNTER; a_level: NATURAL)
		do
			generate_entry_inititalization (buffer, final_mode, idx_cnt, a_level)
		end

feature -- Type information

	type_to_create : CL_TYPE_A
		do
			Result ?= argument_type
		end

	argument_type: TYPE_A
			-- Type of argument as declared.
		do
			Result := context.byte_code.arguments.item (position)
		ensure
			argument_type_not_void: Result /= Void
		end

	associated_create_info: CREATE_INFO
		local
			l_type: TYPE_A
		do
			l_type := argument_type
			if l_type.is_like then
				Result := l_type.create_info
			elseif attached {FORMAL_A} l_type as l_formal then
				create {CREATE_FORMAL_TYPE} Result.make (l_formal)
			else
				create {CREATE_TYPE} Result.make (l_type)
			end
		ensure
			refined_create_info_not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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

end -- class CREATE_ARG

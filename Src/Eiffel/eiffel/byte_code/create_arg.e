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
			created_in, generate_cid, make_gen_type_byte_code,
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
			elseif is_formal then
				context.mark_current_used
			end
		end

	generate_type_id (buffer: GENERATION_BUFFER; final_mode: BOOLEAN) is
			-- Generate creation type. Take the dynamic type of the argument
			-- if possible, otherwise take its static type.
		local
			cl_type_i: CL_TYPE_I
			gen_type_i: GEN_TYPE_I
		do
			cl_type_i := type_to_create
			gen_type_i ?= cl_type_i
			buffer.put_string ("RTCA(arg")
			buffer.put_integer (position)
			buffer.put_string (gc_comma)

			if gen_type_i /= Void then
				buffer.put_string ("typres")
			elseif is_formal then
				create_formal_type.generate_type_id (buffer, final_mode)
			else
				if context.workbench_mode then
					buffer.put_string ("RTUD(")
					buffer.put_static_type_id (cl_type_i.associated_class_type.static_type_id)
					buffer.put_character (')')
				else
					buffer.put_type_id (cl_type_i.type_id)
				end
			end
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

	created_in (other: CLASS_TYPE): TYPE_I is
			-- Resulting type of Current as if it was used to create object in `other'
		do
			Result := type_to_create.created_in (other)
		end

feature {NONE} -- IL code generation

	internal_generate_il (a_is_for_type: BOOLEAN) is
		local
			l_type: TYPE_I
			creation_label, end_label: IL_LABEL
			l_is_formal: BOOLEAN
			l_formal_info: CREATE_FORMAL_TYPE
		do
			l_is_formal := is_formal
			if l_is_formal then
				l_formal_info := create_formal_type
				l_type := l_formal_info.type
			else
				l_type := type_to_create
			end
			creation_label := Il_label_factory.new_label
			end_label := Il_label_factory.new_label

			il_generator.generate_argument (position)
			il_generator.put_default_value (l_type)
			il_generator.generate_binary_operator ({IL_CONST}.il_eq, False)
			il_generator.branch_on_false (creation_label)

				-- Object is null, we are therefore creating an object of
				-- the declared type.
			if a_is_for_type then
				if l_is_formal then
					l_formal_info.generate_il_type
				else
					(create {CREATE_TYPE}.make (l_type)).generate_il_type
				end
			else
				if l_is_formal then
					l_formal_info.generate_il
				else
					(create {CREATE_TYPE}.make (l_type)).generate_il
				end
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

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an argument anchored type.
		do
			ba.append (Bc_carg)
			if is_formal then
				create_formal_type.make_byte_code (ba)
			else
				ba.append ('%U')
					-- Default creation type
				type_to_create.make_full_type_byte_code (ba)
			end
				-- Argument position
			ba.append_short_integer (position)
		end

feature -- Generic conformance

	generate_gen_type_conversion is

		local
			gen_type : GEN_TYPE_I
		do
			gen_type ?= type_to_create

			if gen_type /= Void then
				context.generate_gen_type_conversion (gen_type)
			end
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode : BOOLEAN) is

		do
			buffer.put_string ("RTCA(arg")
			buffer.put_integer (position)
			buffer.put_character (',')
			buffer.put_hex_natural_16 ({SHARED_GEN_CONF_LEVEL}.none_type)
			buffer.put_character (')')
			buffer.put_character (',')
		end

	make_gen_type_byte_code (ba : BYTE_ARRAY) is

		do
			ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.like_arg_type)
			ba.append_short_integer (position)
		end

	generate_cid_array (buffer : GENERATION_BUFFER;
						final_mode : BOOLEAN; idx_cnt : COUNTER) is
		local
			dummy : INTEGER
		do
			buffer.put_string ("0,")
			dummy := idx_cnt.next
		end

	generate_cid_init (buffer : GENERATION_BUFFER;
					   final_mode : BOOLEAN; idx_cnt : COUNTER) is
		local
			dummy : INTEGER
		do
			buffer.put_new_line
			buffer.put_string ("typarr[")
			buffer.put_integer (idx_cnt.value)
			buffer.put_string ("] = RTID(RTCA(arg")
			buffer.put_integer (position)
			buffer.put_character (',')
			buffer.put_hex_natural_16 ({SHARED_GEN_CONF_LEVEL}.none_type)
			buffer.put_string ("));")
			dummy := idx_cnt.next
		end

	type_to_create : CL_TYPE_I is
		local
			type_i : TYPE_I
		do
			type_i := context.byte_code.arguments.item (position)
			Result ?= context.creation_type (type_i)
		end

	is_formal: BOOLEAN is
		local
			l_formal: FORMAL_I
		do
			l_formal ?= context.creation_type (context.byte_code.arguments.item (position))
			Result := l_formal /= Void
		end

	create_formal_type: CREATE_FORMAL_TYPE is
		require
			is_formal: is_formal
		local
			l_formal: FORMAL_I
		do
			l_formal ?= context.creation_type (context.byte_code.arguments.item (position))
			create Result.make (l_formal)
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

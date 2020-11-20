note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class OPT_FEAT_BL

inherit

	OPT_FEAT_B
		rename
			make as make_opt_feat
		undefine
			is_polymorphic, is_temporary, free_register,
			has_one_signature,
			generate_on, basic_register, generate_access,
			register, analyze_on, set_register,
			is_feature_call, generate_special_feature, set_parent,
			generate_parameters,
			generate_parameters_list, generate_access_on_type,
			call_kind, set_call_kind,
			return_c_type
		redefine
			parent, is_feature_special, generate_end,
			generate_metamorphose_end, analyze
		end

	FEATURE_BL
		undefine
			enlarged, inlined_byte_code
		redefine
			fill_from, parent, check_dt_current, is_feature_special,
			generate_end, generate_metamorphose_end, analyze
		select
			make_node
		end

feature

	parent: NESTED_BL

	fill_from (f: OPT_FEAT_B)
		do
			multi_constraint_static := f.multi_constraint_static
			type := f.type
			routine_id := f.routine_id
			set_parameters (f.parameters)
			array_desc := f.array_desc.enlarged
			is_item := f.is_item
			access_area := f.access_area
			precursor_type := f.precursor_type
			enlarge_parameters
		end

	analyze
		do
			array_desc.analyze
			analyze_on (Current_register)
			get_register
		end

feature -- Code generation

	check_dt_current (reg: REGISTRABLE)
		do
		end;

	is_feature_special (compilation_type: BOOLEAN; target_type: BASIC_A): BOOLEAN
		do
		end

	external_reg_name (id: INTEGER): STRING
			-- Register name which will be effectively generated at the C level.
		do
			create Result.make (0)
			if id = 0 then
				Result.append ("tmp_result")
			elseif id < 0 then
					-- local
				Result.append ("loc")
				Result.append_integer (-id)
			else
					-- Argument
				Result.append ("arg")
				Result.append_integer (id)
			end
		end

	internal_reg_name (id: INTEGER): STRING
			-- Same as `external_reg_name' except that for a function returning a
			-- result we need to return `Result' and not `tmp_result' because the
			-- hash_code is based on `Result'.
		do
			create Result.make (0)
			if id = 0 then
				Result.append ("Result")
			elseif id < 0 then
					-- local
				Result.append ("loc")
				Result.append_integer (-id)
			else
					-- Argument
				Result.append ("arg")
				Result.append_integer (id)
			end
		end

	register_acces (buf: GENERATION_BUFFER; id: INTEGER)
		do
			if context.byte_code.is_process_or_thread_relative_once and then id = 0 then
				buf.put_string ("Result")
			else
				buf.put_string (internal_reg_name (id))
			end
		end

	type_c (id: INTEGER): TYPE_C
		do
			Result := System.remover.array_optimizer.array_item_type (id)
		end

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_A)
		local
			id: INTEGER
			buf: GENERATION_BUFFER
		do
			buf := buffer
			if is_item then
				if access_area then
					buf.put_string ("RTAA(")
				else
					buf.put_string ("RTAUA(")
				end
			else
				if access_area then
					buf.put_string ("RTAP(")
				else
					buf.put_string ("RTAUP(")
				end
			end
			id := array_desc.array_descriptor
			type_c (id).generate (buf)
			buf.put_string ({C_CONST}.comma_space)
			buf.put_string (external_reg_name (id))
			buf.put_string ({C_CONST}.comma_space)
			if not access_area then
				register_acces (buf, id)
				buf.put_string ({C_CONST}.comma_space)
			end
			parameters [1].print_register
			if not is_item then
				buf.put_string ({C_CONST}.comma_space)
					-- Index
				parameters [2].print_register
			end
			buf.put_character (')')
		end

	generate_metamorphose_end (gen_reg, meta_reg: REGISTRABLE; class_type: CL_TYPE_A;
		basic_type: BASIC_A; buf: GENERATION_BUFFER)
			-- Generate final portion of C code.
		do
			generate_end (gen_reg, class_type)
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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

end

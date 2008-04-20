indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class OPT_FEAT_BL

inherit

	OPT_FEAT_B
		rename
			make as make_opt_feat
		undefine
			is_polymorphic, free_register, has_call,
			allocates_memory, has_one_signature,
			generate_on, basic_register, generate_access,
			register, analyze_on, set_register,
			is_feature_call, generate_special_feature, set_parent,
			generate_parameters_list, generate_access_on_type,
			need_invariant, set_need_invariant
		redefine
			parent, is_feature_special, generate_end,
			generate_metamorphose_end, analyze
		end;

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

	parent: NESTED_BL;

	fill_from (f: OPT_FEAT_B) is
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

	analyze is
		do
			array_desc.analyze
			analyze_on (Current_register)
			get_register
		end;

feature -- Code generation

	check_dt_current (reg: REGISTRABLE) is
		do
		end;

	is_feature_special (compilation_type: BOOLEAN; target_type: BASIC_A): BOOLEAN is
		do
		end;

	external_reg_name (id: INTEGER): STRING is
			-- Register name which will be effectively generated at the C level.
		do
			create Result.make (0);
			if id = 0 then
				Result.append ("tmp_result");
			elseif id < 0 then
					-- local
				Result.append ("loc");
				Result.append_integer (-id);
			else
					-- Argument
				Result.append ("arg");
				Result.append_integer (id);
			end
		end

	internal_reg_name (id: INTEGER): STRING is
			-- Same as `external_reg_name' except that for a function returning a
			-- result we need to return `Result' and not `tmp_result' because the
			-- hash_code is based on `Result'.
		do
			create Result.make (0);
			if id = 0 then
				Result.append ("Result");
			elseif id < 0 then
					-- local
				Result.append ("loc");
				Result.append_integer (-id);
			else
					-- Argument
				Result.append ("arg");
				Result.append_integer (id);
			end
		end

	register_acces (buf: GENERATION_BUFFER; id: INTEGER) is
		do
			if context.byte_code.is_once and then id = 0 then
				buf.put_string ("Result")
			else
				buf.put_string (internal_reg_name (id));
			end
		end

	type_c (id: INTEGER): TYPE_C is
		do
			Result := System.remover.array_optimizer.array_item_type (id);
		end

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_A) is
		local
			expr: EXPR_B
			id: INTEGER;
			buf: GENERATION_BUFFER
		do
			buf := buffer
			id := array_desc.array_descriptor;
			if is_item then
				if access_area then
					buf.put_string ("RTAA(");
				else
					buf.put_string ("RTAUA(");
				end;
			else
				if access_area then
					buf.put_string ("RTAP(");
				else
					buf.put_string ("RTAUP(");
				end;
			end;
			type_c (id).generate (buf)
			buf.put_string (gc_comma);
			buf.put_string (external_reg_name (id));
			buf.put_string (gc_comma);
			if not access_area then
				register_acces (buf, id);
				buf.put_string (gc_comma);
			end;

			expr := parameters @ 1;
			expr.print_register

			if not is_item then
				buf.put_string (gc_comma);
					-- Index
				expr := parameters @ 2
				expr.print_register
			end
			buf.put_character (')');
		end

	generate_metamorphose_end (gen_reg, meta_reg: REGISTRABLE; class_type: CL_TYPE_A;
		basic_type: BASIC_A; buf: GENERATION_BUFFER) is
			-- Generate final portion of C code.
		do
			generate_end (gen_reg, class_type)
		end
indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

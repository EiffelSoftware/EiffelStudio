indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Enlarge node for attribute access in workbench mode

class ATTRIBUTE_BW

inherit

	ATTRIBUTE_BL
		redefine
			check_dt_current, is_polymorphic, generate_access_on_type
		end

feature

	check_dt_current (reg: REGISTRABLE) is
			-- Check whether we need to compute the dynamic type of current
			-- and call context.add_dt_current accordingly. The parameter
			-- `reg' is the entity on which the access is made.
		local
			class_type: CL_TYPE_I
		do
				-- Do nothing if `reg' is not the current entity
			if reg.is_current then
				class_type ?= context_type;
				if class_type /= Void then
					context.add_dt_current;
				end;
			end;
		end;


	is_polymorphic: BOOLEAN is True;
			-- Is the attribute access polymorphic ?

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_I) is
			-- Generate attribute access in a `typ' context
		local
			is_nested: BOOLEAN;
			type_i: TYPE_i;
			type_c: TYPE_C;
			r_id: INTEGER;
			rout_info: ROUT_INFO;
			base_class: CLASS_C
			buf: GENERATION_BUFFER
		do
			buf := buffer
			is_nested := not is_first;
			type_i := real_type (type);
			type_c := type_i.c_type;
			if not type_i.is_true_expanded and then not type_c.is_bit then
					-- For dereferencing, we need a star...
				buf.put_character ('*');
					-- ...followed by the appropriate access cast
				type_c.generate_access_cast (buf);
			end;
			buf.put_character ('(');
			reg.print_register;
			if reg.is_predefined or reg.register /= No_register then
				buf.put_string (gc_plus);
			else
				buf.put_string (" +");
				buf.put_new_line;
				buf.indent;
			end;
			base_class := typ.base_class;
			if
				Compilation_modes.is_precompiling or else
				base_class.is_precompiled
			then
				if is_nested then
					buf.put_string ("RTVPA(");
				else
					buf.put_string ("RTWPA(");
				end;
				r_id := routine_id
				rout_info := System.rout_info_table.item (r_id);
				buf.put_class_id (rout_info.origin)
				buf.put_string (gc_comma);
				buf.put_integer (rout_info.offset)
			else
				if is_nested then
					buf.put_string ("RTVA(");
				else
					buf.put_string ("RTWA(");
				end;
				buf.put_static_type_id (typ.associated_class_type.static_type_id)
				buf.put_string (gc_comma);
				buf.put_integer (real_feature_id (typ.base_class));
			end;
			buf.put_string (gc_comma);
			if is_nested then
				buf.put_string_literal (attribute_name)
				buf.put_string (gc_comma);
				reg.print_register;
			else
				context.generate_current_dtype;
			end;
			buf.put_string ("))");
			if not (reg.is_predefined or reg.register /= No_register) then
			  buf.exdent;
			end;
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

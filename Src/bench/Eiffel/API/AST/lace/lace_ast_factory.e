indexing

	description: "Lace AST node factories"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class LACE_AST_FACTORY

feature -- Checking

	valid_identifier (st: STRING): BOOLEAN is
			-- Is `st' a valid identifer for Lace syntax.
		local
			i, nb: INTEGER
		do
			Result := st /= Void and then not st.is_empty
			if
				Result and then
				valid_first_identifier_character (st.item (1))
			then
				from
					nb := st.count
					i := 2
				until
					i > nb or not Result
				loop
					Result := valid_identifier_character (st.item (i))
					i := i + 1
				end
			end
		end

	valid_first_identifier_character (c: CHARACTER): BOOLEAN is
			-- Is `c' a good character as first character of a Lace identifier?
		do
			inspect
				c
			when 'a'..'z', 'A'..'Z' then
				Result := True
			else
			end
		end

	valid_identifier_character (c: CHARACTER): BOOLEAN is
			-- Is `c' a good character as first character of a Lace identifier?
		do
			inspect
				c
			when 'a'..'z', 'A'..'Z', '0'..'9', '_' then
				Result := True
			else
			end
		end

feature -- Access

	new_id_sd (s: STRING; is_str: BOOLEAN): ID_SD is
			-- New ID AST node
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			create Result.initialize (s)
			if is_str then
				Result.set_is_string
			end
		ensure
			id_sd_not_void: Result /= Void
		end

	new_clas_visi_sd (cn, vn: ID_SD; cr, er: LACE_LIST [ID_SD];
		r: LACE_LIST [TWO_NAME_SD]): CLAS_VISI_SD is
			-- New CLAS_VISI AST node
		require
			cn_not_void: cn /= Void
		do
			create Result.initialize (cn, vn, cr, er, r)
		ensure
			clas_visi_sd_not_void: Result /= Void
			class_name_set: Result.class_name = cn
			visible_name_set: Result.visible_name = vn
			creation_restriction_set: Result.creation_restriction = cr
			export_restriction_set: Result.export_restriction = er
			renamings_set: Result.renamings = r
		end

	new_file_name_sd (fn: ID_SD): FILE_NAME_SD is
			-- New EXCLUDE AST node
		require
			fn_not_void: fn /= Void
		do
			create Result.initialize (fn)
		ensure
			exclude_sd_not_void: Result /= Void
			file__name: Result.file__name = fn
		end

	new_special_option_sd (type_id: INTEGER; a_name: STRING; flag: BOOLEAN): D_OPTION_SD is
			-- Create new `D_OPTION_SD' node corresponding to a free
			-- option clause. If `a_name' Void then it is `free_option (flag)'.
		require
			valid_type_id: type_id > 0
			type_id_big_enough: type_id < {FREE_OPTION_SD}.free_option_count
		local
			argument_sd: FREE_OPTION_SD
			v: OPT_VAL_SD
		do
			create argument_sd.make (type_id)
			if a_name /= Void then
				create v.make (new_id_sd (a_name, True))
			else
				if flag then
					create v.make_yes
				else
					create v.make_no
				end
			end
			create Result.initialize (argument_sd, v)
		ensure
			result_not_void: Result /= Void
		end

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

end -- class LACE_AST_FACTORY


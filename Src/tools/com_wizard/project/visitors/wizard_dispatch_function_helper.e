indexing
	description: "Dispatch function helper."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_DISPATCH_FUNCTION_HELPER

inherit
	ECOM_FUNC_KIND
		export
			{NONE} all
		end

	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	ECOM_VAR_TYPE
		export
			{NONE} all
		end

	ECOM_PARAM_FLAGS
		export
			{NONE} all
		end

	ANY

feature -- Basic operations

	does_routine_have_result (func_desc: WIZARD_FUNCTION_DESCRIPTOR): BOOLEAN is
			-- Does routine have result?
		local
			cursor: CURSOR
		do
			if func_desc.func_kind = func_dispatch then
				Result := not func_desc.return_type.name.is_equal (Void_c_keyword) and
						func_desc.return_type.type /= Vt_hresult
			else
				if func_desc.argument_count > 0 then
					cursor := func_desc.arguments.cursor
					func_desc.arguments.go_i_th (func_desc.argument_count)
					Result := is_paramflag_fretval (func_desc.arguments.item.flags)
					func_desc.arguments.go_to (cursor)
				end
			end
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
end -- class WIZARD_DISPATCH_FUNCTION_HELPER



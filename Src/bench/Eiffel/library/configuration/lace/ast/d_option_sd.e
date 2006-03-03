indexing
	description: "Default option"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class D_OPTION_SD

inherit

	AST_LACE

create
	initialize

feature {NONE} -- Initialization

	initialize (o: like option; v: like value) is
			-- Create a new D_OPTION AST node.
		require
			o_not_void: o /= Void
		do
			option := o
			value := v
		ensure
			option_set: option = o
			value_set: value = v
		end

feature -- Properties

	option: OPTION_SD
			-- Option name

	value: OPT_VAL_SD
			-- option value

feature -- Status report

	is_optional: BOOLEAN is
			-- Is Current an instance of `O_OPTION_SD'.
		do
		end

	is_precompiled: BOOLEAN is
			-- Is Current an instance of `D_PRECOMPILED_SD'.
		do
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

end -- class D_OPTION_SD

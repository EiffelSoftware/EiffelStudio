indexing

	description: 
		"Representation of feature arguments."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_FEATURE_ARGUMENTS

inherit
	FIXED_LIST [TYPE_A]
		rename
			put_i_th as list_put_i_th
		export
			{NONE} list_put_i_th
		end

create
	make, make_filled

feature -- Property

	argument_names: LIST [STRING];
			-- Argument names

feature -- Setting

	set_argument_names (n: like argument_names) is
			-- Set `argument_names' to `n'.
		require
			valid_n: n /= Void
		do
			argument_names := n	
		ensure
			set: argument_names = n
		end;

feature -- Element change

	put_i_th (type: TYPE_A; i: INTEGER) is
			-- Put `type' at `i' position.
		require
			valid_type: type /= Void
		do
			list_put_i_th (type, i)
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

end -- class E_FEATURE_ARGUMENTS

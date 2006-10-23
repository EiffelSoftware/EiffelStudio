indexing
	description:
		"[
			Objects that represent a contraint triple structure:
			TE_CONSTRAIN, TYPE_AS, EIFFEL_LIST [FEATURE_NAME]
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTRAINT_TRIPLE

create
	make

feature{NONE} -- Initialization

	make (k_as: SYMBOL_AS; t_as: TYPE_AS; l_as: like creation_constrain) is
			-- Create new CONSTRAINT_TRIPLE sturcture.
		do
			constrain_symbol := k_as
			type := t_as
			creation_constrain := l_as
		ensure
			constrain_symbol_set: constrain_symbol = k_as
			type_set: type = t_as
			creation_constrain_set: creation_constrain = l_as
		end

feature -- Access

	constrain_symbol: SYMBOL_AS
			-- Constrain keyword

	type: TYPE_AS
			-- Type associated with current structure

	creation_constrain: CREATION_CONSTRAIN_TRIPLE;
			-- Creation constraion structure

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

end

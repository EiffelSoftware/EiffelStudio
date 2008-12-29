note
	description: "Server for routines' body indexed by body index."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BODY_SERVER

inherit
	READ_SERVER [FEATURE_AS]
		redefine
			has, item
		end

create
	make

feature

	cache: CACHE [FEATURE_AS]
			-- Cache for routine tables
		once
			create Result.make
		end

	has (an_id: INTEGER): BOOLEAN
			-- Has current `an_id'?
		do
			Result := tmp_ast_server.body_has (an_id) or else Precursor (an_id)
		end

	item (an_id: INTEGER): FEATURE_AS
			-- Body of id `an_id'. Look first in the temporary
			-- body server. It not present, look in itself.
		do
			Result := Tmp_ast_server.body_item (an_id)
			if Result = Void then
				Result := Precursor (an_id)
			end
		end

note
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

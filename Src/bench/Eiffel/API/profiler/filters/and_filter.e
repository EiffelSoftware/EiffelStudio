indexing

	description:
		"Profile filter to filter with the AND operation."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class AND_FILTER

inherit
	BOOLEAN_FILTER

create
	make

feature -- Checking

	check_item (item: PROFILE_DATA): BOOLEAN is
		do
			from
				filters.start
				Result := filters.item.check_item (item)
				filters.forth
			until
				filters.after
			loop
				Result := Result and filters.item.check_item (item)
				filters.forth
			end
		end

	filter (input_set: PROFILE_SET): PROFILE_SET is
		do
			from
				create Result.make
				input_set.start
			until
				input_set.after
			loop
				if check_item (input_set.item) then
					Result.insert_unknown_profile_data (input_set.item)
				end
				input_set.forth
			end
			Result.stop_computation;
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

end -- class AND_FILTER

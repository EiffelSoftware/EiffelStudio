note
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Makefile generator for precompiled C compilation

class PRECOMP_MAKER

inherit
	WBENCH_MAKER
		redefine
			system_name, generate_additional_rules
		end

create
	make

feature

	system_name: STRING
			-- Name of executable
		do
			Result := Driver
		end;

	generate_additional_rules
		do
			if
				not (object_baskets.count = 1 and then
				object_baskets.item (1).is_empty)
			then
					-- `object_baskets' may be empty when
					-- merging several precompilations.
				System.set_has_precompiled_preobj (True);
				Make_file.put_string ("%T$(AR) cr preobj.o ");
				generate_objects_macros;
				Make_file.put_new_line
			else
				System.set_has_precompiled_preobj (False)
			end;
		end;

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

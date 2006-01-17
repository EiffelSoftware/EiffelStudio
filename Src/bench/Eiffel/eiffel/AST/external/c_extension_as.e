indexing
	description: "Encapsulation of a C external extension."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class C_EXTENSION_AS

inherit
	EXTERNAL_EXTENSION_AS
		redefine
			parse_special_part
		end

create
	default_create,
	initialize

feature {EXTERNAL_FACTORY} -- Initialization

	initialize (sig: SIGNATURE_AS; use_list: USE_LIST_AS) is
			-- Create a new C_EXTENSION_AS node
		do
			if sig /= Void then
				argument_types := sig.arguments_id_array
				if sig.return_type /= Void then
					return_type := sig.return_type.value_id
				end
			end
			if use_list /= Void then
				header_files := use_list.array_representation
			end
		end

feature -- Get the C extension

	extension_i: C_EXTENSION_I is
			-- C_EXTENSION_I corresponding to current extension
		do
			create Result
			init_extension_i (Result)
		end

feature {NONE} -- Implementation

	parse_special_part is
			-- Parse the special part
			--| By default, it is empty
		local
			s: like special_part
		do
			s := special_part
			if s /= Void and then s.count /= 0 then
				raise_error ("Invalid sub-language routine clause")
			end
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

end -- class C_EXTENSION_AS

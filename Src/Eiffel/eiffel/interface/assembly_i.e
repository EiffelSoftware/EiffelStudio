indexing
	description: "Representation of an assembly."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ASSEMBLY_I

inherit
	CONF_ASSEMBLY
		redefine
			class_type
		end

create
	make,
	make_from_gac

feature -- Access

	full_name: STRING is
			-- Output name of Current
		do
			create Result.make (64)
			Result.append (name)
			if assembly_version /= Void then
				Result.append (", Version=")
				Result.append (assembly_version)
			end
			if assembly_culture /= Void then
				Result.append (", Culture=")
				Result.append (assembly_culture)
			else
				Result.append (", Culture=neutral")
			end
			if assembly_public_key_token /= Void then
				Result.append (", PublicKeyToken=")
				Result.append (assembly_public_key_token)
			end
		ensure
			full_name_not_void: Result /= Void
		end

feature -- Output

	format (a_text_formatter: TEXT_FORMATTER) is
			-- Output name of Current in `a_text_formatter'.
		require
			st_not_void: a_text_formatter /= Void
		do
			a_text_formatter.add_string (assembly_name)
			if assembly_version /= Void then
				a_text_formatter.add_string (", ")
				a_text_formatter.add_string (assembly_version)
			end
			if assembly_culture /= Void then
				a_text_formatter.add_string (", ")
				a_text_formatter.add_string (assembly_culture)
			end
			if assembly_public_key_token /= Void then
				a_text_formatter.add_string (", ")
				a_text_formatter.add_string (assembly_public_key_token)
			end
		end

feature {NONE} -- Class type anchor

	class_type: EXTERNAL_CLASS_I;
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

indexing
	description: "Generate Root Class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	ROOT_GENERATOR


creation
	make

feature -- Initialization

	make (ex: EXAMPLE_GENERATOR;s,t,u,v: STRING) is
		require
			ex /= Void and s /= Void
		do
			example := ex
			result_string := clone(s)
			result_string.replace_substring_all("<FL1>",ex.a_repository_name)
			result_string.replace_substring_all("<FL2>",ex.a_request_name)
			result_string.replace_substring_all("<FL3>",ex.a_request)
			result_string.replace_substring_all("<FL4>",t)
			result_string.replace_substring_all("<FL5>",u)
			result_string.replace_substring_all("<FL6>",v)
		ensure
			result_string /= Void and example /= Void
			set: example = ex
		end

feature -- Implementation

	example: EXAMPLE_GENERATOR

	result_string: STRING

invariant
	example /= Void
	result_string /= Void
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
end -- class ROOT_GENERATOR

indexing
	description: "Sample template"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SAMPLE_TEMPLATE

inherit
	TEMPLATE
	
feature -- Access

	description: STRING is
			-- Description
		do
			Result := "A sample of a system including source code."
		end
		
	content: STRING is
			-- Content
		do
			create Result.make_empty
			Result.append ("<document title=%"(Enter title here...)%">%N%
				%%T<meta_data/>%N%
				%%T<paragraph>%N%
					%%T%T<paragraph>(Introductory remarks here...)</paragraph>%N%
					%%T%T<heading><size>2</size>Compiling</heading>%N%
					%%T%T<paragraph>(Compilation instructions here...)</paragraph>%N%
					%%T%T<heading><size>2</size>Running the Sample</heading>%N%
					%%T%T<paragraph>(How to use instructions here...)</paragraph>%N%
					%%T%T<heading><size>2</size>Under the Hood</heading>%N%
					%%T%T<paragraph>(Source code links, technical details, etc here...)</paragraph>%N%
				%%T</paragraph>%N%
				%</document>")
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
end -- class SAMPLE_TEMPLATE

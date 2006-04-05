indexing
	description: "Constants and routines for code XML readers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_XML_READER_CONSTANTS
	
feature -- File related constants	
	
	link_prefix: STRING is "libraries"
			-- Library root directory
			
	reference_dir: STRING is "reference"
			-- Reference directory name	
	
feature {CODE_XML_READER} -- Tag Constants

	tags: ARRAYED_LIST [STRING] is
			-- Tags
		once
			create Result.make (15)
			Result.compare_objects
			Result.extend ("keyword")
			Result.extend ("cluster")
			Result.extend ("class")
			Result.extend ("feature")
			Result.extend ("reserved")
			Result.extend ("symbol")
			Result.extend ("quoted")
			Result.extend ("string")
			Result.extend ("char")
			Result.extend ("number")
			Result.extend ("local")
			Result.extend ("tag")
			Result.extend ("itag")
			Result.extend ("generic")
			Result.extend ("dot")
			Result.extend ("comment")
		end
		
	location_tag: STRING is "location"
	
	include_tag: STRING is "include"
	
	anchor_tag: STRING is "anchor"
	
	feature_tag: STRING is "feature"
	
	html_anchor_tag: STRING is "a"
	
	html_space: STRING is "&nbsp;";

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
end -- class CODE_XML_READER_CONSTANTS

indexing
	description: "Constants for output filtering"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	OUTPUT_CONSTANTS
	
feature -- Access

	output_list: HASH_TABLE [STRING, STRING] is
			-- List of possible filter output types hashed by description
		once
			create Result.make (3)
			Result.compare_objects
			Result.extend (studio_flag, studio_desc)
			Result.extend (envision_flag, envision_desc)
			Result.extend (studio_lin_flag, studio_lin_desc)
			Result.extend (studio_mac_flag, studio_mac_desc)
			Result.extend (studio_win_flag, studio_win_desc)
			Result.extend (unfiltered_flag, unfiltered)
		end
		
	file_generation_types: ARRAYED_LIST [STRING] is
			-- Valid file generation options
		once
			create Result.make (3)
			Result.compare_objects
			Result.extend (xml_to_help_flag)
			Result.extend (html_to_help_flag)
			Result.extend (xml_to_html_flag)
		end
		
	help_generation_types: ARRAYED_LIST [STRING] is
			-- Valid help generation options
		once
			create Result.make (3)
			Result.compare_objects
			Result.extend (web_help_tree_flag)
			Result.extend (web_help_simple_flag)
			Result.extend (mshtml_help_flag)
			Result.extend (vsip_help_flag)
		end	
		
feature -- Help Tags
	
	mshtml_help_flag: STRING is "mshtml"

	vsip_help_flag: STRING is "vsip"

	web_help_tree_flag: STRING is "web_tree"
	
	web_help_simple_flag: STRING is "web_simple"

	xml_to_html_flag: STRING is "xml2html"
	
	html_to_help_flag: STRING is "html2help"
	
	xml_to_help_flag: STRING is "xml2help"	
		
feature -- Filter tags
		
	unfiltered_flag: STRING is "all"	
		
	studio_flag: STRING is "studio"
	
	studio_win_flag: STRING is "studio_win"
	
	studio_lin_flag: STRING is "studio_lin"
	
	studio_mac_flag: STRING is "studio_mac"
	
	envision_flag: STRING is "envision"

feature -- Filter Descriptions

	none_desc: STRING is "Excluded"

	unfiltered: STRING is "Unfiltered"
	
	studio_desc: STRING is "EiffelStudio"
	
	studio_win_desc: STRING is "EiffelStudio for Windows"
	
	studio_lin_desc: STRING is "EiffelStudio for Unix/Linux"
	
	studio_mac_desc: STRING is "EiffelStudio for Mac OS X"
	
	envision_desc: STRING is "ENViSioN!";

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
end -- class OUTPUT_CONSTANTS

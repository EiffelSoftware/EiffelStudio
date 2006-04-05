indexing
	description: "Objects that provide access to all the currently supported%
		%Vision2 types for Build2."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_HANDLER

inherit
	GB_CONSTANTS
	
	OPERATING_ENVIRONMENT
	
feature -- Access

	supported_types: ARRAYED_LIST [STRING] is
			-- All Vision2 types supported by the system.
		once
			create Result.make (0)
			Result.extend ("gb_ev_colorizable")
			Result.extend ("gb_ev_fontable")
			Result.extend ("gb_ev_deselectable")
			Result.extend ("gb_ev_sensitive")
			Result.extend ("gb_ev_textable")
			Result.extend ("gb_ev_tooltipable")
			Result.extend ("gb_ev_widget")
			Result.extend ("gb_ev_window")
			Result.extend ("gb_ev_box")
			Result.extend ("gb_ev_split_area")
			Result.extend ("gb_ev_frame")
			Result.extend ("gb_ev_notebook")
			Result.extend ("gb_ev_gauge")
			Result.extend ("gb_ev_text_component")
			Result.extend ("gb_ev_text_alignable")
			Result.extend ("gb_ev_pixmapable")
			Result.extend ("gb_ev_fixed")
			Result.extend ("gb_ev_viewport")
			Result.extend ("gb_ev_table")
			Result.extend ("gb_ev_container")
			Result.extend ("gb_ev_pixmap")
			Result.extend ("gb_ev_progress_bar")
			Result.extend ("gb_ev_tool_bar")
		end
	
	--| FIXME This version has been commented, so that we do not need to have
	--| all the interface classes shipped with Build2. The user does not need to know about these
	--| classes and how they work.
	--| The nice thing about having it done this way, is that when a new class is defined, the system
	--| will just work, where as when we are using the above version, it must be updated manually.
--	supported_types: ARRAYED_LIST [STRING] is
--			-- All vision2 types available for the system.
--		local
--			directory: DIRECTORY
--			entries: ARRAYED_LIST [STRING]
--		do
--			create Result.make (0)
--			create directory.make (gb_ev_directory)
--			entries := directory.linear_representation
--			from
--				entries.start
--			until
--				entries.off
--			loop
--				if not entries.item.is_equal (".") and not entries.item.is_equal ("..") then
--					if entries.item.has ('.') then
--						Result.extend (entries.item.substring (1, entries.item.index_of ('.', 1) - 1))
--					elseif not (entries.item.is_equal ("CVS")) then
--						get_files_in_sub_directories (directory.name + directory_separator.out + entries.item, Result)		
--					end	
--				end
--				entries.forth
--			end
--		end
		
feature {NONE} -- Implementation
		
	get_files_in_sub_directories (a_directory: STRING; files: ARRAYED_LIST[STRING]) is
			-- `Result' is all filenames recursively in `a_directory'.
		local
			directory: DIRECTORY
			entries: ARRAYED_LIST [STRING]
		do
			create directory.make (a_directory)
			entries := directory.linear_representation
			from
				entries.start
			until
				entries.off
			loop
				if not entries.item.is_equal (".") and not entries.item.is_equal ("..") then
					if entries.item.has ('.') then
						files.extend (entries.item.substring (1, entries.item.index_of ('.', 1) - 1))
					elseif not (entries.item.is_equal ("CVS")) then
						get_files_in_sub_directories (directory.name + directory_separator.out +  entries.item, files)		
					end	
				end
				entries.forth
			end
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


end -- class GB_EV_HANDLER

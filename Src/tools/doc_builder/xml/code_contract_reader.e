indexing
	description: "Reader of Eiffel XML contract code file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_CONTRACT_READER

inherit
	DOCUMENT_FILTER
		rename
			make as make_filter
		redefine			
			on_start_tag,
			on_end_tag,
			on_content
		end

	CODE_XML_READER_CONSTANTS

create
	make

feature -- Creation

	make is
			-- Create
		do
			make_filter
			create element_stack.make (2)
			element_stack.compare_objects
			create anchors.make (1)
		end

feature -- Tag

	on_start_tag (a_namespace, a_prefix, a_local_part: STRING) is
			-- Start tag
		do
			element_stack.extend (a_local_part)					
		end
	
	on_end_tag (a_namespace, a_prefix, a_local_part: STRING) is
			-- End tag
		do							
			Element_stack.remove
		end	
		
	on_content (a_content: STRING) is
			-- Content
		local
			l_content,
			l_title,
			l_href,
			l_anchor: STRING
		do
			l_content := rt_output_escaped (a_content)
			l_anchor := l_content.substring (l_content.index_of ('#', 1), l_content.count)
			if current_tag.is_equal (Location_tag) then
				if l_content.occurrences ('#') > 0 then
					anchor.put (l_anchor, 2)
					in_anchor := True
				end
			elseif in_anchor and then current_tag.is_equal (Feature_tag) then
				l_title ?= l_content
				l_href ?= Anchor.item (2)
				if l_title /= Void and then l_href /= Void then
						-- Use `force' because it might be already present,
						-- case of a creation routine which appears twice,
						-- once as creation routine, once as a normal routine.
					anchors.force (l_title, l_href)
				end
				in_anchor := False
			end
		end

feature -- Access
	
	anchors: HASH_TABLE [STRING, STRING]
			-- List of anchors

feature {NONE} -- Tag
		
	current_tag: STRING is
			-- Current tag
		do
			Result := element_stack.item
		end

feature {NONE} -- Implementation

	in_anchor: BOOLEAN
			-- In anchor?

	element_stack: ARRAYED_STACK [STRING]
			-- Stack of element names
			
	anchor: TUPLE [STRING, STRING] is
			-- Anchor [feature name/title, location/href]
		once
			Result := ["", ""]
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
end -- class CODE_XML_READER2

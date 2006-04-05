indexing
	description: "Synchronizer for types of document widgets."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_SYNCHRONIZER

inherit
	SHARED_OBJECTS

feature -- Status Setting

	add_document (a_doc: DOCUMENT) is
			-- Add `a_doc'
		do
			if  modified_documents.has (a_doc) then
				modified_documents.prune (a_doc)				
			end
			modified_documents.extend (a_doc)
		end		

feature -- Commands
	
	synchronize is
			-- Synchronize
		do
			Modified_documents.do_all (agent update_toc)
			Modified_documents.wipe_out
		end		

feature -- Implementation

	modified_documents: ARRAYED_LIST [DOCUMENT] is
			-- List of documents that have been modified and need synchronizing at
			-- some point
		once
			create Result.make (3)
		end		

	update_toc (a_doc: DOCUMENT) is
			-- TOC
		do
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
end -- class DOCUMENT_SYNCHRONIZER

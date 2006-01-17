indexing
	description: "Information about where to generate the documentation"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	SYSTEM_DOCUMENTATION

inherit
	PROJECT_CONTEXT

feature -- Document processing

	document_file_name (system_name: STRING): FILE_NAME is
			-- File name specified for the cluster text generation
			-- Void result implies no document generation
		local
			tmp: STRING
		do
			tmp := document_path;
			if tmp /= Void then
				create Result.make_from_string (tmp);
				Result.extend (system_name);
			end
		end;
	
	document_path: DIRECTORY_NAME is
			-- Path specified for the documents directory for classes.
			-- Void result implies no document generation
		local
			tmp: STRING
		do
			tmp := private_document_path;
			if tmp = Void then
				Result := Documentation_path
			elseif not tmp.is_equal (No_word) then
				create Result.make_from_string (tmp)
			end;
		end

	set_document_path (a_path: like document_path) is
			-- Set `document_path' to `a_path'
		do
			private_document_path := a_path
		ensure
			set: document_path = a_path
		end;

feature -- Access

	No_word: STRING is "no";

feature {NONE} -- Document processing

	private_document_path: STRING;
			-- Path specified in Ace for the documents directory

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

end -- class SYSTEM_DOCUMENTATION

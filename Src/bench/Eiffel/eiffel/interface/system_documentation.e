indexing
	description: "Information about where to generate the documentation";
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

	private_document_path: STRING
			-- Path specified in Ace for the documents directory

end -- class SYSTEM_DOCUMENTATION

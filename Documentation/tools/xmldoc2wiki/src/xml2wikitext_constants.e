indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XML2WIKITEXT_CONSTANTS

inherit
	EXECUTION_ENVIRONMENT

	KL_SHARED_FILE_SYSTEM

feature -- Contants

	hardcoded_base_directory: STRING is
		local
			s: STRING
			fn: FILE_NAME
		once
			s := get ("EIFFEL_SRC")
			if s /= Void then
				create fn.make_from_string (s)
				fn.extend ("..")
				fn.extend ("Documentation")
				fn.extend ("xmldoc")
				Result := file_system.canonical_pathname (fn.string)
			else
				Result := "D:\_dev\trunk\Documentation\xmldoc"
				check error: False end
			end
		end

	hardcoded_prefix_url: STRING = "doc://"

end

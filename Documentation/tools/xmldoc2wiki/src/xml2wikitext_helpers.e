indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XML2WIKITEXT_HELPERS

inherit
	KL_SHARED_FILE_SYSTEM

feature -- Access

	removed_parent_redirection (s: STRING): STRING
		local
			pn: KI_PATHNAME
		do
			pn := file_system.string_to_pathname (s)
			pn.set_canonical
			Result := file_system.pathname_to_string (pn)
		end

	url_to_path (pn: STRING): STRING is
		local
			f: FILE_NAME
			s: STRING
			i,p: INTEGER
		do
			create f.make_from_string (pn)
			from
				i := 1
				p := 1
			until
				not pn.valid_index (i)
			loop
				i := pn.index_of ('\', p)
				if (i = 1) or (i > 1 and then pn.item (i - 1) /= '\') then
					f.extend (pn.substring (p, i - 1))
					p := i + 1
					i := p
				else
					i := 0
				end
			end
			if pn.valid_index (p) then
				f.set_file_name (pn.substring (p, pn.count))
			end
			Result := f.string
		end

	path_to_url (pn: STRING): STRING is
		local
			f: FILE_NAME
			i,p: INTEGER
			c: CHARACTER
		do
			c := Op_env.Directory_separator
			if c /= '/' then
				create Result.make_from_string (pn)
				from
					i := 1
					p := 1
				until
					not Result.valid_index (i)
				loop
					i := Result.index_of (c, p)
					if i = 1 or else (i > 1 and then Result.item (i - 1) /= '\') then
						Result.put ('/', i)
						p := i + 1
						i := p
					else
						i := 0
					end
				end
			end
		end

	Op_env: OPERATING_ENVIRONMENT is
			-- Objects available from the operating system
		once
			create Result
		end


end

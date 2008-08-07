indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	URL_RESOLVER

inherit
	KL_SHARED_FILE_SYSTEM

feature -- Access

	resolved (s: STRING): STRING
		local
			c: CHARACTER
		do
			if base_url /= Void then
				if s.is_empty then
					Result := base_url
				else
					if s.item (1) = '/' then
						Result := s
					else
						Result := removed_parent_redirection (base_url + s)
						Result := path_to_url (Result)
					end
				end
			end
			if Result = Void then
				Result := s
			end
		ensure
			Result_attached: Result /= Void
		end

feature -- Settings

	prefix_url: STRING assign set_prefix_url
			-- Prefix url if any

	base_url: STRING
			-- Base url

	current_filename: STRING assign set_current_filename
			-- current_filename to resolve the url or location

	base_directory: STRING assign set_base_directory
			-- Base directory to resolve the url or location

feature -- Element change

	set_prefix_url (v: like prefix_url)
			-- set `prefix_url' to `v'
		do
			if v /= Void and then not v.is_empty then
				prefix_url := v
			else
				prefix_url := void
			end
			update
		end

	set_current_filename (v: like current_filename)
			-- set `current_filename' to `v'
		do
			if v /= Void and then not v.is_empty then
				current_filename := v
			else
				current_filename := void
			end

			update
		end

	set_base_directory (v: like base_directory)
			-- set `base_directory' to `v'
		do
			if v /= Void and then not v.is_empty then
				base_directory := v
			else
				base_directory := void
			end

			update
		end

	update
		local
			c: CHARACTER
			i, p: INTEGER
			fn: STRING
			pn: KI_PATHNAME
			lfn: STRING
		do
			c := op_env.directory_separator
			if current_filename /= Void then
				if base_directory /= Void then
					pn := file_system.string_to_pathname (current_filename)
					lfn := pn.item (pn.count)
					create fn.make_from_string (current_filename)
					fn.remove_tail (lfn.count) --| Keep only folder with trailing '/'

					check fn.substring (1, base_directory.count).is_case_insensitive_equal (base_directory) end
					fn.remove_head (base_directory.count)
					base_url := path_to_url (fn)
					if prefix_url /= Void then
						base_url.prepend (prefix_url)
					end
				end
			end
		end


feature {NONE} -- Implementation

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

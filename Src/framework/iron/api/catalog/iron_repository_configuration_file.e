note
	description: "Summary description for {IRON_REPOSITORY_CONFIGURATION_FILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_REPOSITORY_CONFIGURATION_FILE

inherit
	IRON_EXPORTER

create
	make

feature {NONE} -- Initialization

	make (fn: PATH)
		local
			repo_names: ARRAYED_LIST [READABLE_STRING_GENERAL]
			dft_version: detachable READABLE_STRING_32
			l_uri: detachable URI
			repo: detachable IRON_REPOSITORY
		do
			path := fn
			create repositories.make (1)
			create ini.make_with_path (fn)
			create repo_names.make (1)
			across
				ini as c
			loop
				if not c.key.has ('.') then
					repo_names.force (c.key)
				end
			end
			if attached ini.item (".version") as v then
				dft_version := v
			end
			across
				repo_names as c
			loop
				if attached ini.item (c.item) as s_uri and then not s_uri.is_empty then
					create l_uri.make_from_string (s_uri)
					if l_uri.is_valid then
						if attached ini.item (c.item + ".version") as s_version then
							create repo.make (l_uri, s_version)
						elseif dft_version /= Void then
							create repo.make (l_uri, dft_version)
						else
							repo := Void
						end
						if repo /= Void then
							repositories.force (repo, c.item)
						end
					end
				end
			end
		end

	path: PATH

	ini: INI_FILE

feature -- Access

	repositories: STRING_TABLE [IRON_REPOSITORY]

feature -- Change

	add_repository (a_name: READABLE_STRING_8; a_repo: IRON_REPOSITORY)
		do
			ini.put (a_repo.uri.string, a_name)
			ini.put (a_repo.version, a_name + ".version")
			repositories.force (a_repo, a_name)
		end

	remove_repository (a_name: READABLE_STRING_GENERAL)
		local
			s: STRING_32
		do
			repositories.remove (a_name)
			ini.remove (a_name)
			create s.make_from_string_general (a_name)
			s.append (".version")
			ini.remove (s)
		end

feature -- Operation

	save
		do
			save_to (path)
		end

	save_to (fn: PATH)
		do
			ini.save_to (fn)
		end

end

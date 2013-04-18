note
	description: "Summary description for {IRON_LAYOUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_LAYOUT

inherit
	SHARED_EXECUTION_ENVIRONMENT

create
	make_default,
	make_with_path

feature {NONE} -- Initialization

	make_default
		local
			p: PATH
		do
			if attached execution_environment.item ({IRON_API_CONSTANTS}.iron_variable_name) as s then
				create p.make_from_string (s)
			elseif attached execution_environment.item ("ISE_USER_FILES") as s then
				create p.make_from_string (s)
				p := p.extended ("iron")
			else
				create p.make_current
				p := p.extended ("iron")
			end
			make_with_path (p)
		end

	make_with_path (p: PATH)
		do
			path := p.absolute_path.canonical_path
		end

feature -- Access

	path: PATH

	repositories_configuration_file: PATH
		once
			Result := path.extended ("repositories.conf")
		end

	repositories_path: PATH
		once
			Result := path.extended ("repositories")
		end

	archives_path: PATH
		once
			Result := path.extended ("archives")
		end

	packages_path: PATH
		once
			Result := path.extended ("packages")
		end

feature -- Query

	repository_path (a_repo: IRON_REPOSITORY): PATH
		do
			Result := repositories_path.extended_path (safe_repository_path (a_repo))
		end

	package_archive_path (a_package: IRON_PACKAGE): PATH
		do
			Result := archives_path.extended_path (safe_package_path (a_package)).appended_with_extension ("zip")
		end

	package_installation_path (a_package: IRON_PACKAGE): PATH
		do
			Result := packages_path.extended_path (safe_package_path (a_package))
		end

feature {NONE} -- Implementation

	safe_package_path (a_package: IRON_PACKAGE): PATH
		local
			s: STRING_32
		do
			s := a_package.id
			if attached a_package.name as l_name then
				s.append_character ('-')
				s.append (l_name)
			end
			Result := safe_repository_path (a_package.repository).extended (safe_name (s))
		end

	safe_repository_path (repo: IRON_REPOSITORY): PATH
		do
			create Result.make_from_string (safe_name (repo.uri.string + " " + repo.version))
		end

	safe_name (a_name: READABLE_STRING_32): STRING_8
		do
			create Result.make (a_name.count)
			across
				a_name as c
			loop
				inspect c.item
				when ':', '/' then
					Result.append_character ('_')
				when 'a' .. 'z' then
					Result.append_character (c.item.to_character_8)
				when 'A' .. 'Z' then
					Result.append_character (c.item.to_character_8)
				when '0' .. '9' then
					Result.append_character (c.item.to_character_8)
				when '!', '@', '?' then
					Result.append_character ('+')
				else
					Result.append_character ('_')
				end
			end
		end


end

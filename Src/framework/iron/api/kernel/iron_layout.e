note
	description: "[
			Environment for various iron related path and resources ....
			]"
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

	binaries_path: detachable PATH
			-- Binaries path if available.
			--| Could be $IRON_PATH/spec/$ISE_PLATFORM/bin
			--| Could be $ISE_EIFFEL/tools/iron/spec/$ISE_PLATFORM/bin
			--| ...
		local
			s: detachable READABLE_STRING_32
		once
			if attached execution_environment.item ("IRON_PLATFORM") as e then
				s := e
			elseif attached execution_environment.item ("ISE_PLATFORM") as e then
				s := e
			end
			if s /= Void then
				Result := path.extended ("spec").extended (s).extended ("bin")
			end
		end

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
			Result := archives_path.extended_path (safe_repository_path (a_package.repository)).extended_path (safe_package_path (a_package, True))
		end

	package_expected_installation_path (a_package: IRON_PACKAGE): PATH
		do
			Result := packages_path.extended_path (safe_package_path (a_package, False))
		end

	package_installation_path (a_package: IRON_PACKAGE): detachable PATH
		local
			f: RAW_FILE
			utf: UTF_CONVERTER
			s: STRING_8
		do
			Result := package_expected_installation_path (a_package)
			if attached package_renaming_installation_path (a_package) as p then
				create f.make_with_path (p)
				if f.exists and then f.is_access_readable then
					f.open_read
					f.read_line_thread_aware
					s := f.last_string
					f.close
					create Result.make_from_string (utf.utf_8_string_8_to_escaped_string_32 (s))
				end
			end
		end

	package_installation_info_path (a_package: IRON_PACKAGE): PATH
		do
			Result := packages_path.extended_path (safe_package_path (a_package, True)).appended_with_extension ("info")
		end

	package_renaming_installation_path (a_package: IRON_PACKAGE): PATH
		do
			Result := packages_path.extended_path (safe_package_path (a_package, True)).appended_with_extension ("renaming")
		end

feature {NONE} -- Implementation

	safe_package_path (a_package: IRON_PACKAGE; with_id: BOOLEAN): PATH
		local
			s: STRING_32
		do
			create s.make (10)
			if attached a_package.name as l_name then
				s.append (l_name)
			end
			if with_id then
				if not s.is_empty then
					s.append_character ('_')
					s.append_character ('_')
				end
				s.append_string_general (a_package.id)
			elseif s.is_empty then
				s.append_string_general (a_package.id.as_lower)
			end
			check s_not_empty: not s.is_empty end
			create Result.make_from_string (safe_name (s))
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
				when '-' then
					Result.append_character ('-')
				else
					Result.append_character ('_')
				end
			end
		end


end

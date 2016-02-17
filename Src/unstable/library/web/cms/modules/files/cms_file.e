note
	description: "Interface representing any files under `{CMS_API}.files_location' ."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_FILE

create
	make

feature {NONE} -- Initializaion

	make (a_relative_path: PATH; a_api: CMS_API)
		do
			cms_api := a_api
			relative_path := a_relative_path
		end

	cms_api: CMS_API

feature -- Access

	filename: STRING_32
			-- File name of Current file.
		local
			p: PATH
		do
			p := relative_path
			if attached p.entry as e then
				Result := e.name
			else
				Result := p.name
			end
		end

	relative_path: PATH
			-- Path relative the `CMS_API.files_location'.

	owner: detachable CMS_USER
			-- Optional owner.

feature -- Status report

	is_directory: BOOLEAN
		local
			d: DIRECTORY
		do
			create d.make_with_path (cms_api.files_location.extended_path (relative_path))
			Result := d.exists
		end

	is_file: BOOLEAN
		local
			f: RAW_FILE
		do
			create f.make_with_path (cms_api.files_location.extended_path (relative_path))
			Result := f.exists
		end

feature -- Element change

	set_owner (u: detachable CMS_USER)
			-- Set `owner' to `u'.
		do
			owner := u
		end

end

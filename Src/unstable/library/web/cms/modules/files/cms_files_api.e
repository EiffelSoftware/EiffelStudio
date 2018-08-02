note
	description: "API to manage files."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_FILES_API

inherit
	CMS_MODULE_API

	REFACTORING_HELPER

create
	make

feature -- Access : path

	uploads_relative_path: PATH
			-- Path relative to `{CMS_API}.files_location'.
		do
			create Result.make_from_string (uploads_directory_name)
		end

	uploads_directory: PATH
		do
			Result := cms_api.files_location.extended (uploads_directory_name)
		end

	uploaded_file_path (f: READABLE_STRING_GENERAL): PATH
		do
			Result := uploads_directory.extended (f)
		end

	thumbnail_directory: PATH
		do
			Result := uploads_directory.extended (thumbnail_directory_name)
		end

	is_file_owner (a_user: detachable CMS_USER; a_relative_path: PATH): BOOLEAN
		do
			if
				a_user /= Void and then
				attached metadata (new_uploads_file (a_relative_path)) as md
			then
				Result := a_user.same_as (md.user)
			end
		end

	file_owner (a_relative_path: PATH): detachable CMS_USER
		do
			if attached metadata (new_uploads_file (a_relative_path)) as md then
				Result := md.user
			end
		end

feature {CMS_FILES_MODULE} -- Access : metadata path

	metadata_path (f: READABLE_STRING_GENERAL): PATH
		do
			Result := metadata_directory.extended (f).appended_with_extension ("cms-metadata")
		end

	metadata_directory: PATH
		do
			Result := uploads_directory.extended (metadata_directory_name)
		end

feature -- Access : links

	file_link (f: CMS_FILE): CMS_LOCAL_LINK
		local
			s: STRING
		do
			s := "files"
			across
				f.relative_path.components as ic
			loop
				s.append_character ('/')
				s.append (percent_encoded (ic.item.name))
			end
			create Result.make (f.filename, s)
		end

feature {NONE} -- Constants

	uploads_directory_name: STRING = "uploads"

	metadata_directory_name: STRING = ".metadata"

	thumbnail_directory_name: STRING = ".thumbnails"

feature -- Factory

	new_file (a_relative_path: PATH): CMS_FILE
			-- New CMS_FILE for path `a_relative_path' relative to `files' directory.
		do
			create Result.make (a_relative_path, cms_api)
		end

	new_uploads_file (p: PATH): CMS_FILE
			-- New uploaded path from `p' relative to `uploads_directory'.
		do
			create Result.make (uploads_relative_path.extended_path (p), cms_api)
		end

feature -- Storage

	delete_file (fn: READABLE_STRING_GENERAL)
			-- Delete file at `fn'.
		local
			p: PATH
		do
			error_handler.reset
			p := uploaded_file_path (fn)
			safe_delete (p)
			if not has_error then
				p := metadata_path (fn)
				safe_delete (p)
			end
		end

	save_uploaded_file (uf: CMS_UPLOADED_FILE)
		local
			p: PATH
			ut: FILE_UTILITIES
			stored: BOOLEAN
			original_name: STRING_32
			n: INTEGER_32
			finished: BOOLEAN
		do
			reset_error
			create original_name.make_from_string (uf.filename)

			p := uf.location
			if not p.is_absolute then
				p := uploads_directory.extended_path (p)
			end

			if ut.file_path_exists (p) then

				from
					n := 1
				until
					finished
				loop
					if ut.file_path_exists (p) then
						uf.set_new_location_with_number (n)
						p := uf.location
						if p.is_absolute then
						else
							p := uploads_directory.extended_path (p)
						end
						n := n + 1
					else
						finished := True
					end
				end
				stored := uf.move_to (p)
			else
					-- move file to path
				stored := uf.move_to (p)
			end

			if stored then
				save_metadata_from_uploaded_file (uf, cms_api.user)
			else
				error_handler.add_custom_error (-1, "uploaded file storage failed", "Issue occurred when saving uploaded file!")
			end
		end

	save_metadata_from_uploaded_file (a_uploaded_file: CMS_UPLOADED_FILE; u: detachable CMS_USER)
		local
			f: detachable RAW_FILE
			h_date: HTTP_DATE
			retried: BOOLEAN
		do
			if retried then
					-- FIXME: Report error?
				if f /= Void and then not f.is_closed then
					f.close
				end
			else
					-- create a file for metadata
				create f.make_with_path (metadata_path (a_uploaded_file.filename))

				if f.exists then
					f.open_write
				else
					f.create_read_write
				end
					-- insert username
				if u /= Void then
					f.put_string (u.id.out)
					f.put_new_line
--					f.put_string (utf.utf_32_string_to_utf_8_string_8 (u.name))
--					f.put_new_line
				else
					f.put_new_line
					f.put_new_line
				end
					-- insert uploaded_time
				create h_date.make_now_utc
				f.put_string (h_date.timestamp.out)
				f.put_new_line

					-- insert size of file
				f.put_string (a_uploaded_file.size.out)
				f.put_new_line

					-- insert file type
				if attached a_uploaded_file.type as type then
					f.put_string (type.out)
					f.put_new_line
				end

				f.close
			end
		rescue
			retried := True
			retry
		end

	metadata (a_cms_file: CMS_FILE): detachable CMS_FILE_METADATA
		local
			f: RAW_FILE
			s: READABLE_STRING_8
		do
			if attached metadata_path (a_cms_file.filename) as p then
				create f.make_with_path (p)
				if f.exists and then f.is_access_readable then
					create Result.make_empty

					f.open_read

					f.read_line
					s := f.last_string
					if s.is_integer_64 then
						Result.set_user (cms_api.user_api.user_by_id (s.to_integer_64))
					else
						Result.set_user (cms_api.user_api.user_by_name (s))
					end

					f.read_line
					s := f.last_string
					if s.is_integer_64 then
						Result.set_date ((create {HTTP_DATE}.make_from_timestamp (s.to_integer_64)).date_time)
					end

					f.read_line
					s := f.last_string
					if s.is_integer_32 then
						Result.set_size (s.to_integer_32)
					else
						Result.set_size (-1)
					end

					if not f.end_of_file then
						f.read_line
						Result.set_file_type (f.last_string)
					end
					f.close
				end
			end
		end

	safe_delete (p: PATH)
			-- Safe remove file at path `p'.
		local
			f: RAW_FILE
			retried: BOOLEAN
		do
			if retried then
				error_handler.add_custom_error (-1, "Can not delete file", {STRING_32} "Can not delete file %"" + p.name + "%"")
			else
				create f.make_with_path (p)
				if f.exists then
					f.delete
				else
						-- Not considered as failure.
				end
			end
		rescue
			retried := True
			retry
		end


end

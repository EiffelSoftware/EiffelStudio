note
	description: "FS Storage layer for wdocs data."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_FS_STORAGE_LAYER

inherit
	CMS_API_ACCESS

create {WDOCS_FS_STORAGE_LAYER_FACTORY}
	make

feature {NONE} -- Initialization

	make (a_api: like wdocs_api)
		do
			wdocs_api := a_api
		end

feature -- Access

	wdocs_api: WDOCS_API

	cms_api: CMS_API
		do
			Result := wdocs_api.cms_api
		end

feature -- Access: Error

	add_custom_error (a_code: INTEGER; a_name: STRING; a_message: detachable READABLE_STRING_GENERAL)
		do
			wdocs_api.error_handler.add_custom_error (a_code, a_name, a_message)
		end

	reset_error
		do
			wdocs_api.error_handler.reset
		end

	has_error: BOOLEAN
		do
			Result := wdocs_api.error_handler.has_error
		end

feature -- Execution

	commit (a_context: detachable WDOCS_CHANGE_CONTEXT; a_message: detachable READABLE_STRING_32)
			-- Validate and apply changes with message `a_message` within context `a_context`.
		do
		end

	update (p: PATH)
			-- Refresh folder `p`.
		do
		end

feature -- Recent changes

	recent_changes_before (params: CMS_DATA_QUERY_PARAMETERS; a_date: DATE_TIME; a_version_id: detachable READABLE_STRING_GENERAL): LIST [TUPLE [time: DATE_TIME; author: READABLE_STRING_32; bookid: READABLE_STRING_GENERAL; page: like wdocs_api.new_wiki_page; log: READABLE_STRING_8]]
			-- List of recent changes, before `a_date', according to `params' settings.
		do
			create {ARRAYED_LIST [like recent_changes_before.item]} Result.make (params.size.as_integer_32)
		end

feature -- Basic operations

	create_directory (dir: DIRECTORY)
		local
			retried: BOOLEAN
		do
			if not retried then
				dir.recursive_create_dir
			end
		rescue
			retried := True
			add_custom_error (1, "Could not create directory", {STRING_32} "Could not create directory %"" + dir.path.name + {STRING_32} "%"!")
			retry
		end

	delete_file (p: PATH)
		local
			f: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create f.make_with_path (p)
				if f.exists and then f.is_access_writable then
					f.delete
				else
					add_custom_error (1, "unable to delete file", {STRING_32} "unable to delete file %"" + p.name + {STRING_32} "%"!")
				end
			end
		rescue
			retried := True
			add_custom_error (1, "Could not delete file", {STRING_32} "Could not delete file %"" + p.name + {STRING_32} "%"!")
			retry
		end

	move_file (a_from, a_target: PATH)
		local
			f, tgt: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create f.make_with_path (a_from)
				create tgt.make_with_path (a_target)
				if f.exists then
					if tgt.exists then
						add_custom_error (1, "file not found", {STRING_32} "file %"" + a_from.name + {STRING_32} "%" not found!")
					else
						f.rename_path (a_target)
					end
				else
					add_custom_error (1, "file not found", {STRING_32} "file %"" + a_from.name + {STRING_32} "%" not found!")
				end
			end
		rescue
			retried := True
			add_custom_error (1, "Could not move file", {STRING_32} "Could not move file %"" + a_from.name + {STRING_32} "%" to %""+ a_target.name + {STRING_32} "%"!")
			retry
		end

	new_file (a_content: detachable READABLE_STRING_8; a_path: PATH)
		require
			not_exists: not (create {FILE_UTILITIES}).file_path_exists (a_path)
		local
			f: RAW_FILE
		do
			create f.make_with_path (a_path)
			save_content_to_file (a_content, f)
		end

	overwrite_file (a_content: detachable READABLE_STRING_8; a_path: PATH)
		require
			exists: (create {FILE_UTILITIES}).file_path_exists (a_path)
		local
			f: RAW_FILE
		do
			create f.make_with_path (a_path)
			if not f.exists or else f.is_access_writable then
				backup_file (f)
				save_content_to_file (a_content, f)
				remove_backuped_file (f)
			else
				add_custom_error (0, "Impossible to overwrite file", {STRING_32} "Impossible to overwrite file %"" + a_path.name + {STRING_32} "%"!")
			end
		end

feature {NONE} -- Implementation

	save_content_to_file (a_content: detachable READABLE_STRING_8; f: FILE)
		require
			file_is_closed: f.is_closed
		local
			d: DIRECTORY
		do
			if not f.exists or else f.is_access_writable then
				create d.make_with_path (f.path.parent)
				if not d.exists then
					d.recursive_create_dir
				end
				f.open_write
				if a_content = Void then
					f.put_new_line
				else
					f.put_string (a_content)
				end
				f.close
			else
				add_custom_error (0, "Impossible to save file", {STRING_32} "Impossible to save file %"" + f.path.name + {STRING_32} "%"!")
			end
		end

	backup_file (f: RAW_FILE)
		require
			f.is_closed
		local
			bak: RAW_FILE
		do
			if f.exists and then f.is_access_readable then
				create bak.make_with_path (f.path.appended_with_extension ("bak"))
				if not bak.exists or else bak.is_access_writable then
					bak.create_read_write
					f.open_read
					f.copy_to (bak)
					f.close
					bak.close
				end
			end
		end

	restore_backuped_file (f: RAW_FILE)
		local
			bak: RAW_FILE
		do
			if f.exists and then f.is_access_writable then
				create bak.make_with_path (f.path.appended_with_extension ("bak"))
				if bak.exists and then bak.is_access_writable then
					bak.open_read
					f.open_write
					bak.copy_to (f)
					f.close
					bak.close
					bak.delete
				end
			end
		end

	remove_backuped_file (f: FILE)
		local
			bak: RAW_FILE
		do
			create bak.make_with_path (f.path.appended_with_extension ("bak"))
			if bak.exists and then bak.is_access_writable then
				bak.delete
			end
		end

end

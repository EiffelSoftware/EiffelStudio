note
	description: "files module."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_FILES_MODULE

inherit
	CMS_MODULE
		rename
			module_api as files_api
		redefine
			install,
			initialize,
			setup_hooks,
			permissions,
			files_api
		end

	CMS_HOOK_MENU_SYSTEM_ALTER

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make
		do
			name := "files"
			version := "1.0"
			description := "Service to upload files, and manage them."
			package := "file"
		end

feature -- Access

	name: STRING

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force (admin_files_permission)
			Result.force (upload_files_permission)
			Result.force (browse_files_permission)
			Result.force (delete_file_permission)
			Result.force (delete_own_file_permission)
		end

	admin_files_permission: STRING = "admin files"
	upload_files_permission: STRING = "upload files"
	browse_files_permission: STRING = "browse files"
	delete_file_permission: STRING = "delete file"
	delete_own_file_permission: STRING = "delete own file"

feature {CMS_API} -- Module Initialization

	initialize (api: CMS_API)
			-- <Precursor>
		do
			Precursor (api)
			if files_api = Void then
				create files_api.make (api)
			end
		end

feature {CMS_API}-- Module management

	install (api: CMS_API)
			-- install the module
		local
			l_files_api: like files_api
			d: DIRECTORY
		do
			create l_files_api.make (api)
			create d.make_with_path (l_files_api.uploads_directory)
			if not d.exists then
				d.recursive_create_dir
			end
			create d.make_with_path (l_files_api.metadata_directory)
			if not d.exists then
				d.recursive_create_dir
			end

			files_api := l_files_api
			Precursor (api)
		end

feature {CMS_API} -- Access: API

	files_api: detachable CMS_FILES_API
			-- <Precursor>		

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			map_uri_template_agent (a_router, "/" + uploads_location, agent execute_upload (?, ?, a_api), Void) -- Accepts any method GET, HEAD, POST, PUT, DELETE, ...
			map_uri_template_agent (a_router, "/" + uploads_location + "{filename}", agent display_uploaded_file_info (?, ?, a_api), a_router.methods_get)
			map_uri_template_agent (a_router, "/" + uploads_location + "{filename}/remove", agent remove_file (?, ?, a_api), a_router.methods_get)
		end

	uploads_location: STRING = "upload/"

feature -- Hooks

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
		do
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
		local
			link: CMS_LOCAL_LINK
		do
			-- login in demo did somehow not work
			if a_response.has_permission (upload_files_permission) then
				create link.make ("Upload files", uploads_location)
				a_menu_system.navigation_menu.extend (link)
			end
		end

feature -- Handler

	execute_not_found_handler (uri: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- `uri' is not found, redirect to default page
		do
			res.redirect_now_with_content (req.script_url ("/"), uri + ": not found. %N Redirection to" + req.script_url ("/"), "text/html")
		end

	display_uploaded_file_info (req: WSF_REQUEST; res: WSF_RESPONSE; api: CMS_API)
			-- Display information related to a cms uploaded file.
		local
			body: STRING_8
			r: CMS_RESPONSE
			l_file_url: STRING_8
			f: CMS_FILE
			md: detachable CMS_FILE_METADATA
			fn: READABLE_STRING_32
		do
			check req.is_get_request_method end
			if not api.has_permission (browse_files_permission) then
				create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make_with_permissions (req, res, api, <<browse_files_permission>>)
				r.add_error_message ("You are not allowed to browse files!")
			elseif attached {WSF_STRING} req.path_parameter ("filename") as p_filename then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)

					-- add style
				r.add_style (r.module_resource_url (Current, "/files/css/files.css", Void), Void)

				create body.make_empty

				fn := p_filename.value
				r.set_page_title ({STRING_32} "File %"" + fn + {STRING_32} "%"")
				body.append ("<div class=%"uploaded-files%">%N") -- To ease css customization.
				if attached files_api as l_files_api then
					f := l_files_api.new_uploads_file (create {PATH}.make_from_string (fn))

					body.append ("<div class=%"metadata%">")

					md := l_files_api.metadata (f)

						--| Uploader user
					body.append ("<strong>User: </strong>")
					if md /= Void and then attached md.user as meta_user then
						body.append (api.html_encoded (meta_user.name))
					else
						body.append ("unknown user")
					end
					body.append ("<br/>%N")

						--| Uploaded date
					body.append ("<strong>Upload Time: </strong>")
					if md /= Void and then attached md.date as meta_time then
						body.append (meta_time.out)
					else
						body.append ("NA")
					end
					body.append ("<br/>%N")

						--| File size
					body.append ("<strong> File Size: </strong>")
					if md /= Void and then md.size > 0 then
						body.append (file_size_human_string (md.size))
					else
						body.append ("NA")
					end
					body.append ("<br/>%N")

						--| File type
					body.append ("<strong>File Type: </strong>")
					if md /= Void and then attached md.file_type as meta_type then
						body.append (meta_type)
					else
						body.append ("NA")
					end
					body.append ("<br/>%N")

						--| File Url
					l_file_url := req.script_url ("/" + l_files_api.file_link (f).location)
					body.append ("<strong>File URL: </strong>")
					body.append (l_file_url)
					body.append ("<br/><br/>%N")

					body.append ("<a class=%"button%" href=%"" + l_file_url + "%">Download</a>%N")
					body.append ("<a class=%"button%" href=%"" + req.script_url ("/" + uploads_location + percent_encoded (f.filename) + "/remove") + "%">Remove</a>%N")
					body.append ("</div>%N") -- metadata
					body.append ("<br/>%N")
					body.append ("<div class=%"overview%">")
					if
						attached f.relative_path.extension as ext and then
						(
							ext.is_case_insensitive_equal_general ("png")
							or ext.is_case_insensitive_equal_general ("jpg")
							or ext.is_case_insensitive_equal_general ("gif")
						)
					then
						body.append ("<img src=%"" + req.script_url ("/" + l_files_api.file_link (f).location) + "%" />")
					else
							-- add default thumbnail
						body.append ("<img src=%"" + req.script_url ("/module/" + name + "/files/img/file-logo.png") + "%" />")
					end
					body.append ("</div>%N") -- Overview
				end
				body.append ("</div>%N")

				r.add_to_primary_tabs (create {CMS_LOCAL_LINK}.make ("Uploaded files", uploads_location))
				r.set_main_content (body)
			else
				create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
				r.set_main_content ("Missing 'filename' field value!")
			end
			r.execute
		end

	execute_upload (req: WSF_REQUEST; res: WSF_RESPONSE; api: CMS_API)
		local
			body: STRING_8
			r: CMS_RESPONSE
			i: INTEGER
		do
			if req.is_get_head_request_method then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				create body.make_empty
				body.append ("<h1> Upload files </h1>%N")

					-- set style
				r.add_style (r.module_resource_url (Current, "/files/css/files.css", Void), Void)

				if api.has_permission (upload_files_permission) then
					body.append ("<p>Please choose file(s) to upload.</p>")
						-- create form to choose files and upload them
					body.append ("<div class=%"upload-files%">")

					if attached {WSF_STRING} req.item ("basic_upload") as p and then p.is_case_insensitive_equal ("yes") then
							-- No dropzone
						body.append ("<form action=%"" + r.url (uploads_location, Void) + "%" method=%"post%" enctype=%"multipart/form-data%">")
						body.append ("<input type=%"hidden%" name=%"basic_upload%" value=%"yes%"/>%N")
						from
							i := 1
						until
							i > 5
						loop
							body.append ("<input type=%"file%" name=%"filenames[]%" id=%"filenames[]%" size=%"60%"/><br/>%N")
							i := i + 1
						end
						body.append ("<br/><input type=%"submit%" value=%"Upload File(s)%"/>")
						body.append ("</form>%N")
						body.append ("<a href=%""+ r.url (uploads_location, Void) +"?basic_upload=no%">Use advanced file uploading.</a>%N")
					else
							-- add JS for dropzone
						r.add_javascript_url (r.module_resource_url (Current, "/files/js/dropzone.js", Void))
						r.add_style (r.module_resource_url (Current, "/files/js/dropzone.css", Void), Void)

							-- create form to choose files and upload them
						body.append ("<form action=%"" + r.url (uploads_location, Void) + "%" class=%"dropzone%">")
						body.append ("</form>%N")

						body.append ("<a href=%""+ r.url (uploads_location, Void) + "?basic_upload=yes%">Use basic file uploading.</a>%N")
					end
					body.append ("</div>")
				end

				if req.is_get_head_request_method then
						-- Build the response.
					if r.has_permission (browse_files_permission) then
						body.append ("<br/><div class=%"center%"><a class=%"button%" href=%"" + r.url (uploads_location, Void) + "%">Refresh uploaded</a></div>")

						append_uploaded_file_album_to (req, api, body)
					else
						r.add_warning_message ("You are not allowed to browse files!")
					end
				end
				r.set_main_content (body)
				r.execute
			elseif req.is_post_request_method then
				if api.has_permission (upload_files_permission) then
					create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
					create body.make_empty
					body.append ("<h1> Upload files </h1>%N")
					process_uploaded_files (req, api, body)
					if attached {WSF_STRING} req.item ("basic_upload") as p and then p.is_case_insensitive_equal ("yes") then
						r.set_redirection (r.url (uploads_location, Void) + "?basic_upload=yes")
					else
						r.set_redirection (r.url (uploads_location, Void))
					end
					r.set_main_content (body)
					r.execute
				else
					api.response_api.send_permissions_access_denied ("You are not allowed to upload file!", <<upload_files_permission>>, req, res)
				end
			else
				api.response_api.send_bad_request (Void, req, res)
			end
		end

	process_uploaded_files (req: WSF_REQUEST; api: CMS_API; a_output: STRING)
			-- Process http request uploaded files.
		require
			has_permission: api.has_permission (upload_files_permission)
		local
			l_uploaded_file: CMS_UPLOADED_FILE
			uf: WSF_UPLOADED_FILE
		do
			if attached files_api as l_files_api then
					-- if has uploaded files, then store them
				if req.has_uploaded_file then
					a_output.append ("<strong>Newly uploaded file(s): </strong>%N")
					a_output.append ("<ul class=%"uploaded-files%">")
					across
						req.uploaded_files as ic
					loop
						uf := ic.item
						create l_uploaded_file.make_with_uploaded_file (l_files_api.uploads_directory, uf)
						a_output.append ("<li>")
						a_output.append (api.html_encoded (l_uploaded_file.filename))

							-- create medadata file
						l_uploaded_file.set_size (uf.size)
						l_uploaded_file.set_type (uf.content_type.to_string_8) -- READABLE_STRING to STRING

							-- store the just uploaded file
						l_files_api.save_uploaded_file (l_uploaded_file)

						if l_files_api.has_error then
							a_output.append (" <span class=%"error%">: upload failed!</span>")
						end
						a_output.append ("</li>")
					end
					a_output.append ("</ul>%N")
				end
			end
		end

	append_uploaded_file_album_to (req: WSF_REQUEST; api: CMS_API; a_output: STRING)
		local
			d: DIRECTORY
			f: CMS_FILE
			p: PATH
			rel: PATH
			md: detachable CMS_FILE_METADATA
		do
			if attached files_api as l_files_api then
				rel := l_files_api.uploads_relative_path
				p := l_files_api.uploads_directory

				a_output.append ("<div class=%"uploaded-files%">%N")
				a_output.append ("<strong>Uploaded files:</strong>%N")
				a_output.append ("<table>%N")
				a_output.append ("<tr><th>Filename</th><th>Uploading Time</th><th>User</th><th>Size</th><th></th><th></th></tr>%N")

				create d.make_with_path (p)
				if d.exists then
					across
						d.entries as ic
					loop

						if ic.item.is_current_symbol then
								-- Ignore
						elseif ic.item.is_parent_symbol then
								-- Ignore for now.
						else
							f := l_files_api.new_file (rel.extended_path (ic.item))

								-- check if f is directory -> yes, then do not show
							if not f.is_directory then
								a_output.append ("<tr>")

									-- add filename
								a_output.append ("<td class=%"filename%">")
								a_output.append ("<a href=%"" + api.percent_encoded (f.filename) + "%">")
								a_output.append (api.html_encoded (f.filename))
								a_output.append ("</a>")
								a_output.append ("</td>%N")

								md := l_files_api.metadata (f)
								if md = Void then
									a_output.append ("<td class=%"date%"></td>%N")
									a_output.append ("<td class=%"user%"></td>%N")
									a_output.append ("<td class=%"size%"></td>%N")
								else

										-- add uploading time
									a_output.append ("<td class=%"date%">")
									if attached md.date as meta_time then
										a_output.append (meta_time.out)
									end
									a_output.append ("</td>%N")

										-- add user
									a_output.append ("<td class=%"user%">")
									if attached md.user as u then
										a_output.append (api.html_encoded (u.name))
									end
									a_output.append ("</td>%N")

										-- add size
									a_output.append ("<td class=%"size%">")
									if md.size > 0 then
										a_output.append (file_size_human_string (md.size))
									else
										a_output.append ("NA")
									end
									a_output.append ("</td>%N")
								end

									-- add download link
								a_output.append ("<td>")
								a_output.append ("<a class=%"button%" href=%"" + req.script_url ("/" + l_files_api.file_link (f).location) + "%" download>Download</a>%N")
								a_output.append ("</td>%N")

									-- add remove button
								a_output.append ("<td>")
								a_output.append ("<a class=%"button%" href=%"" + req.script_url ("/" + uploads_location + percent_encoded (f.filename) + "/remove") + "%">Remove</a>%N")
								a_output.append ("</td>%N")

								a_output.append ("</tr>%N")
							else
								if f.relative_path.is_current_symbol or f.relative_path.is_parent_symbol then
										-- Ignore "." and ".."
								else

									-- folder support not yet supported

--										-- add directory identifier
--									a_output.append ("<td>[dir]</td>%N")

--									a_output.append ("<td>")
--									a_output.append ("<a href=%"" + api.percent_encoded (f.filename) + "%">")
--									a_output.append (api.html_encoded (f.filename))
--									a_output.append ("</a>")
--									a_output.append ("</td>%N")

--									a_output.append ("<td></td><td></td><td></td><td></td><td></td>")
								end

							end
						end
					end
				end
				a_output.append ("</table>%N")
				a_output.append ("</div>%N")
			end
		end

	remove_file (req: WSF_REQUEST; res: WSF_RESPONSE; api: CMS_API)
		local
			body: STRING
			r: CMS_RESPONSE
			err: BOOLEAN
		do
			if attached files_api as l_files_api then
				if attached {WSF_STRING} req.path_parameter ("filename") as p_filename then
					if
						api.has_permissions (<<admin_files_permission, delete_file_permission>>)
						or else (
							l_files_api.is_file_owner (api.user, create {PATH}.make_from_string (p_filename.value)) and then
							api.has_permission (delete_own_file_permission)
						)
					then
						create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)

						l_files_api.delete_file (p_filename.value)
						err := l_files_api.has_error
						l_files_api.reset_error
						create body.make_empty

						if err then
							body.append ("<h3>The file removal failed!</h3>")
						else
							body.append ("<h3>The file has been removed successfully!</h3>")
						end

						r.add_to_primary_tabs (create {CMS_LOCAL_LINK}.make ("Uploaded files", uploads_location))
						r.set_main_content (body)
					else
						create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make_with_permissions (req, res, api, <<admin_files_permission, delete_file_permission>>)
						r.add_error_message ("You are not allowed to remove the file!")
					end
				else
					create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
					r.add_error_message ("Missing 'filename' parameter!")
				end
			else
				create {INTERNAL_SERVER_ERROR_CMS_RESPONSE} r.make (req, res, api)
				r.set_main_content ("Removal of file failed due to internal server error!")
			end
			r.execute
		end

feature -- Helpers

	file_size_human_string (a_size: INTEGER): STRING
		local
			size: INTEGER
		do
			size := a_size
			if size >= 1000000 then
				size := size // 1000000
				Result := size.out + " MB"
			else
				if size >= 1000 then
					size := size // 1000
					Result := size.out + " kB"
				else
					Result := size.out + " bytes"
				end
			end
		end

feature -- Mapping helper: uri template agent (analogue to the demo-module)

	map_uri_template (a_router: WSF_ROUTER; a_tpl: STRING; h: WSF_URI_TEMPLATE_HANDLER; rqst_methods: detachable WSF_REQUEST_METHODS)
			-- Map `h' as handler for `a_tpl', according to `rqst_methods'.
		require
			a_tpl_attached: a_tpl /= Void
			h_attached: h /= Void
		do
			a_router.map (create {WSF_URI_TEMPLATE_MAPPING}.make (a_tpl, h), rqst_methods)
		end

	map_uri_template_agent (a_router: WSF_ROUTER; a_tpl: READABLE_STRING_8; proc: PROCEDURE [TUPLE [req: WSF_REQUEST; res: WSF_RESPONSE]]; rqst_methods: detachable WSF_REQUEST_METHODS)
			-- Map `proc' as handler for `a_tpl', according to `rqst_methods'.
		require
			a_tpl_attached: a_tpl /= Void
			proc_attached: proc /= Void
		do
			map_uri_template (a_router, a_tpl, create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (proc), rqst_methods)
		end

end

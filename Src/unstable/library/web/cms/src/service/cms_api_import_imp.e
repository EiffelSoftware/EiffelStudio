note
	description: "Summary description for {CMS_API_IMPORT_IMP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_API_IMPORT_IMP

inherit
	CMS_ENCODERS

	CMS_HOOK_IMPORT

	CMS_IMPORT_JSON_UTILITIES

	CMS_FILE_SYSTEM_UTILITIES

feature {NONE} -- Query: API

	user_api: CMS_USER_API
			-- API to access user related data.
		deferred
		end

	cms_api: CMS_API
		deferred
		end

feature -- Import

	import_from (a_import_id_list: detachable ITERABLE [READABLE_STRING_GENERAL]; a_import_ctx: CMS_IMPORT_CONTEXT; a_response: CMS_RESPONSE)
			-- Import data identified by `a_import_id_list',
			-- or import all data if `a_import_id_list' is Void.
		local
			p: PATH
			d: DIRECTORY
			l_id: STRING_32
		do
				-- User roles			
			if
				a_import_id_list = Void
				or else across a_import_id_list as ic some ic.item.same_string ("user_roles") end
			then
				if
					a_response.has_permissions (<<"import core">>)
				then
					a_import_ctx.log ("Importing user roles...")
						-- From "core" location
					if attached json_object_from_location (a_import_ctx.location.extended ("core").extended ("user_roles.json")) as j_user_roles then
						across
							j_user_roles as j_ic
						loop
							if attached {JSON_OBJECT} j_ic.item as j_user_role then
								import_json_user_role (j_user_role, a_import_ctx)
							end
						end
					end
				end
			end

				-- Users
			if
				a_import_id_list = Void
				or else across a_import_id_list as ic some ic.item.same_string ("users") end
			then
				if
					a_response.has_permissions (<<"import core">>)
				then
					a_import_ctx.log ("Importing users...")

						-- From "core" location
					if attached json_object_from_location (a_import_ctx.location.extended ("core").extended ("users.json")) as j_users then
						across
							j_users as j_ic
						loop
							if attached {JSON_OBJECT} j_ic.item as j_user then
								import_json_user (j_user, a_import_ctx)
							end
						end
					end
				end
				if
					a_response.has_permissions (<<"import users">>)
				then
						-- From "users" location
					p := a_import_ctx.location.extended ("users")
					create d.make_with_path (p)
					if d.exists and then d.is_readable then
						a_import_ctx.log ("Importing users ..")
						across
							d.entries as ic
						loop
							if attached ic.item.extension as ext and then ext.same_string_general ("json") then
								l_id := ic.item.name
								l_id.remove_tail (ext.count + 1)
								if attached json_object_from_location (p.extended_path (ic.item)) as j_user then
									import_json_user (j_user, a_import_ctx)
								end
							end
						end
					end
				end
			end

				-- User roles			
			if
				a_import_id_list = Void
				or else across a_import_id_list as ic some ic.item.same_string ("files") end
			then
				if
					a_response.has_permissions (<<"import files">>)
				then
					a_import_ctx.log ("Importing files ...")
						-- From "core" location
					p := a_import_ctx.location.extended ("files")
					if attached files_from_location (p, True) as l_files then
						across
							l_files as ic
						loop
							import_file (ic.item, p, a_import_ctx)
						end
					end
				end
			end
		end

	import_file (a_file_path: PATH; a_root_path: PATH; a_import_ctx: CMS_IMPORT_CONTEXT)
		local
			b: BOOLEAN
			dst: PATH
		do
			if attached relative_path_inside (a_file_path, a_root_path) as rel_path then
				dst := cms_api.files_location.extended_path (rel_path)
				b := safe_copy_file (a_file_path, dst)
				if b then
					a_import_ctx.log ("Imported file %"" + html_encoded (a_file_path.name) + "%" to %"" + html_encoded (dst.name) + "%".")
				else
					a_import_ctx.log ("ERROR: unable to import file %"" + html_encoded (a_file_path.name) + "%" !!!")
				end
			else
				check a_file_path_in_root_directory: False end
				a_import_ctx.log ("ERROR: unable to import file %"" + html_encoded (a_file_path.name) + "%" (not in root directory) !")
			end
		end

	import_json_user_role (j_user_role: JSON_OBJECT; a_import_ctx: CMS_IMPORT_CONTEXT)
		local
		do
			if attached json_to_user_role (j_user_role) as ur then
				if user_api.user_role_by_name (ur.name) = Void then
					a_import_ctx.log ("new user role %"" + html_encoded (ur.name) + "%".")
					user_api.save_user_role (ur)
				else
					a_import_ctx.log ("Skip user role %"" + html_encoded (ur.name) + "%" : already exists!")
						-- Already exists!
				end
			end
		end

	import_json_user (j_user: JSON_OBJECT; a_import_ctx: CMS_IMPORT_CONTEXT)
		local
			l_user_by_name, l_user_by_email, l_user: detachable CMS_USER
		do
			if attached json_to_user (j_user) as u then
				l_user_by_name := user_api.user_by_name (u.name)
				if attached u.email as l_email then
					l_user_by_email := user_api.user_by_email (l_email)
				end
				if l_user_by_name /= Void or l_user_by_email /= Void then
					a_import_ctx.log ("Skip user %"" + html_encoded (u.name) + "%": already exists!")
						-- Already exists!
					if l_user_by_email /= Void then
						l_user := l_user_by_email
						if
							l_user_by_name /= Void and then
							l_user_by_name.same_as (l_user)
						then
								-- Two different accounts exists!
							a_import_ctx.log ("Two different accounts already exists for username %"" + html_encoded (u.name) + "%" !")
						end
					else
						l_user := l_user_by_name
					end
						-- Check if new information are now available.
					if
						l_user /= Void and then
						l_user.profile_name = Void and then
					 	attached u.profile_name as l_new_prof_name and then
					 	not l_new_prof_name.is_whitespace
					then
						l_user.set_profile_name (l_new_prof_name)
						user_api.update_user (l_user)
					end
				else
					user_api.new_user (u)
					-- FIXME: check what status to use...
					a_import_ctx.log ("New user %"" + html_encoded (u.name) + "%" -> " + u.id.out + " .")
				end
			end
		end

	json_to_user_role (j: JSON_OBJECT): detachable CMS_USER_ROLE
		do
			if attached json_string_item (j, "name") as l_name and then not l_name.is_whitespace then
				create Result.make (l_name)
				if attached {JSON_ARRAY} j.item ("permissions") as j_permissions then
					across
						j_permissions as ic
					loop
						if attached {JSON_STRING} ic.item as j_permission then
							Result.add_permission (j_permission.unescaped_string_8)
						end
					end
				end
			end
		end

	json_to_user (j: JSON_OBJECT): detachable CMS_USER
		local
			l_roles: ARRAYED_LIST [CMS_USER_ROLE]
			s: STRING_32
		do
			if attached json_string_item (j, "name") as l_name and then not l_name.is_whitespace then
				create Result.make (l_name)
				Result.set_password ("")
				if attached json_string_8_item (j, "email") as l_email then
					Result.set_email (l_email)
				end
				if attached json_string_8_item (j, "profile_name") as l_profile_name then
					Result.set_profile_name (l_profile_name)
				else
					create s.make_empty
					if attached json_string_8_item (j, "profile_firstname") as l_profile_firstname then
						s.append (l_profile_firstname)
					end
					if attached json_string_8_item (j, "profile_lastname") as l_profile_lastname then
						if not s.is_empty then
							s.append_character (' ')
						end
						s.append (l_profile_lastname)
					end
					if not s.is_empty then
						Result.set_profile_name (s)
					end
				end

				if attached {JSON_ARRAY} j.item ("roles") as j_roles then
					create l_roles.make (j_roles.count)
					across
						j_roles as ic
					loop
						if attached {JSON_STRING} ic.item as j_role then
							if attached user_api.user_role_by_name (j_role.unescaped_string_32) as ur then
								l_roles.extend (ur)
							end
						end
					end
					Result.set_roles (l_roles)
				end
			end
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

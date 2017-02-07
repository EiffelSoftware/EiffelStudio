note
	description: "Summary description for {CMS_API_EXPORT_IMP}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_API_EXPORT_IMP

inherit
	CMS_ENCODERS

	CMS_HOOK_EXPORT

	CMS_EXPORT_JSON_UTILITIES

	CMS_FILE_SYSTEM_UTILITIES

feature {NONE} -- Query: API

	user_api: CMS_USER_API
			-- API to access user related data.
		deferred
		end

	cms_api: CMS_API
		deferred
		end

feature -- Export	

	export_to (a_export_id_list: detachable ITERABLE [READABLE_STRING_GENERAL]; a_export_ctx: CMS_EXPORT_CONTEXT; a_response: CMS_RESPONSE)
			-- <Precursor>.
		local
			p: PATH
			d: DIRECTORY
			ja: JSON_ARRAY
			jobj,jo,j: JSON_OBJECT
			f: PLAIN_TEXT_FILE
			u: CMS_USER
		do
			if attached a_response.has_permissions (<<"admin export", "export core">>) then
				if a_export_id_list = Void then -- Include everything
					p := a_export_ctx.location.extended ("core")
					create d.make_with_path (p)
					if not d.exists then
						d.recursive_create_dir
					end

						-- path_aliases export.
					a_export_ctx.log ("Exporting path_aliases")
					create jo.make_empty
					across cms_api.storage.path_aliases as ic loop
						jo.put_string (ic.item, ic.key)
					end
					create f.make_with_path (p.extended ("path_aliases.json"))
					f.create_read_write
					f.put_string (json_to_string (jo))
					f.close

						-- custom_values export.					
					if attached cms_api.storage.custom_values as lst then
						a_export_ctx.log ("Exporting custom_values")
						create ja.make_empty
						across
							lst as ic
						loop
							create j.make_empty
							if attached ic.item.type as l_type then
								j.put_string (l_type, "type")
							end
							j.put_string (ic.item.name, "name")
							if attached ic.item.type as l_value then
								j.put_string (l_value, "value")
							end
							ja.extend (j)
						end
						create f.make_with_path (p.extended ("custom_values.json"))
						f.create_read_write
						f.put_string (json_to_string (ja))
						f.close
					end

						-- user roles export.
					a_export_ctx.log ("Exporting user roles")

					create jobj.make_empty
					across user_api.roles as ic loop
						create j.make_empty
						j.put_string (ic.item.name, "name")
						if attached ic.item.permissions as l_perms then
							create ja.make (l_perms.count)
							across
								l_perms as perms_ic
							loop
								ja.extend (create {JSON_STRING}.make_from_string (perms_ic.item))
							end
							j.put (ja, "permissions")
						end
						jobj.put (j, ic.item.id.out)
					end
					create f.make_with_path (p.extended ("user_roles.json"))
					f.create_read_write
					f.put_string (json_to_string (jo))
					f.close

						-- users export.
					a_export_ctx.log ("Exporting users")

					create jobj.make_empty
					across user_api.recent_users (create {CMS_DATA_QUERY_PARAMETERS}.make (0, user_api.users_count.as_natural_32)) as ic loop
						u := ic.item
						create j.make_empty
						j.put_string (u.name, "name")
						if attached u.profile_name as pn then
							j.put_string (pn, "profile_name")
						end
						j.put_integer (u.status, "status")
						put_string_into_json (u.email, "email", j)
						put_string_into_json (u.password, "password", j)
						put_string_into_json (u.hashed_password, "hashed_password", j)
						put_date_into_json (u.creation_date, "creation_date", j)
						put_date_into_json (u.last_login_date, "last_login_date", j)
						if attached u.roles as l_roles then
							create ja.make (l_roles.count)
							across
								l_roles as roles_ic
							loop
								ja.extend (create {JSON_STRING}.make_from_string_32 ({STRING_32} " %"" + roles_ic.item.name + {STRING_32} "%" #" + roles_ic.item.id.out))
							end
							j.put (ja, "roles")
						end
						jobj.put (j, u.id.out)
					end
					create f.make_with_path (p.extended ("users.json"))
					f.create_read_write
					f.put_string (json_to_string (jobj))
					f.close
				end
			end
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

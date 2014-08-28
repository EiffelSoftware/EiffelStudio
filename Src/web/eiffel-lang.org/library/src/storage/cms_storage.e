note
	description : "[ 
				CMS interface to storage
			]"
	date        : "$Date$"
	revision    : "$Revision$"

deferred class
	CMS_STORAGE

feature {NONE} -- Initialization

	initialize
		do
		end

feature -- Access: user

	has_user: BOOLEAN
			-- Has any user?
		deferred
		end

	fill_user_profile (a_user: CMS_USER)
		deferred
		end

	all_users: LIST [CMS_USER]
		deferred
		end

	user_by_id (a_id: like {CMS_USER}.id): detachable CMS_USER
		require
			a_id > 0
		deferred
		ensure
			same_id: Result /= Void implies Result.id = a_id
			no_password: Result /= Void implies Result.password = Void
		end

	user_by_name (a_name: like {CMS_USER}.name): detachable CMS_USER
		require
			 a_name /= Void and then not a_name.is_empty
		deferred
		ensure
			no_password: Result /= Void implies Result.password = Void
		end

	user_by_email (a_email: like {CMS_USER}.email): detachable CMS_USER
		deferred
		ensure
			no_password: Result /= Void implies Result.password = Void
		end

	is_valid_credential (u, p: READABLE_STRING_32): BOOLEAN
		deferred
		end

feature -- Change: user

	save_user (a_user: CMS_USER)
		deferred
		ensure
			a_user_password_is_encoded: a_user.password = Void
			a_user.has_id
		end

feature -- Access: roles and permissions

	user_has_permission (u: detachable CMS_USER; s: detachable READABLE_STRING_8): BOOLEAN
			-- Anonymous or user `u' has permission for `s' ?
			--| `s' could be "create page",	
		do
			if s = Void then
				Result := True
			elseif u = Void then
				Result := user_role_has_permission (anonymous_user_role, s)
			else
				Result := user_role_has_permission (authenticated_user_role, s)
				if not Result and attached u.roles as l_roles then
					across
						l_roles as r
					until
						Result
					loop
						if attached user_role_by_id (r.item) as ur then
							Result := user_role_has_permission (ur, s)
						end
					end
				end
			end
		end

	anonymous_user_role: CMS_USER_ROLE
		do
			if attached user_role_by_id (1) as l_anonymous then
				Result := l_anonymous
			else
				create Result.make ("anonymous")
			end
		end

	authenticated_user_role: CMS_USER_ROLE
		do
			if attached user_role_by_id (2) as l_authenticated then
				Result := l_authenticated
			else
				create Result.make ("authenticated")
			end
		end

	user_role_has_permission (a_role: CMS_USER_ROLE; s: READABLE_STRING_8): BOOLEAN
		do
			Result := a_role.has_permission (s)
		end

	user_role_by_id (a_id: like {CMS_USER_ROLE}.id): detachable CMS_USER_ROLE
		deferred
		end

	user_roles: LIST [CMS_USER_ROLE]
		deferred
		end

feature -- Change: roles and permissions		

	save_user_role (a_user_role: CMS_USER_ROLE)
		deferred
		end

feature -- Email		

	save_email (a_email: NOTIFICATION_EMAIL)
		deferred
		end

feature -- Log

	recent_logs (a_lower: INTEGER; a_count: INTEGER): LIST [CMS_LOG]
		deferred
		end

	log (a_id: like {CMS_LOG}.id): detachable CMS_LOG
		require
			a_id > 0
		deferred
		end

	save_log (a_log: CMS_LOG)
		deferred
		end

feature -- Node

	recent_nodes (a_lower: INTEGER; a_count: INTEGER): LIST [CMS_NODE]
		deferred
		end

	node (a_id: INTEGER): detachable CMS_NODE
		require
			a_id > 0
		deferred
		end

	save_node (a_node: CMS_NODE)
		deferred
		end

feature -- Misc

	set_custom_value (a_name: READABLE_STRING_8; a_value: attached like custom_value; a_type: READABLE_STRING_8)
			-- Save data `a_name:a_value' for type `a_type'
		deferred
		end

	custom_value (a_name: READABLE_STRING_8; a_type: READABLE_STRING_8): detachable TABLE_ITERABLE [READABLE_STRING_8, STRING_8]
			-- Data for name `a_name' and type `a_type'.
		deferred
		end

	custom_value_names_where (a_where_key, a_where_value: READABLE_STRING_8; a_type: READABLE_STRING_8): detachable LIST [READABLE_STRING_8]
			-- Names where custom value has item `a_where_key' same as `a_where_value' for  type `a_type'.
		deferred
		end

end

note
	description: "[
			Generic CMS Response.
			It builds the content to get process to render the output.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_RESPONSE_I

inherit
	CMS_URL_UTILITIES

	REFACTORING_HELPER

feature {NONE} -- Initialization

	make (req: WSF_REQUEST; res: WSF_RESPONSE; a_api: like api)
		do
			status_code := {HTTP_STATUS_CODE}.ok
			api := a_api
			request := req
			response := res
			create header.make
			site_url := a_api.site_url
			if attached a_api.base_url as l_base_url then
				base_url := l_base_url
			end
			base_path := a_api.base_path
			initialize
		end

	initialize
		local
			s: READABLE_STRING_8
		do
			s := request.percent_encoded_path_info
			if
				attached base_url as l_base_url and then
				s.starts_with (l_base_url)
			then
				s := s.substring (l_base_url.count + 1, s.count)
			end
			if not s.is_empty and then s[1] = '/' then
				create location.make_from_string (s.substring (2, s.count))
			else
				create location.make_from_string (s)
			end
		end

feature -- Access

	request: WSF_REQUEST

	response: WSF_RESPONSE

	status_code: INTEGER

	header: WSF_HEADER

feature -- Settings

	is_site_mode: BOOLEAN
			-- Is site mode?
		do
			Result := api.is_site_mode
		end

	is_webapi_mode: BOOLEAN
			-- Is Web API mode?
		do
			Result := api.is_webapi_mode
		end

	is_administration_mode: BOOLEAN
			-- Is administration mode?
		do
			Result := api.is_administration_mode
		end

feature -- Access: metadata

	keywords: detachable ARRAYED_LIST [READABLE_STRING_32]

	publication_date: detachable DATE_TIME
			-- Optional publication date.

	modification_date: detachable DATE_TIME
			-- Optional modification date.

	redirection: detachable READABLE_STRING_8
			-- Location for eventual redirection.

	redirection_delay: NATURAL
			-- Optional redirection delay in seconds.

	set_metadata (v: READABLE_STRING_32; k: READABLE_STRING_GENERAL)
			-- Set `v` as metadata `k`, replace any previous occurrences (if any).
		local
			md: like metadata
		do
			md := metadata
			if md = Void then
				create md.make (1)
				metadata := md
			end
			md.put (v, k)
		end

	add_metadata (v: READABLE_STRING_32; k: READABLE_STRING_GENERAL)
			-- Add `v` as metadata `k`, allows mutiple occurrences.
		local
			md: like metadata
		do
			md := metadata
			if md = Void then
				create md.make (1)
				metadata := md
			end
			md.add (v, k)
		end

feature -- Change: metadata

	metadata: detachable CMS_RESPONSE_METADATA
			-- Optional metadata.
			-- For instance:
			--	`type` or `og:type`: Optional public type of the response page (related to http://ogp.me/)

feature -- Access: query

	location: IMMUTABLE_STRING_8
			-- Associated cms local location.

	request_url (opts: detachable CMS_API_OPTIONS): STRING_8
			-- Current request location as a url.
		do
			Result := url (location, opts)
		end

feature -- API

	api: CMS_API
			-- Current CMS API.

	setup: CMS_SETUP
			-- Current setup
		do
			Result := api.setup
		end

feature -- URL utilities

	is_front: BOOLEAN
			-- Is current response related to "front" page?
		local
			l_path_info: READABLE_STRING_8
		do
			l_path_info := request.percent_encoded_path_info
			if attached setup.front_page_path as l_front_page_path then
				Result := l_front_page_path.same_string (l_path_info)
			else
				if base_path.same_string (l_path_info) then
					Result := True
				else
					Result := l_path_info.is_empty or else l_path_info.same_string ("/")
				end
			end
		end

	site_url: IMMUTABLE_STRING_8
			-- Absolute site url.
			-- Always ends with '/'

	base_url: detachable IMMUTABLE_STRING_8
			-- Base url if any.
			--| Usually it is Void, but it could be
			--|  /project/demo/

	base_path: IMMUTABLE_STRING_8
			-- Base path, default to "/".
			-- Always ends with '/'
			-- Could be /project/demo/

feature -- Access: CMS

	site_name: STRING_32
		do
			Result := setup.site_name
		end

	front_page_url: READABLE_STRING_8
		do
			Result := absolute_url ("/", Void)
		end

feature -- User access

	is_authenticated: BOOLEAN
			-- Is user authenticated?
		do
			Result := user /= Void
		end

	user: detachable CMS_USER
			-- Active user if authenticated.
		do
			Result := api.user
		end

	set_user (u: CMS_USER)
			-- Set active user to `u'.
		require
			attached_u: u /= Void
		do
			api.set_user (u)
		end

	unset_user
			-- Unset active user.
		do
			api.unset_user
		end

feature -- Permission

	has_permission_on_link (a_link: CMS_LINK): BOOLEAN
			-- Does current user has permission to access link `a_link'?
		do
			Result := True
			if
				attached {CMS_LOCAL_LINK} a_link as lnk and then
				attached lnk.permission_arguments as l_perms
			then
				Result := has_permissions (l_perms)
			end
		end

	has_permission (a_permission: READABLE_STRING_GENERAL): BOOLEAN
			-- Does current user has permission `a_permission' ?
		do
			Result := user_has_permission (user, a_permission)
		end

	has_permissions (a_permission_list: ITERABLE [READABLE_STRING_GENERAL]): BOOLEAN
			-- Does current user has any of the permissions `a_permission_list' ?
		do
			Result := user_has_permissions (user, a_permission_list)
		end

	user_has_permission (a_user: detachable CMS_USER; a_permission: READABLE_STRING_GENERAL): BOOLEAN
			-- Does `a_user' has permission `a_permission' ?
		do
			Result := api.user_has_permission (a_user, a_permission)
		end

	user_has_permissions (a_user: detachable CMS_USER; a_permission_list: ITERABLE [READABLE_STRING_GENERAL]): BOOLEAN
			-- Does `a_user' has any of the permissions `a_permission_list' ?
		do
			Result := api.user_has_permissions (a_user, a_permission_list)
		end

feature -- Element change				

	add_keyword (a_keyword: READABLE_STRING_GENERAL)
			-- Add keyword `keyword` to the existing list of keywords.
		local
			lst: like keywords
		do
			lst := keywords
			if lst = Void then
				create lst.make (1)
				keywords := lst
			end
			lst.force (a_keyword.to_string_32)
		end

	set_publication_date (dt: like publication_date)
		do
			publication_date := dt
			if dt /= Void and modification_date = Void then
				modification_date := dt
			end
		end

	set_modification_date (dt: like modification_date)
		do
			modification_date := dt
			if dt /= Void and publication_date = Void then
				publication_date := dt
			end
		end

	set_redirection (a_location: READABLE_STRING_8)
			-- Set `redirection' to `a_location'.
		do
			redirection := a_location
		end

	set_redirection_delay (nb_secs: NATURAL)
		do
			redirection_delay := nb_secs
		end

feature -- Hooks

	hooks: CMS_HOOK_CORE_MANAGER
			-- Manager handling hook subscriptions.
		obsolete
			"Use api.hooks [2017-05-31]"
		do
			Result := api.hooks
		end

feature -- Internationalization (i18n)

	html_translation (a_text: READABLE_STRING_GENERAL; opts: detachable CMS_API_OPTIONS): STRING_8
			-- Translated HTML text `a_text' according to expected context (lang, ...)
			-- and adapt according to options eventually set by `opts'.
		do
			Result := html_encoded (api.translation (a_text, opts))
		end

	translation (a_text: READABLE_STRING_GENERAL; opts: detachable CMS_API_OPTIONS): STRING_32
			-- Translated text `a_text' according to expected context (lang, ...)
			-- and adapt according to options eventually set by `opts'.
		do
			Result := api.translation (a_text, opts)
		end

	formatted_string (a_text: READABLE_STRING_GENERAL; args: TUPLE): STRING_32
			-- Format `a_text' using arguments `args'.
			--| ex: formatted_string ("hello $1, see page $title.", ["bob", "contact"] -> "hello bob, see page contact"
		do
			Result := api.formatted_string (a_text, args)
		end

feature -- Element Change

	set_status_code (a_status: INTEGER)
			-- Set `status_code' with `a_status'.
		note
			EIS: "src=eiffel:?class=HTTP_STATUS_CODE"
		do
			status_code := a_status
		ensure
			status_code_set: status_code = a_status
		end

feature -- Helpers: cms link

	webapi_link (a_title: READABLE_STRING_GENERAL; a_relative_location: detachable READABLE_STRING_8): CMS_LOCAL_LINK
		require
			no_first_slash: a_relative_location = Void or else not a_relative_location.starts_with_general ("/")
		do
			Result := api.webapi_link (a_title, a_relative_location)
		end

	administration_link (a_title: READABLE_STRING_GENERAL; a_relative_location: detachable READABLE_STRING_8): CMS_LOCAL_LINK
		require
			no_first_slash: a_relative_location = Void or else not a_relative_location.starts_with_general ("/")
		do
			Result := api.administration_link (a_title, a_relative_location)
		end

	local_link (a_title: READABLE_STRING_GENERAL; a_location: READABLE_STRING_8): CMS_LOCAL_LINK
		do
			Result := api.local_link (a_title, a_location)
		end

	user_local_link (u: CMS_USER; a_opt_title: detachable READABLE_STRING_GENERAL): CMS_LOCAL_LINK
		do
			Result := api.user_local_link (u, a_opt_title)
		end

feature -- Helpers: html links

	user_profile_name, user_display_name (u: CMS_USER): READABLE_STRING_32
		do
			Result := api.user_display_name (u)
		end

feature -- Helpers: URLs	

	location_absolute_url (a_location: READABLE_STRING_8; opts: detachable CMS_API_OPTIONS): STRING
			-- Absolute URL for `a_location'.
			--| Options `opts' could be
			--|  - absolute: True|False	=> return absolute url
			--|  - query: string		=> append "?query"
			--|  - fragment: string		=> append "#fragment"
		do
			Result := api.location_absolute_url (a_location, opts)
		end

	location_url (a_location: READABLE_STRING_8; opts: detachable CMS_API_OPTIONS): STRING
			-- URL for `a_location'.
			--| Options `opts' could be
			--|  - absolute: True|False	=> return absolute url
			--|  - query: string		=> append "?query"
			--|  - fragment: string		=> append "#fragment"
		do
			Result := api.location_url (a_location, opts)
		end

	module_resource_url (a_module: CMS_MODULE; a_path: READABLE_STRING_8; opts: detachable CMS_API_OPTIONS): STRING_8
			-- Url for resource `a_path` associated with module `a_module`.
		require
			a_valid_valid: a_path.is_empty or else a_path.starts_with ("/")
		do
			Result := url ("/module/" + a_module.name + a_path, opts)
		end

	module_name_resource_url (a_module_name: READABLE_STRING_8; a_path: READABLE_STRING_8; opts: detachable CMS_API_OPTIONS): STRING_8
			-- Url for resource `a_path` associated with module `a_module_name`.
		require
			a_valid_valid: a_path.is_empty or else a_path.starts_with ("/")
		do
			Result := url ("/module/" + a_module_name + a_path, opts)
		end

	user_url (u: CMS_USER): like url
		require
			u_with_id: u.has_id
		do
			Result := api.user_url (u)
		end

feature -- Execution

	execute
		deferred
		end

note
	copyright: "2011-2022, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

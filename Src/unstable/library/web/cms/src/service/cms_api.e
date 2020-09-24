note
	description: "API for a CMS"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_API

inherit
	CMS_HOOK_EXPORT
	CMS_API_EXPORT_IMP

	CMS_HOOK_IMPORT
	CMS_API_IMPORT_IMP

	CMS_ENCODERS

	CMS_URL_UTILITIES

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialize

	make (a_setup: CMS_SETUP; req: WSF_REQUEST; resp: WSF_RESPONSE)
			-- Create the API service with a setup `a_setup'
			-- and request `req', response `resp`.
		do
			request := req
			response := resp
			setup := a_setup
			create error_handler.make
			create {CMS_ENV_LOGGER} logger.make
			create hooks.make
			initialize
		ensure
			setup_set: setup = a_setup
			error_handler_set: not error_handler.has_error
		end

	initialize
				-- Initialize the persitent layer.
		local
			l_module: CMS_MODULE
			l_enabled_modules: CMS_MODULE_COLLECTION
			l_uninstalled_mods: detachable ARRAYED_LIST [CMS_MODULE]
			s: IMMUTABLE_STRING_8
		do
				-- Initialize site_url
			initialize_site_url

				-- Administration backend
			s := setup.administration_base_path
			administration_base_path_location := s.shared_substring (2, s.count)

				-- Webapi backend
			s := setup.webapi_base_path
			webapi_base_path_location := s.shared_substring (2, s.count)

				-- Initialize contents.
			initialize_content_types

				-- Initialize filters and formats.
			initialize_content_filters_and_formats

				-- Initialize storage.
			has_storage_error := False
			if attached setup.storage (error_handler) as l_storage then
				storage := l_storage
				has_storage_error := error_handler.has_error
			else
				create {CMS_STORAGE_NULL} storage
				storage.error_handler.append (error_handler)
				has_storage_error := error_handler.has_error
				error_handler.remove_all_errors
			end

				-- Keep enable modules list.
			create l_enabled_modules.make (setup.modules.count)
			enabled_modules := l_enabled_modules
			setup.fill_enabled_modules (Current)

				-- Complete storage setup.
			storage.set_api (Current)

				-- Initialize enabled modules.
			across
				l_enabled_modules as ic
			loop
				l_module := ic.item
					-- FIXME: should we initialize first, and then install
					-- or the reverse, or merge installation and initialization
					-- and leave the responsability to the module to know
					-- if this is installed or not...
				if attached {CMS_CORE_MODULE} l_module as l_core_module then
					if not l_core_module.is_installed (Current) then
						l_core_module.install (Current)
					end
				end
--				if not l_module.is_installed (Current) then
--					l_module.install (Current)
--				end
				if l_module.is_installed (Current) then
					l_module.initialize (Current)
				else
					if l_uninstalled_mods = Void then
						create l_uninstalled_mods.make (1)
					end
					l_uninstalled_mods.force (l_module)
				end
			end
			if l_uninstalled_mods /= Void then
				across
					l_uninstalled_mods as ic
				loop
					l_enabled_modules.remove (ic.item)
				end
			end

				-- hooks initialization, is done after site/admin switch.
				-- See `initialize_execution`
		end

	initialize_site_url
				-- Initialize site and base url.
		local
			l_base_url: detachable READABLE_STRING_8
			l_url: detachable STRING_8
			i,j: INTEGER
		do
				--| WARNING: do not use `absolute_url' and `url', since it relies on site_url and base_url.
			if attached setup.site_url as l_site_url and then not l_site_url.is_empty then
				create l_url.make_from_string (l_site_url)
			else
				l_url := request.absolute_script_url ("/")
			end
			check is_not_empty: not l_url.is_empty end
			if l_url [l_url.count] /= '/' then
				l_url.append_character ('/')
			end
			site_url := l_url
			i := l_url.substring_index ("://", 1)
			if i > 0 then
				j := l_url.index_of ('/', i + 3)
				if j > 0 then
					l_base_url := l_url.substring (j, l_url.count)
				end
			end
			if l_base_url /= Void then
				base_url := l_base_url
				if l_base_url.ends_with_general ("/") then
					create base_path.make_from_string (l_base_url)
				else
					create base_path.make_from_string (l_base_url + "/")
				end
			else
				create base_path.make_from_string ("/")
			end
		ensure
			site_url_set: site_url /= Void
			site_url_ends_with_slash: site_url.ends_with_general ("/")
			base_path_set: base_path /= Void and then base_path.ends_with_general ("/")
		end

	initialize_content_types
			-- Initialize content types.
		do
			create content_types.make (1)
			create content_type_webform_managers.make (1)
		end

	initialize_content_filters_and_formats
			-- Initialize content filters and formats.
		local
			l_filters: like content_filters
		do
				-- Initialize built-in content filters
			create l_filters.make (4)
			content_filters := l_filters
			l_filters.extend (create {HTML_TO_TEXT_CONTENT_FILTER})
			l_filters.extend (create {LINE_BREAK_TO_HTML_CONTENT_FILTER})
			l_filters.extend (create {URL_CONTENT_FILTER})
			l_filters.extend (create {HTML_CONTENT_FILTER})
			l_filters.extend (create {SECURITY_HTML_CONTENT_FILTER})


				-- Initialize built-in formats
			create formats.make (4)
		end

	setup_formats
			-- Initialize content filters and formats.
		local
			l_formats: like formats
		do
			load_formats
			l_formats := formats
			if l_formats.count = 0 then
					-- Setup built-in formats

					-- plain_text: html_to_text + line_break_converter
				l_formats.extend (new_format ("plain_text", "Plain text", <<{HTML_TO_TEXT_CONTENT_FILTER}.name, {LINE_BREAK_TO_HTML_CONTENT_FILTER}.name>>))

					-- full_html: url
				l_formats.extend (new_format ("full_html", "Full HTML", <<{URL_CONTENT_FILTER}.name>>))

					-- filtered_html: url + html_filter + line_break_converter
				l_formats.extend (new_format ("filtered_html", "Filtered HTML", <<{URL_CONTENT_FILTER}.name, {HTML_CONTENT_FILTER}.name, {LINE_BREAK_TO_HTML_CONTENT_FILTER}.name, {SECURITY_HTML_CONTENT_FILTER}.name>>))

					-- CMS Editor!
				l_formats.extend (new_format ("cms_editor", "CMS HTML content", Void))

				save_formats
			end
		end

feature {CMS_API_ACCESS} -- CMS Formats management

	load_formats
		local
			f: CMS_FORMAT
			jp: JSON_PARSER
			s: STRING_32
			l_name, l_title: READABLE_STRING_8
		do
			formats.wipe_out
			if
				attached storage.custom_value ("cms.formats", "api-formats") as v_formats and then
				v_formats.is_valid_as_string_8
			then
				create jp.make_with_string (v_formats.to_string_8)
				jp.parse_content
				if jp.is_parsed and then jp.is_valid and then attached jp.parsed_json_object as j_formats then
						-- { "plain_text": { "title": "Plain text", "filters": "plain_text+foobar+toto"}, ...}
					across
						j_formats as ic
					loop
						if attached {JSON_OBJECT} ic.item as j_format then
							l_name := ic.key.unescaped_string_8
							if attached {JSON_STRING} j_format.item ("title") as j_title then
								l_title := j_title.unescaped_string_8
							else
								l_title := l_name
							end
							if attached {JSON_STRING} j_format.item ("filters") as j_filters then
								s := j_filters.unescaped_string_32
								f := new_format (l_name, l_title, s.split ('+'))
							else
								f := new_format (l_name, l_title, Void)
							end
							formats.extend (f)
							if attached {JSON_STRING} j_format.item ("types") as j_types then
								s := j_types.unescaped_string_32
								across
									s.split ('+') as s_ic
								loop
									if attached content_type (s_ic.item) as ct then
										ct.extend_format (f)
									end
								end
							end
						end
					end
				end
			end
		end

	save_formats
			-- Save `formats`.
		local
			f: CMS_FORMAT
			j,ji: JSON_OBJECT
			s: STRING_32
			ct: CMS_CONTENT_TYPE
		do
				-- { "plain_text": { "title": "Plain text", "filters": "plain_text+foobar+toto"}, ...}
			create j.make_empty
			across
				formats as ic
			loop
				f := ic.item
				create ji.make
				ji.put_string (f.title, "title")

				create s.make_empty
				across
					f.filters as f_ic
				loop
					if not s.is_empty then
						s.append ("+")
					end
					s.append_string_general (f_ic.item.name)
				end
				ji.put_string (s, "filters")

				create s.make_empty
				across
					content_types as ct_ic
				loop
					ct := ct_ic.item
					if ct.has_format (f.name) then
						if not s.is_empty then
							s.append ("+")
						end
						s.append_string_general (ct.name)
					end
				end
				ji.put_string (s, "types")

				j.put (ji, f.name)
			end
			storage.set_custom_value ("cms.formats", j.representation, "api-formats")
		end

feature -- Execution initialization

	initialize_execution
		do
			setup_hooks
			setup_formats
		end

feature {CMS_ACCESS} -- Module management

	install_all_modules
			-- Install CMS or uninstalled module which are enabled.
		local
			l_module: CMS_MODULE
			l_tmp_err_handler: ERROR_HANDLER
		do
			create l_tmp_err_handler.make_with_id ("cms_api.install_all_modules")
			across
				setup.modules as ic
			loop
				l_module := ic.item
					-- FIXME: should we initialize first, and then install
					-- or the reverse, or merge installation and initialization
					-- and leave the responsability to the module to know
					-- if this is installed or not...
				if l_module.is_enabled and not l_module.is_installed (Current) then
					install_module (l_module)
					if has_error then
						l_tmp_err_handler.append (error_handler)
						reset_error
					end
				end
			end
			if l_tmp_err_handler.has_error then
				error_handler.append (l_tmp_err_handler)
			end
		end

 	installed_module_version (m: CMS_MODULE): detachable READABLE_STRING_32
 		require
 			module_installed: is_module_installed (m)
 		do
 			Result := m.installed_version (Current)
 		end

	install_module (m: CMS_MODULE)
			-- Install module `m'.
		require
			module_not_installed: not is_module_installed (m)
		do
			m.install (Current)
			if not has_error and then m.is_enabled then
				m.initialize (Current)
			end
		end

	uninstall_module (m: CMS_MODULE)
			-- Uninstall module `m'.
		require
			module_installed: is_module_installed (m)
		do
			m.uninstall (Current)
		end

	update_module (m: CMS_MODULE; a_installed_version: READABLE_STRING_GENERAL)
			-- Update module `m'.
		require
			module_installed: is_module_installed (m)
		do
			m.update (a_installed_version, Current)
		end

	enable_module (m: CMS_MODULE)
			-- Enable module `m'.
		do
			m.update_status_in_storage (True, Current)
		ensure
			module_enabled: is_module_enabled (m)
		end

	disable_module (m: CMS_MODULE)
			-- Disable module `m'.
		do
			m.update_status_in_storage (False, Current)
		ensure
			module_disabled: not is_module_enabled (m)
		end

feature -- Access

	setup: CMS_SETUP
			-- CMS setup.

	logger: CMS_LOGGER
			-- Logger

	storage: CMS_STORAGE
			-- Default persistence storage.

feature -- Access: url

	base_url: detachable IMMUTABLE_STRING_8
			-- Base url if any.
			--| Usually it is Void, but it could be
			--|  /project/demo/

	base_path: IMMUTABLE_STRING_8
			-- Base path, default to "/"

	site_url: IMMUTABLE_STRING_8
			-- Site url

feature -- Access: WebAPI

	is_webapi_request (req: WSF_REQUEST): BOOLEAN
		do
			Result := setup.webapi_enabled and then req.percent_encoded_path_info.starts_with_general (setup.webapi_base_path)
		end

	webapi_path (a_relative_path: detachable READABLE_STRING_8): STRING_8
		require
			is_webapi_enabled: setup.webapi_enabled
		do
			create Result.make_from_string (setup.webapi_base_path)
			if a_relative_path /= Void then
				if a_relative_path.is_empty then
					Result.append_character ('/')
				else
					if a_relative_path[1] /= '/' then
						Result.append_character ('/')
					end
					Result.append (a_relative_path)
				end
			end
		end

	webapi_path_location (a_relative_location: detachable READABLE_STRING_8): STRING_8
		require
			is_webapi_enabled: setup.webapi_enabled
			no_first_slash: a_relative_location = Void or else not a_relative_location.starts_with_general ("/")
		do
			create Result.make_from_string (webapi_base_path_location)
			if a_relative_location /= Void then
				if a_relative_location.is_empty then
					Result.append_character ('/')
				else
					if a_relative_location[1] /= '/' then
						Result.append_character ('/')
					end
					Result.append (a_relative_location)
				end
			end
		end

feature {NONE} -- Implementation/WebAPI.

	webapi_base_path_location: IMMUTABLE_STRING_8
			-- Webapi path without first slash!

feature -- Access: Administration

	is_administration_request (req: WSF_REQUEST): BOOLEAN
		do
			Result := req.percent_encoded_path_info.starts_with_general (setup.administration_base_path)
		end

	administration_path (a_relative_path: detachable READABLE_STRING_8): STRING_8
		do
			create Result.make_from_string (setup.administration_base_path)
			if a_relative_path /= Void then
				if a_relative_path.is_empty then
					Result.append_character ('/')
				else
					if a_relative_path[1] /= '/' then
						Result.append_character ('/')
					end
					Result.append (a_relative_path)
				end
			end
		end

	administration_path_location (a_relative_location: detachable READABLE_STRING_8): STRING_8
		require
			no_first_slash: a_relative_location = Void or else not a_relative_location.starts_with_general ("/")
		do
			create Result.make_from_string (administration_base_path_location)
			if a_relative_location /= Void then
				if a_relative_location.is_empty then
					Result.append_character ('/')
				else
					if a_relative_location[1] /= '/' then
						Result.append_character ('/')
					end
					Result.append (a_relative_location)
				end
			end
		end

feature {NONE} -- Implementation/ Administration

	administration_base_path_location: IMMUTABLE_STRING_8
			-- Administration path without first slash!

feature -- CMS links

	webapi_link (a_title: READABLE_STRING_GENERAL; a_relative_location: detachable READABLE_STRING_8): CMS_LOCAL_LINK
		require
			no_first_slash: a_relative_location = Void or else not a_relative_location.starts_with_general ("/")
		do
			Result := local_link (a_title, webapi_path_location (a_relative_location))
		end

	administration_link (a_title: READABLE_STRING_GENERAL; a_relative_location: detachable READABLE_STRING_8): CMS_LOCAL_LINK
		require
			no_first_slash: a_relative_location = Void or else not a_relative_location.starts_with_general ("/")
		do
			Result := local_link (a_title, administration_path_location (a_relative_location))
		end

	local_link (a_title: detachable READABLE_STRING_GENERAL; a_location: READABLE_STRING_8): CMS_LOCAL_LINK
		do
			create Result.make (a_title, a_location)
		end

	user_local_link (u: CMS_USER; a_opt_title: detachable READABLE_STRING_GENERAL): CMS_LOCAL_LINK
		do
			if a_opt_title /= Void then
				create Result.make (a_opt_title, user_url (u))
			else
				create Result.make (user_display_name (u), user_url (u))
			end
		end

	user_html_link (u: CMS_USER): STRING
		require
			u_with_name: not u.name.is_whitespace
		do
			Result := link (real_user_display_name (u), "user/" + u.id.out, Void)
		end

	user_html_administration_link (u: CMS_USER): STRING
		require
			u_with_name: not u.name.is_whitespace
		do
			Result := link (real_user_display_name (u), administration_path_location ("user/" + u.id.out), Void)
		end

feature -- Helpers: URLs

	location_absolute_url (a_location: READABLE_STRING_8; opts: detachable CMS_API_OPTIONS): STRING
			-- Absolute URL for `a_location'.
			--| Options `opts' could be
			--|  - absolute: True|False	=> return absolute url
			--|  - query: string		=> append "?query"
			--|  - fragment: string		=> append "#fragment"
		do
			Result := absolute_url (a_location, opts)
		end

	location_url (a_location: READABLE_STRING_8; opts: detachable CMS_API_OPTIONS): STRING
			-- URL for `a_location'.
			--| Options `opts' could be
			--|  - absolute: True|False	=> return absolute url
			--|  - query: string		=> append "?query"
			--|  - fragment: string		=> append "#fragment"
		do
			Result := url (a_location, opts)
		end

	user_url (u: CMS_USER): like url
		require
			u_with_id: u.has_id
		do
			Result := location_url ("user/" + u.id.out, Void)
		end

feature -- Helpers: html links

	user_display_name (u: CMS_USER): READABLE_STRING_32
			-- User profile name or name.
		do
			Result := user_api.user_display_name (u)
		end

	real_user_display_name (u: CMS_USER): READABLE_STRING_32
			-- Real user profile name or name, even if `u` has only user `id` value.
		do
			Result := user_api.real_user_display_name (u)
		end

feature -- Settings

	switch_to_site_mode
		do
			if not is_site_mode then
				setup.set_site_mode
				mode := mode_site
			end
		end

	switch_to_webapi_mode
		do
			if not is_webapi_mode then
				setup.set_webapi_mode
				mode := mode_webapi
			end
		end

	switch_to_administration_mode
		do
			if not is_administration_mode then
				setup.set_administration_mode
				mode := mode_administration
			end
		end

	mode: NATURAL_8

	mode_site: NATURAL_8 = 0
	mode_administration: NATURAL_8 = 1
	mode_webapi: NATURAL_8 = 2

	is_site_mode: BOOLEAN
		do
			Result := mode = mode_site
		end

	is_administration_mode: BOOLEAN
			-- Is administration mode?
		do
			Result := mode = mode_administration
		end

	is_webapi_mode: BOOLEAN
			-- Is webapi mode?
		do
			Result := mode = mode_webapi
		end

	is_debug: BOOLEAN
			-- Is debug mode enabled?
		do
			Result := setup.is_debug
		end

feature {NONE} -- Access: request

	request: WSF_REQUEST
			-- Associated http request.
			--| note: here for the sole purpose of CMS_API.

	response: WSF_RESPONSE
			-- Associated http response.
			--| note: here for the sole purpose of CMS_API, mainly to report error.

feature -- Access: request

	self_link: CMS_LOCAL_LINK
		local
			s: READABLE_STRING_8
			loc: READABLE_STRING_8
		do
			s := request.percent_encoded_path_info
			if not s.is_empty and then s[1] = '/' then
				loc := s.substring (2, s.count)
			else
				loc := s
			end
			if attached request.query_string as q and then not q.is_whitespace then
				loc := loc + "?" + q
			end
			Result := local_link (Void, loc)
		end

feature -- Content

	content_types: ARRAYED_LIST [CMS_CONTENT_TYPE]
			-- Available content types

	add_content_type (a_type: CMS_CONTENT_TYPE)
			-- Register content type `a_type'.
		do
			content_types.force (a_type)
		end

	content_type (a_name: READABLE_STRING_GENERAL): detachable CMS_CONTENT_TYPE
			-- Content type named `a_named' if any.
		do
			across
				content_types as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if not a_name.is_case_insensitive_equal (Result.name) then
					Result := Void
				end
			end
		end

feature -- Content type webform

	content_type_webform_managers: ARRAYED_LIST [CMS_CONTENT_TYPE_WEBFORM_MANAGER [CMS_CONTENT]]
			-- Available content types

	add_content_type_webform_manager (a_manager: CMS_CONTENT_TYPE_WEBFORM_MANAGER [CMS_CONTENT])
			-- Register webform manager `a_manager'.
		do
			content_type_webform_managers.force (a_manager)
		end

	content_type_webform_manager (a_content_type: CMS_CONTENT_TYPE): detachable CMS_CONTENT_TYPE_WEBFORM_MANAGER [CMS_CONTENT]
			-- Web form manager for content type `a_content_type' if any.
		do
			Result := content_type_webform_manager_by_name (a_content_type.name)
		end

	content_type_webform_manager_by_name (a_content_type_name: READABLE_STRING_GENERAL): detachable CMS_CONTENT_TYPE_WEBFORM_MANAGER [CMS_CONTENT]
			-- Web form manager for content type named `a_content_type_name' if any.
		do
			across
				content_type_webform_managers as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if not a_content_type_name.is_case_insensitive_equal (Result.name) then
					Result := Void
				end
			end
		end

feature -- Filters and Formats

	content_filters: CMS_CONTENT_FILTERS
			-- Available content filters.

	formats: CMS_FORMATS
			-- Available content formats.

	format (a_format_name: detachable READABLE_STRING_GENERAL): detachable CMS_FORMAT
			-- Content format named `a_format_name' if any.
		do
			Result := formats.item (a_format_name)
		end

	append_text_formatted_to (a_format_name: detachable READABLE_STRING_GENERAL; a_text: READABLE_STRING_GENERAL; a_output: STRING_GENERAL)
			-- Append `a_text`  to `a_output`, formatted with format named `a_format_name` or using `formats.default_format`.
		do
			if attached secured_format (a_format_name) then

			end
			if attached format (a_format_name) as ft then
				ft.append_formatted_to (a_text, a_output)
			else
				formats.default_format.append_formatted_to (a_text, a_output)
			end
		end

	formatted_text (a_format_name: detachable READABLE_STRING_GENERAL; a_text: READABLE_STRING_GENERAL): STRING_GENERAL
			-- Append `a_text`  to `a_output`, formatted with format named `a_format_name` or using `formats.default_format`.
		do
			if attached {READABLE_STRING_8} a_text as s8 then
				create {STRING_8} Result.make (a_text.count)
			else
				create {STRING_32} Result.make (a_text.count)
			end
			append_text_formatted_to (a_format_name, a_text, Result)
		end

	secured_format (a_format_name: detachable READABLE_STRING_GENERAL): CMS_FORMAT
			-- Content format named `a_format_name` (if any) chained with security vulnerability filter.
		do
			Result := format (a_format_name)
			if Result = Void then
				if attached {CMS_FORMAT} formats.default_format as dft then
					Result := dft
				else
					create Result.make_from_format (formats.default_format)
				end
			end
			if not Result.has_filter_by_name ({SECURITY_HTML_CONTENT_FILTER}.name) then
				create Result.make ("secured format", Void)
				Result.import_filters_from_format (Result)
				Result.add_filter (create {SECURITY_HTML_CONTENT_FILTER})
			end
		end

	new_format (a_name: READABLE_STRING_8; a_title: READABLE_STRING_8; a_filter_names: detachable ITERABLE [READABLE_STRING_GENERAL]): CMS_FORMAT
			-- New cms content format named `a_name`, with `a_title`, and composed from `a_filter_names`.
		do
			create Result.make (a_name, a_title)
			if a_filter_names /= Void then
				across
					a_filter_names as ic
				loop
					if attached content_filters.item (ic.item) as f then
						Result.add_filter (f)
					end
				end
			end
		end

feature -- Template

	resolved_smarty_template_text (a_loc: PATH): detachable READABLE_STRING_8
			-- Resolved smarty template located at `a_loc`.
		local
			smt: CMS_SMARTY_TEMPLATE_TEXT
		do
			smt := resolved_smarty_template (a_loc)
			if smt /= Void then
				Result := smt.string
			end
		end

	resolved_smarty_template (a_loc: PATH): detachable CMS_SMARTY_TEMPLATE_TEXT
			-- Resolved smarty template located at `a_loc`.
		do
			if attached file_content (a_loc) as txt then
				create Result.make (txt)
				across
					builtin_variables as ic
				loop
					Result.set_value (ic.item, ic.key)
				end
			end
		end

feature -- Status Report

	has_storage_error: BOOLEAN
			-- Has storage issue?
			--| Can not connect, or database not found, or ...

	has_error: BOOLEAN
			-- Has error?
		do
			Result := error_handler.has_error
		end

	string_representation_of_errors: STRING_32
			-- String representation of all error(s).
		require
			has_error: has_error
		do
			Result := error_handler.as_string_representation
		end

feature -- Logging

	logs (a_category: detachable READABLE_STRING_GENERAL; a_level: INTEGER; params: detachable CMS_DATA_QUERY_PARAMETERS): LIST [CMS_LOG]
			-- List of recent logs, and if `params` is set, from `params.offset' to `params.offset + params.a_count'.
			-- If `a_category' is set, filter to return only associated logs.
			-- If `a_level > 0' , filter to return only associated logs for that level.
			-- If `params.count' <= 0 then, return all logs.
		do
			if params /= Void then
				Result := storage.logs (a_category, a_level, params.offset.to_integer_32, params.size.to_integer_32)
			else
				Result := storage.logs (a_category, a_level, 0, 0)
			end
		end

	log	(a_category: READABLE_STRING_8; a_message: READABLE_STRING_8; a_level: INTEGER; a_link: detachable CMS_LINK)
		local
			l_log: CMS_LOG
			m: STRING
		do
			create l_log.make (a_category, a_message, a_level, Void)
			if a_link /= Void then
				l_log.set_link (a_link)
			end
			storage.save_log (l_log)

			create m.make_from_string ("[" + a_category + "] ")
			m.append (a_message)
			if a_link /= Void then
				m.append (" [" + url_encoded (a_link.title) + "]("+ a_link.location +")")
			end

			inspect a_level
			when {CMS_LOG}.level_emergency then
				response.put_error (m)
				logger.put_alert (m, Void)
			when {CMS_LOG}.level_alert then
				response.put_error (m)
				logger.put_alert (m, Void)
			when {CMS_LOG}.level_critical then
				response.put_error (m)
				logger.put_critical (m, Void)
			when {CMS_LOG}.level_error then
				response.put_error (m)
				logger.put_error (m, Void)
			when {CMS_LOG}.level_warning then
				logger.put_warning (m, Void)
			when {CMS_LOG}.level_notice then
				logger.put_information (m, Void)
			when {CMS_LOG}.level_info then
				logger.put_information (m, Void)
			when {CMS_LOG}.level_debug then
				response.put_error (m)
				logger.put_debug (m, Void)
			else
				logger.put_debug (m, Void)
			end
		end

	log_error (a_category: READABLE_STRING_8; a_message: READABLE_STRING_8; a_link: detachable CMS_LINK)
		do
			log (a_category, a_message, {CMS_LOG}.level_error, a_link)
		end

	log_debug (a_category: READABLE_STRING_8; a_message: READABLE_STRING_8; a_link: detachable CMS_LINK)
		do
			log (a_category, a_message, {CMS_LOG}.level_debug, a_link)
		end

feature -- Internationalization (i18n)

	translation (a_text: READABLE_STRING_GENERAL; opts: detachable CMS_API_OPTIONS): STRING_32
			-- Translated text `a_text' according to expected context (lang, ...)
			-- and adapt according to options eventually set by `opts'.
		do
			to_implement ("Implement i18n support [2015-may]")
			Result := a_text.as_string_32
		end

	formatted_string (a_text: READABLE_STRING_GENERAL; args: TUPLE): STRING_32
			-- Format `a_text' using arguments `args'.
			--| ex: formatted_string ("hello $1, see page $title.", ["bob", "contact"] -> "hello bob, see page contact"
		local
			l_formatter: CMS_STRING_FORMATTER
		do
			create l_formatter
			Result := l_formatter.formatted_string (a_text, args)
		end

feature -- Formating		

	formatted_date_time_ago (dt: DATE_TIME): STRING_8
			-- Output date `dt` using time ago duration.
		local
			ago: DATE_TIME_AGO_CONVERTER
		do
			create ago.make
			create Result.make (10)
			Result.append_string_general (ago.smart_date_duration (dt))
		end

	formatted_date_time_yyyy_mm_dd (dt: DATE_TIME): STRING_8
			-- Output date `dt` using YYYY-MM-DD
		local
			i: INTEGER
		do
			create Result.make (10)
			Result.append_integer (dt.year)
			Result.append_character ('-')
			i := dt.month
			if i <= 9 then
				Result.append_character ('0')
			end
			Result.append_integer (i)
			Result.append_character ('-')
			i := dt.day
			if i <= 9 then
				Result.append_character ('0')
			end
			Result.append_integer (i)
		end

	formatted_date_time_yyyy_mm_dd__hh_min_ss (dt: DATE_TIME): STRING_8
			-- Output date `dt` using YYYY-MM-DD h:min:sec
		local
			i: INTEGER
		do
			create Result.make (19)
			Result.append (formatted_date_time_yyyy_mm_dd (dt))
			Result.append_character (' ')
			i := dt.hour
			if i <= 9 then
				Result.append_character ('0')
			end
			Result.append_integer (i)
			Result.append_character (':')
			i := dt.minute
			if i <= 9 then
				Result.append_character ('0')
			end
			Result.append_integer (i)
			Result.append_character (':')
			i := dt.second
			if i <= 9 then
				Result.append_character ('0')
			end
			Result.append_integer (i)
		end

feature -- Factory

	random_generator: RANDOM
			-- New generator of random value.
		once
			create Result.make
--			Result.set_seed ((100 * (create {DATE_TIME}.make_now_utc).fine_second).truncated_to_integer)
			Result.set_seed (random_seed)
			Result.start
		end

	random_seed: INTEGER
			-- Seed of the random number generator.
		local
			l_seed: NATURAL_64
			l_date: C_DATE
		do
			create l_date
				-- Compute the seed as number of milliseconds since EPOC (January 1st 1970)
			l_seed := (l_date.year_now - 1970).to_natural_64 * 12 * 30 * 24 * 60 * 60 * 1000
			l_seed := l_seed + l_date.month_now.to_natural_64 * 30 * 24 * 60 * 60 * 1000
			l_seed := l_seed + l_date.day_now.to_natural_64 * 24 * 60 * 60 * 1000
			l_seed := l_seed + l_date.hour_now.to_natural_64 * 60 * 60 * 1000
			l_seed := l_seed + l_date.minute_now.to_natural_64 * 60 * 1000
			l_seed := l_seed + l_date.second_now.to_natural_64 * 1000
			l_seed := l_seed + l_date.millisecond_now.to_natural_64
				-- Use RFC 4122 trick to preserve as much meaning of `l_seed' onto an INTEGER_32.
			Result := (l_seed |>> 32).bit_xor (l_seed).as_integer_32 & 0x7FFFFFFF
		ensure
			instance_free: class
		end

	new_uppercase_uuid: STRING
		do
			Result := {UUID_GENERATOR}.generate_uuid.out
		end

	new_lowercase_uuid: STRING
		do
			Result := {UUID_GENERATOR}.generate_uuid.out.as_lower
		end

	new_random_identifier (a_length: INTEGER; a_chars: detachable READABLE_STRING_8): STRING
		require
			a_chars /= Void implies a_chars.count > 1
		local
			rnd: RANDOM
			n,i: INTEGER
		do
			rnd := random_generator
			create Result.make_filled ('_', a_length)
			n := a_length
			if a_chars /= Void then
				from until n = 0 loop
					rnd.forth
					i := rnd.item \\ a_chars.count
					Result [n] := a_chars[i + 1]
					n := n - 1
				end
			else
				from until n = 1 loop
					rnd.forth
					i := rnd.item \\ 36
					if i <= 9 then
						Result [n] := '0' + i
					else
						Result [n] := 'A' + i - 10
					end
					n := n - 1
				end
				Result.put ('A' + i \\ 26, 1) -- Start with a letter!
			end
		end

feature -- Emails

	new_email (a_to_address: READABLE_STRING_8; a_subject: READABLE_STRING_8; a_content: READABLE_STRING_8): CMS_EMAIL
			-- New email object.
		local
			l_subject: READABLE_STRING_8
		do
			l_subject := a_subject
			if attached setup.site_email_subject_prefix as l_prefix then
				if not l_subject.starts_with (l_prefix) then
					l_subject := l_prefix +  l_subject
				end
			end
			create Result.make (setup.site_email, a_to_address, l_subject, a_content)
		end

	new_html_email (a_to_address: READABLE_STRING_8; a_subject: READABLE_STRING_8; a_content: READABLE_STRING_8): CMS_EMAIL
			-- New HTML email object using MIME header.
		do
			Result := new_email (a_to_address, a_subject, a_content)
			Result.add_header_line ("MIME-Version:1.0")
			Result.add_header_line ("Content-Type: text/html; charset=utf-8")
		end

	process_email (e: CMS_EMAIL)
			-- Process email `e'.
		do
			log ("mailer", "Send email %"" + e.subject + "%"%N" + e.header, {CMS_LOG}.level_notice, Void)
			reset_error
			prepare_email (e)
			setup.mailer.safe_process_email (e)
			if setup.mailer.has_error then
				error_handler.add_custom_error (0, "Mailer error", "Error occurred while processing email.")
			else
				e.set_is_sent (True)
			end
		end

	process_emails (lst: ITERABLE [CMS_EMAIL])
			-- Process collection of email `lst'.
		do
			across
				lst as ic
			loop
				process_email (ic.item)
			end
		end

feature {NONE} -- Emails implementation

	prepare_email (e: CMS_EMAIL)
			-- Prepare email `e', and update parameters if needed.
		local
			l_sender, l_from: READABLE_STRING_8
		do
			l_sender := setup.site_email
			l_from := e.from_address
			if not l_sender.is_case_insensitive_equal_general (l_from) then
				e.set_from_address (l_sender)
				if not e.has_header ("Return-Path") then
					e.add_header_line ("Return-path: " + l_from)
				end
				if e.reply_to_address = Void then
					e.set_reply_to_address (l_from)
				else
						--| As a Reply-To address is already set,
						--| ignore previous from address.
				end
			end
		end

feature -- Permissions system

	has_permission (a_permission: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Anonymous or user `user' has permission for `a_permission'?
			--| `a_permission' could be for instance "create page".
		do
			Result := user_has_permission (user, a_permission)
		end

	has_permissions (a_permission_list: ITERABLE [READABLE_STRING_GENERAL]): BOOLEAN
			-- Anonymous or user `user' has any of the permissions `a_permission_list`?
		do
			Result := user_has_permissions (user, a_permission_list)
		end

	user_has_permission (a_user: detachable CMS_USER; a_permission: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Anonymous or user `a_user' has permission for `a_permission'?
			--| `a_permission' could be for instance "create page".
		do
			Result := user_api.user_has_permission (a_user, a_permission)
		end

	user_has_permissions (a_user: detachable CMS_USER; a_permission_list: ITERABLE [READABLE_STRING_GENERAL]): BOOLEAN
			-- Does `a_user' has any of the permissions `a_permission_list' ?
		do
			across
				a_permission_list as ic
			until
				Result
			loop
				Result := user_has_permission (a_user, ic.item)
			end
		end

	has_permission_to_use_format (a_format: CONTENT_FORMAT): BOOLEAN
			-- Anonymous or user `user` has permission to use content format `a_format`?
		do
					-- See `CMS_CORE_MODULE.use_format_permission_name (...)`
			Result := has_permission ("use format " + a_format.name)
		end

feature -- Query: module

	is_module_installed (a_module: CMS_MODULE): BOOLEAN
			-- Is `a_module' installed?
		do
			Result := a_module.is_installed (Current)
		end

	is_module_enabled (a_module: CMS_MODULE): BOOLEAN
		do
			Result := a_module.is_enabled or a_module.is_enabled_in_storage (Current)
		end

	enabled_modules: CMS_MODULE_COLLECTION

	module (a_type: TYPE [CMS_MODULE]): detachable CMS_MODULE
			-- Enabled module typed `a_type', if any.
			--| usage: if attached module ({FOO_MODULE}) as mod then ...
		do
			Result := installed_module (a_type)
			if Result /= Void then
				if not Result.is_enabled or else not Result.is_initialized then
					Result := Void
				end
			end
		ensure
			Result /= Void implies (Result.is_enabled and Result.is_initialized) -- and a_type.is_conforming_to (Result.generating_type))
		end

	installed_module (a_type: TYPE [CMS_MODULE]): detachable CMS_MODULE
			-- Module typed `a_type', if any.
			-- It may not be enabled!
			--| usage: if attached module ({FOO_MODULE}) as mod then ...
		do
			Result := setup.modules.item (a_type)
		ensure
--FIXME			Result /= Void implies (Result.is_enabled) -- and a_type.is_conforming_to (Result.generating_type))
		end

	module_api (a_type: TYPE [CMS_MODULE]): detachable CMS_MODULE_API
			-- Enabled module API associated with module typed `a_type'.
		do
			if attached module (a_type) as mod then
				if mod.is_enabled then
					if not mod.is_initialized then
						mod.initialize (Current)
					end
					Result := mod.module_api
				end
			end
		end

	module_by_name (a_name: READABLE_STRING_GENERAL): detachable CMS_MODULE
			-- Enabled module named `a_name', if any.
		do
			across
				setup.modules as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if
					not Result.is_enabled
					or else not Result.name.is_case_insensitive_equal_general (a_name)
				then
					Result := Void
				end
			end
		ensure
			Result /= Void implies (Result.is_enabled and Result.name.is_case_insensitive_equal_general (a_name))
		end

	module_api_by_name (a_name: READABLE_STRING_GENERAL): detachable CMS_MODULE_API
			-- Enabled module API associated with module named `a_name'.
		do
			if attached module_by_name (a_name) as mod then
				Result := mod.module_api
			end
		end

feature -- Hooks

	hooks: CMS_HOOK_CORE_MANAGER
			-- Manager handling hook subscriptions.

feature {CMS_EXECUTION} -- Hooks

	setup_hooks
			-- Set up CMS hooks.
			--| Each module has to opportunity to subscribe to various hooks.
		local
			l_module: detachable CMS_MODULE
			l_hooks: like hooks
		do
			l_hooks := hooks
			setup_core_hooks (l_hooks)
			across
				enabled_modules as ic
			loop
				l_module := ic.item
				if is_administration_mode then
					if attached {CMS_WITH_MODULE_ADMINISTRATION} l_module as adm then
						l_module := adm.module_administration
					else
						l_module := Void
					end
				elseif is_webapi_mode then
					if attached {CMS_WITH_WEBAPI} l_module as wapi then
						l_module := wapi.module_webapi
					else
						l_module := Void
					end
				end
				if l_module /= Void then
					if attached {CMS_HOOK_AUTO_REGISTER} l_module as l_auto then
						l_auto.auto_subscribe_to_hooks (l_hooks)
					end
					l_module.setup_hooks (l_hooks)
				end
			end
		end

feature {NONE} -- Access: API

	cms_api: CMS_API
		do
			Result := Current
		end

feature -- Access: API

	user_api: CMS_USER_API
			-- API to access user related data.
		local
			l_api: like internal_user_api
		do
			l_api := internal_user_api
			if l_api = Void then
				create l_api.make (Current)
				internal_user_api := l_api
			end
			Result := l_api
		end

	response_api: CMS_RESPONSE_API
			-- API to send predefined cms responses.
		local
			l_api: like internal_response_api
		do
			l_api := internal_response_api
			if l_api = Void then
				create l_api.make (Current)
				internal_response_api := l_api
			end
			Result := l_api
		end

feature -- Hooks

	setup_core_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Register hooks associated with the cms core.
		do
			if is_administration_mode then
				a_hooks.subscribe_to_export_hook (Current)
				a_hooks.subscribe_to_import_hook (Current)
			end
		end

feature -- Path aliases

	is_valid_path_alias (a_alias: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := a_alias.is_empty or else not a_alias.starts_with ("/")
		end

	set_path_alias (a_source, a_alias: READABLE_STRING_8; a_keep_previous: BOOLEAN)
			-- Set `a_alias' as alias of `a_source',
			-- and eventually unset previous alias if any.
		require
			valid_alias: is_valid_path_alias (a_alias)
		local
			l_continue: BOOLEAN
		do
			if attached storage.path_alias (a_source) as l_existing_alias then
				if a_alias.same_string (l_existing_alias) then
						-- Already aliased as expected
				else
						-- New alias
					if a_keep_previous then
						l_continue := True
					else
						storage.replace_path_alias (a_source, l_existing_alias, a_alias)
					end
				end
			elseif a_alias.is_whitespace then
					-- Ignore
			elseif a_source.same_string (a_alias) then
					-- No need for alias
			else
				l_continue := True
			end
			if l_continue then
				storage.set_path_alias (a_source, a_alias)
			end
		end

	unset_path_alias (a_source: READABLE_STRING_8; a_alias: READABLE_STRING_8)
		do
			storage.unset_path_alias (a_source, a_alias)
		end

	location_alias (a_source: READABLE_STRING_8): READABLE_STRING_8
			-- Location alias associated with `a_source' or the source itself.
		do
			Result := a_source
			if attached storage.path_alias (Result) as l_path then
				Result := l_path
				if Result.starts_with ("/") then
					Result := Result.substring (2, Result.count)
				end
			end
		end

	path_alias (a_source: READABLE_STRING_8): READABLE_STRING_8
			-- Path alias associated with `a_source' or the source itself.
		do
			Result := a_source
			if attached storage.path_alias (Result) as l_path then
				Result := "/" + l_path
			end
		end

	source_of_path_alias (a_alias: READABLE_STRING_GENERAL): detachable READABLE_STRING_8
			-- Resolved path for alias `a_alias'.
			--| the CMS supports aliases for path, and then this function simply returns
			--| the effective target path/url for this `a_alias'.
			--| For instance: articles/2015/may/this-is-an-article can be an alias to node/123
			--| This function will return "node/123".
			--| If the alias is bad (i.e does not alias real path), then this function
			--| returns Void.
		do
			if attached storage.source_of_path_alias (a_alias) as l_source_path then
				Result := l_source_path
			end
		end

feature -- Element Change: Error

	reset_error
			-- Reset error handler.
		do
			error_handler.reset
		end

	report_error (a_name: STRING_8; a_message: detachable READABLE_STRING_GENERAL)
			-- Report a custom error.
		do
			error_handler.add_custom_error (-1, a_name, a_message)
		end

feature {NONE}-- Implementation

	error_handler: ERROR_HANDLER
			-- Error handler.

	internal_user_api: detachable like user_api
			-- Cached value for `user_api`.

	internal_response_api: detachable like response_api
			-- Cached value for `response_api`.

feature -- Environment/ theme

	site_location: PATH
			-- CMS site location.
		do
			Result := setup.site_location
		end

	temp_location: PATH
			-- CMS temp folder location.
		do
			Result := setup.temp_location
		end

	files_location: PATH
			-- CMS public files location.
		do
			Result := setup.files_location
		end

	files_path: STRING_8
		do
			create Result.make_from_string (base_path)
			Result.append ("files/")
		ensure
			ends_with_slash: Result.ends_with ("/")
		end

	cache_location: PATH
			-- CMS internal cache location.
		do
			Result := setup.cache_location
		end

	theme_location: PATH
			-- Active theme location.
		do
			Result := setup.theme_location
		end

	theme_name: READABLE_STRING_32
		do
			Result := setup.theme_name
		end

	theme_path: STRING_8
			-- URL path to the theme.
		do
			Result := theme_path_for (theme_name)
		ensure
			ends_with_slash: Result.ends_with ("/")
		end

	theme_assets_location: PATH
			-- assets (js, css, images, etc).
		do
				-- Check how to get this path from the CMS_THEME information.
			Result := theme_location.extended ("assets")
		end

feature -- Theming path helpers

	theme_location_for (a_theme_name: READABLE_STRING_GENERAL): PATH
		do
			Result := setup.theme_location_for (a_theme_name)
		end

	theme_path_for (a_theme_name: READABLE_STRING_GENERAL): STRING_8
			-- URL path to the theme `a_theme_name`.
		do
			create Result.make_from_string (base_path)
			Result.append ("theme/")
			Result.append (url_encoded (a_theme_name))
			Result.append_character ('/')
		ensure
			ends_with_slash: Result.ends_with ("/")
		end

	theme_assets_location_for (a_theme_name: READABLE_STRING_GENERAL): PATH
		do
			Result := theme_location_for (a_theme_name).extended ("assets")
		end

feature -- Environment/ module

	module_configuration (a_module: CMS_MODULE; a_name: detachable READABLE_STRING_GENERAL): detachable CONFIG_READER
		do
			Result := module_configuration_by_name (a_module.name, a_name)
		end

	module_configuration_by_name (a_module_name: READABLE_STRING_GENERAL; a_name: detachable READABLE_STRING_GENERAL): detachable CONFIG_READER
			-- Configuration reader for `a_module', and if `a_name' is set, using name `a_name'.
		local
			k: STRING_32
			p: detachable PATH
			l_cache: like module_configuration_cache
		do
				-- Search first in site/config/modules/$module_name/($app|$module_name).(json|ini)
				-- if none, look as sub configuration if $app /= Void
				-- and then in site/modules/$module_name/config/($app|$module_name).(json|ini)
				-- and if non in sub config if $app /= Void
			create k.make_from_string_general (a_module_name)
			if a_name /= Void then
				k.append_character (':')
				k.append_string_general (a_name)
			end
			l_cache := module_configuration_cache
			if l_cache /= Void then
				l_cache.search (k)
			else
				create l_cache.make_caseless (1)
				module_configuration_cache := l_cache
			end
			if l_cache.found then
				Result := l_cache.found_item
			else
				p := site_location.extended ("config").extended ("modules").extended (a_module_name)
				Result := module_configuration_by_name_in_location (a_module_name, p, a_name)
				if Result = Void then
					p := module_location_by_name (a_module_name).extended ("config")
					Result := module_configuration_by_name_in_location (a_module_name, p, a_name)
				end
				l_cache.force (Result, k)
			end
		end

	module_configuration_cache: detachable STRING_TABLE [detachable CONFIG_READER]
			-- Cache for `module_configuration(_by_name)` function.

	module_configuration_by_name_in_location (a_module_name: READABLE_STRING_GENERAL; a_dir: PATH; a_name: detachable READABLE_STRING_GENERAL): detachable CONFIG_READER
			-- Configuration reader from "$a_dir/($a_module_name|$a_name).(json|ini)" location.
		local
			p: PATH
			l_path: PATH
			ut: FILE_UTILITIES
		do
			if a_name = Void then
				p := a_dir.extended (a_module_name)
			else
				p := a_dir.extended (a_name)
			end
			l_path := p.appended_with_extension ("json")
			if ut.file_path_exists (l_path) then
				create {JSON_CONFIG} Result.make_from_file (l_path)
			else
				l_path := p.appended_with_extension ("ini")
				if ut.file_path_exists (l_path) then
					create {INI_CONFIG} Result.make_from_file (l_path)
				end
			end
			if Result = Void then
				if
					a_name /= Void and then
					attached {CONFIG_READER} module_configuration_by_name_in_location (a_module_name, a_dir, Void) as cfg
				then
						-- Use sub config from default.
					Result := cfg.sub_config (a_name)
				end
			elseif Result.has_error then
				log ("modules", "module configuration has error %"" + p.utf_8_name + "%"", {CMS_LOG}.level_error, Void)
			end
		end

	modules_location: PATH
			-- Directory containing cms modules.
		do
			Result := setup.modules_location
		end

	module_location (a_module: CMS_MODULE): PATH
			-- Location associated with `a_module'.
		do
			Result := module_location_by_name (a_module.name)
		end

	module_location_by_name (a_module_name: READABLE_STRING_GENERAL): PATH
			-- Location associated with `a_module_name'.
		do
			Result := modules_location.extended (a_module_name)
		end

	module_resource_location (a_module: CMS_MODULE; a_resource: PATH): PATH
			-- Location of resource `a_resource' for `a_module'.
		do
				--| site/modules/$modname/$a_resource
			Result := module_resource_location_by_name (a_module.name, a_resource)
		end

	module_resource_location_by_name (a_module_name: READABLE_STRING_GENERAL; a_resource: PATH): PATH
			-- Location of resource `a_resource' for `a_module'.
		do
				--| site/modules/$modname/$a_resource
			Result := module_location_by_name (a_module_name).extended_path (a_resource)
		end

feature -- Environment/ modules and theme

	module_theme_resource_location (a_module: CMS_MODULE; a_resource: PATH): detachable PATH
			-- Theme resource location of `a_resource' for module `a_module', if exists.
			-- By default, located under the module location folder, but could be overriden
			-- from files located under modules subfolder of active `theme_location'.
			--| First search in themes/$theme/modules/$a_module.name/$a_resource,
			--| and if not found then search in
			--| modules/$a_module_name/$a_resource.
		local
			ut: FILE_UTILITIES
		do
				-- Check first in selected theme folder.
			Result := module_theme_location (a_module).extended_path (a_resource)
			if not ut.file_path_exists (Result) then
					-- And if not found, look into site/modules/$a_module.name/.... folders.
				Result := module_resource_location (a_module, a_resource)
				if not ut.file_path_exists (Result) then
					Result := Void
				end
			end
		end

	module_theme_resource_location_by_name (a_module_name: READABLE_STRING_GENERAL; a_resource: PATH): detachable PATH
			-- Theme resource location of `a_resource' for module named `a_module_name', if exists.
			-- By default, located under the module location folder, but could be overriden
			-- from files located under modules subfolder of active `theme_location'.
			--| First search in themes/$theme/modules/$a_module.name/$a_resource,
			--| and if not found then search in
			--| modules/$a_module_name/$a_resource.
		local
			ut: FILE_UTILITIES
		do
				-- Check first in selected theme folder.
			Result := module_theme_location_by_name (a_module_name).extended_path (a_resource)
			if not ut.file_path_exists (Result) then
					-- And if not found, look into site/modules/$a_module.name/.... folders.
				Result := module_resource_location_by_name (a_module_name, a_resource)
				if not ut.file_path_exists (Result) then
					Result := Void
				end
			end
		end

	module_theme_location (a_module: CMS_MODULE): PATH
			-- Location for overriden files associated with `a_module_name'.
		do
			Result := module_theme_location_by_name (a_module.name)
		end

	module_theme_location_by_name (a_module_name: READABLE_STRING_GENERAL): PATH
			-- Location for overriden files associated with `a_module_name'.
		do
			Result := theme_location.extended ("modules").extended (a_module_name)
		end

feature -- Access: active user

	user_is_authenticated: BOOLEAN
			-- Is user authenticated?
		do
			Result := user /= Void
		ensure
			Result implies user /= Void
		end

	user_is_administrator: BOOLEAN
		do
			Result := attached user as u and then user_api.is_admin_user (u)
		end

	user: detachable CMS_USER
			-- Current user or Void in case of visitor.
		note
			EIS: "eiffel:?class=CMS_BASIC_AUTH_FILTER&feature=execute"
		do
			Result := current_user (request)
		end

	set_inactive_user (a_user: CMS_USER)
		require
			a_user_attached: a_user /= Void
			is_inactive_user: not a_user.is_active
		do
			current_inactive_user := a_user
		end

	set_user (a_user: CMS_USER)
			-- Set `a_user' as current `user'.
		require
			a_user_attached: a_user /= Void
			is_active_user: a_user.is_active -- TODO: check if we could allow temp user.
		do
			current_inactive_user := Void
			if a_user.is_active then
					-- in case existing code do not check for `is_active`.
				set_current_user (request, a_user)
			end
		end

	unset_user
			-- Unset `user'.
		do
			unset_current_user (request)
		end

	record_user_login (a_user: CMS_USER)
			-- Record login event for `a_user'.
		require
			user_has_id: a_user.has_id
		do
			a_user.set_last_login_date_now
			user_api.update_user (a_user)
		end

feature -- Site builtin variables

	builtin_variables: STRING_TABLE [detachable ANY]
			-- Builtin variables , value indexed by name.
		do
			create Result.make (7)

			Result["site_url"] := site_url
			Result["site_email"] := setup.site_email
			Result["site_name"] := setup.site_name
			if attached user as l_user then
				Result["active_user"] := l_user
				Result["user"] := l_user.name
				Result["user_id"] := l_user.id
				Result["user_profile_name"] := user_api.user_display_name (l_user)
			end
		end

feature -- Request utilities

	execution_variable (a_name: READABLE_STRING_GENERAL): detachable ANY
			-- Execution variable related to `a_name'
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			Result := request.execution_variable (a_name)
		end

	set_execution_variable (a_name: READABLE_STRING_GENERAL; a_value: detachable ANY)
		do
			request.set_execution_variable (a_name, a_value)
		ensure
			param_set: execution_variable (a_name) = a_value
		end

	unset_execution_variable (a_name: READABLE_STRING_GENERAL)
		do
			request.unset_execution_variable (a_name)
		ensure
			param_unset: execution_variable (a_name) = Void
		end


feature {CMS_API_ACCESS, CMS_RESPONSE, CMS_MODULE} -- Request utilities

	current_inactive_user: detachable CMS_USER

	current_user (req: WSF_REQUEST): detachable CMS_USER
			-- Current user or Void in case of Guest user.
		do
			check req = request end
			if attached {CMS_USER} execution_variable (cms_execution_variable_name_for_user) as l_user then
				Result := l_user
			end
		end

	set_current_user (req: WSF_REQUEST; a_user: CMS_USER)
			-- Set `a_user' as `current_user'.
		do
			check req = request end
			set_execution_variable (cms_execution_variable_name_for_user, a_user)
		ensure
			user_set: current_user (req) ~ a_user
		end

	unset_current_user (req: WSF_REQUEST)
			-- Unset current user.
		do
			check req = request end
			req.unset_execution_variable (cms_execution_variable_name_for_user)
		ensure
			user_unset: current_user (req) = Void
		end

feature {NONE} -- Implementation: current user

	internal_cms_execution_variable_name_for_user: detachable like cms_execution_variable_name_for_user

	cms_execution_variable_name_for_user: READABLE_STRING_GENERAL
		do
			Result := internal_cms_execution_variable_name_for_user
			if Result = Void then
				Result := cms_execution_variable_name ("user")
				internal_cms_execution_variable_name_for_user := Result
			end
		end

	cms_execution_variable_name (a_name: READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
			-- Execution variable name for `a_name'.
		local
			s32: STRING_32
		do
			create s32.make (19 + a_name.count)
			s32.append_integer_64 (request.request_time_stamp) -- About 10 characters
			s32.append (once {STRING_32} "_roccms_.") -- 9 characters
			s32.append_string_general (a_name) -- a_name.count characters.
			Result := s32
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end


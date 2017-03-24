note
	description: "CMS module bringing support for feed aggregation."
	date: "$Date$"
	revision: "$Revision$"

class
	FEED_AGGREGATOR_MODULE

inherit
	CMS_MODULE
		rename
			module_api as feed_aggregator_api
		redefine
			initialize,
			setup_hooks,
			feed_aggregator_api
		end

	CMS_ADMINISTRABLE

	CMS_HOOK_BLOCK

	CMS_HOOK_RESPONSE_ALTER

	CMS_HOOK_MENU_SYSTEM_ALTER

create
	make

feature {NONE} -- Initialization

	make
			-- Create Current module, disabled by default.
		do
			version := "1.0"
			description := "Feed aggregation"
			package := "feed"
		end

feature -- Access

	name: STRING = "feed_aggregator"

feature {CMS_EXECUTION} -- Administration

	administration: FEED_AGGREGATOR_MODULE_ADMINISTRATION
		do
			create Result.make (Current)
		end

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		do
			Precursor (api)
			create feed_aggregator_api.make (api)
		end

feature {CMS_API} -- Access: API

	feed_aggregator_api: detachable FEED_AGGREGATOR_API
			-- Eventual module api.

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		local
			h: WSF_URI_TEMPLATE_HANDLER
		do
			create {WSF_URI_TEMPLATE_AGENT_HANDLER} h.make (agent handle_feed_aggregation (a_api, ?, ?))
			a_router.handle ("/feed_aggregation/", h, a_router.methods_head_get)
			a_router.handle ("/feed_aggregation/{feed_id}", h, a_router.methods_head_get)
		end

feature -- Handle

	handle_feed_aggregation	(a_api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			m: WSF_PAGE_RESPONSE
			r: detachable CMS_RESPONSE
			s: STRING
			nb: INTEGER
		do
			if attached {WSF_STRING} req.query_parameter ("size") as p_size and then p_size.is_integer then
				nb := p_size.integer_value
			else
				nb := -1
			end
			if attached {WSF_STRING} req.path_parameter ("feed_id") as p_feed_id then
				if attached feed_aggregation (p_feed_id.value) as l_agg then
					if attached {WSF_STRING} req.query_parameter ("view") as p_view and then p_view.same_string ("embedded") then
						create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_api)
						if attached feed_to_html (p_feed_id.value, nb, True, r) as l_html then
							r := Void
							create m.make_with_body (l_html)
							m.header.put_content_type_text_html
							res.send (m)
						else
							create {NOT_FOUND_ERROR_CMS_RESPONSE} r.make (req, res, a_api)
							r.execute
						end
					else
						create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_api)
						create s.make_empty
						s.append ("<h1>")
						s.append (r.html_encoded (l_agg.name))
						s.append ("</h1>")
						if attached l_agg.included_categories as l_categories then
							s.append ("<span class=%"category%">")
							across
								l_categories as cats_ic
							loop
								s.append (" [")
								s.append (r.html_encoded (cats_ic.item))
								s.append ("]")
							end
							s.append ("</span>")
						end
						if attached l_agg.description as l_desc and then l_desc.is_valid_as_string_8 then
							s.append ("<div class=%"description%">")
							s.append (l_desc.as_string_8)
							s.append ("</div>")
						end
						s.append ("<ul>")
						across
							l_agg.locations as ic
						loop
							s.append ("<li><a href=%"")
							s.append (ic.item)
							s.append ("%">")
							s.append (ic.item)
							s.append ("</a></li>")
						end
						s.append ("</ul>")

						if attached feed_to_html (p_feed_id.value, nb, True, r) as l_html then
							s.append (l_html)
						end

						r.set_main_content (s)
						r.execute
					end
				else
					create {NOT_FOUND_ERROR_CMS_RESPONSE} r.make (req, res, a_api)
					r.execute
				end
			else
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_api)
				if attached feed_aggregator_api as l_feed_agg_api then
					create s.make_empty
					across
						l_feed_agg_api.aggregations as ic
					loop
						s.append ("<li>")
						s.append (r.link (ic.key, "feed_aggregation/" + r.url_encoded (ic.key), Void))
						if attached ic.item.included_categories as l_categories then
							s.append ("<span class=%"category%">")
							across
								l_categories as cats_ic
							loop
								s.append (" [")
								s.append (r.html_encoded (cats_ic.item))
								s.append ("]")
							end
							s.append ("</span>")
						end
						if attached ic.item.description as l_desc then
							if l_desc.is_valid_as_string_8 then
								s.append ("<div class=%"description%">")
								s.append (l_desc.as_string_8)
								s.append ("</div>")
							end
						end
						s.append ("</li>")
					end
					r.set_main_content (s)
				else
					create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, a_api)
				end
				r.execute
			end
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			a_hooks.subscribe_to_block_hook (Current)
			a_hooks.subscribe_to_response_alter_hook (Current)
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
		end

feature -- Hook

	block_list: ITERABLE [like {CMS_BLOCK}.name]
			-- List of block names, managed by current object.
		local
			res: ARRAYED_LIST [like {CMS_BLOCK}.name]
			utf_conv: UTF_CONVERTER
		do
			if
				attached feed_aggregator_api as l_feed_api and then
				attached l_feed_api.aggregations_ids as l_aggs
			then
				create res.make (1)
				across
					l_aggs as ic
				loop
					res.force ("?feed." + utf_conv.utf_32_string_to_utf_8_string_8 (ic.item))
				end
			else
				create res.make (0)
			end
			Result := res
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
			-- Get block object identified by `a_block_id' and associate with `a_response'.
		local
			s: READABLE_STRING_8
			b: CMS_CONTENT_BLOCK
			pref: STRING
			nb: INTEGER
		do
			if attached feed_aggregator_api as l_feed_api then
				pref := "feed."
				if a_block_id.starts_with (pref) then
					s := a_block_id.substring (pref.count + 1, a_block_id.count)
				else
					s := a_block_id
				end
				nb := 0
				if
					attached a_response.block_options (a_block_id) as l_options and then
					attached {READABLE_STRING_GENERAL} l_options.item ("size") as l_size and then
					l_size.is_integer
				then
					nb := l_size.to_integer
				end
				if attached feed_to_html (s, nb, True, a_response) as l_content then
					create b.make (a_block_id, Void, l_content, Void)
					b.set_is_raw (True)
					a_response.add_block (b, "feed_" + s)
				end
			end
		end

	feed_aggregation (a_feed_id: READABLE_STRING_GENERAL): detachable FEED_AGGREGATION
		do
			if attached feed_aggregator_api as l_feed_api then
				Result := l_feed_api.aggregation (a_feed_id)
			end
		end

	feed_to_html (a_feed_id: READABLE_STRING_GENERAL; a_count: INTEGER; with_feed_info: BOOLEAN; a_response: CMS_RESPONSE): detachable STRING
		local
			nb: INTEGER
			i: INTEGER
			e: FEED_ITEM
			l_cache: CMS_FILE_STRING_8_CACHE
			lnk: detachable FEED_LINK
			vis: FEED_TO_XHTML_VISITOR
			s: STRING
		do
			if attached feed_aggregator_api as l_feed_api then
				if attached l_feed_api.aggregation (a_feed_id) as l_agg then
					create l_cache.make (l_feed_api.cms_api.cache_location.extended (name).extended ("feed__" + a_feed_id + "__" + a_count.out + "_" + with_feed_info.out))
					Result := l_cache.item
					if Result = Void or l_cache.expired (Void, l_agg.expiration) then

						create Result.make (1024)
						Result.append ("<!-- ")
						Result.append ("Updated: " + l_cache.cache_date_time.out)
						Result.append (" -->")

						create vis.make (Result)
						if a_count = 0 then
							nb := l_agg.size
						else
							nb := a_count
						end
						vis.set_limit (nb)
						vis.set_description_enabled (l_agg.description_enabled)

						if with_feed_info then
							create s.make_empty
							if attached l_agg.description as l_desc then
								s.append ("<div class=%"description%">")
								s.append_string_general (l_desc)
								s.append ("</div>")
							end
							vis.set_header (s)
						end
						create s.make_empty
						s.append_string ("<liv class=%"nav%">")
						s.append_string (a_response.link ("See more ...", "feed_aggregation/" + a_response.url_encoded (a_feed_id), Void))
						s.append_string ("</li>")
						vis.set_footer (s)

						if attached l_feed_api.aggregation_feed (l_agg) as l_feed then
							if l_agg.has_category_filter and attached l_feed.items as lst then
								from
									lst.start
								until
									lst.after
								loop
									if not l_agg.is_included (lst.item_for_iteration) then
										lst.remove
									else
										lst.forth
									end
								end
							end
							l_feed.accept (vis)
						end
						l_cache.put (Result)
					end
				end
			end
		end

feature -- Hook

	response_alter (a_response: CMS_RESPONSE)
		do
			a_response.add_style (a_response.url ("/module/" + name + "/files/css/feed_aggregator.css", Void), Void)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		do
			if a_response.is_authenticated then
				a_menu_system.navigation_menu.extend (create {CMS_LOCAL_LINK}.make ("Feeds", "feed_aggregation/"))
			end
		end

end

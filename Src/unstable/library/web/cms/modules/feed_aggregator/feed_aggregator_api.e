note
	description: "API for Feed aggregator module."
	date: "$Date$"
	revision: "$Revision$"

class
	FEED_AGGREGATOR_API

inherit
	CMS_MODULE_API

create
	make

feature -- Access

	aggregations_ids: detachable ITERABLE [READABLE_STRING_GENERAL]
		local
			l_table: like internal_aggregations
		do
			l_table := internal_aggregations
			if l_table /= Void then
				Result := l_table.current_keys
			elseif attached cms_api.module_configuration_by_name ({FEED_AGGREGATOR_MODULE}.name, "feeds") as cfg then
				if attached cfg.text_list_item ("ids") as l_ids then
					Result := l_ids
				end
			end
		end

	aggregations: STRING_TABLE [FEED_AGGREGATION]
			-- List of feed aggregations.
		local
			agg: FEED_AGGREGATION
			l_feed_id: READABLE_STRING_32
			l_title: detachable READABLE_STRING_GENERAL
			l_locations: detachable STRING_TABLE [READABLE_STRING_8]
			loc_name: READABLE_STRING_GENERAL
			loc: READABLE_STRING_8
			l_table: like internal_aggregations
		do
			l_table := internal_aggregations
			if l_table /= Void then
				Result := l_table
			else
				create Result.make_caseless (0)
				internal_aggregations := Result
				if attached cms_api.module_configuration_by_name ({FEED_AGGREGATOR_MODULE}.name, "feeds") as cfg then
					if attached cfg.text_list_item ("ids") as l_ids then
						across
							l_ids as ic
						loop
							l_feed_id := ic.item
							create l_locations.make (1)

							if attached cfg.text_list_item ({STRING_32} "feeds." + l_feed_id + ".locations") as l_location_list then
								across
									l_location_list as loc_ic
								loop
									l_locations.force (cms_api.utf_8_encoded (loc_ic.item), loc_ic.item)
								end
							end
							if attached cfg.text_table_item ({STRING_32} "feeds." + l_feed_id + ".locations") as l_location_table then
								across
									l_location_table as loc_tb_ic
								loop
									l_locations.force (cms_api.utf_8_encoded (loc_tb_ic.item), loc_tb_ic.key)
								end
							end
							if
								attached cfg.text_item ({STRING_32} "feeds." + l_feed_id + ".location") as l_location
							then
								l_locations.force (cms_api.utf_8_encoded (l_location), l_location)
							end
							if l_locations /= Void and then not l_locations.is_empty then
								l_title := cfg.text_item ({STRING_32} "feeds." + l_feed_id + ".title")
								if l_title = Void then
									l_title := l_feed_id
								end
								create agg.make (l_title)
								if attached cfg.text_item ({STRING_32} "feeds." + l_feed_id + ".expiration") as l_expiration then
									if l_expiration.is_integer then
										agg.set_expiration (l_expiration.to_integer)
									end
								end
								if attached cfg.text_item ({STRING_32} "feeds." + l_feed_id + ".size") as l_size then
									if l_size.is_integer then
										agg.set_size (l_size.to_integer)
									end
								end
								if attached cfg.text_item ({STRING_32} "feeds." + l_feed_id + ".option_description") as l_description_opt then
									agg.set_description_enabled (not l_description_opt.is_case_insensitive_equal_general ("disabled"))
								end
								across
									l_locations as loc_ic
								loop
									agg.locations.force (cms_api.utf_8_encoded (loc_ic.item))
								end
								Result.force (agg, l_feed_id)
								if attached cfg.text_list_item ({STRING_32} "feeds." + l_feed_id + ".categories") as l_cats then
									across
										l_cats as cats_ic
									loop
										agg.include_category (cats_ic.item)
									end
								end
								across
									l_locations as locs_ic
								loop
									loc_name := locs_ic.key
									loc := locs_ic.item
									if attached cfg.text_list_item ({STRING_32} "feeds." + l_feed_id + {STRING_32} ".categories." + loc_name.to_string_32) as l_loc_cats then
										across
											l_loc_cats as cats_ic
										loop
											agg.include_category_per_feed (cats_ic.item, loc)
										end
									end
								end
							end
						end
					end
				end
			end
		end

	aggregation (a_name: READABLE_STRING_GENERAL): detachable FEED_AGGREGATION
		do
			if attached a_name.is_valid_as_string_8 then
				Result := aggregations.item (a_name.to_string_8)
			end
		end

feature {NONE} -- Access: implementation

	internal_aggregations: detachable like aggregations
			-- Cache value for `aggregations'.

feature -- Operation

	feed (a_location: READABLE_STRING_8): detachable FEED
		local
			fac: FEED_DEFAULT_PARSERS
			ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT
		do
			if attached cms_api.hooks.subscribers ({FEED_PROVIDER_HOOK}) as l_feed_providers then
				across
					l_feed_providers as ic
				until
					Result /= Void
				loop
					if attached {FEED_PROVIDER_HOOK} ic.item as h then
						Result := h.feed (a_location)
					end
				end
			end
			if Result = Void then
				create fac
				if attached new_http_client_session (a_location).get ("", ctx) as res then
					if attached res.body as l_content then
						Result := fac.feed_from_string (l_content)
					end
				end
			end
		end

	aggregation_feed (agg: FEED_AGGREGATION): detachable FEED
			-- Feed from aggregation `agg'.
		local
			loc: READABLE_STRING_8
			lst: LIST [FEED_ITEM]
		do
			across
				agg.locations as ic
			loop
				loc := ic.item
				if attached feed (loc) as f then
					lst := f.items
					if agg.has_category_filter_for_location (loc) then
							-- Note: it also check the global filter.
						from
							lst.start
						until
							lst.after
						loop
							if agg.is_included_for_location (lst.item, loc) then
								lst.forth
							else
								lst.remove
							end
						end
					elseif agg.has_category_filter then
						from
							lst.start
						until
							lst.after
						loop
							if agg.is_included (lst.item) then
								lst.forth
							else
								lst.remove
							end
						end
					end
					if Result /= Void then
						if f /= Void then
							Result := Result + f
						end
					else
						Result := f
					end
				end
			end
			if Result /= Void then
				Result.set_date (create {DATE_TIME}.make_now_utc)
			end
		end

	new_http_client_session (a_url: READABLE_STRING_8): HTTP_CLIENT_SESSION
		local
			cl: DEFAULT_HTTP_CLIENT
		do
			create cl
			Result := cl.new_session (a_url)
			Result.set_is_insecure (True)
		end

end

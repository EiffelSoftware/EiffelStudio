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

	aggregations: HASH_TABLE [FEED_AGGREGATION, STRING]
			-- List of feed aggregations.
		local
			agg: FEED_AGGREGATION
			l_feed_id: READABLE_STRING_32
			l_title: detachable READABLE_STRING_GENERAL
			l_locations: detachable STRING_TABLE [READABLE_STRING_8]
			utf: UTF_CONVERTER
			l_utf8_loc: STRING
			l_table: like internal_aggregations
		do
			l_table := internal_aggregations
			if l_table /= Void then
				Result := l_table
			else
				create Result.make (0)
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
									l_locations.force (utf.utf_32_string_to_utf_8_string_8 (loc_ic.item), loc_ic.item)
								end
							end
							if attached cfg.text_table_item ({STRING_32} "feeds." + l_feed_id + ".locations") as l_location_table then
								across
									l_location_table as loc_tb_ic
								loop
									l_locations.force (utf.utf_32_string_to_utf_8_string_8 (loc_tb_ic.item), loc_tb_ic.key)
								end
							end
							if
								attached cfg.text_item ({STRING_32} "feeds." + l_feed_id + ".location") as l_location
							then
								l_locations.force (utf.utf_32_string_to_utf_8_string_8 (l_location), l_location)
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
									l_utf8_loc := utf.utf_32_string_to_utf_8_string_8 (loc_ic.item)
									agg.locations.force (l_utf8_loc)
									if attached cfg.text_list_item ({STRING_32} "feeds." + l_feed_id + {STRING_32} ".categories." + loc_ic.key) as l_cats then
										across
											l_cats as cats_ic
										loop
											agg.include_category_per_feed (cats_ic.item, l_utf8_loc)
										end
									end
								end
								Result.force (agg, l_feed_id)
								if attached cfg.text_list_item ({STRING_32} "feeds." + l_feed_id + ".categories") as l_cats then
									across
										l_cats as cats_ic
									loop
										agg.include_category (cats_ic.item)
									end
								elseif attached cfg.text_list_item ({STRING_32}"feeds." + l_feed_id + {STRING_32}".categories.*") as l_cats then
									across
										l_cats as cats_ic
									loop
										agg.include_category (cats_ic.item)
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
				Result := aggregations.item (a_name.as_string_8)
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
			create fac
			if attached new_http_client_session (a_location).get ("", ctx) as res then
				if attached res.body as l_content then
					Result := fac.feed_from_string (l_content)
				end
			end
		end

	aggregation_feed (agg: FEED_AGGREGATION): detachable FEED
			-- Feed from aggregation `agg'.
		local
			loc: READABLE_STRING_8
		do
			across
				agg.locations as ic
			loop
				loc := ic.item
				if attached feed (loc) as f then
					if agg.has_category_filter_for_location (loc) and then attached f.items as lst then
						from
							lst.start
						until
							lst.after
						loop
							if agg.is_included_for_location (lst.item_for_iteration, loc) then
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
		end

	new_http_client_session (a_url: READABLE_STRING_8): HTTP_CLIENT_SESSION
		local
			cl: LIBCURL_HTTP_CLIENT
		do
			create cl.make
			Result := cl.new_session (a_url)
			Result.set_is_insecure (True)
		end

end

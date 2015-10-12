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
			l_location_list: detachable LIST [READABLE_STRING_32]
			utf: UTF_CONVERTER
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
							l_location_list := cfg.text_list_item ({STRING_32} "feeds." + l_feed_id + ".locations")
							if
								attached cfg.text_item ({STRING_32} "feeds." + l_feed_id + ".location") as l_location
							then
								if l_location_list = Void then
									create {ARRAYED_LIST [READABLE_STRING_32]} l_location_list.make (1)
								end
								l_location_list.force (l_location)
							end
							if l_location_list /= Void and then not l_location_list.is_empty then
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
									l_location_list as loc_ic
								loop
									agg.locations.force (utf.utf_32_string_to_utf_8_string_8 (loc_ic.item))
								end
								Result.force (agg, l_feed_id)
								if attached cfg.text_list_item ({STRING_32} "feeds." + l_feed_id + ".categories") as l_cats then
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
		do
			across
				agg.locations as ic
			loop
				if attached feed (ic.item) as f then
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

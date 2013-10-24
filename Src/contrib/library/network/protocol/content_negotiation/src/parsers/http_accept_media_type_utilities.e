note
	description: "[
			{HTTP_ACCEPT_MEDIA_TYPE_UTILITIES}. is encharge to parse Accept request-header field defined as follow:

			Accept         = "Accept" ":"
                        #( media-range [ accept-params ] )
       		media-range    = ( "*/*"
                        | ( type "/" "*" )
                        | ( type "/" subtype )
                        ) *( ";" parameter )
       		accept-params  = ";" "q" "=" qvalue *( accept-extension )
		    accept-extension = ";" token [ "=" ( token | quoted-string ) ]

	   	    Example:

	   	    Accept: text/plain; q=0.5, text/html, text/x-dvi; q=0.8, text/x-c
			]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Accept", "src=http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1", "protocol=uri"

class
	HTTP_ACCEPT_MEDIA_TYPE_UTILITIES

inherit
	HTTP_HEADER_UTILITIES

feature -- Parser

	media_type (a_range: READABLE_STRING_8): HTTP_MEDIA_TYPE
			-- Media-ranges are mime-types with wild-cards and a 'q' quality parameter.
			-- For example, the media range 'application/*;q=0.5' would get parsed into:
			-- ('application', '*', {'q', '0.5'})
			-- In addition this function also guarantees that there is a value for 'q'
			-- in the params dictionary, filling it in with a proper default if
			-- necessary.
		do
			fixme ("Improve the code!!!")
			create Result.make_from_string (a_range)
			if attached Result.parameter ("q") as q then
				if
					q.is_double and then
					attached {REAL_64} q.to_real_64 as r and then
					(r >= 0.0 and r <= 1.0)
				then
					--| Keep current value
					if q.same_string ("1") then
							--| Use 1.0 formatting
						Result.add_parameter ("q", "1.0")
					end
				else
					Result.add_parameter ("q", "1.0")
				end
			else
				Result.add_parameter ("q", "1.0")
			end
		end

	quality (a_mime_type: READABLE_STRING_8; ranges: READABLE_STRING_8): REAL_64
			-- Returns the quality 'q' of a mime-type when compared against the
			-- mediaRanges in ranges.
		local
			l_ranges : LIST [READABLE_STRING_8]
			res : ARRAYED_LIST [HTTP_MEDIA_TYPE]
			p_res : HTTP_MEDIA_TYPE
		do
			l_ranges := ranges.split (',')
			from
				create res.make (10);
				l_ranges.start
			until
				l_ranges.after
			loop
				p_res := media_type (l_ranges.item_for_iteration)
				res.force (p_res)
				l_ranges.forth
			end
			Result := quality_from_list (a_mime_type, res)
		end

	best_match (supported: ITERABLE [READABLE_STRING_8]; header: READABLE_STRING_8): READABLE_STRING_8
			-- Choose the mime-type with the highest fitness score and quality ('q') from a list of candidates.
		local
			l_header_results: LIST [HTTP_MEDIA_TYPE]
			weighted_matches: LIST [FITNESS_AND_QUALITY]
			l_res: LIST [READABLE_STRING_8]
			p_res: HTTP_MEDIA_TYPE
			fitness_and_quality, first_one: detachable FITNESS_AND_QUALITY
			s: READABLE_STRING_8
		do
			l_res := header.split (',')
			create {ARRAYED_LIST [HTTP_MEDIA_TYPE]} l_header_results.make (l_res.count)

			fixme("Extract method!!!")
			from
				l_res.start
			until
				l_res.after
			loop
				p_res := media_type (l_res.item_for_iteration)
				l_header_results.force (p_res)
				l_res.forth
			end

			create {ARRAYED_LIST [FITNESS_AND_QUALITY]} weighted_matches.make (0)

			across supported as ic loop
				fitness_and_quality := fitness_and_quality_from_list (ic.item, l_header_results)
				fitness_and_quality.set_entity (entity_value (ic.item))
				weighted_matches.force (fitness_and_quality)
			end

				--| Keep only top quality+fitness types
			from
				weighted_matches.start
				first_one := weighted_matches.item
				weighted_matches.forth
			until
				weighted_matches.after
			loop
				fitness_and_quality := weighted_matches.item
				if first_one < fitness_and_quality then
					first_one := fitness_and_quality
					if not weighted_matches.isfirst then
						from
							weighted_matches.back
						until
							weighted_matches.before
						loop
							weighted_matches.remove
							weighted_matches.back
						end
						weighted_matches.forth
					end
					check weighted_matches.item = fitness_and_quality end
					weighted_matches.forth
				elseif first_one.is_equal (fitness_and_quality) then
					weighted_matches.forth
				else
					check first_one > fitness_and_quality end
					weighted_matches.remove
				end
			end
			if first_one /= Void and then first_one.quality /= 0.0 then
				if weighted_matches.count = 1 then
					Result := first_one.entity
				else
					from
						fitness_and_quality := Void
						l_header_results.start
					until
						l_header_results.after or fitness_and_quality /= Void
					loop
						s := l_header_results.item.simple_type
						from
							weighted_matches.start
						until
							weighted_matches.after or fitness_and_quality /= Void
						loop
							fitness_and_quality := weighted_matches.item
							if fitness_and_quality.entity.same_string (s) then
								--| Found
							else
								fitness_and_quality := Void
								weighted_matches.forth
							end
						end
						l_header_results.forth
					end
					if fitness_and_quality /= Void then
						Result := fitness_and_quality.entity
					else
						Result := first_one.entity
					end
				end
			else
				Result := ""
			end
		end

feature {NONE} -- Implementation

	fitness_and_quality_from_list (a_mime_type: READABLE_STRING_8; parsed_ranges: LIST [HTTP_MEDIA_TYPE]): FITNESS_AND_QUALITY
			-- Find the best match for a given mimeType against a list of media_ranges
			-- that have already been parsed by parse_media_range.
		local
			best_fitness: INTEGER
			target_q: REAL_64
			best_fit_q: REAL_64
			target: HTTP_MEDIA_TYPE
			range: HTTP_MEDIA_TYPE
			param_matches: INTEGER
			element: detachable READABLE_STRING_8
			l_fitness: INTEGER
		do
			best_fitness := -1
			best_fit_q := 0.0
			target := media_type (a_mime_type)
			if attached target.parameter ("q") as q and then q.is_double then
				target_q := q.to_double
				if target_q < 0.0 then
					target_q := 0.0
				elseif target_q > 1.0 then
					target_q := 1.0
				end
			else
				target_q := 1.0
			end

			if
				attached target.type as l_target_type and
				attached target.subtype as l_target_sub_type
			then
				from
					parsed_ranges.start
				until
					parsed_ranges.after
				loop
					range := parsed_ranges.item_for_iteration
					if
						(
							attached range.type as l_range_type and then
							(l_target_type.same_string (l_range_type) or l_range_type.same_string ("*") or l_target_type.same_string ("*"))
						) and
						(
							attached range.subtype as l_range_sub_type and then
							(l_target_sub_type.same_string (l_range_sub_type) or l_range_sub_type.same_string ("*") or l_target_sub_type.same_string ("*"))
						)
					then
						if attached target.parameters as l_keys then
							param_matches := 0
							across l_keys as ic loop
								element := ic.key
								if
									not element.same_string ("q") and then
									range.has_parameter (element) and then
									(attached target.parameter (element) as t_item and attached range.parameter (element) as r_item) and then
									t_item.same_string (r_item)
								then
									param_matches := param_matches + 1
								end
							end
						end
						if l_range_type.same_string (l_target_type) then
							l_fitness := 100
						else
							l_fitness := 0
						end

						if l_range_sub_type.same_string (l_target_sub_type) then
							l_fitness := l_fitness + 10
						end

						l_fitness := l_fitness + param_matches

						if l_fitness > best_fitness then
							best_fitness := l_fitness
							element := range.parameter ("q")
							if element /= Void then
								best_fit_q := element.to_double.min (target_q)
							else
								best_fit_q := 0.0
							end
						end
					end
					parsed_ranges.forth
				end
			end
			create Result.make (best_fitness, best_fit_q)
		end

	quality_from_list (a_mime_type: READABLE_STRING_8; parsed_ranges: LIST [HTTP_MEDIA_TYPE]): REAL_64
			--	Find the best match for a given mime-type against a list of ranges that
			--	have already been parsed by parse_media_range. Returns the 'q' quality
			--	parameter of the best match, 0 if no match was found. This function
			--	bahaves the same as quality except that 'parsed_ranges' must be a list
			--	of parsed media ranges.
		do
			Result := fitness_and_quality_from_list (a_mime_type, parsed_ranges).quality
		end


note
	copyright: "2011-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

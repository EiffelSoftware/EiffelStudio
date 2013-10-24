note
	description: "[
		  {HTTP_ACCEPT_LANGUAGE_UTILITIES} is in charge to parse language tags defined as follow:

		  Accept-Language = "Accept-Language" ":"
                         1#( language-l_range [ ";" "q" "=" qvalue ] )
   	      language-l_range  = ( ( 1*8ALPHA *( "-" 1*8ALPHA ) ) | "*" )
   	      
   	      Example:
   	      Accept-Language: da, en-gb;q=0.8, en;q=0.7

	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Accept-Language", "src=http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4", "protocol=uri"

class
	HTTP_ACCEPT_LANGUAGE_UTILITIES

inherit
	HTTP_HEADER_UTILITIES

feature -- Parser

	accept_language_list (a_header_value: READABLE_STRING_8): LIST [HTTP_ACCEPT_LANGUAGE]
			-- Languages-ranges are languages with wild-cards and a 'q' quality parameter.
			-- For example, the language l_range ('en-* ;q=0.5') would get parsed into:
			-- ('en', '*', {'q', '0.5'})
			-- In addition this function also guarantees that there is a value for 'q'
			-- in the params dictionary, filling it in with a proper default if
			-- necessary.
		local
			l_res: LIST [READABLE_STRING_8]
			l_lang: HTTP_ACCEPT_LANGUAGE
		do
			l_res := a_header_value.split (',')
			create {ARRAYED_LIST [HTTP_ACCEPT_LANGUAGE]} Result.make (l_res.count)

			from
				l_res.start
			until
				l_res.after
			loop
				create l_lang.make_from_string (l_res.item_for_iteration)
				Result.force (l_lang)
				l_res.forth
			end
		end

	accept_language (a_accept_language_item: READABLE_STRING_8): HTTP_ACCEPT_LANGUAGE
			-- Languages-ranges are languages with wild-cards and a 'q' quality parameter.
			-- For example, the language l_range ('en-* ;q=0.5') would get parsed into:
			-- ('en', '*', {'q', '0.5'})
			-- In addition this function also guarantees that there is a value for 'q'
			-- in the params dictionary, filling it in with a proper default if
			-- necessary.
		do
			create Result.make_from_string (a_accept_language_item)
		end

	quality (a_language: READABLE_STRING_8; a_ranges: READABLE_STRING_8): REAL_64
			-- Returns the quality 'q' of a `a_language' when compared against the
			-- language l_range in `a_ranges'.
		do
			Result := quality_from_list (a_language, accept_language_list (a_ranges))
		end

	best_match (a_supported: ITERABLE [READABLE_STRING_8]; a_header_value: READABLE_STRING_8): READABLE_STRING_8
			-- Choose the `parse_language' with the highest fitness score and quality ('q') from a list of candidates.
		local
			l_header_results: LIST [HTTP_ACCEPT_LANGUAGE]
			l_weighted_matches: LIST [FITNESS_AND_QUALITY]
			l_fitness_and_quality, l_first_one: detachable FITNESS_AND_QUALITY
			s: READABLE_STRING_8
		do
			l_header_results := accept_language_list (a_header_value)

				--| weighted matches
			create {ARRAYED_LIST [FITNESS_AND_QUALITY]} l_weighted_matches.make (0)
			across a_supported as ic loop
				l_fitness_and_quality := fitness_and_quality_from_list (ic.item, l_header_results)
				l_fitness_and_quality.set_entity (entity_value (ic.item))
				l_weighted_matches.force (l_fitness_and_quality)
			end

				--| Keep only top quality+fitness types
			from
				l_weighted_matches.start
				l_first_one := l_weighted_matches.item
				l_weighted_matches.forth
			until
				l_weighted_matches.after
			loop
				l_fitness_and_quality := l_weighted_matches.item
				if l_first_one < l_fitness_and_quality then
					l_first_one := l_fitness_and_quality
					if not l_weighted_matches.isfirst then
						from
							l_weighted_matches.back
						until
							l_weighted_matches.before
						loop
							l_weighted_matches.remove
							l_weighted_matches.back
						end
						l_weighted_matches.forth
					end
					check
						l_weighted_matches.item = l_fitness_and_quality
					end
					l_weighted_matches.forth
				elseif l_first_one ~ l_fitness_and_quality then
					l_weighted_matches.forth
				else
					check
						l_first_one > l_fitness_and_quality
					end
					l_weighted_matches.remove
				end
			end
			if l_first_one /= Void and then l_first_one.quality /= 0.0 then
				if l_weighted_matches.count = 1 then
					Result := l_first_one.entity
				else
					from
						l_fitness_and_quality := Void
						l_header_results.start
					until
						l_header_results.after or l_fitness_and_quality /= Void
					loop
						s := l_header_results.item.language_range
						from
							l_weighted_matches.start
						until
							l_weighted_matches.after or l_fitness_and_quality /= Void
						loop
							l_fitness_and_quality := l_weighted_matches.item
							if l_fitness_and_quality.entity.same_string (s) then
									--| Found
							else
								l_fitness_and_quality := Void
								l_weighted_matches.forth
							end
						end
						l_header_results.forth
					end
					if l_fitness_and_quality /= Void then
						Result := l_fitness_and_quality.entity
					else
						Result := l_first_one.entity
					end
				end
			else
				Result := ""
			end
		end

feature {NONE} -- Implementation

	fitness_and_quality_from_list (a_language: READABLE_STRING_8; a_parsed_ranges: LIST [HTTP_ACCEPT_LANGUAGE]): FITNESS_AND_QUALITY
			-- Find the best match for a given `a_language' against a list of language ranges `a_parsed_ranges'
			-- that have already been parsed by parse_language_range.
		local
			l_best_fitness: INTEGER
			l_target_q: REAL_64
			l_best_fit_q: REAL_64
			l_target: HTTP_ACCEPT_LANGUAGE
			l_target_type: READABLE_STRING_8
			l_range: HTTP_ACCEPT_LANGUAGE
			l_param_matches: INTEGER
			l_element: detachable READABLE_STRING_8
			l_fitness: INTEGER
		do
			l_best_fitness := -1
			l_best_fit_q := 0.0
			create l_target.make_from_string (a_language)
			l_target_q := l_target.quality

			l_target_type := l_target.language
			from
				a_parsed_ranges.start
			until
				a_parsed_ranges.after
			loop
				l_range := a_parsed_ranges.item_for_iteration
				if
					attached l_range.language as l_range_type and then
					(	l_target_type.same_string (l_range_type)
						or l_range_type.same_string ("*")
						or l_target_type.same_string ("*")
					)
				then
					l_param_matches := 0
					if attached l_target.parameters as l_target_parameters then
						across
							l_target_parameters as ic
						loop
							l_element := ic.key
							if
								not l_element.same_string ("q") and then
								l_range.has_parameter (l_element) and then
								(attached ic.item as t_item and attached l_range.parameter (l_element) as r_item) and then
								t_item.same_string (r_item)
							then
								l_param_matches := l_param_matches + 1
							end
						end
					end
					if l_range_type.same_string (l_target_type) then
						l_fitness := 100
					else
						l_fitness := 0
					end
					if
						attached l_range.specialization as l_range_sub_type and then
						attached l_target.specialization as l_target_sub_type and then
						(	l_target_sub_type.same_string (l_range_sub_type)
						 or l_range_sub_type.same_string ("*")
						 or l_target_sub_type.same_string ("*")
						)
					then
						if l_range_sub_type.same_string (l_target_sub_type) then
							l_fitness := l_fitness + 10
						end
					end
					l_fitness := l_fitness + l_param_matches
					if l_fitness > l_best_fitness then
						l_best_fitness := l_fitness
						l_element := l_range.parameter ("q")
						if l_element /= Void then
							l_best_fit_q := l_element.to_real_64.min (l_target_q)
						else
							l_best_fit_q := 0.0
						end
					end
				end
				a_parsed_ranges.forth
			end
			create Result.make (l_best_fitness, l_best_fit_q)
		end

	quality_from_list (a_language: READABLE_STRING_8; a_parsed_ranges: LIST [HTTP_ACCEPT_LANGUAGE]): REAL_64
			--	Find the best match for a given `a_language' against a list of ranges `parsed_ranges' that
			--	have already been parsed by parse_language_range. Returns the 'q' quality
			--	parameter of the best match, 0 if no match was found. This function
			--	bahaves the same as quality except that 'a_parsed_ranges' must be a list
			--	of parsed language ranges.
		do
			Result := fitness_and_quality_from_list (a_language, a_parsed_ranges).quality
		end

note
	copyright: "2011-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end

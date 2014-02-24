note
	description: "[
					HTTP_ANY_ACCEPT_HEADER_PARSER, this class allows to parse Accept-* headers

		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Charset", "src=http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.2", "protocol=uri"
	EIS: "name=Encoding", "src=http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.3", "protocol=uri"

class
	HTTP_ANY_ACCEPT_HEADER_UTILITIES

inherit
	HTTP_HEADER_UTILITIES

feature -- Parser

	header (a_header: READABLE_STRING_8): HTTP_ANY_ACCEPT
			-- Parses `a_header' charset/encoding into its component parts.
			-- For example, the charset 'iso-8889-5' would get parsed
			-- into:
			-- ('iso-8889-5', {'q':'1.0'})
		do
			create Result.make_from_string (a_header)
			if Result.parameter ("q") = Void then
				Result.put_parameter ("1.0", "q")
			end
		end

	quality (a_field: READABLE_STRING_8; a_header: READABLE_STRING_8): REAL_64
			-- Returns the quality 'q' of a charset/encoding when compared against the
			-- a list of charsets/encodings/
		local
			l_commons: LIST [READABLE_STRING_8]
			res: ARRAYED_LIST [HTTP_ANY_ACCEPT]
			p_res: HTTP_ANY_ACCEPT
		do
			l_commons := a_header.split (',')
			from
				create res.make (10)
				l_commons.start
			until
				l_commons.after
			loop
				p_res := header (l_commons.item_for_iteration)
				res.force (p_res)
				l_commons.forth
			end
			Result := quality_from_list (a_field, res)
		end

	best_match (a_supported: ITERABLE [READABLE_STRING_8]; a_header: READABLE_STRING_8): READABLE_STRING_8
			-- Choose the accept with the highest fitness score and quality ('q') from a list of candidates.
		local
			l_header_results: LIST [HTTP_ANY_ACCEPT]
			l_weighted_matches: LIST [FITNESS_AND_QUALITY]
			l_res: LIST [READABLE_STRING_8]
			p_res: HTTP_ANY_ACCEPT
			l_fitness_and_quality, l_first_one: detachable FITNESS_AND_QUALITY
		do
			l_res := a_header.split (',')
			create {ARRAYED_LIST [HTTP_ANY_ACCEPT]} l_header_results.make (l_res.count)
			from
				l_res.start
			until
				l_res.after
			loop
				p_res := header (l_res.item_for_iteration)
				l_header_results.force (p_res)
				l_res.forth
			end
			create {ARRAYED_LIST [FITNESS_AND_QUALITY]} l_weighted_matches.make (0)
			across a_supported as ic loop
				l_fitness_and_quality := fitness_and_quality_from_list (ic.item, l_header_results)
				l_fitness_and_quality.set_entity (entity_value (ic.item))
				l_weighted_matches.force (l_fitness_and_quality)
			end

				--| Keep only top quality+fitness types
				--| TODO extract method
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
				elseif l_first_one.is_equal (l_fitness_and_quality) then
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
						if attached l_header_results.item.value as l_field then
							from
								l_weighted_matches.start
							until
								l_weighted_matches.after or l_fitness_and_quality /= Void
							loop
								l_fitness_and_quality := l_weighted_matches.item
								if l_fitness_and_quality.entity.same_string (l_field) then
										--| Found
								else
									l_fitness_and_quality := Void
									l_weighted_matches.forth
								end
							end
						else
							check
								has_field: False
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

	fitness_and_quality_from_list (a_field: READABLE_STRING_8; a_parsed_charsets: LIST [HTTP_ANY_ACCEPT]): FITNESS_AND_QUALITY
			-- Find the best match for a given charset/encoding against a list of charsets/encodings
			-- that have already been parsed by parse_common. Returns a
			-- tuple of the fitness value and the value of the 'q' quality parameter of
			-- the best match, or (-1, 0) if no match was found. Just as for
			-- quality_parsed().
		local
			best_fitness: INTEGER
			target_q: REAL_64
			best_fit_q: REAL_64
			target: HTTP_ANY_ACCEPT
			range: HTTP_ANY_ACCEPT
			element: detachable READABLE_STRING_8
			l_fitness: INTEGER
		do
			best_fitness := -1
			best_fit_q := 0.0
			target := header (a_field)
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
			if attached target.value as l_target_field then
				from
					a_parsed_charsets.start
				until
					a_parsed_charsets.after
				loop
					range := a_parsed_charsets.item_for_iteration
					if attached range.value as l_range_common then
						if
							l_target_field.same_string (l_range_common)
							or l_target_field.same_string ("*")
							or l_range_common.same_string ("*")
							or l_target_field.same_string ("identity")
						then
							if l_range_common.same_string (l_target_field) then
								l_fitness := 100
							else
								l_fitness := 0
							end
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
					end
					a_parsed_charsets.forth
				end
			end
			create Result.make (best_fitness, best_fit_q)
		end

	quality_from_list (a_field: READABLE_STRING_8; a_parsed_common: LIST [HTTP_ANY_ACCEPT]): REAL_64
			--	Find the best match for a given charset/encoding against a list of charsets/encodings that
			--	have already been parsed by parse_charsets(). Returns the 'q' quality
			--	parameter of the best match, 0 if no match was found. This function
			--	bahaves the same as quality()
		do
			Result := fitness_and_quality_from_list (a_field, a_parsed_common).quality
		end

note
	copyright: "2011-2014, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end

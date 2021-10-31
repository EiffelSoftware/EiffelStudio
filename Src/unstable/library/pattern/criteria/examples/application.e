note
	description: "[
		Example to filter a list of article using the criteria library.
	]"

class
	APPLICATION

inherit
	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make
		do
			print ("Using criteria described as:%N")
			print (criteria_factory.description)
			print ("%N%N")

			process ("(title:eiffel or description:eiffel or content:eiffel) and published:yes")

			process ("title:eiffel")
				--| note: "title:eiffel and published:yes" is same as
				--| "eiffel and published:yes" since "title" is the default
				--| criteria.
			process ("eiffel")
				--| with an addition criteria, published
			process ("eiffel and published:yes")

				--| with an addition criteria, and at least 5 pages
			process ("eiffel and (published:yes or pages:5)")
				--| with an addition criteria, and at most 4 pages
			process ("eiffel and (published:yes and -pages:5)")

			process ("eiffel")
		end

	process (q: STRING)
		do
			print ("Method BOOLEAN:%N")
			process_boolean (q)
			print ("Method SCORE:%N")
			process_score (q)
		end

	process_boolean (q: STRING)
		local
			fac: CRITERIA_FACTORY [ARTICLE]
			a: ARTICLE
		do
			fac := criteria_factory
			print ("Process [" + q + "] ... %N")
			if attached fac.criteria_from_string (q) as crit then
					-- Filter and display matched items.
				across
					crit.list (articles) as ic
				loop
					a := ic
					print ("  Article %"" + a.title + "%" ")
					print (a.page_count.out + " pages ")
					if not a.published then
						print ("(not published)")
					end
					print ("%N")
				end
				print ("%N")
			else
				io.error.put_string ("Expression has syntax error!%N")
				io.error.put_string_32 (fac.description)
				io.error.put_new_line
			end
		end

	process_score (q: STRING)
		local
			fac: SCORER_CRITERIA_FACTORY [ARTICLE]
			a: ARTICLE
		do
			fac := score_factory
			print ("Process [" + q + "] ... %N")
			if attached fac.criteria_from_string (q) as crit then
					-- Filter and display matched items.
				across
					crit.scores (articles, articles.count) as ic
				loop
					a := ic.value
					print ("[")
					print (ic.score.out)
					print ("] ")
					print ("Article %"" + a.title + "%" ")
					print (a.page_count.out + " pages ")
					if not a.published then
						print ("(not published)")
					end
					print ("%N")
				end
				print ("%N")
			else
				io.error.put_string ("Expression has syntax error!%N")
				io.error.put_string_32 (fac.description)
				io.error.put_new_line
			end
		end

	criteria_factory: CRITERIA_FACTORY [ARTICLE]
		once
			create Result.make
			Result.register_builder ("title", agent  (n, v: READABLE_STRING_32): detachable CRITERIA [ARTICLE]
				do
					create {CRITERIA_AGENT [ARTICLE]} Result.make (n + ":" + v, agent  (e: ARTICLE; a_title: READABLE_STRING_GENERAL): BOOLEAN
						do
							Result := e.title.as_lower.has_substring (a_title.as_lower)
						end (?, v))
				end)
			Result.set_builder_description ("title", "Title contains value?")

			Result.register_builder ("description", agent  (n, v: READABLE_STRING_32): detachable CRITERIA [ARTICLE]
				do
					create {CRITERIA_AGENT [ARTICLE]} Result.make (n + ":" + v, agent  (e: ARTICLE; a_description: READABLE_STRING_GENERAL): BOOLEAN
						local
							d: detachable STRING
						do
							d := e.description
							Result := d /= Void and then d.as_lower.has_substring (a_description.as_lower)
						end (?, v))
				end)
			Result.set_builder_description ("description", "Description contains value?")

			Result.register_builder ("content", agent  (n, v: READABLE_STRING_32): detachable CRITERIA [ARTICLE]
				do
					create {CRITERIA_AGENT [ARTICLE]} Result.make (n + ":" + v, agent  (e: ARTICLE; a_text: READABLE_STRING_GENERAL): BOOLEAN
						local
							t: detachable STRING
						do
							t := e.content
							Result := t /= Void and then t.as_lower.has_substring (a_text.as_lower)
						end (?, v))
				end)
			Result.set_builder_description ("content", "Content contains value?")

			Result.register_builder ("pages", agent  (n, v: READABLE_STRING_32): detachable CRITERIA [ARTICLE]
				do
					create {CRITERIA_AGENT [ARTICLE]} Result.make (n + ":" + v, agent  (e: ARTICLE; a_count: INTEGER): BOOLEAN
						do
							Result := e.page_count >= a_count
						end (?, v.to_integer))
				end)
			Result.set_builder_description ("pages", "At least N pages?")

			Result.register_builder ("published", agent  (n, v: READABLE_STRING_32): detachable CRITERIA [ARTICLE]
				do
					create {CRITERIA_AGENT [ARTICLE]} Result.make (n + ":" + v, agent  (e: ARTICLE; b: BOOLEAN): BOOLEAN
						do
							Result := e.published = b
						end (?, v.same_string ("yes")))
				end)
			Result.set_builder_description ("published", "Is published (yes|no)?")

			Result.register_default_builder ("title")
		end

	score_factory: SCORER_CRITERIA_FACTORY [ARTICLE]
		once
			create Result.make
			Result.register_builder ("title", agent (n, v: READABLE_STRING_32): detachable SCORER_CRITERIA [ARTICLE]
				do
					create {SCORER_CRITERIA_AGENT [ARTICLE]} Result.make (n + ":" + v, 0.5, agent  (e: ARTICLE; a_title: READABLE_STRING_GENERAL): REAL
						do
							Result := if e.title.as_lower.has_substring (a_title.as_lower) then 1.0 else 0.0 end
						end (?, v))
				end)
			Result.set_builder_description ("title", "Title contains value?")

			Result.register_builder ("description", agent (n, v: READABLE_STRING_32): detachable SCORER_CRITERIA [ARTICLE]
				do
					create {SCORER_CRITERIA_AGENT [ARTICLE]} Result.make (n + ":" + v, 0.3, agent (e: ARTICLE; a_description: READABLE_STRING_GENERAL): REAL
						do
							if attached e.description as l_desc then
								Result := if l_desc.as_lower.has_substring (a_description.as_lower) then 1.0 else 0.0 end
							end
						end (?, v))
				end)
			Result.set_builder_description ("description", "Description contains value?")

			Result.register_builder ("content", agent (n, v: READABLE_STRING_32): detachable SCORER_CRITERIA [ARTICLE]
				do
					create {SCORER_CRITERIA_AGENT [ARTICLE]} Result.make (n + ":" + v, 0.05, agent (e: ARTICLE; a_text: READABLE_STRING_GENERAL): REAL
						do
							if attached e.content as l_content then
								Result := if l_content.as_lower.has_substring (a_text.as_lower) then 1.0 else 0.0 end
							end
						end (?, v))
				end)
			Result.set_builder_description ("content", "Content contains value?")

			Result.register_builder ("pages", agent (n, v: READABLE_STRING_32): detachable SCORER_CRITERIA [ARTICLE]
				do
					create {SCORER_CRITERIA_AGENT [ARTICLE]} Result.make (n + ":" + v, 0.05, agent (e: ARTICLE; a_count: INTEGER): REAL
						do
							Result := if e.page_count >= a_count then 1.0 else 0.0 end
						end (?, v.to_integer))
				end)
			Result.set_builder_description ("pages", "At least N pages?")

			Result.register_builder ("published", agent (n, v: READABLE_STRING_32): detachable SCORER_CRITERIA [ARTICLE]
				do
					create {SCORER_CRITERIA_AGENT [ARTICLE]} Result.make (n + ":" + v, 0.1, agent (e: ARTICLE; b: BOOLEAN): REAL
						do
							Result := if e.published = b then 1.0 else 0.0 end
						end (?, v.same_string ("yes")))
				end)
			Result.set_builder_description ("published", "Is published (yes|no)?")

			Result.register_builder ("default", agent (n, v: READABLE_STRING_32): detachable SCORER_CRITERIA [ARTICLE]
				do
					create {SCORER_CRITERIA_AGENT [ARTICLE]} Result.make (n + ":" + v, 0.9, agent (e: ARTICLE; a_text: READABLE_STRING_GENERAL): REAL
						local
							l_lowered_text: READABLE_STRING_GENERAL
							w: REAL
						do
							l_lowered_text := a_text.as_lower

							w := 0.5
							if e.title.as_lower.has_substring (l_lowered_text) then
								Result := 0.5
							end

							w := w + 0.3
							if attached e.description as l_desc and then l_desc.as_lower.has_substring (l_lowered_text) then
								Result := Result + 0.3
							end

							w := w + 0.05
							if attached e.content as l_content and then l_content.as_lower.has_substring (l_lowered_text) then
								Result := Result + 0.05
							end

							if Result > 0 then
								w := w + 0.05
								if e.published then
									Result := Result + 0.05
								end
							end

							Result :=  Result / w
						end (?, v))
				end)
			Result.set_builder_description ("default", "Title, or description or content has searched term?")

			Result.register_default_builder ("default")
		end

	articles: ARRAYED_LIST [ARTICLE]
		local
			a: ARTICLE
		once
			create Result.make (3)
			create a.make ("Hello World")
			a.set_description ("Simple Hello World")
			a.set_content ("This is the content of the Hello world article.")
			a.mark_published
			a.set_page_count (5)
			Result.force (a)

			create a.make ("Eiffel World")
			a.set_description ("Simple Eiffel Hello World")
			a.set_content ("This is the content of the article Hello World written in Eiffel.")
			a.mark_published
			a.set_page_count (10)
			Result.force (a)

			create a.make ("Eiffel Universe")
			a.set_description ("Ecosystem.")
			a.set_content ("This is the content of the Eiffel universe ecosystem.")
			a.set_page_count (20)
			Result.force (a)

			create a.make ("Eiffel Criteria lib: documentation")
			a.set_description ("Quick criteria documentation.")
			a.set_content ("How to use the Eiffel criteria library.")
			a.mark_published
			a.set_page_count (1)
			Result.force (a)

		end

end

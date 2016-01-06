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
			process ("eiffel and (published:yes -pages:5)")
		end

	process (q: STRING)
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
					a := ic.item
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
				io.error.put_string (fac.description)
				io.error.put_new_line
			end
		end

	criteria_factory: CRITERIA_FACTORY [ARTICLE]
		once
			create Result.make
			Result.register_builder ("title", agent  (n, v: READABLE_STRING_GENERAL): detachable CRITERIA [ARTICLE]
				do
					create {CRITERIA_AGENT [ARTICLE]} Result.make (n + ":" + v, agent  (e: ARTICLE; a_title: READABLE_STRING_GENERAL): BOOLEAN
						do
							Result := e.title.as_lower.has_substring (a_title.as_lower)
						end (?, v))
				end)
			Result.set_builder_description ("title", "Title contains value?")
			Result.register_builder ("pages", agent  (n, v: READABLE_STRING_GENERAL): detachable CRITERIA [ARTICLE]
				do
					create {CRITERIA_AGENT [ARTICLE]} Result.make (n + ":" + v, agent  (e: ARTICLE; a_count: INTEGER): BOOLEAN
						do
							Result := e.page_count >= a_count
						end (?, v.to_integer))
				end)
			Result.set_builder_description ("pages", "At least N pages?")
			Result.register_builder ("published", agent  (n, v: READABLE_STRING_GENERAL): detachable CRITERIA [ARTICLE]
				do
					create {CRITERIA_AGENT [ARTICLE]} Result.make (n + ":" + v, agent  (e: ARTICLE; b: BOOLEAN): BOOLEAN
						do
							Result := e.published = b
						end (?, v.same_string ("yes")))
				end)
			Result.set_builder_description ("published", "Is published (yes|no)?")
			Result.register_default_builder ("title")
		end

	articles: ARRAYED_LIST [ARTICLE]
		local
			a: ARTICLE
		once
			create Result.make (3)
			create a.make ("Hello World")
			a.mark_published
			a.set_page_count (5)
			Result.force (a)
			create a.make ("Eiffel World")
			a.mark_published
			a.set_page_count (10)
			Result.force (a)
			create a.make ("Eiffel Universe")
			a.set_page_count (20)
			Result.force (a)
			create a.make ("Eiffel Criteria lib: documentation")
			a.set_page_count (1)
			Result.force (a)

		end

end

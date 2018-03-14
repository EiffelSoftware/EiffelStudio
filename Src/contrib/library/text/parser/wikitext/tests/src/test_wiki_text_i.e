deferred class
	TEST_WIKI_TEXT_I

inherit
	WIKI_TEMPLATE_RESOLVER

feature {NONE} -- Implementation

	same_output (s1, s2: READABLE_STRING_8): BOOLEAN
		local
			t1, t2: STRING
			lst1, lst2: LIST [READABLE_STRING_8]
		do
			lst1 := s1.split ('%N')
			lst2 := s2.split ('%N')
			if lst1.count = lst2.count then
				Result := True
				from
					lst1.start
					lst2.start
				until
					not Result or lst1.after or lst2.after
				loop
					t1 := lst1.item
					t2 := lst2.item
					t1.right_adjust
					t2.right_adjust
					Result := t1.same_string (t2)
					lst1.forth
					lst2.forth
				end
			end
		end

	new_xhtml_generator (o: STRING): WIKI_XHTML_GENERATOR
		do
			create Result.make (o)
			Result.set_template_resolver (Current)
		end

feature -- Resolver

	content (a_template: WIKI_TEMPLATE; a_page: detachable WIKI_PAGE): detachable STRING
			-- Template content for `a_template' in the context of `a_page' if any.
		do
			if a_template.name.is_case_insensitive_equal_general ("rule") then
				Result := "Template#" + a_template.name + "%Nname={{{name}}} %Ntext={{{text}}}%N"
			elseif a_template.name.is_case_insensitive_equal_general ("unknown") then
				-- Unknown template case.
			elseif a_template.name.is_case_insensitive_equal_general ("toc") then
			else
				Result := "Template#" + a_template.name + "%N1={{{1}}} %N2={{{2}}} %N3={{{3}}}%N"
			end
		end


end

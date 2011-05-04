class
	TEST2 [G]

feature

	retrieve_signature (a_sig: G; a_statement: STRING; a_items: ARRAY [INTEGER]): ARRAY [LIST [G]]
		do
			Result := retrieve_signature_with (a_sig, a_statement, a_items, 0)
		end

	retrieve_signature_with (a_sig: G; a_statement: STRING; a_items: ARRAY [INTEGER]; a_limit: INTEGER): ARRAY [LIST [G]]
		do
		end

end

note
	description: "Summary description for {ESA_SQLSERVER_ENCODER_TEST}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_SQLSERVER_ENCODER_TEST

inherit
	EQA_TEST_SET

feature -- Test

	test_escape_quotes
			--	set @data = 'data'
			--  [data]	
		local
			l_enc: DATABASE_SQL_SERVER_ENCODER
		do
			assert ("Expected [data]", (l_enc.encoded_string ("'data'")).same_string("[data]"))
		end

	test_escape_quotes_and_braces
				-- set @data = 'this data needs to be escaped: ] '
				-- [this data needs to be escaped: ]] ]		
		local
			l_enc: DATABASE_SQL_SERVER_ENCODER
		do
			assert ("Expected [data]", (l_enc.encoded_string ("'this data needs to be escaped: ] '")).same_string("[this data needs to be escaped: ]] ]"))
		end



	test_escape_data
			--	set @data = data
			--  [data]	
		local
			l_enc: DATABASE_SQL_SERVER_ENCODER
		do
			assert ("Expected [data]", (l_enc.encoded_string ("data")).same_string("[data]"))
		end


end

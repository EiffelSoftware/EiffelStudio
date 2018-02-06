note
	description: "Token used in Collection+JSON parser and printer."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_TOKENS

feature -- Tokens

	code_key: JSON_STRING
		once
			create Result.make_from_string ("code")
		end

	collection_key: JSON_STRING
		once
			create Result.make_from_string ("collection")
		end

	data_key: JSON_STRING
		once
			create Result.make_from_string ("data")
		end

	error_key: JSON_STRING
		once
			create Result.make_from_string ("error")
		end

	href_key: JSON_STRING
		once
			create Result.make_from_string ("href")
		end

	items_key: JSON_STRING
		once
			create Result.make_from_string ("items")
		end

	links_key: JSON_STRING
		once
			create Result.make_from_string ("links")
		end

	message_key: JSON_STRING
		once
			create Result.make_from_string ("message")
		end

	name_key: JSON_STRING
		once
			create Result.make_from_string ("name")
		end

	prompt_key: JSON_STRING
		once
			create Result.make_from_string ("prompt")
		end

	queries_key: JSON_STRING
		once
			create Result.make_from_string ("queries")
		end

	rel_key: JSON_STRING
		once
			create Result.make_from_string ("rel")
		end

	render_key: JSON_STRING
		once
			create Result.make_from_string ("render")
		end

	template_key: JSON_STRING
		once
			create Result.make_from_string ("template")
		end

	title_key: JSON_STRING
		once
			create Result.make_from_string ("title")
		end

	value_key: JSON_STRING
		once
			create Result.make_from_string ("value")
		end

	version_key: JSON_STRING
		once
			create Result.make_from_string ("version")
		end

note
	copyright: "2011-2014, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

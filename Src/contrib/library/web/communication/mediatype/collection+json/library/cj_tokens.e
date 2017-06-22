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
			create Result.make_json ("code")
		end

	collection_key: JSON_STRING
		once
			create Result.make_json ("collection")
		end

	data_key: JSON_STRING
		once
			create Result.make_json ("data")
		end

	error_key: JSON_STRING
		once
			create Result.make_json ("error")
		end

	href_key: JSON_STRING
		once
			create Result.make_json ("href")
		end

	items_key: JSON_STRING
		once
			create Result.make_json ("items")
		end

	links_key: JSON_STRING
		once
			create Result.make_json ("links")
		end

	message_key: JSON_STRING
		once
			create Result.make_json ("message")
		end

	name_key: JSON_STRING
		once
			create Result.make_json ("name")
		end

	prompt_key: JSON_STRING
		once
			create Result.make_json ("prompt")
		end

	queries_key: JSON_STRING
		once
			create Result.make_json ("queries")
		end

	rel_key: JSON_STRING
		once
			create Result.make_json ("rel")
		end

	render_key: JSON_STRING
		once
			create Result.make_json ("render")
		end

	template_key: JSON_STRING
		once
			create Result.make_json ("template")
		end

	title_key: JSON_STRING
		once
			create Result.make_json ("title")
		end

	value_key: JSON_STRING
		once
			create Result.make_json ("value")
		end

	version_key: JSON_STRING
		once
			create Result.make_json ("version")
		end

note
	copyright: "2011-2014, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

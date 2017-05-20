note
	description: "A JSON converter for CJ_ERROR"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_ERROR_JSON_CONVERTER

inherit
	CJ_JSON_CONVERTER

create
	make

feature {NONE} -- Initialization

	make
		do
			create object.make_empty
		end

feature -- Access

	object: CJ_ERROR

feature -- Conversion

	from_json (j: like to_json): detachable like object
		local
			l_title: detachable STRING_32
			l_code: detachable STRING_32
			l_message: detachable STRING_32
		do
			if attached {STRING_32} json_to_object (j.item (title_key), Void) as l_ucs then
				l_title := l_ucs
			end
			if attached {STRING_32} json_to_object (j.item (code_key), Void) as l_ucs then
				l_code := l_ucs
			end
			if attached {STRING_32} json_to_object (j.item (message_key), Void) as l_ucs then
				l_message := l_ucs
			end
			--|TODO improve this code
			--|is there a better way to write this?
			--|is a good idea create the Result object at the first line and then set the value
			--|if it is attached?
			create Result.make_empty
			if l_title /= Void then
				Result.set_title (l_title)
			end
			if l_code /= Void then
				Result.set_code (l_code)
			end
			if l_message /= Void then
				Result.set_message (l_message)
			end
		end

	to_json (o: like object): JSON_OBJECT
		do
			create Result.make
			Result.put (json.value (o.title), title_key)
			Result.put (json.value (o.code), code_key)
			Result.put (json.value (o.message), message_key)
		end

feature {NONE} -- Implementation

	title_key: JSON_STRING
		once
			create Result.make_from_string ("title")
		end

	code_key: JSON_STRING
		once
			create Result.make_from_string ("code")
		end

	message_key: JSON_STRING
		once
			create Result.make_from_string ("message")
		end
note
	copyright: "2011-2017, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

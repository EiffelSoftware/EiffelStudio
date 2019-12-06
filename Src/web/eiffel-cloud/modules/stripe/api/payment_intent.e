note
	description: "Summary description for {PAYMENT_INTENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PAYMENT_INTENT

inherit
	ANY
		redefine
			out
		end

create
	make_empty,
	make_with_json

feature {NONE} -- Initialization

	make_empty
		do
			make_with_json (create {JSON_OBJECT}.make_empty)
		end

	make_with_json (j: like json)
		do
			json := j
			id := string_8_item (j, "id", "")
			client_secret := string_8_item (j, "client_secret", "")
			currency := string_8_item (j, "currency", "usd")
			if attached {JSON_NUMBER} j.item ("amount") as num then
				amount := num.integer_64_item.to_integer
			elseif attached j.string_item ("amount") as s then
				amount := s.item.to_integer
			else
				amount := 0
			end
		end

feature -- Access

	id: IMMUTABLE_STRING_8

	client_secret: IMMUTABLE_STRING_8

	amount: INTEGER_32

	currency: READABLE_STRING_8

feature -- Element change

	set_id (v: READABLE_STRING_8)
		do
			id := v
		end

	set_client_secret (v: READABLE_STRING_8)
		do
			client_secret := v
		end

	put_string (v: READABLE_STRING_GENERAL; k: READABLE_STRING_GENERAL)
		do
			json.put_string (v, k)
		end

feature {NONE} -- Implementation

	string_8_item (j: JSON_OBJECT; k: READABLE_STRING_GENERAL; dft: STRING_8): STRING_8
		do
			if attached {JSON_STRING} (j @ k) as js then
				Result := js.unescaped_string_8
			else
				Result := dft
			end
		end

	json: JSON_OBJECT

feature -- Conversion

	out: STRING
		local
			jp: JSON_PRETTY_STRING_VISITOR
		do
			create Result.make (1_000)
			create jp.make (Result)
			jp.visit_json_object (json)
		end

end

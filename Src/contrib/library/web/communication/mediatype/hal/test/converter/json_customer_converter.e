note
	description: "Summary description for {JSON_CUSTOMER_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_CUSTOMER_CONVERTER
inherit
    JSON_CONVERTER

create
    make

feature {NONE} -- Initialization

    make
        local
            l_name: STRING_32
            l_email: STRING_32
        do
            create l_name.make_from_string ("")
            create l_email.make_from_string ("")
            create object.make (l_name,l_email)
        end

feature -- Access

    object: CUSTOMER

feature -- Conversion

    from_json (j: like to_json): detachable like object
        local
            l_name: detachable STRING_32
            l_email : detachable STRING_32
        do
            if attached {STRING_32} json.object (j.item (name_key), Void) as l_ucs then
            	l_name := l_ucs
            end

            if attached {STRING_32} json.object (j.item (email_key), Void) as l_ucs then
            	l_email := l_ucs
            end

            check l_email /= Void end
            check l_name /= Void end
            create Result.make (l_name, l_email)
        end

    to_json (o: like object): JSON_OBJECT
        do
            create Result.make
            Result.put (json.value (o.name), name_key)
            Result.put (json.value (o.email), email_key)
        end

feature    {NONE} -- Implementation

    name_key: JSON_STRING
        once
            create Result.make_from_string ("name")
        end

    email_key: JSON_STRING
        once
            create Result.make_from_string ("email")
        end

end -- class JSON_CUSTOMER_CONVERTER

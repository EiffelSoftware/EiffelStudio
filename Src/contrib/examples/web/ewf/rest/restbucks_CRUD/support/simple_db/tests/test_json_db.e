note
	description: "Summary description for {TEST_JSON_DB}."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_JSON_DB

inherit
	EQA_TEST_SET

	TEST_BASIC_DB_I

feature -- Test routines

	test_json_db
			-- New test routine
		local
			db: BASIC_JSON_FS_DATABASE
			obj: like new_object
			cl: CELL [detachable READABLE_STRING_GENERAL]
			l_type: TYPE [detachable ANY]
			l_id: detachable READABLE_STRING_GENERAL
		do
			create db.make (create {PATH}.make_from_string ("json-db"))
			db.serialization.set_pretty_printing
			db.serialization.register_default (create{JSON_REFLECTOR_SERIALIZATION})

			obj := new_object
			l_type := obj.generating_type
			create cl.put ("0")
			db.save (l_type, obj, cl)
			l_id := cl.item
			assert ("new id", l_id /= Void and then not l_id.is_whitespace)
			if l_id /= Void then
				assert ("has previous entry", db.has (l_type, l_id))
				if attached db.item (l_type, l_id) as l_stored_obj then
					assert ("same object", same_object (l_stored_obj, obj))
				else
					assert ("found", False)
				end
			end

			db.wipe_out
		end

end

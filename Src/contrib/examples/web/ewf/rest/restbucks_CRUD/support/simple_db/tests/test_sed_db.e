note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_SED_DB

inherit
	EQA_TEST_SET

	TEST_BASIC_DB_I

feature -- Test routines

	test_sed_db
			-- New test routine
		local
			db: BASIC_SED_FS_DATABASE
			obj: like new_object
			cl: CELL [detachable READABLE_STRING_GENERAL]
			l_type: TYPE [detachable ANY]
			l_id: detachable READABLE_STRING_GENERAL
		do
			create db.make (create {PATH}.make_from_string ("sed-db"))
			obj := new_object
			l_type := obj.generating_type
			create cl.put ("0")
			db.save (l_type, obj, cl)
			l_id := cl.item
			assert ("new id", l_id /= Void and then not l_id.is_whitespace)
			if l_id /= Void then
				assert ("has previous entry", db.has (l_type, l_id))
				if attached db.item (l_type, l_id) as l_stored_obj then
					assert ("same object", l_stored_obj.is_deep_equal (obj))
				else
					assert ("found", False)
				end
			end
			db.wipe_out
		end

end



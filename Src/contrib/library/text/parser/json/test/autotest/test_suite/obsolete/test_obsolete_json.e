note
	description: "Summary description for {TEST_OBSOLETE_JSON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_OBSOLETE_JSON

inherit
	SHARED_EJSON
		undefine
			default_create
		end

	EQA_TEST_SET

	JSON_PARSER_ACCESS
		undefine
			default_create
		end

	EXCEPTIONS
		undefine
			default_create
		end

feature -- Factory

	new_parser (a_string: STRING_8): JSON_PARSER
		do
			create Result.make_with_string (a_string)
		end

feature -- Test

	test_json_failed_json_conversion
			-- Test converting an Eiffel object to JSON that is based on a class
			-- for which no JSON converter has been registered.
		local
			gv: OPERATING_ENVIRONMENT
			jv: detachable JSON_VALUE
			has_exception: BOOLEAN
		do
			if not has_exception then
				create gv
				jv := json.value (gv)
			else
				assert ("exceptions.is_developer_exception", is_developer_exception)
			end
		rescue
			has_exception := True
			retry
		end

	test_json_failed_eiffel_conversion
			-- Test converting from a JSON value to an Eiffel object based on a
			-- class for which no JSON converter has been registered.
		local
			gv: detachable ANY
			jo: JSON_OBJECT
			has_exception: BOOLEAN
		do
			if not has_exception then
				create jo.make
				gv := json.object (jo, "OPERATING_ENVIRONMENT")
			else
				assert ("exceptions.is_developer_exception", is_developer_exception)
			end
		rescue
			has_exception := True
			retry
		end

end

note
	description: "[
		Shared factory class for creating JSON objects. Maps JSON
		objects to ELKS HASH_TABLEs and JSON arrays to ELKS
		LINKED_LISTs. Use non-conforming inheritance from this 
		class to ensure that your classes share the same 
		JSON_FACTORY instance.
	]"
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"
	file: "$HeadURL: $"

class
	SHARED_EJSON

obsolete
	"This JSON converter design has issues [2014-10-01]."

feature -- Access

	json: EJSON
			-- A shared EJSON instance with default converters for
			--LINKED_LIST [ANY] and HASH_TABLE [ANY, HASHABLE]
		obsolete
			"Use JSON_SERIALIZATION as replacement [2017-11-15]."			
		local
			jalc: JSON_ARRAYED_LIST_CONVERTER
			jllc: JSON_LINKED_LIST_CONVERTER
			jhtc: JSON_HASH_TABLE_CONVERTER
		once
			create Result
			create jalc.make
			Result.add_converter (jalc)
			create jllc.make
			Result.add_converter (jllc)
			create jhtc.make
			Result.add_converter (jhtc)
		end

note
	copyright: "2010-2014, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"

end -- class SHARED_EJSON

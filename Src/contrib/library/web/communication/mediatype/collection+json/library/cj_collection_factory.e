note
	description: "Summary description for {CJ_COLLECTION_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_COLLECTION_FACTORY

inherit
	SHARED_EJSON

feature -- Access

	collection (js: STRING): detachable CJ_COLLECTION
		local
			l_classname: STRING
		do
			l_classname := ({detachable CJ_COLLECTION}).name
			if l_classname.item (1) = '!' then
				l_classname := l_classname.substring (2, l_classname.count)
			end
			if attached {like collection} json.object_from_json (js, l_classname) as obj then
				Result := obj
			end
		end

note
	copyright: "2011-2012, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

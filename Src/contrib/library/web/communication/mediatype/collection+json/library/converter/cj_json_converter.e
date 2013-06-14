note
	description: "Summary description for {CJ_JSON_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CJ_JSON_CONVERTER

inherit
	JSON_CONVERTER

feature -- 	Convertion

	json_to_object (j: detachable JSON_VALUE; a_type: detachable TYPE [detachable ANY]): detachable ANY
		local
			l_classname: detachable STRING
		do
			if a_type /= Void then
				l_classname := a_type.name
				if l_classname.item (1) = '!' then
					l_classname := l_classname.substring (2, l_classname.count)
				end
			end
			Result := json.object (j, l_classname)
		end

note
	copyright: "2011-2012, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

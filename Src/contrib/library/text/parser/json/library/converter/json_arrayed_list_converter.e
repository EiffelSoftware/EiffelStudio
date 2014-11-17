note
	description: "A JSON converter for ARRAYED_LIST [ANY]"
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"
	file: "$HeadURL: $"

class
	JSON_ARRAYED_LIST_CONVERTER

obsolete
	"This JSON converter design has issues [Sept/2014]."

inherit

	JSON_LIST_CONVERTER
		redefine
			object
		end

create
	make

feature -- Access

	object: ARRAYED_LIST [detachable ANY]

feature {NONE} -- Factory

	new_object (nb: INTEGER): like object
		do
			create Result.make (nb)
		end

note
	copyright: "2010-2014, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end -- class JSON_ARRAYED_LIST_CONVERTER

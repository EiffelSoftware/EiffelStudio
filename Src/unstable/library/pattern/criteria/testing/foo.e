note
	description: "Summary description for {FOO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FOO

create
	make

feature

	make (s: READABLE_STRING_GENERAL)
		do
			create bar.make (s)
		end

	bar: BAR

end


note
	description: "Summary description for {APPLICATION_CONFIGURATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_CONFIGURATION

create
	make

feature {NONE} -- Initialization

	make
		do
			create document_root.make_empty
		end

feature -- Access

	document_root: STRING

feature -- Change

	set_document_root (v: like document_root)
		do
			document_root := v
		end

note
	copyright: "2011-2013, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

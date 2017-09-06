note
	description: "Summary description for {ROC_INSTALL_COPY_PARAMETERS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROC_INSTALL_COPY_PARAMETERS

create
	make_with_location

convert
	make_with_location ({PATH})

feature {NONE} -- Creation

	make_with_location (a_location: PATH)
		do
			location := a_location
		end

feature -- Access

	location: PATH

	is_link_mode: BOOLEAN

feature -- Element change

	set_link_mode (b: BOOLEAN)
		do
			is_link_mode := b
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

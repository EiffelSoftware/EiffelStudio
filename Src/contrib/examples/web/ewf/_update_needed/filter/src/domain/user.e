note
	description: "User."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	USER

inherit
	ANY
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (an_id: INTEGER; a_name, a_password: STRING)
		do
			id := an_id
			name := a_name
			password := a_password
		ensure
			id_set: id = an_id
			name_set: name = a_name
			password_set: password = a_password
		end

feature -- Access

	id: INTEGER
			-- Identifier

 	name: STRING
 			-- Name

 	password: STRING
 			-- Password

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			if Current = other then
				Result := True
			else
				Result := (id = other.id) and (name = other.name) and (password = other.password)
			end
		end

;note
	copyright: "2011-2012, Olivier Ligot, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

note
	description: "x509v3 Validity sequence"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "If we don't believe in freedom of expression for people we despise, we don't believe in it at all. - Noam Chomsky"

class
	VALIDITY

create
	make

feature
	make (not_before_a: TIME; not_after_a: TIME)
		do
			not_before := not_before_a
			not_after := not_after_a
		end

feature
	not_before: TIME
	not_after: TIME
end

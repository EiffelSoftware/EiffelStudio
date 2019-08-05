note
	description: "UUID data"
	date: "$Date: 2012-06-29 10:36:04 +0200 (Fri, 29 Jun 2012) $"
	revision: "$Revision: 89050 $"

class
	UUID_DATA

inherit
	ANY
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Init

	make (a_uuid_t: like uuid_t)
			-- Init
		do
			uuid_t := a_uuid_t
		ensure
			a_uuid_t_set: uuid_t = a_uuid_t
		end

feature -- Query

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := other.uuid_t ~ uuid_t
		end

feature -- Access

	uuid_t: STRING

feature -- Element Change

	set_uuid_t (a_uuid_t: STRING)
			-- Set `uuid_t' with `a_uuid_t'
		do
			uuid_t := a_uuid_t
		end

end

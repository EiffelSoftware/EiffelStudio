note
	description: "Summary description for {ES_CLOUD_PLAN}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_PLAN

create
	make,
	make_with_id_and_name

feature {NONE} -- Creation

	make (a_name: READABLE_STRING_8)
		do
			create name.make_from_string (a_name)
		end

	make_with_id_and_name (a_pid: INTEGER; a_name: READABLE_STRING_8)
		do
			id := a_pid
			make (a_name)
		end

feature -- Access

	has_id: BOOLEAN
		do
			Result := id > 0
		end

	id: INTEGER

	name: IMMUTABLE_STRING_8

	title: detachable IMMUTABLE_STRING_32

	description: detachable IMMUTABLE_STRING_32

feature -- Status report	

	same_plan (pl: detachable ES_CLOUD_PLAN): BOOLEAN
			-- Is Current same plan as `pl`?
		do
			if pl /= Void then
				if has_id then
					Result := id = pl.id
				else
					Result := name.same_string (pl.name)
				end
			end
		end

feature -- Query

	title_or_name: READABLE_STRING_32
		do
			if attached title as t then
				Result := t
			else
				Result := name.as_string_32
			end
		end

feature -- Element change

	set_title (s: detachable READABLE_STRING_GENERAL)
		do
			if s = Void then
				title := Void
			else
				create title.make_from_string_general (s)
			end
		end

	set_description (d: detachable READABLE_STRING_GENERAL)
		do
			if d = Void then
				description := Void
			else
				create description.make_from_string_general (d)
			end
		end

end

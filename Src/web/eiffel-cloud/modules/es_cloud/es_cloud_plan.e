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

	id: INTEGER

	name: IMMUTABLE_STRING_8

	title: detachable IMMUTABLE_STRING_32

	description: detachable IMMUTABLE_STRING_32

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

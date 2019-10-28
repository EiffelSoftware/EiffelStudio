note
	description: "Summary description for {ES_CLOUD_ORGANIZATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_ORGANIZATION

create
	make,
	make_with_id

feature {NONE} -- Initialization

	make (a_org_id: like id; a_name: READABLE_STRING_GENERAL)
		do
			id := a_org_id
			create name.make_from_string_general (a_name)
		end

	make_with_id (a_org_id: like id)
		do
			id := a_org_id
			create name.make_from_string_general ("org#" + a_org_id.out)
		end

feature -- Access

	id: INTEGER_64

	name: IMMUTABLE_STRING_32

	title: detachable IMMUTABLE_STRING_32

	description: detachable IMMUTABLE_STRING_32

	data: detachable IMMUTABLE_STRING_32
		do
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

feature -- Constants

	role_owner_id: INTEGER = 8
	role_manager_id: INTEGER = 4
	role_member_id: INTEGER = 1
	role_none_id: INTEGER = 0

feature -- Status

	has_id: BOOLEAN
		do
			Result := id /= 0
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

	set_data (a_data: detachable READABLE_STRING_GENERAL)
		local
--			s: READABLE_STRING_GENERAL
		do
--			if a_data /= Void then
--				across
--					a_data.split (';') as ic
--				loop
--					s := ic.item
--					if s.starts_with ("foo.bar=") then
--						v := s.substring (s.index_of ('=', 1) + 1, s.count).to_natural
--					end
--				end
--			end
		end

end

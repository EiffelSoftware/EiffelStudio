note
	description: "Summary description for {ES_CLOUD_INSTALLATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_INSTALLATION

create
	make

feature {NONE} -- Creation

	make (a_installation_id: READABLE_STRING_GENERAL; a_user: ES_CLOUD_USER)
		do
			user := a_user
			create installation_id.make_from_string_general (a_installation_id)
			create info.make_empty
			status := status_active
			get_product_info
		end

	get_product_info
		local
			i,j: INTEGER
			s: like installation_id
		do
			s := installation_id
			i := s.index_of ('_', 1)
			if i > 0 then
				product_id := s.head (i - 1)
				j := s.index_of ('-', i + 1)
				if j > 0 then
					s := s.substring (i + 1, j - 1)
					product_version := s
					i := s.index_of ('.', 1)
					if i > 0 then
						i := s.index_of ('.', i + 1)
						if i > 0 then
							product_version := s.head (i - 1)
						end
					end
				end
			else
				product_id := Void
				product_version := Void
			end
		end

feature -- Access

	installation_id: IMMUTABLE_STRING_32

	name: detachable IMMUTABLE_STRING_32

	user: ES_CLOUD_USER

	info: IMMUTABLE_STRING_32

	status: INTEGER

	creation_date: detachable DATE_TIME
			-- Installation registration date.

	product_id: detachable IMMUTABLE_STRING_32

	product_version: detachable IMMUTABLE_STRING_32

feature -- status report

	is_active: BOOLEAN
		do
			Result := status = status_active
		end

feature -- Constants/status

	status_active: INTEGER = 1
	status_inactive: INTEGER = 0

feature -- Element change

	set_info (inf: detachable READABLE_STRING_GENERAL)
		do
			if inf = Void then
				create info.make_empty
			else
				create info.make_from_string_general (inf)
			end
		end

	set_name (s: detachable READABLE_STRING_GENERAL)
		do
			if s = Void then
				name := Void
			else
				create name.make_from_string_general (s)
			end
		end

	set_status (s: INTEGER)
		do
			status := s
		end

	set_creation_date (dt: like creation_date)
		do
			creation_date := dt
		end

end

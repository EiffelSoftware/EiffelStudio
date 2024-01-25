note
	description: "Summary description for {ES_CLOUD_INSTALLATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_INSTALLATION

create
	make,
	make_with_license_id

feature {NONE} -- Creation

	make (a_installation_id: READABLE_STRING_GENERAL; a_license: ES_CLOUD_LICENSE)
		do
			make_with_license_id (a_installation_id, a_license.id)
		end

	make_with_license_id (a_installation_id: READABLE_STRING_GENERAL; a_license_id: like {ES_CLOUD_LICENSE}.id)
		do
			license_id := a_license_id
			create id.make_from_string_general (a_installation_id)
			create info.make_empty
			status := status_active
			get_product_info
		end

	get_product_info
		local
			i,j,k: INTEGER
			s,p: like id
		do
				-- Eiffel_20.03.10.3992-win64-...
			s := id
			i := s.index_of ('_', 1)
			if i > 0 then
				product_id := s.head (i - 1)
				s := s.substring (i + 1, s.count)
				i := s.index_of ('-', 1)
				if i > 0 then
					p := s.substring (1, i - 1)
					product_version := p
					j := p.index_of ('.', 1)
					if j > 0 then
						k := p.index_of ('.', j + 1)
						if k > 0 then
							product_version := p.head (k - 1)
						end
					end
					s := s.substring (i + 1, s.count)
					j := s.index_of ('-', 1)
					if j > 0 then
						s := s.head (j - 1)
--						if s.starts_with ("win") then
--							platform := "windows"
--						elseif s.starts_with ("linux") then
--							platform := "linux"
--						elseif s.starts_with ("macos") then
--							platform := "macos"
--						else
							create platform.make_from_string_general (s)
--						end
					end
				end
			else
				product_id := Void
				product_version := Void
				platform := Void
			end
		end

feature -- Access

	id: IMMUTABLE_STRING_32

	license_id: like {ES_CLOUD_LICENSE}.id

	name: detachable IMMUTABLE_STRING_32

	info: IMMUTABLE_STRING_32

	status: INTEGER

	creation_date: detachable DATE_TIME
			-- Installation registration date.

	product_id: detachable IMMUTABLE_STRING_32

	product_version: detachable IMMUTABLE_STRING_32

	platform: detachable IMMUTABLE_STRING_32

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

feature {ES_CLOUD_API} -- Update element

	update_license (a_license: ES_CLOUD_LICENSE)
		do
			update_license_id (a_license.id)
		end

	update_license_id (a_license_id: like license_id)
		do
			license_id := a_license_id
		end

end

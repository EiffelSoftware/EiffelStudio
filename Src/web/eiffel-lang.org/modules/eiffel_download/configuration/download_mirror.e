note
	description: "Summary description for {DOWNLOAD_MIRROR}."
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_MIRROR

feature -- Access

	id: detachable READABLE_STRING_32
			-- artifact id.

	mirrors: detachable LIST[DOWNLOAD_MIRROR_MIRRORS]
			-- Possibly list of mirrors.

feature -- Element change

	set_id (a_id: like id)
			-- Assign `id' with `a_id'.
		do
			id := a_id
		ensure
			id_assigned: id = a_id
		end

	set_mirrors (a_mirrors: like mirrors)
		do
			mirrors := a_mirrors
		end
end

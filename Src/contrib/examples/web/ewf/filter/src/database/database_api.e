note
	description: "Summary description for {DATABASE_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_API
create
	make

feature -- Initialization

	make
		local
			l_user: USER
		do
			create users.make (10)
			create l_user.make (1, "foo", "bar")
			users.put (l_user, l_user.id)
			create l_user.make (2, "demo", "demo")
			users.put (l_user, l_user.id)
		end

feature -- Access

	user_by_id (a_id: INTEGER): detachable USER
		do
			Result := users.item (a_id)
		end

	user_by_name (a_name: READABLE_STRING_GENERAL): detachable USER
		do
			across
				users as c
			until
				Result /= Void
			loop
				if attached c.item as u and then a_name.same_string (u.name) then
					Result := u
				end
			end
		end

	user (a_id: INTEGER; a_name: detachable READABLE_STRING_GENERAL): detachable USER
			-- User with id `a_id' or name `a_name'.
		require
			a_id > 0 xor a_name /= Void
		do
			if a_id > 0 then
				Result := user_by_id (a_id)
			elseif a_name /= Void then
				Result := user_by_name (a_name)
			end
		ensure
			Result /= Void implies ((a_id > 0 and then Result.id = a_id) xor (a_name /= Void and then Result.name.same_string_general (a_name)))
		end

	users: HASH_TABLE [USER, INTEGER]

;note
	copyright: "2011-2015, Olivier Ligot, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

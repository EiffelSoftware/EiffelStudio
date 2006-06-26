indexing
	description: "Named mutex factory"

class
	MUTEX_FACTORY

feature -- Access

	new_mutex (a_name: STRING): SYSTEM_MUTEX is
			-- Instantiate new named mutex with name `a_name'.
		do
			create Result.make (False, a_name)
		end

end
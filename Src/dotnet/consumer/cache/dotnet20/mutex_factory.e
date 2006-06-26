indexing
	description: "Named mutex factory"

class
	MUTEX_FACTORY

feature -- Access

	new_mutex (a_name: STRING): SYSTEM_MUTEX is
			-- Instantiate new named mutex with name `a_name'.
			-- Grant full control to everyone so that multiple users can access
			-- the metadata cache concurrently.
		local
			l_security: MUTEX_SECURITY
			l_rule: MUTEX_ACCESS_RULE
		do
			create Result.make (False, a_name)
			l_security := Result.get_access_control
			create l_rule.make ("Everyone", {MUTEX_RIGHTS}.Full_control, {ACCESS_CONTROL_TYPE}.Allow)
			l_security.add_access_rule (l_rule)
			Result.set_access_control (l_security)
		end

end

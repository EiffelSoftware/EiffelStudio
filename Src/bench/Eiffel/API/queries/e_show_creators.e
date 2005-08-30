indexing
	description: "Command to display class creation procedures of a class."
	date: "$Date$"
	revision: "$Revision$"

class E_SHOW_CREATORS

inherit
	E_CLASS_FORMAT_CMD
	
create
	make, default_create

feature -- Access

	criterium (f: E_FEATURE): BOOLEAN is
			-- Criterium for feature `f'
		local
			l_creators: HASH_TABLE [EXPORT_I, STRING]
		do
				-- Note that this is not the most efficient way to know if `f'
				-- is a creation routine, as the quicked way would be to iterate
				--  through `current_class.creators', but this enables the reuse
				-- of the existing framework.
			l_creators := current_class.creators
			if l_creators = Void then
					-- Simply search for the version of `{ANY}.default_create'.
				Result := f.rout_id_set.has (eiffel_system.system.default_create_id)
			elseif not l_creators.is_empty then
				Result := l_creators.has (f.name)
			end
		end

end

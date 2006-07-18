indexing
	description: "Implementation of PROCESS_INFO"
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_INFO_IMP

inherit
	PROCESS_INFO

feature -- Access

	process_id: INTEGER is
			-- Process ID of current process
		local
			l_prc: SYSTEM_DLL_PROCESS
		do
			create l_prc.make
			l_prc := l_prc.get_current_process
			Result := l_prc.id
		end

	environment_variables: HASH_TABLE [STRING, STRING] is
			-- Table of environment variables associated with current process,
			-- indexed by variable name
		local
			l_dic: IDICTIONARY
			l_enumerator: IENUMERATOR
			l_entry: DICTIONARY_ENTRY
			l_key: SYSTEM_STRING
			l_value: SYSTEM_STRING
		do
			l_dic := {ENVIRONMENT}.get_environment_variables
			l_enumerator := l_dic.get_enumerator_2
			create Result.make (l_dic.count)
			from
			until
				not l_enumerator.move_next
			loop
				l_entry ?= l_enumerator.current_
				check l_entry /= Void end
				l_key ?= l_entry.key
				l_value ?= l_entry.value
				check
					l_key /= Void
					l_value /= Void
				end
				Result.force (l_value, l_key)
			end
		end

end

note
	description: "Dummy class to restrict export of backend features to descendants of this class."
	author: "Roman schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_EIFFELSTORE_EXPORT

feature {NONE} -- Utilities

	attach (obj: detachable ANY): attached like obj
			-- Nice little helper function to make implementation with void safety easier.
		do
			check attached obj as attached_obj then
				Result := obj
			end
		end


feature {PS_EIFFELSTORE_EXPORT} -- Contracts

	enable_expensive_contracts: BOOLEAN = True
			-- Defines if some very expensive contracts should be enabled as well.
end

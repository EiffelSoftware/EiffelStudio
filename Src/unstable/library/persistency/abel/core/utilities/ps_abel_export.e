note
	description: "Dummy class to restrict export of backend features to descendants of this class."
	author: "Roman schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_ABEL_EXPORT

inherit

	REFACTORING_HELPER
		export {NONE}
			--to_implement_assertion,
			fixme,
			to_implement
		end
end

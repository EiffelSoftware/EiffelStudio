indexing
	description: "[
		Representation of an object that contains tags
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TAGABLE_I

inherit
	ACTIVE_ITEM_I
		redefine
			memento
		end

	HASHABLE

feature -- Access

	tags: !DS_LINEAR [!STRING]
			-- List of tags
		require
			usable: is_interface_usable
		deferred
		ensure
			result_uses_string_equality: ({KL_STRING_EQUALITY_TESTER} #? Result.equality_tester) /= Void
			results_not_empty: not ({!DS_LINEAR [!STRING]} #? Result).there_exists (agent {!STRING}.is_empty)
		end

	memento: !TAGABLE_MEMENTO_I
			-- <Precursor>
		deferred
		end

end

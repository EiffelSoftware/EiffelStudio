note
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

	TAG_UTILITIES

	HASHABLE

feature -- Access

	name: attached STRING
			-- Name describing `Current'
		require
			usable: is_interface_usable
		deferred
		ensure
			not_empty: not Result.is_empty
		end

	tags: attached DS_LINEAR [attached STRING]
			-- List of tags
		require
			usable: is_interface_usable
		deferred
		ensure
			result_uses_string_equality: ({KL_STRING_EQUALITY_TESTER} #? Result.equality_tester) /= Void
			results_valid: Result.for_all (agent is_valid_tag)
			results_not_empty: not ({attached DS_LINEAR [attached STRING]} #? Result).there_exists (agent {attached STRING}.is_empty)
		end

	memento: attached TAGABLE_MEMENTO_I
			-- <Precursor>
		deferred
		end

end

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

	TAG_UTILITIES

	HASHABLE

feature -- Access

	name: !STRING
			-- Name describing `Current'
		require
			usable: is_interface_usable
		deferred
		ensure
			not_empty: not Result.is_empty
		end

	tags: !DS_LINEAR [!STRING]
			-- List of tags
		require
			usable: is_interface_usable
		deferred
		ensure
			result_uses_string_equality: ({KL_STRING_EQUALITY_TESTER} #? Result.equality_tester) /= Void
			results_valid: Result.for_all (agent is_valid_tag)
			results_not_empty: not ({!DS_LINEAR [!STRING]} #? Result).there_exists (agent {!STRING}.is_empty)
		end

	memento: !TAGABLE_MEMENTO_I
			-- <Precursor>
		deferred
		end

end

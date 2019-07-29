note

	description:

		"Xace target lists"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2018-2019, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_XACE_TARGETS

obsolete

	"Use ET_ECF_* classes instead. [2019-03-17]"

inherit

	ANY

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make (a_target: like target)
			-- Create a new target list with initially one target `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			create targets.make (Initial_targets_capacity)
			targets.put_last (a_target)
		ensure
			one_target: targets.count = 1
			targets_set: targets.last = a_target
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is the list of targets empty?
		do
			Result := (count = 0)
		ensure
			definition: Result = (count = 0)
		end

	has_target (a_name: STRING): BOOLEAN
			-- Is there a target with name `a_name'?
		require
			a_name_not_void: a_name /= Void
		local
			i, nb: INTEGER
		do
			nb := targets.count
			from i := 1 until i > nb loop
				if STRING_.same_case_insensitive (targets.item (i).name, a_name) then
					Result := True
					i := nb + 1 -- Jump out of the loop.
				end
				i := i + 1
			end
		end

	has (a_target: like target): BOOLEAN
			-- Is `a_target' included in current list of targets?
		require
			a_target_not_void: a_target /= Void
		do
			Result := targets.has (a_target)
		ensure
			definition: Result = targets.has (a_target)
		end

feature -- Access

	target (i: INTEGER): ET_XACE_TARGET
			-- `i'-th target
		require
			i_large_enough: i >= 1
			i_small_enough: i <= count
		do
			Result := targets.item (i)
		ensure
			target_not_void: Result /= Void
		end

	target_by_name (a_name: STRING): detachable like target
			-- Target with name `a_name' if any, Void otherwise
		require
			a_name_not_void: a_name /= Void
		local
			i, nb: INTEGER
			l_target: like target
		do
			nb := targets.count
			from i := 1 until i > nb loop
				l_target := targets.item (i)
				if STRING_.same_case_insensitive (l_target.name, a_name) then
					Result := l_target
					i := nb + 1 -- Jump out of the loop.
				end
				i := i + 1
			end
		ensure
			target_not_void: has_target (a_name) implies Result /= Void
		end

	last: like target
			-- Last target
		require
			not_empty: not is_empty
		do
			Result := target (count)
		ensure
			last_not_void: Result /= Void
			definition: Result = target (count)
		end

	targets: DS_ARRAYED_LIST [like target]
			-- Targets

feature -- Measurement

	count: INTEGER
			-- Number of targets
		do
			Result := targets.count
		ensure
			count_not_negative: Result >= 0
			definition: Result = targets.count
		end

feature -- Element change

	put_last (a_target: like target)
			-- Add `a_target' to the list of targets.
		require
			a_target_not_void: a_target /= Void
		do
			targets.force_last (a_target)
		ensure
			one_more: targets.count = old targets.count + 1
			target_added: targets.last = a_target
		end

feature -- Iteration

	do_all (an_action: PROCEDURE [ET_XACE_TARGET])
			-- Apply `an_action' to every target, from first to last.
			-- (Semantics not guaranteed if `an_action' changes the list.)
		require
			an_action_not_void: an_action /= Void
		do
			targets.do_all (an_action)
		end

feature {NONE} -- Constants

	Initial_targets_capacity: INTEGER = 50
			-- Initial capacity for `targets'

invariant

	targets_not_void: targets /= Void
	no_void_target: not targets.has_void

end

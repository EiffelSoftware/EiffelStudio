indexing
	description: "Refactoring logger."
	date: "$Date$"
	revision: "$Revision$"

class
	ERF_LOGGER

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Create.
		do
			create start_actions.make (1)
			create end_actions.make (1)
			create class_actions.make (1)
		end


feature

	start_actions: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			-- Actions executed when a new refactoring is started.

	end_actions: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			-- Actions executed when a refactoring is finished.

	class_actions: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [CLASS_I]]]
			-- Actions executed when a class has been modified.

feature -- Trigger events

	refactoring_start is
			-- Triggered when a new refactoring is started.
		do
			from
				start_actions.start
			until
				start_actions.after
			loop
				start_actions.item.call ([])
				start_actions.forth
			end
		end

	refactoring_end is
			-- Triggered when a refactoring is finished.
		do
			from
				end_actions.start
			until
				end_actions.after
			loop
				end_actions.item.call ([])
				end_actions.forth
			end
		end

	refactoring_class (a_class: CLASS_I) is
			-- Triggered when a class is edited.
		do
			from
				class_actions.start
			until
				class_actions.after
			loop
				class_actions.item.call ([a_class])
				class_actions.forth
			end
		end

end

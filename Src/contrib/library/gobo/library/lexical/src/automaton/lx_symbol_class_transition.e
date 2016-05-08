note

	description:

		"Symbol class transitions to automaton states"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class LX_SYMBOL_CLASS_TRANSITION [G -> LX_STATE]

inherit

	LX_TRANSITION [G]
		rename
			make as make_transition
		redefine
			labeled,
			record,
			recordable
		end

create

	make

feature {NONE} -- Initialization

	make (symbols: like label; state: like target)
			-- Create a new transition to
			-- `target', labeled `symbols'.
		require
			state_not_void: state /= Void
			symbols_not_void: symbols /= Void
			symbols_sorted: not symbols.sort_needed
		do
			label := symbols
			target := state
		ensure
			label_set: label = symbols
			target_set: target = state
		end

feature -- Access

	label: LX_SYMBOL_CLASS
			-- Transition label

feature -- Setting

	set_label (symbols: like label)
			-- Set `label' to `symbols'.
		require
			symbols_not_void: symbols /= Void
			symbols_sorted: not symbols.sort_needed
		do
			label := symbols
		ensure
			label_set: label = symbols
		end

feature -- Status report

	labeled (symbol: INTEGER): BOOLEAN
			-- Is current transition labeled `symbol'?
		do
			if label.negated then
				Result := not label.has (symbol)
			else
				Result := label.has (symbol)
			end
		end

feature -- Equivalence classes

	record (equiv_classes: LX_EQUIVALENCE_CLASSES)
			-- Update set label equivalence classes `equiv_classes'
			-- with transition labels, if any.
		do
			equiv_classes.add (label)
		end

	recordable (equiv_classes: LX_EQUIVALENCE_CLASSES): BOOLEAN
			-- May current transition be recorded in `equiv_classes'?
		do
			Result := equiv_classes.valid_symbol_class (label)
		end

invariant

	label_not_void: label /= Void
	label_sorted: not label.sort_needed

end

note

	description:

		"Deferred common base for wrapper classes that wrap types"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class EWG_ABSTRACT_TYPE_WRAPPER

inherit

	EWG_ABSTRACT_WRAPPER

feature -- Access

	type: EWG_C_AST_TYPE
		deferred
		end

invariant

	type_not_void: type /= Void

end

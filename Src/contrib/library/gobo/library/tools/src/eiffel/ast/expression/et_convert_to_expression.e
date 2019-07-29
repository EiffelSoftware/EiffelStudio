﻿note

	description:

		"Eiffel conversion-to expressions"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2004-2019, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_CONVERT_TO_EXPRESSION

inherit

	ET_CONVERT_EXPRESSION

	ET_QUALIFIED_FEATURE_CALL_EXPRESSION
		rename
			target as expression
		undefine
			is_instance_free
		end

create

	make

feature {NONE} -- Initialization

	make (e: like expression; a_feature: like convert_feature)
			-- Create a new conversion expression.
		require
			e_not_void: e /= Void
			a_feature_not_void: a_feature /= Void
		local
			l_name: ET_IDENTIFIER
			l_position: ET_POSITION
		do
			expression := e
			convert_feature := a_feature
			create l_name.make (a_feature.name.name)
			l_name.set_seed (a_feature.name.seed)
			l_position := e.position
			l_name.set_position (l_position.line, l_position.column)
			name := l_name
		ensure
			expression_set: expression = e
			convert_feature_set: convert_feature = a_feature
		end

feature -- Access

	name: ET_FEATURE_NAME
			-- Feature name

	arguments: detachable ET_ACTUAL_ARGUMENTS
			-- Arguments
		do
		ensure then
			no_arguments: Result = Void
		end

feature -- Processing

	process (a_processor: ET_AST_PROCESSOR)
			-- Process current node.
		do
			a_processor.process_convert_to_expression (Current)
		end

end

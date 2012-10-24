note

	description: "[
				Convenient class to create event filters
			]"
	date: "$Date$"
	revision: "$Revision$"

class XML_CALLBACKS_FILTER_FACTORY

feature -- Filters

	new_null: XML_CALLBACKS_NULL
			-- New null callback consumer
		do
			create Result.make
		ensure
			null_callback_not_void: Result /= Void
		end

	new_namespace_resolver: XML_NAMESPACE_RESOLVER
			-- New namespace resolver
		do
			create Result.make_null
		ensure
			namespace_resolver_not_void: Result /= Void
		end

	new_document_builder,
	new_tree_builder: XML_CALLBACKS_DOCUMENT
			-- New tree construction filter
		do
			create Result.make_null
		ensure
			tree_builder_not_void: Result /= Void
		end

feature -- Filters to implement

	new_pretty_print: XML_PRETTY_PRINT_FILTER
			-- New pretty printer (to standard io)
		do
			create Result.make_null
		ensure
			pretty_print_not_void: Result /= Void
		end

	new_indent_pretty_print: XML_INDENT_PRETTY_PRINT_FILTER
			-- Indenting pretty print filter
		do
			create Result.make_null
		ensure
			indent_pretty_print_not_void: Result /= Void
		end

	new_xmlns_generator: XML_XMLNS_GENERATOR
			-- New xmlns: generator (opposite of namespace resolver)
		do
			create Result.make_null
		ensure
			xmlns_generator_not_void: Result /= Void
		end

	new_content_concatenator: XML_CONTENT_CONCATENATOR
			-- New content concatenation filter.
		do
			create Result.make_null
		ensure
			content_concatenator_not_void: Result /= Void
		end

--	new_canonical_pretty_print: XML_CANONICAL_PRETTY_PRINT_FILTER
--			-- James Clark' canonical XML output
--		do
--			create Result.make_null
--		ensure
--			pretty_print_not_void: Result /= Void
--		end

--	new_stop_on_error: XM_STOP_ON_ERROR_FILTER
--			-- New stop-on-error filter
--		do
--			create Result.make_null
--		ensure
--			stop_on_error_not_void: Result /= Void
--		end

--	new_whitespace_normalizer: XML_WHITESPACE_NORMALIZER
--			-- New whitespace normalizer.
--		do
--			create Result.make_null
--		ensure
--			whitespace_normalizer_not_void: Result /= Void
--		end

feature -- Pipes

	callbacks_pipe (a: ARRAY [XML_CALLBACKS_FILTER]): XML_CALLBACKS
			-- Make a pipe,
			-- eg << new_tag_checker, new_pretty_print >>
			-- return first item of pipe.
		require
			a_not_void: a /= Void
			a_not_empty: a.count > 0
			-- no_void_callbacks_filter: not a.has (Void)
		local
			i, nb: INTEGER
		do
			i := a.lower
			nb := a.upper
			from until i >= nb loop
				a.item (i).set_next (a.item (i + 1))
				i := i + 1
			end
			Result := a.item (a.lower)
		ensure
			pipe_not_void: Result /= Void
		end

	standard_callbacks_pipe (a: ARRAY [XML_CALLBACKS_FILTER]): XML_CALLBACKS
			-- Add elements to standard validation pipe, which
			-- begins with:
			--  namespace resolver -> stop on error
		require
			a_not_void: a /= Void
		local
			a_last: XML_CALLBACKS_FILTER
		do
			a_last := new_namespace_resolver
			Result := callbacks_pipe (<<a_last>>)
			if a.count > 0 then
				a_last.set_next (callbacks_pipe (a))
			end
		ensure
			pipe_not_void: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

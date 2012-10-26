note

	description:
		"[
			Interface for external resolver of system entities

			Note: the original code is from Gobo's XM library (http://www.gobosoft.com/)
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class XML_EXTERNAL_RESOLVER

feature -- Action(s)

	resolve (a_system: STRING)
			-- Resolve a system identifier to an input stream
			-- on behalf of an XML parser.
		require
			a_system_not_void: a_system /= Void
		deferred
		ensure
			stream_if_not_error: not has_error implies last_stream /= Void
			stream_open_on_success: attached last_stream as s implies s.is_open_read
			--depth: not has_error implies resolve_depth = old resolve_depth + 1
		end

	resolve_public (a_public: STRING; a_system: STRING)
			-- Resolve a public/system identified pair to an input stream.
			-- (Default implementation: resolve using system ID only.)
		require
			a_public_not_void: a_public /= Void
			a_system_not_void: a_system /= Void
		do
			resolve (a_system)
		ensure
			stream_if_not_error: not has_error implies last_stream /= Void
			stream_open_on_success: attached last_stream as s implies s.is_open_read
			--depth: not has_error implies resolve_depth = old resolve_depth + 1
		end

	resolve_finish
			-- The parser has finished with the last resolved entity.
			-- The previously resolved entity becomes the last resolved one.
			-- Note: `last_stream' is not required to be restored accordingly.
		require
			--balanced: resolve_depth > 0
		do
		ensure
			--depth: resolve_depth = old resolve_depth - 1
		end

feature -- Result

	last_stream: detachable XML_INPUT_STREAM
			-- Last stream initialised from external entity.
		require
			not_error: not has_error
		deferred
		ensure
			not_void: Result /= Void
		end

	has_error: BOOLEAN
			-- Did the last resolution attempt succeed?
		deferred
		end

	last_error: detachable STRING
			-- Last error message.
		require
			has_error: has_error
		deferred
		ensure
			not_void: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

indexing
	
	description:
	
		"Interface for external resolver of system entities"
	
	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2001, Andreas Leitner and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class XM_EXTERNAL_RESOLVER

feature -- Action(s)

	resolve (a_system: STRING) is
			-- Resolve a system identifier to an input stream
			-- on behalf of an XML parser.
		require
			a_system_not_void: a_system /= Void
		deferred
		ensure
			stream_open_on_success: not has_error implies last_stream.is_open_read
			--depth: not has_error implies resolve_depth = old resolve_depth + 1
		end
		
	resolve_public (a_public: STRING; a_system: STRING) is
			-- Resolve a public/system identified pair to an input stream.
			-- (Default implementation: resolve using system ID only.)
		require
			a_public_not_void: a_public /= Void
			a_system_not_void: a_system /= Void
		do
			resolve (a_system)
		ensure
			stream_open_on_success: not has_error implies last_stream.is_open_read
			--depth: not has_error implies resolve_depth = old resolve_depth + 1
		end
		
	resolve_finish is
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

	last_stream: KI_CHARACTER_INPUT_STREAM is
			-- Last stream initialised from external entity.
		require
			not_error: not has_error
		deferred
		ensure
			not_void: Result /= Void
		end
	
	has_error: BOOLEAN is
			-- Did the last resolution attempt succeed?
		deferred
		end
		
	last_error: STRING is
			-- Last error message.
		require
			has_error: has_error
		deferred
		ensure
			not_void: Result /= Void
		end

end

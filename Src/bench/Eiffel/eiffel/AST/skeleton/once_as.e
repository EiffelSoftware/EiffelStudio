indexing
	description: "AST representation of a once routines."
	date: "$Date$"
	revision: "$Revision$"

class ONCE_AS

inherit
	INTERNAL_AS
		redefine
			byte_node, is_once
		end

feature -- Properties

	is_once: BOOLEAN is True
			-- Is the current routine body a once one ?

feature -- Access

	byte_node: ONCE_BYTE_CODE is
			-- Byte code for once body
		local
			body: FEATURE_AS
			is_global_once: BOOLEAN
		do
			!! Result
			if compound /= Void then
				Result.set_compound (compound.byte_node)
			end
			Result.record_separate_calls_on_arguments
			
			body := Context.a_feature.body
			check
				body_not_void: body /= Void
			end

			if body.indexes /= Void then
				is_global_once := body.indexes.has_global_once
				Result.set_is_global_once (is_global_once)
				if is_global_once and System.has_multithreaded then
						-- No byte code generation at the moment for global
						-- onces in multithreaded mode.
					System.set_freeze
				end
			end
		end

feature {NONE}

	begin_keyword: BASIC_TEXT is
			-- "once" keyword
		once
			Result := ti_Once_keyword
		end

end -- class ONCE_AS

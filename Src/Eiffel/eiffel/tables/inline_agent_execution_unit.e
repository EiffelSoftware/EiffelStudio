indexing
	description: "Execution unit of an inline agent"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INLINE_AGENT_EXECUTION_UNIT

inherit
	EXECUTION_UNIT
		rename
			make as make_execution_unit
		redefine
			is_valid
		end

create
	make

feature -- Initialization

	make (a_cl_type: CLASS_TYPE; a_enclosing_feature: FEATURE_I) is
			-- Initialization
		require
			a_cl_type_not_void: a_cl_type /= Void
			a_enclosing_feature_not_void: a_enclosing_feature /= Void
		do
			enclosing_feature := a_enclosing_feature
			make_execution_unit (a_cl_type)
		end

feature -- Access

	is_valid: BOOLEAN is
			-- Is the execution unit still valid ?
		local
			written_type: CLASS_TYPE
			written_class: EIFFEL_CLASS_C
			f: FEATURE_AS
		do
			written_class ?= System.class_of_id (written_in)
			if
				written_class /= Void and then
				written_class.has_inline_agent_with_body_index (body_index) and then
				System.class_type_of_id (type_id) = class_type
			then
				written_type :=	class_type.written_type (written_class)
				if written_type.is_precompiled then
					Result := True
				else
						-- Feature may have disappeared from system and
						-- we need to detect it.
					Result := Body_server.server_has (enclosing_feature.body_index)
					if Result then
						if System.execution_table.has_dead_function (enclosing_feature.body_index) then

							f := Body_server.server_item (enclosing_feature.body_index)

								-- This is an attribute that was a function before, so
								-- it is not a valid `execution_unit' anymore if after
								-- all recompilation it is still an attribute.
								--
								-- Or if it is a deferred feature that was not
								-- deferred before
							Result := not f.is_attribute and then not f.is_deferred
						end
					else
						Result := class_type.associated_class.invariant_feature = enclosing_feature
					end
				end
			end
		end

feature	{NONE}-- Implementation

	enclosing_feature: FEATURE_I

end

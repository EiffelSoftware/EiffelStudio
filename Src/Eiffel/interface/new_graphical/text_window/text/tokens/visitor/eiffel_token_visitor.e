note
	description: "Visitor of Eiffel specific tokens."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TOKEN_VISITOR

inherit
	TOKEN_VISITOR

feature -- Visit

	process_editor_token_breakpoint (a_tok: EDITOR_TOKEN_BREAKPOINT)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_class (a_tok: EDITOR_TOKEN_CLASS)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_cluster (a_tok: EDITOR_TOKEN_CLUSTER)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_error_code (a_tok: EDITOR_TOKEN_ERROR_CODE)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_feature (a_tok: EDITOR_TOKEN_FEATURE)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_feature_start (a_tok: EDITOR_TOKEN_FEATURE_START)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_object (a_tok: EDITOR_TOKEN_OBJECT)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_generic (a_tok: EDITOR_TOKEN_GENERIC)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_local (a_tok: EDITOR_TOKEN_LOCAL)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_reserved (a_tok: EDITOR_TOKEN_RESERVED)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_tag (a_tok: EDITOR_TOKEN_TAG)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_target (a_tok: EDITOR_TOKEN_TARGET)
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EIFFEL_TOKEN_VISITOR

indexing
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

	process_editor_token_breakpoint (a_tok: EDITOR_TOKEN_BREAKPOINT) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_class (a_tok: EDITOR_TOKEN_CLASS) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_cluster (a_tok: EDITOR_TOKEN_CLUSTER) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_error_code (a_tok: EDITOR_TOKEN_ERROR_CODE) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_feature (a_tok: EDITOR_TOKEN_FEATURE) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_feature_start (a_tok: EDITOR_TOKEN_FEATURE_START) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_object (a_tok: EDITOR_TOKEN_OBJECT) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_generic (a_tok: EDITOR_TOKEN_GENERIC) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_local (a_tok: EDITOR_TOKEN_LOCAL) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_reserved (a_tok: EDITOR_TOKEN_RESERVED) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

	process_editor_token_tag (a_tok: EDITOR_TOKEN_TAG) is
		require
			a_tok_not_void: a_tok /= Void
		deferred
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

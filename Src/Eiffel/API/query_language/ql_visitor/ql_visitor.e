indexing
	description: "Visitor to visit Eiffel query language items"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_VISITOR

feature -- Process

	process_domain (a_item: QL_DOMAIN) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_item (a_item: QL_VISITABLE) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		do
			a_item.process (Current)
		end

	process_target (a_item: QL_TARGET) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_group (a_item: QL_GROUP) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_class (a_item: QL_CLASS) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_feature (a_item: QL_FEATURE) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_real_feature (a_item: QL_REAL_FEATURE) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_invariant (a_item: QL_INVARIANT) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_quantity (a_item: QL_QUANTITY) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_line (a_item: QL_LINE) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_generic (a_item: QL_GENERIC) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_local (a_item: QL_LOCAL) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_argument (a_item: QL_ARGUMENT) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_assertion (a_item: QL_ASSERTION) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

indexing
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


end

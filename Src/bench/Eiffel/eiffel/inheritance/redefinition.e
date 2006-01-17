indexing
	description: "Redefinition of inherited features contained in `old_features' into%N%
		%a new feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	REDEFINITION 

inherit
	DEFINITION
		redefine
			check_adaptation
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

create
	make
	
feature 

	check_adaptation (feat_tbl: FEATURE_TABLE) is
			-- Check signature conformance beetween the precursors contained
			-- in `old_features' and the feature `new_feature'.
			-- Take care also of the attribute `redefinitions' of
			-- `new_feature' for merging assertions.
		require else
			old_features /= Void
			new_feature /= Void
		local
			vdrd8: VDRD8
		do
			Precursor {DEFINITION} (feat_tbl)

				-- Check assertion marks
			if
				not new_feature.is_require_else or else
				not new_feature.is_ensure_then
			then
				create vdrd8
				vdrd8.set_class (System.current_class)
				vdrd8.set_feature (new_feature)
				if not new_feature.is_require_else then
					vdrd8.set_precondition
				end
				if not new_feature.is_ensure_then then
					vdrd8.set_postcondition
				end
				Error_handler.insert_error (vdrd8)
			end
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

end -- class REDEFINITION

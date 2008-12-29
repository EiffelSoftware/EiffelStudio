note
	description: "Representation of a deferred procedure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DEF_PROC_I

inherit

	PROCEDURE_I
		redefine
			is_deferred, has_entry, to_generate_in, extension,
			update_api, transfer_to, transfer_from, access_for_feature
		end

feature -- Status Report

	has_entry: BOOLEAN = False;
			-- No polymorphic unit for deferred features

	is_deferred: BOOLEAN
		do
			Result := True
		end;

feature -- Access

	access_for_feature (access_type, static_type: TYPE_A; is_qualified: BOOLEAN): ACCESS_B
			-- New ACCESS_B structure for current deferred routine
		local
			external_b: EXTERNAL_B
			l_type: TYPE_A
		do
			check
				not_a_static_binding: static_type = Void
			end
			if extension /= Void then
				if is_qualified then
						-- To fix eweasel test#term155 we remove all anchors from
						-- calls after the first dot in a call chain.
					l_type := access_type.context_free_type
				else
					l_type := access_type
				end
				create external_b
				external_b.init (Current)
				external_b.set_type (l_type)
				external_b.set_external_name_id (external_name_id)
				external_b.set_extension (extension)
				Result := external_b
			else
				Result := Precursor (access_type, static_type, is_qualified)
			end
		end

feature -- Conversion

	to_generate_in (a_class: CLASS_C): BOOLEAN
			-- Has the current feature to be generated in class `a_class' ?
			-- (Deferred routines with pre or post conditions are
			-- not generated)
		do
			-- Do nothing
		end;

feature -- Basic Operation

	transfer_to (other: DEF_PROC_I)
			-- Transfer datas form `other' into Current.
		do
			Precursor {PROCEDURE_I} (other)
			extension := other.extension
		end

	transfer_from (other: DEF_PROC_I)
			-- Transfer datas form `other' into Current.
		do
			Precursor {PROCEDURE_I} (other)
			extension := other.extension
		end

feature -- Access

	replicated (in: INTEGER): FEATURE_I
			-- Replication
		local
			rep: R_DEF_PROC_I
		do
			create rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			rep.set_access_in (in)
			Result := rep;
		end;

	selected: DEF_PROC_I
			-- Selected attribute
		do
			create Result
			Result.transfer_from (Current)
		end

	unselected (in: INTEGER): FEATURE_I
			-- Unselected feature
		local
			unselect: D_DEF_PROC_I
		do
			create unselect;
			transfer_to (unselect);
			unselect.set_access_in (in);
			Result := unselect;
		end;

	extension: EXTERNAL_EXT_I
			-- Deferred external information

feature -- Element Change

	set_extension (an_extension: like extension)
			-- Set `extension' with `an_extension'.
		require
			an_extension_not_void: an_extension /= Void
		do
			extension := an_extension
		ensure
			extension_set: extension = an_extension
		end

feature {NONE} -- Implementation

	update_api (f: E_ROUTINE)
		do
			Precursor {PROCEDURE_I} (f);
			f.set_deferred (True);
		end;

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

end

indexing
	description: "Shared BMP or XPM's"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_SHARED_BITMAPS

feature -- Access

	bm_About: EV_PIXMAP is
		once
			Result := pixmap_file_content ("bm_About")
		end

	bm_Clear_breakpoints: EV_PIXMAP is
		once
			Result := pixmap_file_content ("clr_bp")
		end

	bm_Disable_breakpoints: EV_PIXMAP is
		once
			Result := pixmap_file_content ("dis_bp")
		end

	bm_Exec_step: EV_PIXMAP is
		once
			Result := pixmap_file_content ("execstep")
		end

	bm_Open: EV_PIXMAP is
		once
			Result := pixmap_file_content ("open")
		end
	
	bm_Setstop: EV_PIXMAP is
		once
			Result := pixmap_file_content ("setstop")
		end

	bm_Showaversions: EV_PIXMAP is
		once
			Result := pixmap_file_content ("saversio")
		end

	bm_Showdversions: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sdversio")
		end

	bm_Showancestors: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sancesto")
		end

	bm_Showhistory: EV_PIXMAP is
		once
			Result := pixmap_file_content ("shistory")
		end

	bm_Showattributes: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sattribu")
		end

	bm_Showcallers: EV_PIXMAP is
		once
			Result := pixmap_file_content ("scallers")
		end

	bm_Showclients: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sclients")
		end

	bm_Showclickable: EV_PIXMAP is
		once
			Result := pixmap_file_content ("clckable")
		end

	bm_Showdeferreds: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sdeferre")
		end

	bm_Showdescendants: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sdescend")
		end

	bm_Showexported: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sexporte")
		end

	bm_Showexternals: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sexterna")
		end

	bm_Showflat: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sflat")
		end

	bm_Showfs: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sfshort")
		end

	bm_Showonces: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sonces")
		end

	bm_Showroutines: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sroutine")
		end

	bm_Showshort: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sshort")
		end

	bm_Showsuppliers: EV_PIXMAP is
		once
			Result := pixmap_file_content ("ssupplie")
		end

	bm_Showhomonyms: EV_PIXMAP is
		once
			Result := pixmap_file_content ("shomonym")
		end

	bm_Showtext: EV_PIXMAP is
		once
			Result := pixmap_file_content ("stext")
		end

feature {NONE} -- Implementation

	pixmap_file_content (fn: STRING): EV_PIXMAP is
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

end -- class EB_SHARED_BITMAPS

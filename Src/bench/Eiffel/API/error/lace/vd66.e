indexing
	description: "Error when can not modify Ace file to add new assemblies."
	date: "$Date$"
	revision: "$Revision$"

class
	VD66
	
inherit
	WARNING

create
	make
	
feature {NONE} -- Initialization

	make (a_list: ARRAYED_LIST [ASSEMBLY_I]) is
			-- Initialize Current with `a_list'.
		do
			missing_assemblies := a_list
		ensure
			missing_assemblies_set: missing_assemblies = a_list
		end
		
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Print out error message.
		do
			st.add_string ("Could not insert following assembly(ies) in Ace file: ")
			st.add_new_line
			if missing_assemblies /= Void then
				from
					missing_assemblies.start
				until
					missing_assemblies.after
				loop
					missing_assemblies.item.format (st)
					st.add_new_line
					missing_assemblies.forth
				end
			end
		end

feature -- Access

	code: STRING is
			-- Error code
		do
			Result := generator
		end

feature {NONE} -- Access

	missing_assemblies: ARRAYED_LIST [ASSEMBLY_I]
			-- List of missing assemblies.

end -- class VD66

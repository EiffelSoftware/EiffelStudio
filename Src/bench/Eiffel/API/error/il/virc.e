indexing
	description	: "[
		Error when resource compiler cannot be invoked or if during its invocation it fails to
		generate the binary resources file.
		]"
	definition: "VIRC = failed Resource Compiler"
	date: "$Date$"
	revision: "$Revision$"

class
	VIRC

inherit
	WARNING
	
create
	make_rc_not_found,
	make_resource_file_not_found,
	make_failed

feature {NONE} -- Initialization

	make_rc_not_found (a_rc: like resource_compiler) is
			-- Create warning when resource compiler is not found.
		do
			has_resource_compiler := False
			resource_compiler := a_rc
		ensure
			resource_compiler_set: resource_compiler = a_rc
		end

	make_resource_file_not_found (a_file: like resource_file) is
			-- Create a warning
		do
			has_resource_compiler := True
			has_resource_file := False
			resource_file := a_file
		ensure
			resource_file_set: resource_file = a_file
		end
		
	
	make_failed (a_file: like resource_file) is
			-- Create warning when resource compiler failed.
		do
			has_resource_compiler := True
			has_resource_file := True
			resource_file := a_file
		ensure
			resource_file_set: resource_file = a_file
		end
		
feature -- Properties

	code: STRING is "VIRC"
		-- Error code

feature -- Access

	has_resource_compiler: BOOLEAN
			-- Do we have a resource compiler available?
			
	has_resource_file: BOOLEAN
			-- Does `resource_file' exist?
			
	resource_compiler: STRING
			-- Name of resource compiler.
			
	resource_file: STRING
			-- Name of file being processed.

	file_name: STRING is
			-- No associated file name
		do
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- No need for an error message.
		do
			if not has_resource_compiler then
				if resource_compiler = Void then
					st.add_string ("Could not locate resource compiler.")
				else
					st.add_string ("Could not locate resource compiler at location:")
					st.add_new_line
					st.add_string (resource_compiler)
				end
			else
				if not has_resource_file then
					st.add_string ("Could not find resource file %"")
					st.add_string (resource_file)
					st.add_string ("%".")
				else
					st.add_string ("Could not compile resource file %"")
					st.add_string (resource_file)
					st.add_string ("%".")
				end
			end
		end

invariant
	resource_file_set: has_resource_compiler implies resource_file /= Void

end -- class VIRC

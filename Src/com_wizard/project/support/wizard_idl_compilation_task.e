indexing
	description: "Task used for compiling IDL file from Eiffel class"
	date: "$date"
	revision: "$revision"

class
	WIZARD_IDL_COMPILATION_TASK

inherit
	WIZARD_PROGRESS_REPORTING_TASK

feature -- Access

	title: STRING is
			-- Task title
		do
			if not environment.is_new_component or not environment.marshaller_generated then
				Result := "Compiling IDL:"
			else
				Result := "Compiling IDL and Marshaller DLL:"
			end
		end

	steps_count: INTEGER is
			-- Number of steps involved in task
		do
			if not environment.is_new_component or not environment.marshaller_generated then
				Result := 1
			else
				Result := 6
			end
		end

feature {NONE} -- Implementation

	internal_execute is
			-- Implementation of `execute'.
		do
			compiler.compile_idl
			progress_report.step

			-- Create Proxy/Stub
			if environment.is_new_component and environment.marshaller_generated and not environment.abort then
				message_output.add_title ("Compiling marshaller DLL GUIDs")
				compiler.compile_iid
				if not environment.abort then
					progress_report.step
					message_output.add_title ("Compiling marshaller DLL data")
					compiler.compile_data
				end
				if not environment.abort then
					progress_report.step
					message_output.add_title ("Compiling marshaller DLL interface")
					compiler.compile_ps
				end
				if not environment.abort then
					progress_report.step
					message_output.add_title ("Linking marshaller DLL")
					compiler.link
				end
				if not environment.abort then
					progress_report.step
					message_output.add_title ("Registering marshaller DLL")
					compiler.register_ps
				end
				if not environment.abort then
					progress_report.step
				end
			end
		end

	compiler: WIZARD_COMPILER is
			-- IDL/C compiler
		once
			create Result
		end

end -- class WIZARD_IDL_COMPILATION_TASK

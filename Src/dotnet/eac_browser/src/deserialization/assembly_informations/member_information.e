class
	MEMBER_INFORMATION


creation
	make
	
feature -- Initialization
	
	make is
			-- Initialization
		do
			create name.make_empty
			create summary.make_empty
			create parameters.make
			create returns.make_empty
		ensure
			non_void_name: name /= Void
			non_void_summary: summary /= Void
			non_void_parameters: parameters /= Void
			non_void_returns: returns /= Void
		end

feature -- Access

	name: STRING
	
	summary: STRING
	
	parameters: LINKED_LIST [PARAMETER_INFORMATION]
	
	returns: STRING

feature -- Status Setting

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		require
			non_void_a_name: a_name /= Void
		do
			name := a_name	
		ensure
			name_set: name = a_name
		end

	set_summary (a_summary: like summary) is
			-- Set `summary' with `a_summary'.
		require
			non_void_a_summary: a_summary /= Void
		do
			summary := a_summary	
		ensure
			summary_set: summary = a_summary
		end

	set_returns (a_returns: like returns) is
			-- Set `returns' with `a_returns'.
		require
			non_void_a_returns: a_returns /= Void
		do
			returns := a_returns	
		ensure
			returns_set: returns = a_returns
		end

feature -- Basic Operations
	
	add_parameter (a_parameter: PARAMETER_INFORMATION) is
			-- Add `a_parameter' to `parameters'.
		require
			non_void_a_parameter: a_parameter /= Void
		do
			parameters.extend (a_parameter)
		ensure
			a_parameter_added: parameters.has (a_parameter)
		end

invariant
	non_void_name: name /= Void
	non_void_summary: summary /= Void
	non_void_parameters: parameters /= Void
	non_void_returns: returns /= Void

end -- class MEMBER_INFORMATION

indexing
	description: "Formats .NET XML class text."
	date: "$Date$"
	revision: "$1.0$"

class DOTNET_TEXT_FORMATTER

inherit
	E_TEXT_FORMATTER

	SHARED_INST_CONTEXT

	SHARED_WORKBENCH

	SHARED_FORMAT_INFO
		rename
			is_short as format_is_short,
			set_is_short as format_set_is_short
		end

feature {NONE} -- Properties

	is_flat_short: BOOLEAN
			-- Is the format doing a flat short?

feature -- Setting
		
	set_is_flat_short is
			-- Set `is_flat_short' to True.
		do
			is_flat_short := True
		ensure
			is_flat_short: is_flat_short
		end

feature -- Output

	format (e_class: CONSUMED_TYPE; e_classi: CLASS_I) is
			-- Format text for eiffel class `e_class'.
		require
			valid_e_class: e_class /= Void
			valid_i_class: e_classi /= Void
		local
			f: DOTNET_CLASS_CONTEXT
			l_include_ancestors: BOOLEAN
		do
			l_include_ancestors := not is_flat_short
			create f.make (e_class, e_classi, l_include_ancestors)
			f.execute
			text := f.text
			error := f.execution_error
		end

end -- class DOTNET_TEXT_FORMATTER

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

	is_short: BOOLEAN
			-- Is the format doing a short?
			
	is_flat_short: BOOLEAN
			-- Is the format doing a flat short?

feature -- Setting

	set_is_short is
			-- Set `is_short' to True.
		do
			is_short := True
		ensure
			is_short: is_short
		end
		
	set_is_flat_short is
			-- Set `is_flat_short' to True.
		do
			is_short := True
			is_flat_short := True
		ensure
			is_short: is_short
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
		do
			create f.make (e_class, e_classi)
			if is_short then
				f.set_is_short
			end
			if is_clickable then
				f.set_in_bench_mode
			end
			if not is_flat_short then
				f.set_current_class_only
			end
			f.execute
			text := f.text
			error := f.execution_error
		end

invariant
	flat_short_is_short: is_flat_short implies is_short

end -- class DOTNET_TEXT_FORMATTER

note

	description:

		"Deferred common base for wrapper classes"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class EWG_ABSTRACT_WRAPPER

inherit

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end
	ANY


feature {NONE} -- Initialization

	make (a_mapped_eiffel_name: STRING; a_header_file_name: STRING)
			-- Create a new wrapper with the mapped name `a_mapped_eiffel_name'
			-- and "#include" `a_header_file_name' when needed to make wrapped
			-- types available to the C compiler.
		require
			a_mapped_eiffel_name_not_void: a_mapped_eiffel_name /= Void
			a_mapped_eiffel_name_not_empty: not a_mapped_eiffel_name.is_empty
			a_header_file_name_not_void: a_header_file_name /= Void
			a_header_file_name_not_empty: not a_header_file_name.is_empty
		do
			proposed_eiffel_name := a_mapped_eiffel_name
			header_file_name := a_header_file_name
			update_mapped_eiffel_name
		ensure
			mapped_eiffel_name_set: mapped_eiffel_name = a_mapped_eiffel_name
			header_file_name_set: header_file_name = a_header_file_name
		end

feature -- Access

	mapped_eiffel_name: STRING
			-- A name (which must be a valid Eiffel identifier),
			-- which should be used in the Eiffel world to refere
			-- to the wrapped C construct.

	header_file_name: STRING
			-- The header which must be included to have the wrapped C construct
			-- declared.

feature -- Rename mapped names

	rename_mapped_eiffel_name
			-- Rename Eiffel name of wrapper.
			-- Currently a very simplisitc implementation is provided,
			-- which just appends a number (and increases it on multiple calls)
			-- This feature can be used to avoid name clases in the resulting
			-- Eiffel code.
		do
			renaming_status := renaming_status + 1
			update_mapped_eiffel_name
		end



feature {NONE} -- Implementation

	renaming_status: INTEGER
			-- How many times has `rename_mapped_eiffel_name' been called?

	proposed_eiffel_name: STRING
			-- The originally proposed Eiffel name for this wrapper;
			-- It might differ from `mapped_eiffel_name' because of a clash
			-- that had to be resolved.

	update_mapped_eiffel_name
			-- Update `mapped_eiffel_name' according to `renaming_status' and
			-- `proposed_eiffel_name'.
		local
			rename_overhead: INTEGER
		do
			if renaming_status = 0 then
				mapped_eiffel_name := proposed_eiffel_name
				trim_mapped_eiffel_name_size (0)
			else
				rename_overhead := 1 + renaming_status.out.count
				create mapped_eiffel_name.make (proposed_eiffel_name.count + rename_overhead)

				mapped_eiffel_name.append_string (proposed_eiffel_name)

				trim_mapped_eiffel_name_size (rename_overhead)

				mapped_eiffel_name.append_string ("_")
				mapped_eiffel_name.append_string (renaming_status.out)
			end
		end

feature {NONE}

	trim_mapped_eiffel_name_size (a_rename_overhead: INTEGER)
		require
			a_rename_overhead_greater_equal_zero: a_rename_overhead >= 0
		do
			if mapped_eiffel_name.count + a_rename_overhead > Max_mapped_eiffel_name_size then
				mapped_eiffel_name.keep_head (Max_mapped_eiffel_name_size - a_rename_overhead)
			end
		end

	Max_mapped_eiffel_name_size: INTEGER = 120

invariant

	header_file_name_not_void: header_file_name /= Void
	header_file_name_not_empty: not header_file_name.is_empty
	mapped_eiffel_name_not_void: mapped_eiffel_name /= Void
	mapped_eiffel_name_not_empty: not mapped_eiffel_name.is_empty
	mapped_eiffel_name_not_too_big: mapped_eiffel_name.count <= Max_mapped_eiffel_name_size
	proposed_eiffel_name_not_void: proposed_eiffel_name /= Void
	renaming_status_greater_equal_zero: renaming_status >= 0

end

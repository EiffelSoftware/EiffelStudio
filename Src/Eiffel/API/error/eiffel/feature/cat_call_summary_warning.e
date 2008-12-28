indexing
	description: "Give a summary of all catcall warnings."
	date: "$Date$"
	revision: "$Revision$"

class
	CAT_CALL_SUMMARY_WARNING

inherit
	COMPILER_WARNING

create
	make

feature

	make (a_summary: like summary) is
			-- Intialize Current with `a_summary'.
		require
			a_summary_not_void: a_summary /= Void
		do
			summary := a_summary
		ensure
			summary_set: summary = a_summary
		end

feature -- Access

	summary: STRING
			-- Hold summary

	code: STRING = "Catcall Summary Report"

	file_name: STRING is
		do
			-- Not applicable
		end


feature -- Formatting

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
			a_text_formatter.add (summary)
		end

end

indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.IDataGridColumnStyleEditingNotificationService"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_IDATA_GRID_COLUMN_STYLE_EDITING_NOTIFICATION_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	column_started_editing (editing_control: WINFORMS_CONTROL) is
		external
			"IL deferred signature (System.Windows.Forms.Control): System.Void use System.Windows.Forms.IDataGridColumnStyleEditingNotificationService"
		alias
			"ColumnStartedEditing"
		end

end -- class WINFORMS_IDATA_GRID_COLUMN_STYLE_EDITING_NOTIFICATION_SERVICE
